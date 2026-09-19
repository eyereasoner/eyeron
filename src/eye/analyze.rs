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

/// Indexes one relation's rules by their head's ground argument positions,
/// so `engine::evaluate_table` can skip every rule that provably cannot
/// unify with a call instead of attempting all of them. Rules are first
/// grouped by their *exact set* of ground positions -- a predicate such as
/// `a(?individual, class1000).` (used by the per-level-unrolled
/// `deep-taxonomy-*.eye` benchmarks, one clause per class) groups every
/// recursive clause together under "position 1 is ground" (the
/// discriminating position is the *second* argument there, not the
/// first), separately from a fact like `a(ind, n0).` grouped under
/// "positions 0 and 1 are both ground". Within a group, rules are further
/// keyed by their value at that group's own first ground position.
///
/// This grouping is what keeps `candidates` correct, not just fast: a
/// naive single first-argument index would, for a call with *no* ground
/// argument at all (e.g. a top-level `ask arc(?check, ?message)`
/// enumerating every solution), wrongly exclude every rule with a ground
/// head, since no call argument would ever probe a matching bucket. Here,
/// a group whose own discriminating position the call does not (or
/// cannot usefully) narrow is included in full instead of silently
/// dropped, so a rule is only ever excluded when the call is ground at a
/// position the rule is *also* ground at and they disagree -- the exact
/// `unify` check afterward is what decides a real match; this is only a
/// safe over-approximation of it.
#[derive(Default)]
pub struct ArgIndex {
    groups: Vec<ArgGroup>,
}

#[derive(Default)]
struct ArgGroup {
    /// The ground argument positions shared by every rule in this group,
    /// ascending; empty means "no ground argument at all" (always a
    /// candidate, regardless of the call).
    positions: Vec<usize>,
    /// Keyed by `term_key` of each rule's value at `positions[0]` (unused,
    /// single bucket under `""`, when `positions` is empty).
    by_key: HashMap<String, Vec<usize>>,
}

impl ArgIndex {
    fn build(rules: &[Rule]) -> Self {
        let mut index = ArgIndex::default();
        let mut group_of: HashMap<Vec<usize>, usize> = HashMap::new();
        for (i, rule) in rules.iter().enumerate() {
            let args: &[Term] = match &rule.head {
                Term::Struct(_, args) => args,
                _ => &[],
            };
            let positions: Vec<usize> = args.iter().enumerate().filter(|(_, a)| ground(a)).map(|(pos, _)| pos).collect();
            let group_idx = *group_of.entry(positions.clone()).or_insert_with(|| {
                index.groups.push(ArgGroup { positions: positions.clone(), by_key: HashMap::new() });
                index.groups.len() - 1
            });
            let group = &mut index.groups[group_idx];
            let key = group.positions.first().map(|&pos| term_key(&args[pos])).unwrap_or_default();
            group.by_key.entry(key).or_default().push(i);
        }
        index
    }

    /// Rule indices that could possibly unify with a call whose own
    /// arguments are `call_args`, ascending.
    pub fn candidates(&self, call_args: &[Term]) -> Vec<usize> {
        let mut indices = Vec::new();
        for group in &self.groups {
            let Some(&first_pos) = group.positions.first() else {
                // No ground position at all: always a candidate.
                indices.extend(group.by_key.values().flatten().copied());
                continue;
            };
            match call_args.get(first_pos).filter(|arg| ground(arg)) {
                // The call is ground at this group's discriminating
                // position: narrow to the exact matching bucket.
                Some(arg) => {
                    if let Some(matching) = group.by_key.get(&term_key(arg)) {
                        indices.extend(matching.iter().copied());
                    }
                }
                // The call has no value there to narrow by (unbound, or
                // shorter arity than expected): include the whole group
                // rather than risk missing a match.
                None => indices.extend(group.by_key.values().flatten().copied()),
            }
        }
        indices.sort_unstable();
        indices
    }
}

pub struct Analyzed {
    pub predicates: HashMap<String, Vec<Rule>>,
    pub predicate_index: HashMap<String, ArgIndex>,
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
    let predicate_index: HashMap<String, ArgIndex> = predicates.iter().map(|(name, rules)| (name.clone(), ArgIndex::build(rules))).collect();

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
