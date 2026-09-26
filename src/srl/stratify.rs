//! Stratification and well-formedness analysis for SPARQL 1.2 RL rule sets.
//!
//! Ported from eyeleng's `src/analyze.js`. eyeron's own forward fixpoint
//! (`crate::n3::reasoner::reason`) has no stratification concept: its only
//! non-monotonic-ish feature, formula-scoped `log:notIncludes`, is handled
//! by an ad hoc "defer until the ordinary closure saturates, then resume if
//! it changed" trick. SPARQL-RL's `NOT`/`NOT DATA` is inline negation over
//! the ambient body, not a formula literal, and its safety depends on
//! running rules in dependency order: a rule whose body negates a pattern
//! must not run until every rule that could produce that pattern has
//! already reached a fixpoint. This module computes that order (or rejects
//! the rule set as unstratifiable) as a pure, self-contained static
//! analysis over the already-parsed `SparqlRlRule`s; the actual staged
//! execution lives in `super::reason`.

use std::collections::{BTreeMap, BTreeSet};

use crate::ast::{Term, Triple};
use crate::error::{EyeronError, Result};

use super::ast::{expr_variables, Clause, Expr, PathExpr, SparqlRlRule};

/// One dependency edge: `from` reads a pattern that `to`'s head could
/// generate. `closed` edges (through negation, or from a `run_once` rule —
/// SPARQL 1.2 RL §4.3) must not participate in a cycle; `open` (ordinary
/// positive) edges may, since monotonic recursion (e.g. transitive
/// closure) is fine.
struct Edge {
    from: usize,
    to: usize,
    closed: bool,
}

/// Compute the rule execution order: a sequence of strata (layers), each a
/// set of rule indices that may be run to a local fixpoint together, with
/// every stratum's rules guaranteed to only ever negate patterns already
/// fully resolved by an earlier stratum. Returns an error naming the cycle
/// if the rule set is not stratifiable.
pub fn stratify(rules: &[SparqlRlRule]) -> Result<Vec<Vec<usize>>> {
    let infos: Vec<RuleFacts> = rules.iter().map(rule_facts).collect();
    let n = rules.len();
    let template_index = TemplateIndex::build(&infos);

    let mut edge_map: BTreeMap<(usize, usize), bool> = BTreeMap::new();
    for (from_idx, from) in infos.iter().enumerate() {
        add_edges(&mut edge_map, from_idx, &from.positive_patterns, &template_index, from.run_once);
        add_edges_closed(&mut edge_map, from_idx, &from.negative_patterns, &template_index);
    }
    let edges: Vec<Edge> = edge_map.into_iter().map(|((from, to), closed)| Edge { from, to, closed }).collect();

    let components = strongly_connected_components(n, &edges);
    let mut component_of = vec![0usize; n];
    for (ci, comp) in components.iter().enumerate() {
        for &r in comp {
            component_of[r] = ci;
        }
    }

    let mut seen_components = BTreeSet::new();
    for edge in &edges {
        if !edge.closed || component_of[edge.from] != component_of[edge.to] {
            continue;
        }
        let comp = &components[component_of[edge.from]];
        let is_cycle = comp.len() > 1 || edge.from == edge.to;
        if !is_cycle || !seen_components.insert(component_of[edge.from]) {
            continue;
        }
        let names: Vec<String> = comp.iter().map(|&i| rule_display_name(rules, i)).collect();
        return Err(EyeronError::new(format!(
            "stratification condition violated by a recursive closed dependency through {}",
            names.join(" -> ")
        )));
    }

    Ok(stratification_layers(n, &edges))
}

fn add_edges(edge_map: &mut BTreeMap<(usize, usize), bool>, from_idx: usize, patterns: &[Triple], template_index: &TemplateIndex, run_once: bool) {
    for pattern in patterns {
        for &(to_idx, ref template) in template_index.candidates(pattern) {
            if can_possibly_generate(template, pattern) {
                let entry = edge_map.entry((from_idx, to_idx)).or_insert(false);
                *entry = *entry || run_once;
            }
        }
    }
}

fn add_edges_closed(edge_map: &mut BTreeMap<(usize, usize), bool>, from_idx: usize, patterns: &[Triple], template_index: &TemplateIndex) {
    for pattern in patterns {
        for &(to_idx, ref template) in template_index.candidates(pattern) {
            if can_possibly_generate(template, pattern) {
                edge_map.insert((from_idx, to_idx), true);
            }
        }
    }
}

