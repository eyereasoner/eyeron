//! SRL-native `--proof` rendering.
//!
//! `n3::proof::proof_to_n3` writes a proof step as a top-level triple whose
//! subject is the quoted conclusion (`{ s p o } pe:rule 1; ...`), which is
//! idiomatic N3 but not valid `.srl`: SRL has no bare `{ ... }` graph term,
//! only the single-triple RDF-star triple term `<<(s p o)>>` (see
//! `parser.rs`'s own doc comment on why it reuses `Term::Formula(vec![t])`
//! for that, not for general quoted graphs). So instead each step here is a
//! small blank node reifying its own conclusion — `_:stepN rdf:reifies
//! <<(s p o)>>` — the same idiom `examples/proof-audit.srl` demonstrates
//! by hand, with `pe:uses` linking straight to the blank nodes of the steps
//! it depended on rather than repeating their triples. Every step lives in
//! one flat `DATA { ... }` block, since SRL has no bare top-level triples.
//! The result is an ordinary `.srl` document: `PREFIX` headers and one `DATA
//! { ... }` block, loadable by eyeron like any other rule set's data.
//!
//! The analysis phase (one walk across every claim, into a flat list of
//! `ProofEntry`s with each conclusion explained once) is shared with
//! `n3::proof` verbatim, via items it exposes as `pub(crate)`; only the
//! rendering below is SRL-specific.

use crate::ast::*;
use super::printing::{term_to_srl, triple_term, triple_to_srl};
use crate::n3::proof::{
    collect_all_proof_entries, collect_prefixes_triple, index_by_conclusion, justification, quoted_string, render_predicate_objects, rule_reference, unique_proofs,
    vars_in_rule, RuleNumbering,
    ProofEntry,
};
use crate::n3::reasoner::{DerivedFact, ReasonerResult};
use std::collections::{BTreeMap, BTreeSet};

const PE_NS: &str = "https://eyereasoner.github.io/pe#";
const RDF_NS: &str = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";

pub fn proof_to_srl(prefixes: &BTreeMap<String, String>, result: &ReasonerResult) -> String {
    if result.proofs.is_empty() {
        return String::new();
    }

    let selected = unique_proofs(&result.proofs);
    let derived_by_fact = index_by_conclusion(&result.proofs);
    let explicit_facts = result.explicit.iter().cloned().collect::<BTreeSet<_>>();

    // One walk across every root, so a premise shared by several
    // derivations is explained once rather than once per root.
    let entries = collect_all_proof_entries(&selected, &derived_by_fact, &explicit_facts, &result.explicit_sources, &result.closure, &result.rules);

    // One stable `_:stepN` id per distinct fact, in first-encounter order
    // across every root; a fact reached from several roots (or as both a
    // root and someone else's premise) collapses onto the same id. The id
    // is the number alone until it is written: a long chain has as many
    // steps as rules, and a name held twice per step is two strings per
    // rule of the program.
    let mut fact_to_step = BTreeMap::<&Triple, usize>::new();
    let mut steps = Vec::<(usize, &ProofEntry)>::new();
    for entry in entries.iter() {
        // A fact that is simply given in `DATA` or the base graph gets no
        // step of its own: there is nothing to explain about it, and
        // `pe:uses` names it by its own triple term instead. Only a
        // derived fact (or a builtin/unproven premise, which carries its
        // own annotation) becomes a step.
        if matches!(entry, ProofEntry::Fact { .. }) {
            continue;
        }
        let fact = entry_fact(entry);
        if fact_to_step.contains_key(fact) {
            continue;
        }
        let id = fact_to_step.len() + 1;
        fact_to_step.insert(fact, id);
        steps.push((id, entry));
    }

    let mut proof_prefixes = prefixes.clone();
    proof_prefixes.entry("pe".to_string()).or_insert_with(|| PE_NS.to_string());
    proof_prefixes.entry("rdf".to_string()).or_insert_with(|| RDF_NS.to_string());
    let used = used_prefixes(&proof_prefixes, &selected, &entries);

    let mut header = Vec::<String>::new();
    for prefix in &used {
        let Some(base) = proof_prefixes.get(prefix) else { continue };
        if base.is_empty() {
            continue;
        }
        if prefix.is_empty() {
            header.push(format!("PREFIX : <{}>", base));
        } else {
            header.push(format!("PREFIX {}: <{}>", prefix, base));
        }
    }

    let numbering = RuleNumbering::new(&result.rules);
    let mut body = Vec::<String>::new();
    let mut output_seen = BTreeSet::<&Triple>::new();
    for root in &selected {
        if output_seen.insert(&root.fact) {
            body.push(format!("  {}", triple_to_srl(&root.fact, &proof_prefixes)));
        }
    }
    body.push(String::new());

    for (idx, (id, entry)) in steps.iter().enumerate() {
        if idx > 0 {
            body.push(String::new());
        }
        body.push(render_step(*id, entry, &fact_to_step, &numbering, &proof_prefixes));
    }

    let mut parts = header;
    if !parts.is_empty() {
        parts.push(String::new());
    }
    parts.push("DATA {".to_string());
    parts.extend(body);
    parts.push("}".to_string());

    parts.join("\n").trim_end().to_string() + "\n"
}

