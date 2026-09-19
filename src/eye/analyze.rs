//! Static stratification and validation, mirroring `analyze.js`.
//!
//! Unlike `crate::srl::stratify` (per-rule granularity), Eyelang stratifies
//! per relation *signature* (`name/arity`): every clause defining a
//! relation is assigned the same stratum level.

use std::collections::HashMap;

use crate::error::{EyeronError, Result};

use super::ast::{Goal, Rule};
use super::builtins::is_builtin_relation;
use super::term::{ground, term_key, Term};

pub fn signature(term: &Term) -> String {
    match term {
        Term::Struct(name, args) => format!("{}/{}", name, args.len()),
        _ => unreachable!("call/head terms are always normalized to Term::Struct by the parser"),
    }
}

struct Dependency {
    name: String,
    closed: bool,
}

/// `not`/`collect` bodies always contribute closed edges (they require the
/// dependency's stratum to be strictly lower); ordinary calls are closed
/// only when already inside a `collect` body (`closed` propagates down).
fn dependencies(body: &[Goal], closed: bool) -> Vec<Dependency> {
    let mut out = Vec::new();
    for goal in body {
        match goal {
            Goal::Call(term) => out.push(Dependency { name: signature(term), closed }),
            Goal::Not(term) => out.push(Dependency { name: signature(term), closed: true }),
            Goal::Collect { body, .. } => out.extend(dependencies(body, true)),
            _ => {}
        }
    }
    out
}

/// Indexes one relation's rules by their head's first argument, when that
/// argument is ground in the rule itself (the common shape for a large,
/// flat fact table such as `hasRoute("AIRPORT_1", "AIRPORT_2").`), so
/// `engine::evaluate_table` can skip every rule that provably cannot unify
/// with a call instead of attempting all of them — for a predicate with
/// tens of thousands of facts (as in `path-discovery.eye`'s full air-route
/// data), the difference between "attempt ~40" and "attempt ~40,000" per
/// call. `open` holds rules whose own first argument is a variable (or
/// which have no arguments at all): such a rule can unify with any call
/// regardless of the call's first argument, so it is always a candidate.
/// Both fields store indices into the predicate's own `Vec<Rule>`, each
/// list kept in original definition order.
#[derive(Default)]
pub struct FirstArgIndex {
    by_key: HashMap<String, Vec<usize>>,
    open: Vec<usize>,
}

impl FirstArgIndex {
    fn build(rules: &[Rule]) -> Self {
        let mut index = FirstArgIndex::default();
        for (i, rule) in rules.iter().enumerate() {
            match &rule.head {
                Term::Struct(_, args) if args.first().is_some_and(ground) => {
                    index.by_key.entry(term_key(&args[0])).or_default().push(i);
                }
                _ => index.open.push(i),
            }
        }
        index
    }

    /// Rule indices that could possibly unify with a call whose own first
    /// argument's `term_key` is `call_key`, in original definition order.
    pub fn candidates(&self, call_key: &str) -> Vec<usize> {
        let mut indices = self.open.clone();
        if let Some(matching) = self.by_key.get(call_key) {
            indices.extend(matching.iter().copied());
            indices.sort_unstable();
        }
        indices
    }
}

pub struct Analyzed {
    pub predicates: HashMap<String, Vec<Rule>>,
    pub predicate_index: HashMap<String, FirstArgIndex>,
    pub strata: HashMap<String, usize>,
    /// Relation signatures in first-declaration order (the order
    /// `--check`'s `stratum/2` facts are reported in — a plain `HashMap`
    /// has no defined iteration order, and JS's `Map` preserves insertion
    /// order, so this is tracked separately to match it).
    pub predicate_order: Vec<String>,
}

pub fn analyze(rules: Vec<Rule>) -> Result<Analyzed> {
    let mut predicates: HashMap<String, Vec<Rule>> = HashMap::new();
    let mut predicate_order: Vec<String> = Vec::new();
    for rule in &rules {
        let name = signature(&rule.head);
        if is_builtin_relation(&name) {
            return Err(EyeronError::new(format!("Cannot redefine built-in {}", name)));
        }
        if !predicates.contains_key(&name) {
            predicate_order.push(name.clone());
        }
        predicates.entry(name).or_default().push(rule.clone());
    }
    let predicate_index: HashMap<String, FirstArgIndex> = predicates.iter().map(|(name, rules)| (name.clone(), FirstArgIndex::build(rules))).collect();

    let edges: Vec<(String, Dependency)> =
        rules.iter().flat_map(|rule| dependencies(&rule.body, false).into_iter().map(move |dep| (signature(&rule.head), dep))).collect();

    for (_, dep) in &edges {
        if !predicates.contains_key(&dep.name) && !is_builtin_relation(&dep.name) {
            return Err(EyeronError::new(format!("Undefined relation {}", dep.name)));
        }
    }

    let mut strata: HashMap<String, usize> = predicates.keys().map(|name| (name.clone(), 0)).collect();
    for _round in 0..=predicates.len() {
        let mut changed = false;
        for (from, dep) in &edges {
            let level = strata.get(&dep.name).copied().unwrap_or(0) + usize::from(dep.closed);
            let current = *strata.get(from).unwrap();
            if current < level {
                strata.insert(from.clone(), level);
                changed = true;
            }
        }
        if !changed {
            return Ok(Analyzed { predicates, predicate_index, strata, predicate_order });
        }
    }
    Err(EyeronError::new("Recursion through not or collect is not stratified"))
}

pub fn check_query(body: &[Goal], analyzed: &Analyzed) -> Result<()> {
    for dep in dependencies(body, false) {
        if !analyzed.predicates.contains_key(&dep.name) && !is_builtin_relation(&dep.name) {
            return Err(EyeronError::new(format!("Undefined relation {}", dep.name)));
        }
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::eye::parser::parse;
    use crate::eye::term::VarCounter;

    fn analyzed(source: &str) -> Result<Analyzed> {
        let mut counter = VarCounter::new();
        let program = parse(source, &mut counter).unwrap();
        analyze(program.rules)
    }

    #[test]
    fn plain_recursion_is_stratum_zero() {
        let a = analyzed("ancestor(?x, ?y) if parent(?x, ?y). ancestor(?x, ?y) if parent(?x, ?z), ancestor(?z, ?y). parent(a, b).").unwrap();
        assert_eq!(*a.strata.get("ancestor/2").unwrap(), 0);
    }

    #[test]
    fn negation_forces_higher_stratum() {
        let a = analyzed("single(?x) if person(?x), not married(?x). person(a). married(a).").unwrap();
        assert!(a.strata.get("single/1").unwrap() > a.strata.get("married/1").unwrap());
    }

    #[test]
    fn unstratifiable_negation_is_rejected() {
        assert!(analyzed("p(?x) if not p(?x).").is_err());
    }

    #[test]
    fn undefined_relation_is_rejected() {
        assert!(analyzed("p(?x) if q(?x).").is_err());
    }

    #[test]
    fn redefining_a_builtin_is_rejected() {
        assert!(analyzed("length(?x, ?y) if likes(?x, ?y). likes(a, b).").is_err());
    }
}
