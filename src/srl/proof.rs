//! SRL-native `--proof` rendering.
//!
//! `n3::proof::proof_to_n3` represents a proof step as an N3 quoted-formula
//! subject (`{ s p o } pe:why { ...steps... }`), which is idiomatic N3 but
//! not valid `.srl`: SRL's grammar has no bare `{ ... }` graph-literal term,
//! only the single-triple RDF-star triple term `<<( s p o )>>` (see
//! `parser.rs`'s own doc comment on why it reuses `Term::Formula(vec![t])`
//! for that, not for general quoted graphs). So instead each step here is a
//! small blank node reifying its own conclusion — `_:stepN rdf:reifies
//! <<( s p o )>>` — the same idiom `examples/proof-audit.srl` demonstrates
//! by hand, with `pe:uses` linking straight to the blank nodes of the steps
//! it depended on rather than repeating their triples. Every step lives in
//! one flat `DATA { ... }` block (SRL has no bare top-level triples), which
//! also naturally deduplicates a fact reached from more than one place —
//! unlike `proof_to_n3`'s one-`pe:why`-tree-per-derived-fact structure,
//! where a shared premise is repeated under every root that uses it. The
//! result is an ordinary `.srl` document: `PREFIX` headers and one `DATA
//! { ... }` block, loadable by eyeron like any other rule set's data.
//!
//! The analysis phase (walking each derived fact's proof tree into a flat
//! list of `ProofEntry`s) is shared with `n3::proof` verbatim, via items it
//! exposes as `pub(crate)`; only the rendering below is SRL-specific.