/// Indexes every rule's `head_templates` (the triples its head could
/// generate) by shape -- ground predicate, plus whether its object is also
/// ground -- so `add_edges`/`add_edges_closed` can look up just the
/// templates a given body pattern could possibly depend on, instead of
/// testing it against every rule's every head template. That previous
/// all-pairs scan was `O(rules^2)` regardless of how few dependency edges
/// actually exist, which made stratifying a long single-premise rule chain
/// such as `deep-taxonomy-100000.srl` the dominant cost of the whole run
/// even though the N3 equivalent of the same benchmark has
/// nothing resembling it (`crate::n3::reasoner` has no stratification
/// step at all). Lookups here are an over-approximation of
/// `can_possibly_generate`'s exact per-position term compatibility (in
/// particular, they never look at the subject, and a body pattern's own
/// non-ground predicate or object falls back to every template sharing —
/// or, for a non-ground predicate, every template regardless of
/// predicate); every candidate is still re-checked with the exact
/// function before an edge is recorded, so this can only make the search
/// space smaller, never change which edges are found.
#[derive(Default)]
struct TemplateIndex {
    /// `(rule_idx, template)` pairs, in no particular order; every other
    /// field stores indices into this `Vec`.
    entries: Vec<(usize, Triple)>,
    /// Entries whose template has a non-ground predicate: compatible with
    /// any pattern regardless of predicate, so always a candidate.
    wildcard_predicate: Vec<usize>,
    /// Ground predicate, non-ground object: compatible with any pattern
    /// sharing that predicate regardless of the pattern's own object.
    by_p_open_object: BTreeMap<Term, Vec<usize>>,
    /// Ground predicate, ground object: compatible only with a pattern
    /// whose object is either equal or itself non-ground.
    by_po: BTreeMap<(Term, Term), Vec<usize>>,
    /// Every entry with this ground predicate, regardless of its object's
    /// groundness -- the fallback used when the *pattern's* own object is
    /// non-ground (so it could match a ground-object template too).
    by_p_all: BTreeMap<Term, Vec<usize>>,
}

impl TemplateIndex {
    fn build(infos: &[RuleFacts]) -> Self {
        let mut index = TemplateIndex::default();
        for (rule_idx, info) in infos.iter().enumerate() {
            for template in &info.head_templates {
                let entry_idx = index.entries.len();
                index.entries.push((rule_idx, template.clone()));
                if !template.p.is_ground() {
                    index.wildcard_predicate.push(entry_idx);
                    continue;
                }
                index.by_p_all.entry(template.p.clone()).or_default().push(entry_idx);
                if template.o.is_ground() {
                    index.by_po.entry((template.p.clone(), template.o.clone())).or_default().push(entry_idx);
                } else {
                    index.by_p_open_object.entry(template.p.clone()).or_default().push(entry_idx);
                }
            }
        }
        index
    }

    fn candidates(&self, pattern: &Triple) -> Vec<&(usize, Triple)> {
        let mut indices: Vec<usize> = self.wildcard_predicate.clone();
        if !pattern.p.is_ground() {
            indices.extend(self.by_p_all.values().flatten().copied());
        } else if !pattern.o.is_ground() {
            if let Some(entries) = self.by_p_all.get(&pattern.p) {
                indices.extend(entries.iter().copied());
            }
        } else {
            if let Some(entries) = self.by_p_open_object.get(&pattern.p) {
                indices.extend(entries.iter().copied());
            }
            if let Some(entries) = self.by_po.get(&(pattern.p.clone(), pattern.o.clone())) {
                indices.extend(entries.iter().copied());
            }
        }
        indices.into_iter().map(|i| &self.entries[i]).collect()
    }
}

fn rule_display_name(rules: &[SparqlRlRule], index: usize) -> String {
    rules[index].name.clone().unwrap_or_else(|| format!("rule#{}", index + 1))
}

/// A rule's own top-level positive body triple patterns (property paths
/// expanded to their per-segment predicate IRIs; patterns nested inside a
/// `NOT`/`NOT DATA` excluded). Exposed for `super::forward`'s rule-activation
/// index, which needs the same "what could feed this rule's body" shape
/// this module already computes for dependency-edge purposes.
pub(crate) fn rule_positive_patterns(rule: &SparqlRlRule) -> Vec<Triple> {
    rule_facts(rule).positive_patterns
}

struct RuleFacts {
    positive_patterns: Vec<Triple>,
    negative_patterns: Vec<Triple>,
    head_templates: Vec<Triple>,
    run_once: bool,
}

