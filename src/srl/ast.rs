//! Abstract syntax for SPARQL 1.2 RL ("SRL") rule sets.
//!
//! SRL borrows SPARQL's lexical vocabulary (`PREFIX`, `FILTER`, property
//! paths, RDF-star triple terms) but its rules are a Datalog-style
//! `RULE { head } WHERE [DATA] { body }` construct, much closer to N3's
//! `{ body } => { head }` than to a SPARQL `SELECT` query. Because clauses
//! such as `FILTER`/`SET`/`NOT` require their variables to already be bound
//! by *preceding* clauses in source order, an SRL rule body is evaluated by
//! a dedicated, strictly-ordered evaluator (`super::eval`) rather than
//! eyeron's existing selectivity-reordering premise matcher in
//! `crate::reasoner`. This module therefore defines its own rule/program
//! types instead of reusing `crate::ast::Rule`/`Document`, while still
//! reusing `crate::ast::{Term, Triple, Literal}` wherever the shapes
//! coincide.

use crate::ast::{SourceRef, Term, Triple};

/// A SPARQL-RL expression, as used inside `FILTER(...)` and `SET(?v := ...)`.
#[derive(Debug, Clone, PartialEq)]
pub enum Expr {
    /// A bound or to-be-bound variable, e.g. `?x`.
    Var(String),
    /// A constant term: IRI, literal, blank node, or (for `IN`-style lists
    /// of terms) list.
    Term(Term),
    /// A prefix operator, e.g. unary `-` or logical `!`.
    Unary { op: UnaryOp, expr: Box<Expr> },
    /// An infix operator, e.g. `+`, `&&`, `=`.
    Binary { op: BinaryOp, left: Box<Expr>, right: Box<Expr> },
    /// A built-in or XSD-cast function call, e.g. `CONCAT(?a, ?b)`,
    /// `xsd:integer(?x)`.
    Call { name: String, args: Vec<Expr> },
    /// A parenthesized expression list, used by `IN`/`NOT IN` right-hand
    /// sides.
    List(Vec<Expr>),
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum UnaryOp {
    Neg,
    Not,
    Plus,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BinaryOp {
    Or,
    And,
    Eq,
    NotEq,
    Lt,
    Gt,
    Le,
    Ge,
    Add,
    Sub,
    Mul,
    Div,
    In,
    NotIn,
}

/// A SPARQL property path, restricted to the subset SRL currently supports:
/// a single IRI, an inverse path (`^p`), or a sequence (`p1/p2/...`). There
/// is no Kleene star/plus/optional or alternation in the current SPARQL 1.2
/// RL grammar.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum PathExpr {
    Iri(String),
    Inverse(Box<PathExpr>),
    Sequence(Vec<PathExpr>),
}

/// One clause of a SPARQL-RL rule body, in source order. Order matters:
/// `Filter`/`Set`/`Not` may only reference variables bound by clauses that
/// precede them.
#[derive(Debug, Clone, PartialEq)]
pub enum Clause {
    Triple(Triple),
    Path { s: Term, p: PathExpr, o: Term },
    Filter(Expr),
    /// `SET(?v := expr)`. Binds `var` if unbound; if `var` is already bound
    /// (e.g. reused across a rule), succeeds only if the existing binding
    /// equals the expression's value.
    Set { var: String, expr: Expr },
    /// `NOT { ... }` / `NOT DATA { ... }` (negation as failure): succeeds
    /// iff `body` has zero solutions under the bindings accumulated so far.
    /// `ground_data` routes the sub-search to the immutable base graph
    /// instead of the growing inference graph.
    Not { body: Vec<Clause>, ground_data: bool },
}

/// One `RULE { head } WHERE [DATA] { body }` statement.
#[derive(Debug, Clone, PartialEq)]
pub struct SparqlRlRule {
    pub name: Option<String>,
    pub head: Vec<Triple>,
    pub body: Vec<Clause>,
    /// `WHERE DATA { ... }`: the whole body reads the immutable base graph
    /// only, not the growing inference graph.
    pub ground_data: bool,
    /// True iff the rule must fire on at most its first successful body
    /// match per stratification layer, rather than being run to a fixpoint.
    /// SPARQL-RL mandates this for rules whose body contains a `SET` clause
    /// or whose head contains a blank node (SPARQL 1.2 RL §4.4).
    pub run_once: bool,
    pub source: Option<SourceRef>,
}

impl SparqlRlRule {
    pub fn new(head: Vec<Triple>, body: Vec<Clause>) -> Self {
        let run_once = rule_needs_run_once(&head, &body);
        Self { name: None, head, body, ground_data: false, run_once, source: None }
    }
}

/// A parsed `.srl` program: prefixes, `DATA { ... }` facts (which seed the
/// *inference* graph, not the base graph — see `SparqlRlRule::ground_data`),
/// and rules.
#[derive(Debug, Clone, PartialEq, Default)]
pub struct SparqlRlProgram {
    pub base_iri: Option<String>,
    pub version: Option<String>,
    pub imports: Vec<String>,
    pub prefixes: std::collections::BTreeMap<String, String>,
    pub data: Vec<Triple>,
    pub rules: Vec<SparqlRlRule>,
}

/// SPARQL 1.2 RL §4.4: a rule needs run-once handling iff its body assigns
/// a variable via `SET`, or its head contains a blank node (recursively,
/// including inside RDF-star triple terms represented as `Term::Formula`).
pub fn rule_needs_run_once(head: &[Triple], body: &[Clause]) -> bool {
    body.iter().any(clause_has_assignment) || head.iter().any(triple_has_blank_node)
}

fn clause_has_assignment(clause: &Clause) -> bool {
    matches!(clause, Clause::Set { .. })
}

fn triple_has_blank_node(triple: &Triple) -> bool {
    term_has_blank_node(&triple.s) || term_has_blank_node(&triple.p) || term_has_blank_node(&triple.o)
}

fn term_has_blank_node(term: &Term) -> bool {
    match term {
        Term::Blank(_) => true,
        Term::Formula(triples) => triples.iter().any(triple_has_blank_node),
        Term::List(items) => items.iter().any(term_has_blank_node),
        _ => false,
    }
}

/// Free variables referenced by an expression (used for well-formedness
/// checks: a `FILTER`/`SET` may only use variables already bound by
/// preceding clauses).
pub fn expr_variables(expr: &Expr, out: &mut std::collections::BTreeSet<String>) {
    match expr {
        Expr::Var(name) => {
            out.insert(name.clone());
        }
        Expr::Term(term) => term_variables(term, out),
        Expr::Unary { expr, .. } => expr_variables(expr, out),
        Expr::Binary { left, right, .. } => {
            expr_variables(left, out);
            expr_variables(right, out);
        }
        Expr::Call { args, .. } => {
            for arg in args {
                expr_variables(arg, out);
            }
        }
        Expr::List(items) => {
            for item in items {
                expr_variables(item, out);
            }
        }
    }
}

pub fn term_variables(term: &Term, out: &mut std::collections::BTreeSet<String>) {
    match term {
        Term::Var(name) => {
            out.insert(name.clone());
        }
        Term::Formula(triples) => {
            for triple in triples {
                term_variables(&triple.s, out);
                term_variables(&triple.p, out);
                term_variables(&triple.o, out);
            }
        }
        Term::List(items) => {
            for item in items {
                term_variables(item, out);
            }
        }
        _ => {}
    }
}

pub fn path_variables(path_s: &Term, path_o: &Term, out: &mut std::collections::BTreeSet<String>) {
    term_variables(path_s, out);
    term_variables(path_o, out);
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ast::Literal;

    #[test]
    fn run_once_true_for_set_clause() {
        let body = vec![Clause::Set { var: "x".into(), expr: Expr::Term(Term::Literal(Literal::plain("1"))) }];
        assert!(rule_needs_run_once(&[], &body));
    }

    #[test]
    fn run_once_true_for_blank_head() {
        let head = vec![Triple::new(Term::blank("b0"), Term::var("p"), Term::var("o"))];
        assert!(rule_needs_run_once(&head, &[]));
    }

    #[test]
    fn run_once_false_otherwise() {
        let head = vec![Triple::new(Term::var("s"), Term::var("p"), Term::var("o"))];
        let body = vec![Clause::Triple(Triple::new(Term::var("s"), Term::var("p"), Term::var("o")))];
        assert!(!rule_needs_run_once(&head, &body));
    }
}