fn entry_fact<'a>(entry: &'a ProofEntry<'a>) -> &'a Triple {
    match entry {
        ProofEntry::Rule(df) => &df.fact,
        ProofEntry::Fact { fact, .. } => fact,
        ProofEntry::Builtin { fact, .. } => fact,
        ProofEntry::Unproven { fact, .. } => fact,
    }
}

fn render_step(id: usize, entry: &ProofEntry<'_>, fact_to_step: &BTreeMap<&Triple, usize>, numbering: &RuleNumbering, prefixes: &BTreeMap<String, String>) -> String {
    match entry {
        ProofEntry::Rule(proof) => render_rule_step(id, proof, fact_to_step, numbering, prefixes),
        // Collection above never makes a step for a given fact.
        ProofEntry::Fact { fact, .. } => render_step_groups(id, &[("rdf:reifies".to_string(), vec![triple_term(fact, prefixes)])]),
        ProofEntry::Builtin { fact, builtin } => render_step_groups(
            id,
            &[("rdf:reifies".to_string(), vec![triple_term(fact, prefixes)]), justification("builtin", term_to_srl(builtin, prefixes, false))],
        ),
        ProofEntry::Unproven { fact, reason } => render_step_groups(
            id,
            &[("rdf:reifies".to_string(), vec![triple_term(fact, prefixes)]), justification("unproven", quoted_string(reason))],
        ),
    }
}

fn render_rule_step(id: usize, proof: &DerivedFact, fact_to_step: &BTreeMap<&Triple, usize>, numbering: &RuleNumbering, prefixes: &BTreeMap<String, String>) -> String {
    let mut groups = vec![("rdf:reifies".to_string(), vec![triple_term(&proof.fact, prefixes)])];
    groups.push(justification("rule", rule_reference(&proof.rule, numbering, prefixes)));

    let bindings = render_binding_items(proof, prefixes);
    if !bindings.is_empty() {
        groups.push(("pe:binding".to_string(), bindings));
    }

    let uses: Vec<String> = proof
        .premises
        .iter()
        .map(|premise| fact_to_step.get(premise).map(|id| step_name(*id)).unwrap_or_else(|| triple_term(premise, prefixes)))
        .collect();
    if !uses.is_empty() {
        groups.push(("pe:uses".to_string(), uses));
    }

    render_step_groups(id, &groups)
}

fn step_name(id: usize) -> String {
    format!("_:step{}", id)
}

fn render_step_groups(id: usize, groups: &[(String, Vec<String>)]) -> String {
    let mut out = String::new();
    out.push_str("  ");
    out.push_str(&step_name(id));
    out.push('\n');
    for (idx, (predicate, objects)) in groups.iter().enumerate() {
        let is_last = idx + 1 == groups.len();
        for line in render_predicate_objects(predicate, objects, is_last) {
            out.push_str(&line);
            out.push('\n');
        }
    }
    out.trim_end().to_string()
}

fn render_binding_items(proof: &DerivedFact, prefixes: &BTreeMap<String, String>) -> Vec<String> {
    let rule_vars = vars_in_rule(&proof.rule);
    // A property path's join variables are introduced by expanding the
    // path, not written by anyone, so they are noise in a trace. Leaving
    // them out loses nothing a checker needs: `pe:uses` names the matched
    // triples outright, and matching them against the rule's patterns
    // determines the join.
    let mut items = proof
        .bindings
        .iter()
        .filter(|(name, _)| rule_vars.contains(name) && !name.starts_with("__path_"))
        .map(|(name, value)| {
            let display = proof.rule.proof_var_source_names.get(name).unwrap_or(name);
            (display.clone(), format!("[ pe:var {}; pe:value {} ]", quoted_string(display), term_to_srl(value, prefixes, false)))
        })
        .collect::<Vec<_>>();
    items.sort();
    items.into_iter().map(|(_, item)| item).collect()
}

fn used_prefixes(prefixes: &BTreeMap<String, String>, roots: &[&DerivedFact], entries: &[ProofEntry]) -> BTreeSet<String> {
    let mut used = BTreeSet::new();
    used.insert("pe".to_string());
    used.insert("rdf".to_string());
    for root in roots {
        collect_prefixes_triple(&root.fact, prefixes, &mut used);
    }
    for entry in entries {
        match entry {
            ProofEntry::Rule(df) => {
                collect_prefixes_triple(&df.fact, prefixes, &mut used);
                for prem in &df.premises {
                    collect_prefixes_triple(prem, prefixes, &mut used);
                }
            }
            ProofEntry::Fact { fact, .. } => collect_prefixes_triple(fact, prefixes, &mut used),
            ProofEntry::Builtin { fact, .. } => collect_prefixes_triple(fact, prefixes, &mut used),
            ProofEntry::Unproven { fact, .. } => collect_prefixes_triple(fact, prefixes, &mut used),
        }
    }
    used
}