fn rule_facts(rule: &SparqlRlRule) -> RuleFacts {
    // `WHERE DATA { ... }` reads the immutable base graph only; rule heads
    // can never write to that graph, so it creates no dependency edges
    // (SPARQL 1.2 RL §4.3 dependency is about inference-graph
    // head/body matching).
    let (positive_patterns, negative_patterns) = if rule.ground_data {
        (Vec::new(), Vec::new())
    } else {
        (body_triple_patterns(&rule.body, false, false), body_triple_patterns(&rule.body, true, false))
    };
    RuleFacts { positive_patterns, negative_patterns, head_templates: effective_head_templates(rule), run_once: rule.run_once }
}

fn body_triple_patterns(clauses: &[Clause], want_negative: bool, in_negative_context: bool) -> Vec<Triple> {
    let mut out = Vec::new();
    for clause in clauses {
        match clause {
            Clause::Triple(t) if want_negative == in_negative_context => out.push(t.clone()),
            Clause::Path { p, .. } if want_negative == in_negative_context => out.extend(path_triple_patterns(p)),
            Clause::Not { body, ground_data } if !ground_data => out.extend(body_triple_patterns(body, want_negative, true)),
            _ => {}
        }
    }
    out
}

/// A property path's dependency shape: one synthetic triple pattern per
/// path segment, each with its own fresh, unconnected subject/object
/// variables (matching eyeleng's `pathTriplePatterns` exactly). Only the
/// predicate IRIs matter for dependency-edge purposes — the real endpoints
/// (`s`/`o`) are typically variables in body position anyway, which
/// `compatible_term` already treats as a wildcard, so nothing is lost by
/// not threading them through.
fn path_triple_patterns(path: &PathExpr) -> Vec<Triple> {
    path_predicate_iris(path)
        .into_iter()
        .enumerate()
        .map(|(i, predicate)| Triple::new(Term::var(format!("__path_s_{}", i)), Term::iri(predicate), Term::var(format!("__path_o_{}", i))))
        .collect()
}

fn path_predicate_iris(path: &PathExpr) -> Vec<String> {
    match path {
        PathExpr::Iri(iri) => vec![iri.clone()],
        PathExpr::Inverse(inner) => path_predicate_iris(inner),
        PathExpr::Sequence(parts) => parts.iter().flat_map(path_predicate_iris).collect(),
    }
}

/// A rule's head triples with any `SET`-assigned *constant* substituted in
/// (e.g. `SET(?kind := :Warning)` makes `?kind` in the head behave like the
/// literal IRI `:Warning` for dependency purposes), matching eyeleng's
/// `effectiveHeadTemplates`.
fn effective_head_templates(rule: &SparqlRlRule) -> Vec<Triple> {
    let constants = assignment_constant_terms(&rule.body);
    if constants.is_empty() {
        return rule.head.clone();
    }
    rule.head
        .iter()
        .map(|t| Triple::new(substitute_assigned_constant(&t.s, &constants), substitute_assigned_constant(&t.p, &constants), substitute_assigned_constant(&t.o, &constants)))
        .collect()
}

fn assignment_constant_terms(clauses: &[Clause]) -> BTreeMap<String, Term> {
    let mut constants = BTreeMap::new();
    let mut bound = BTreeSet::new();
    for clause in clauses {
        match clause {
            Clause::Triple(t) => collect_triple_vars(t, &mut bound),
            Clause::Path { s, o, .. } => {
                collect_term_vars(s, &mut bound);
                collect_term_vars(o, &mut bound);
            }
            Clause::Filter(_) | Clause::Not { .. } => {}
            Clause::Set { var, expr } => {
                if let Some(value) = constant_expression_term(expr) {
                    if !bound.contains(var) {
                        constants.insert(var.clone(), value);
                    }
                }
                bound.insert(var.clone());
            }
        }
    }
    constants
}

fn constant_expression_term(expr: &Expr) -> Option<Term> {
    let mut vars = BTreeSet::new();
    expr_variables(expr, &mut vars);
    if !vars.is_empty() {
        return None;
    }
    match expr {
        Expr::Term(t) => Some(t.clone()),
        _ => None,
    }
}

fn substitute_assigned_constant(term: &Term, constants: &BTreeMap<String, Term>) -> Term {
    match term {
        Term::Var(name) => constants.get(name).cloned().unwrap_or_else(|| term.clone()),
        Term::Formula(triples) => Term::Formula(
            triples
                .iter()
                .map(|t| Triple::new(substitute_assigned_constant(&t.s, constants), substitute_assigned_constant(&t.p, constants), substitute_assigned_constant(&t.o, constants)))
                .collect(),
        ),
        _ => term.clone(),
    }
}