use crate::ast::*;
use crate::n3::printing::{term_to_n3_object, term_to_n3_predicate};
use crate::n3::proof::{
    collect_prefixes_triple, collect_proof_entries, quoted_string, render_predicate_objects, source_label_for_proof, unique_proofs, vars_in_rule,
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
    let mut derived_by_fact = BTreeMap::<Triple, Vec<DerivedFact>>::new();
    for proof in &result.proofs {
        derived_by_fact.entry(proof.fact.clone()).or_default().push(proof.clone());
    }
    let explicit_facts = result.explicit.iter().cloned().collect::<BTreeSet<_>>();

    let mut root_entries = Vec::<(DerivedFact, Vec<ProofEntry>)>::new();
    for proof in selected {
        let entries = collect_proof_entries(&proof, &derived_by_fact, &explicit_facts, &result.explicit_sources, &result.explicit, &result.rules);
        root_entries.push((proof, entries));
    }

    // One stable `_:stepN` id per distinct fact, in first-encounter order
    // across every root; a fact reached from several roots (or as both a
    // root and someone else's premise) collapses onto the same id.
    let mut fact_to_step = BTreeMap::<Triple, String>::new();
    let mut steps = Vec::<(String, ProofEntry)>::new();
    for (_, entries) in &root_entries {
        for entry in entries {
            let fact = entry_fact(entry);
            if fact_to_step.contains_key(fact) {
                continue;
            }
            let id = format!("_:step{}", fact_to_step.len() + 1);
            fact_to_step.insert(fact.clone(), id.clone());
            steps.push((id, entry.clone()));
        }
    }

    let mut proof_prefixes = prefixes.clone();
    proof_prefixes.entry("pe".to_string()).or_insert_with(|| PE_NS.to_string());
    proof_prefixes.entry("rdf".to_string()).or_insert_with(|| RDF_NS.to_string());
    let used = used_prefixes(&proof_prefixes, &root_entries);

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

    let mut body = Vec::<String>::new();
    let mut output_seen = BTreeSet::<Triple>::new();
    for (root, _) in &root_entries {
        if output_seen.insert(root.fact.clone()) {
            body.push(format!("  {}", triple_to_srl(&root.fact, &proof_prefixes)));
        }
    }
    body.push(String::new());

    for (idx, (id, entry)) in steps.iter().enumerate() {
        if idx > 0 {
            body.push(String::new());
        }
        body.push(render_step(id, entry, &fact_to_step, &proof_prefixes));
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

fn entry_fact(entry: &ProofEntry) -> &Triple {
    match entry {
        ProofEntry::Rule(df) => &df.fact,
        ProofEntry::Fact { fact, .. } => fact,
        ProofEntry::Builtin { fact, .. } => fact,
        ProofEntry::Unproven { fact, .. } => fact,
    }
}

fn render_step(id: &str, entry: &ProofEntry, fact_to_step: &BTreeMap<Triple, String>, prefixes: &BTreeMap<String, String>) -> String {
    match entry {
        ProofEntry::Rule(proof) => render_rule_step(id, proof, fact_to_step, prefixes),
        ProofEntry::Fact { fact, source } => {
            let mut groups = vec![("rdf:reifies".to_string(), vec![triple_term(fact, prefixes)])];
            push_source_groups(&mut groups, "fact", source.as_ref());
            render_step_groups(id, &groups)
        }
        ProofEntry::Builtin { fact, builtin } => render_step_groups(
            id,
            &[("rdf:reifies".to_string(), vec![triple_term(fact, prefixes)]), ("pe:builtin".to_string(), vec![term_to_srl(builtin, prefixes, false)])],
        ),
        ProofEntry::Unproven { fact, reason } => render_step_groups(
            id,
            &[("rdf:reifies".to_string(), vec![triple_term(fact, prefixes)]), ("pe:unproven".to_string(), vec![quoted_string(reason)])],
        ),
    }
}

fn render_rule_step(id: &str, proof: &DerivedFact, fact_to_step: &BTreeMap<Triple, String>, prefixes: &BTreeMap<String, String>) -> String {
    let mut groups = vec![("rdf:reifies".to_string(), vec![triple_term(&proof.fact, prefixes)])];
    push_source_groups(&mut groups, "rule", proof.rule.source.as_ref());

    let bindings = render_binding_items(proof, prefixes);
    if !bindings.is_empty() {
        groups.push(("pe:binding".to_string(), bindings));
    }

    let uses: Vec<String> = proof
        .premises
        .iter()
        .map(|premise| fact_to_step.get(premise).cloned().unwrap_or_else(|| triple_term(premise, prefixes)))
        .collect();
    if !uses.is_empty() {
        groups.push(("pe:uses".to_string(), uses));
    }

    render_step_groups(id, &groups)
}

fn push_source_groups(groups: &mut Vec<(String, Vec<String>)>, kind: &str, source: Option<&SourceRef>) {
    let label = source.map(|s| source_label_for_proof(&s.label)).unwrap_or_else(|| "<unknown>".to_string());
    groups.push((format!("pe:{kind}"), vec![quoted_string(&label)]));
    if let Some(source) = source {
        if source.line > 0 {
            groups.push(("pe:line".to_string(), vec![source.line.to_string()]));
        }
    }
}

fn render_step_groups(id: &str, groups: &[(String, Vec<String>)]) -> String {
    let mut out = String::new();
    out.push_str("  ");
    out.push_str(id);
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
    let mut names = proof.bindings.keys().filter(|name| rule_vars.contains(*name)).cloned().collect::<Vec<_>>();
    names.sort();
    names
        .into_iter()
        .filter_map(|name| {
            let value = proof.bindings.get(&name)?;
            let display = proof.rule.proof_var_source_names.get(&name).unwrap_or(&name);
            Some(format!("[ pe:var {}; pe:value {} ]", quoted_string(display), term_to_srl(value, prefixes, false)))
        })
        .collect()
}

/// `<<( s p o )>>`, the RDF-star triple-term syntax SRL parses `Term::
/// Formula(vec![triple])` from — used both for a step's own `rdf:reifies`
/// object and, recursively via `term_to_srl`, for any triple-term-valued
/// binding or premise.
fn triple_term(triple: &Triple, prefixes: &BTreeMap<String, String>) -> String {
    format!(
        "<<( {} {} {} )>>",
        term_to_srl(&triple.s, prefixes, false),
        term_to_srl(&triple.p, prefixes, true),
        term_to_srl(&triple.o, prefixes, false),
    )
}

fn triple_to_srl(triple: &Triple, prefixes: &BTreeMap<String, String>) -> String {
    format!(
        "{} {} {} .",
        term_to_srl(&triple.s, prefixes, false),
        term_to_srl(&triple.p, prefixes, true),
        term_to_srl(&triple.o, prefixes, false),
    )
}

/// Like `n3::printing::term_to_n3_object`/`term_to_n3_predicate`, except a
/// single-triple `Term::Formula` — the only shape SRL's own parser ever
/// produces — renders as `<<( ... )>>` instead of N3's `{ ... }`, which
/// `.srl` cannot parse back in.
fn term_to_srl(term: &Term, prefixes: &BTreeMap<String, String>, predicate_position: bool) -> String {
    if let Term::Formula(triples) = term {
        if triples.len() == 1 {
            return triple_term(&triples[0], prefixes);
        }
    }
    if predicate_position {
        term_to_n3_predicate(term, prefixes)
    } else {
        term_to_n3_object(term, prefixes)
    }
}

fn used_prefixes(prefixes: &BTreeMap<String, String>, root_entries: &[(DerivedFact, Vec<ProofEntry>)]) -> BTreeSet<String> {
    let mut used = BTreeSet::new();
    used.insert("pe".to_string());
    used.insert("rdf".to_string());
    for (root, entries) in root_entries {
        collect_prefixes_triple(&root.fact, prefixes, &mut used);
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
    }
    used
}
