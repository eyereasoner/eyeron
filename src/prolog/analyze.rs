//! Static stratification and validation.
//!
//! Unlike `crate::srl::stratify` (per-rule granularity), this stratifies
//! per predicate indicator (`name/arity`): every clause defining a
//! predicate is assigned the same stratum level.

use std::collections::HashMap;

use crate::error::{EyeronError, Result};

use super::ast::{goals_of, Rule};
use super::builtins::is_builtin_relation;
use super::term::{ground, term_key, Term};

/// The predicate indicator of a callable term, written the way the
/// standard writes one: `name/arity`.
pub fn signature(term: &Term) -> String {
    match term {
        Term::Struct(name, args) => format!("{}/{}", name, args.len()),
        _ => unreachable!("goal and head terms are always callable, checked by the parser"),
    }
}

struct Dependency {
    name: String,
    closed: bool,
}

/// What a body depends on, and how tightly. A `\+` or `findall/3`
/// argument always contributes closed edges (they need the dependency's
/// stratum to be strictly lower, because both read a *completed*
/// predicate); an ordinary call is closed only when it is already inside
/// one of those (`closed` propagates down).
///
/// A `call/1` argument contributes nothing: the goal is a value, so which
/// predicates it reaches is not known until evaluation. The specification
/// says so explicitly (§10), since it is the one place the analysis cannot
/// see through.
fn dependencies(body: &[Term], closed: bool) -> Vec<Dependency> {
    let mut out = Vec::new();
    for goal in body {
        let Term::Struct(name, args) = goal else { continue };
        match (name.as_str(), args.len()) {
            ("\\+", 1) => out.extend(dependencies(&goals_of(&args[0]), true)),
            ("findall", 3) => out.extend(dependencies(&goals_of(&args[1]), true)),
            ("call", 1) => {}
            (name, arity) => {
                let indicator = format!("{}/{}", name, arity);
                if !is_builtin_relation(&indicator) {
                    out.push(Dependency { name: indicator, closed });
                }
            }
        }
    }
    out
}

/// Indexes one relation's rules by their head's ground argument positions,
/// so `engine::evaluate_table` can skip every rule that provably cannot
/// unify with a call instead of attempting all of them. Rules are first
/// grouped by their *exact set* of ground positions -- a predicate such as
/// `a(Individual, class1000).` (used by the per-level-unrolled
/// `deep-taxonomy-*.pl` benchmarks, one clause per class) groups every
/// recursive clause together under "position 1 is ground" (the
/// discriminating position is the *second* argument there, not the
/// first), separately from a fact like `a(ind, n0).` grouped under
/// "positions 0 and 1 are both ground". Within a group, rules are further
/// keyed by their value at that group's own first ground position.
///
/// This grouping is what keeps `candidates` correct, not just fast: a
/// naive single first-argument index would, for a call with *no* ground
/// argument at all (e.g. a top-level `?- arc(Check, Message)`
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
        if !predicates.contains_key(&dep.name) {
            return Err(EyeronError::new(format!("Undefined predicate {}", dep.name)));
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
    Err(EyeronError::new("Recursion through \\+ or findall is not stratified"))
}

pub fn check_query(body: &[Term], analyzed: &Analyzed) -> Result<()> {
    for dep in dependencies(body, false) {
        if !analyzed.predicates.contains_key(&dep.name) {
            return Err(EyeronError::new(format!("Undefined predicate {}", dep.name)));
        }
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::prolog::parser::parse;
    use crate::prolog::term::VarCounter;

    fn analyzed(source: &str) -> Result<Analyzed> {
        let mut counter = VarCounter::new();
        let program = parse(source, &mut counter).unwrap_or_else(|err| panic!("{source}: {err}"));
        analyze(program.rules)
    }

    #[test]
    fn plain_recursion_is_stratum_zero() {
        let a = analyzed("ancestor(X, Y) :- parent(X, Y).\nancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).\nparent(a, b).").unwrap();
        assert_eq!(*a.strata.get("ancestor/2").unwrap(), 0);
    }

    #[test]
    fn negation_forces_a_higher_stratum() {
        let a = analyzed("single(X) :- person(X), \\+ married(X).\nperson(a).\nmarried(a).").unwrap();
        assert!(a.strata.get("single/1").unwrap() > a.strata.get("married/1").unwrap());
    }

    #[test]
    fn unstratifiable_negation_is_rejected() {
        assert!(analyzed("p(X) :- \\+ p(X).").is_err());
    }

    #[test]
    fn findall_over_its_own_predicate_is_rejected() {
        assert!(analyzed("p(Xs) :- findall(X, p(X), Xs).").is_err());
    }

    #[test]
    fn an_undefined_predicate_is_rejected() {
        assert!(analyzed("p(X) :- q(X).").is_err());
    }

    #[test]
    fn a_builtin_goal_needs_no_definition() {
        assert!(analyzed("p(X) :- between(1, 3, X).").is_ok());
    }

    #[test]
    fn redefining_a_builtin_is_rejected() {
        assert!(analyzed("length(X, Y) :- likes(X, Y).\nlikes(a, b).").is_err());
    }
}