fn collect_triple_vars(triple: &Triple, out: &mut BTreeSet<String>) {
    collect_term_vars(&triple.s, out);
    collect_term_vars(&triple.p, out);
    collect_term_vars(&triple.o, out);
}

fn collect_term_vars(term: &Term, out: &mut BTreeSet<String>) {
    match term {
        Term::Var(name) => {
            out.insert(name.clone());
        }
        Term::Formula(triples) => triples.iter().for_each(|t| collect_triple_vars(t, out)),
        Term::List(items) => items.iter().for_each(|t| collect_term_vars(t, out)),
        _ => {}
    }
}

/// Whether `template` (a rule head triple, ground where possible) could
/// possibly produce a fact matching `pattern` (a rule body triple pattern).
/// This is a syntactic over-approximation used only to decide dependency
/// *edges*; it never needs to be exact, only sound (it must not omit a
/// real dependency), so a "maybe" is treated as "yes".
fn can_possibly_generate(template: &Triple, pattern: &Triple) -> bool {
    if !compatible_term(&template.s, &pattern.s) || !compatible_term(&template.p, &pattern.p) || !compatible_term(&template.o, &pattern.o) {
        return false;
    }
    let mut constraints = BTreeMap::new();
    record_template_variable_constraints(&template.s, &pattern.s, &mut constraints)
        && record_template_variable_constraints(&template.p, &pattern.p, &mut constraints)
        && record_template_variable_constraints(&template.o, &pattern.o, &mut constraints)
}

fn compatible_term(template: &Term, pattern: &Term) -> bool {
    if matches!(template, Term::Var(_)) || matches!(pattern, Term::Var(_)) {
        return true;
    }
    match (template, pattern) {
        (Term::Formula(t1), Term::Formula(t2)) => {
            t1.len() == t2.len() && t1.iter().zip(t2).all(|(a, b)| compatible_term(&a.s, &b.s) && compatible_term(&a.p, &b.p) && compatible_term(&a.o, &b.o))
        }
        (Term::Formula(_), _) | (_, Term::Formula(_)) => false,
        _ => template == pattern,
    }
}

fn record_template_variable_constraints(template: &Term, pattern: &Term, constraints: &mut BTreeMap<String, Term>) -> bool {
    match template {
        Term::Var(name) => match constraints.get(name) {
            None => {
                constraints.insert(name.clone(), pattern.clone());
                true
            }
            Some(existing) => possibly_same_term(existing, pattern),
        },
        Term::Formula(t1) => match pattern {
            Term::Formula(t2) if t1.len() == t2.len() => t1.iter().zip(t2).all(|(a, b)| {
                record_template_variable_constraints(&a.s, &b.s, constraints)
                    && record_template_variable_constraints(&a.p, &b.p, constraints)
                    && record_template_variable_constraints(&a.o, &b.o, constraints)
            }),
            _ => true,
        },
        _ => true,
    }
}

fn possibly_same_term(a: &Term, b: &Term) -> bool {
    if matches!(a, Term::Var(_)) || matches!(b, Term::Var(_)) {
        return true;
    }
    match (a, b) {
        (Term::Formula(t1), Term::Formula(t2)) => t1.len() == t2.len() && t1.iter().zip(t2).all(|(x, y)| possibly_same_term(&x.s, &y.s) && possibly_same_term(&x.p, &y.p) && possibly_same_term(&x.o, &y.o)),
        (Term::Formula(_), _) | (_, Term::Formula(_)) => false,
        _ => a == b,
    }
}

fn stratification_layers(n: usize, edges: &[Edge]) -> Vec<Vec<usize>> {
    if n == 0 {
        return Vec::new();
    }
    let mut levels = vec![0usize; n];
    let mut changed = true;
    let mut guard = 0usize;
    while changed && guard <= n + 1 {
        changed = false;
        for edge in edges {
            let required = levels[edge.to] + usize::from(edge.closed);
            if levels[edge.from] < required {
                levels[edge.from] = required;
                changed = true;
            }
        }
        guard += 1;
    }
    let max_level = levels.iter().copied().max().unwrap_or(0);
    let mut layers = vec![Vec::new(); max_level + 1];
    for (rule_index, level) in levels.into_iter().enumerate() {
        layers[level].push(rule_index);
    }
    layers
}

