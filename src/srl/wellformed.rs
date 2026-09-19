//! Static well-formedness checks for a single SPARQL 1.2 RL rule.
//!
//! Ported from eyeleng's `sequentialWellFormednessDiagnostics` plus its
//! head-safety check in `src/analyze.js`. These are checks on the rule's
//! *text*, independent of any particular run's bindings — distinct from
//! `super::stratify`, which reasons about dependencies *between* rules.
//! `SET` reassigning a variable a preceding clause already bound, or a
//! `FILTER`/`SET` referencing a variable no preceding clause has bound
//! yet, are rejected here rather than at evaluation time; contrast this
//! with `super::eval`'s `Clause::Set` handling, which treats seeing an
//! *already-bound* variable at *runtime* (which can only happen through
//! variable reuse across separate rule/goal applications, e.g. in
//! `super::backward`, never from the rule's own source text once it has
//! passed this check) as an equality test rather than an error.

use std::collections::BTreeSet;

use crate::ast::Term;
use crate::error::{EyeronError, Result};

use super::ast::{expr_variables, Clause, SparqlRlRule};

/// Check one rule's head and body for the four conditions SPARQL 1.2 RL
/// treats as ill-formed: an unbound head variable, a non-IRI/non-variable
/// head predicate, a `FILTER`/`SET` referencing a variable before any
/// preceding clause binds it, and a `SET` reassigning a variable a
/// preceding clause already bound.
pub fn check_rule(rule: &SparqlRlRule, index: usize) -> Result<()> {
    let name = rule.name.clone().unwrap_or_else(|| format!("rule#{}", index + 1));
    let bound = visit(&rule.body, &BTreeSet::new(), &name, false)?;

    for head in &rule.head {
        for term in [&head.s, &head.p, &head.o] {
            if let Term::Var(v) = term {
                if !bound.contains(v) {
                    return Err(EyeronError::new(format!("{} has unbound head variable ?{}", name, v)));
                }
            }
        }
        if !matches!(&head.p, Term::Iri(_) | Term::Var(_)) {
            return Err(EyeronError::new(format!("{} has a non-IRI/non-variable predicate in the head", name)));
        }
    }
    Ok(())
}

fn visit(clauses: &[Clause], initial_bound: &BTreeSet<String>, name: &str, in_not: bool) -> Result<BTreeSet<String>> {
    let mut bound = initial_bound.clone();
    let scope = if in_not { " inside NOT" } else { "" };
    for clause in clauses {
        match clause {
            Clause::Triple(t) => {
                collect_term_vars(&t.s, &mut bound);
                collect_term_vars(&t.p, &mut bound);
                collect_term_vars(&t.o, &mut bound);
            }
            Clause::Path { s, o, .. } => {
                collect_term_vars(s, &mut bound);
                collect_term_vars(o, &mut bound);
            }
            Clause::Filter(expr) => {
                let mut used = BTreeSet::new();
                expr_variables(expr, &mut used);
                if let Some(v) = used.iter().find(|v| !bound.contains(*v)) {
                    return Err(EyeronError::new(format!("{} FILTER uses ?{} before it is bound{}", name, v, scope)));
                }
            }
            Clause::Set { var, expr } => {
                if bound.contains(var) {
                    return Err(EyeronError::new(format!("{} SET assigns ?{}, but that variable is already bound{}", name, var, scope)));
                }
                let mut used = BTreeSet::new();
                expr_variables(expr, &mut used);
                if let Some(v) = used.iter().find(|v| !bound.contains(*v)) {
                    return Err(EyeronError::new(format!("{} SET expression uses ?{} before it is bound{}", name, v, scope)));
                }
                bound.insert(var.clone());
            }
            Clause::Not { body, .. } => {
                // A NOT block is checked against the bindings visible at
                // this point, but its own clauses' bindings do not leak
                // back out (SPARQL-RL negation as failure: the block's
                // variables are local to it).
                visit(body, &bound, name, true)?;
            }
        }
    }
    Ok(bound)
}

fn collect_term_vars(term: &Term, out: &mut BTreeSet<String>) {
    match term {
        Term::Var(name) => {
            out.insert(name.clone());
        }
        Term::Formula(triples) => {
            for t in triples {
                collect_term_vars(&t.s, out);
                collect_term_vars(&t.p, out);
                collect_term_vars(&t.o, out);
            }
        }
        Term::List(items) => items.iter().for_each(|t| collect_term_vars(t, out)),
        _ => {}
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::srl::parser::parse_sparql_rl;

    fn check_source(src: &str) -> Result<()> {
        let program = parse_sparql_rl(src, None).unwrap();
        for (i, rule) in program.rules.iter().enumerate() {
            check_rule(rule, i)?;
        }
        Ok(())
    }

    #[test]
    fn accepts_ordinary_rules() {
        assert!(check_source("PREFIX : <http://example/>\nRULE { ?s ?p ?o } WHERE { ?s ?p ?o }").is_ok());
    }

    #[test]
    fn accepts_not_then_reuse_and_set_from_constant() {
        let src = "PREFIX : <http://example/>\nRULE { ?s ?p ?o } WHERE { ?s :p :z . NOT { ?s :q ?y } ?s :q ?o SET(?p := :p) }";
        assert!(check_source(src).is_ok());
    }

    #[test]
    fn rejects_set_reassigning_a_bound_variable() {
        let src = "PREFIX : <http://example/>\nRULE { ?s ?p ?o } WHERE { ?s ?p ?o SET(?o := 123) }";
        let err = check_source(src).unwrap_err();
        assert!(err.message.contains("already bound"), "{}", err.message);
    }

    #[test]
    fn rejects_set_assigning_the_same_variable_twice() {
        let src = "PREFIX : <http://example/>\nRULE { :s :p ?x } WHERE { SET(?x := 1) SET(?x := 1) }";
        let err = check_source(src).unwrap_err();
        assert!(err.message.contains("already bound"), "{}", err.message);
    }

    #[test]
    fn rejects_filter_before_its_variable_is_bound() {
        let src = "PREFIX : <http://example/>\nRULE { ?s ?p ?o } WHERE { FILTER(?o < 50) ?s ?p ?o }";
        let err = check_source(src).unwrap_err();
        assert!(err.message.contains("before it is bound"), "{}", err.message);
    }

    #[test]
    fn rejects_unsafe_head_variable() {
        let src = "PREFIX : <http://example/>\nRULE { ?s ?p ?o } WHERE { ?s ?p ?z }";
        let err = check_source(src).unwrap_err();
        assert!(err.message.contains("unbound head variable"), "{}", err.message);
    }
}