/// Iterative Kosaraju's algorithm (avoids recursion depth limits on large
/// rule sets), ported from eyeleng's `stronglyConnectedComponents`.
fn strongly_connected_components(size: usize, edges: &[Edge]) -> Vec<Vec<usize>> {
    let mut adjacency = vec![Vec::new(); size];
    let mut reverse = vec![Vec::new(); size];
    for edge in edges {
        adjacency[edge.from].push(edge.to);
        reverse[edge.to].push(edge.from);
    }

    let mut visited = vec![false; size];
    let mut order = Vec::with_capacity(size);
    for start in 0..size {
        if visited[start] {
            continue;
        }
        let mut stack = vec![(start, 0usize)];
        visited[start] = true;
        while let Some(&mut (v, ref mut next_index)) = stack.last_mut() {
            if *next_index < adjacency[v].len() {
                let w = adjacency[v][*next_index];
                *next_index += 1;
                if !visited[w] {
                    visited[w] = true;
                    stack.push((w, 0));
                }
            } else {
                order.push(v);
                stack.pop();
            }
        }
    }

    let mut assigned = vec![false; size];
    let mut components = Vec::new();
    for &start in order.iter().rev() {
        if assigned[start] {
            continue;
        }
        let mut component = Vec::new();
        let mut stack = vec![start];
        assigned[start] = true;
        while let Some(v) = stack.pop() {
            component.push(v);
            for &w in &reverse[v] {
                if !assigned[w] {
                    assigned[w] = true;
                    stack.push(w);
                }
            }
        }
        component.sort_unstable();
        components.push(component);
    }
    components
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::srl::parser::parse_sparql_rl;

    fn rules_of(src: &str) -> Vec<SparqlRlRule> {
        parse_sparql_rl(src, None).unwrap().rules
    }

    #[test]
    fn independent_rules_form_one_layer() {
        let rules = rules_of(
            "PREFIX : <http://example/>\n\
             RULE { ?x :childOf ?y } WHERE { ?y :fatherOf ?x }\n\
             RULE { ?x :childOf ?y } WHERE { ?y :motherOf ?x }",
        );
        let layers = stratify(&rules).unwrap();
        assert_eq!(layers.len(), 1);
        assert_eq!(layers[0].len(), 2);
    }

    #[test]
    fn positive_recursion_stays_in_one_stratum() {
        let rules = rules_of(
            "PREFIX : <http://example/>\n\
             RULE { ?x :descendedFrom ?y } WHERE { ?x :childOf ?y }\n\
             RULE { ?x :descendedFrom ?y } WHERE { ?x :childOf ?z . ?z :descendedFrom ?y }",
        );
        let layers = stratify(&rules).unwrap();
        assert_eq!(layers.len(), 1);
    }

    #[test]
    fn negation_forces_a_later_stratum() {
        // Rule 1 negates `:childOf`, which rule 0 derives from `:fatherOf` —
        // a genuine closed dependency, unlike a negated pattern nothing
        // ever produces.
        let rules = rules_of(
            "PREFIX : <http://example/>\n\
             RULE { ?x :childOf ?y } WHERE { ?y :fatherOf ?x }\n\
             RULE { ?x a :Orphan } WHERE { ?x a :Person . NOT { ?x :childOf ?y } }",
        );
        let layers = stratify(&rules).unwrap();
        assert_eq!(layers.len(), 2);
        assert_eq!(layers[0], vec![0]);
        assert_eq!(layers[1], vec![1]);
    }

    #[test]
    fn recursive_negation_is_rejected() {
        let rules = rules_of(
            "PREFIX : <http://example/>\n\
             RULE { ?x :p true } WHERE { NOT { ?x :q true } }\n\
             RULE { ?x :q true } WHERE { NOT { ?x :p true } }",
        );
        let err = stratify(&rules).unwrap_err();
        assert!(err.message.contains("stratification"), "{}", err.message);
    }

    #[test]
    fn not_data_creates_no_dependency() {
        let rules = rules_of(
            "PREFIX : <http://example/>\n\
             RULE { ?x a :Person } WHERE { ?x :name ?n }\n\
             RULE { ?x a :Eligible } WHERE { ?x a :Person . NOT DATA { ?x :banned true } }",
        );
        let layers = stratify(&rules).unwrap();
        // `NOT DATA` reads the immutable base graph, which no rule head can
        // write to, so this negation creates no dependency edge at all —
        // both rules can share a stratum.
        assert_eq!(layers.len(), 1);
    }
}
