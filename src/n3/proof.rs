use crate::ast::*;
use crate::n3::printing::{term_to_n3_object, triple_to_n3};
use crate::n3::reasoner::{explain_backward, BackwardStep, DerivedFact, ReasonerResult};
use std::collections::{BTreeMap, BTreeSet, HashSet};
use std::path::Path;

const PE_NS: &str = "https://eyereasoner.github.io/pe#";

pub fn proof_to_n3(prefixes: &BTreeMap<String, String>, result: &ReasonerResult) -> String {
    if result.proofs.is_empty() { return String::new(); }

    let selected = unique_proofs(&result.proofs);
    let mut derived_by_fact = BTreeMap::<Triple, Vec<DerivedFact>>::new();
    for proof in &result.proofs {
        derived_by_fact.entry(proof.fact.clone()).or_default().push(proof.clone());
    }
    let explicit_facts = result.explicit.iter().cloned().collect::<BTreeSet<_>>();

    let mut root_entries = Vec::<(DerivedFact, Vec<ProofEntry>)>::new();
    for proof in selected {
        let entries = collect_proof_entries(
            &proof,
            &derived_by_fact,
            &explicit_facts,
            &result.explicit_sources,
            &result.explicit,
            &result.rules,
        );
        root_entries.push((proof, entries));
    }

    let mut proof_prefixes = prefixes.clone();
    proof_prefixes.entry("pe".to_string()).or_insert_with(|| PE_NS.to_string());
    let used = used_prefixes_for_proof(&proof_prefixes, &root_entries);

    let mut parts = Vec::<String>::new();
    for prefix in &used {
        let Some(base) = proof_prefixes.get(prefix) else { continue; };
        if base.is_empty() { continue; }
        if prefix.is_empty() {
            parts.push(format!("@prefix : <{}> .", base));
        } else {
            parts.push(format!("@prefix {}: <{}> .", prefix, base));
        }
    }
    if !parts.is_empty() { parts.push(String::new()); }

    let mut output_seen = BTreeSet::<Triple>::new();
    for (proof, _) in &root_entries {
        if output_seen.insert(proof.fact.clone()) {
            parts.push(triple_to_n3(&proof_prefixes, &proof.fact));
        }
    }
    parts.push(String::new());

    for (idx, (proof, entries)) in root_entries.iter().enumerate() {
        if idx > 0 { parts.push(String::new()); }
        parts.push(render_proof_block(proof, entries, &result.rules, &proof_prefixes));
    }

    parts.join("\n").trim_end().to_string() + "\n"
}

pub(crate) fn unique_proofs(proofs: &[DerivedFact]) -> Vec<DerivedFact> {
    let mut seen = BTreeSet::<Triple>::new();
    let mut out = Vec::new();
    for proof in proofs {
        if seen.insert(proof.fact.clone()) {
            out.push(proof.clone());
        }
    }
    out
}

#[derive(Debug, Clone)]
pub(crate) enum ProofEntry {
    Rule(DerivedFact),
    Fact { fact: Triple, source: Option<SourceRef> },
    Builtin { fact: Triple, builtin: Term },
    Unproven { fact: Triple, reason: String },
}

pub(crate) fn collect_proof_entries(
    root: &DerivedFact,
    derived_by_fact: &BTreeMap<Triple, Vec<DerivedFact>>,
    explicit_facts: &BTreeSet<Triple>,
    explicit_sources: &BTreeMap<Triple, SourceRef>,
    base_facts: &[Triple],
    rules: &[Rule],
) -> Vec<ProofEntry> {
    let mut collector = ProofCollector {
        derived_by_fact,
        explicit_facts,
        explicit_sources,
        base_facts,
        rules,
        seen: HashSet::new(),
        entries: Vec::new(),
    };
    collector.visit_derived_fact(root);
    collector.entries
}

struct ProofCollector<'a> {
    derived_by_fact: &'a BTreeMap<Triple, Vec<DerivedFact>>,
    explicit_facts: &'a BTreeSet<Triple>,
    explicit_sources: &'a BTreeMap<Triple, SourceRef>,
    base_facts: &'a [Triple],
    rules: &'a [Rule],
    seen: HashSet<String>,
    entries: Vec<ProofEntry>,
}

impl ProofCollector<'_> {
    fn visit_derived_fact(&mut self, proof: &DerivedFact) {
        let key = format!("rule:{}:{}", triple_key(&proof.fact), source_key(proof.rule.source.as_ref()));
        if !self.seen.insert(key) { return; }
        self.entries.push(ProofEntry::Rule(proof.clone()));

        for premise in &proof.premises {
            self.visit_premise(premise, Some(proof));
        }
    }

    fn remember_backward_step(&mut self, step: BackwardStep) {
        match step {
            BackwardStep::Rule(df) => {
                let key = format!("rule:{}:{}", triple_key(&df.fact), source_key(df.rule.source.as_ref()));
                if self.seen.insert(key) {
                    self.entries.push(ProofEntry::Rule(df));
                }
            }
            BackwardStep::Fact { fact } => {
                let source = self.explicit_sources.get(&fact).cloned();
                self.remember_entry(ProofEntry::Fact { fact, source });
            }
            BackwardStep::Builtin { fact, builtin } => self.remember_entry(ProofEntry::Builtin { fact, builtin }),
            BackwardStep::Unproven { fact, reason } => self.remember_entry(ProofEntry::Unproven { fact, reason }),
        }
    }

    fn visit_premise(&mut self, premise: &Triple, parent: Option<&DerivedFact>) {
        if let Some(candidates) = self.derived_by_fact.get(premise) {
            if let Some(child) = candidates.iter().find(|candidate| match parent { Some(p) => candidate.fact != p.fact, None => true }) {
                self.visit_derived_fact(child);
                return;
            }
        }

        // An exact match against an already-ground ambient fact is always
        // more authoritative than a goal-directed backward search: a
        // premise's own blank nodes (e.g. from a rule pattern resolved
        // against this derivation's own bindings) are already fixed
        // constants here, not free variables to unify afresh, but
        // `find_backward_proof_for_goal`'s unification treats them as
        // such and can match a *different*, merely pattern-compatible
        // explicit fact (e.g. `:root pe:binding _:b1` for a goal of
        // `:root pe:binding _:b2`) — checking the explicit set first, by
        // exact triple equality, avoids that misattribution.
        if self.explicit_facts.contains(premise) {
            let source = self.explicit_sources.get(premise).cloned();
            self.remember_entry(ProofEntry::Fact { fact: premise.clone(), source });
            return;
        }

        // The explanation comes back as a flat set of steps rather than a
        // tree, so a premise used more than once is explained once.
        let mut steps = Vec::new();
        if explain_backward(premise, self.base_facts, self.rules, 4096, &mut |step| steps.push(step)) {
            for step in steps {
                self.remember_backward_step(step);
            }
            return;
        }

        self.remember_entry(ProofEntry::Unproven {
            fact: premise.clone(),
            reason: if is_builtin_premise(premise) {
                "builtin evaluation did not verify this premise".to_string()
            } else {
                "no explicit fact, verified builtin, or backward proof was found".to_string()
            },
        });
    }

    fn remember_entry(&mut self, entry: ProofEntry) {
        let key = match &entry {
            ProofEntry::Rule(df) => format!("rule:{}:{}", triple_key(&df.fact), source_key(df.rule.source.as_ref())),
            ProofEntry::Fact { fact, source } => format!("fact:{}:{}", triple_key(fact), source_key(source.as_ref())),
            ProofEntry::Builtin { fact, .. } => format!("builtin:{}", triple_key(fact)),
            ProofEntry::Unproven { fact, .. } => format!("unproven:{}", triple_key(fact)),
        };
        if self.seen.insert(key) { self.entries.push(entry); }
    }
}

/// The 1-based position of `rule` in the document's rule list — the number
/// a proof step cites. `proof_to_n3` and `proof_to_srl` both cite a rule
/// this way, and `prolog::output` cites a clause by its own number, so a
/// step reads the same in all three formats.
///
/// A rule's source location is tried first and structural equality only as
/// a fallback, because the rule a `DerivedFact` carries is not always
/// `==` to the one in the document: backward chaining and rule generation
/// both rewrite a rule's premises or conclusion while leaving its source
/// alone. A rule with no source at all (one the reasoner generated at run
/// time) has no number to cite.
pub(crate) fn rule_number(rule: &Rule, rules: &[Rule]) -> Option<usize> {
    if let Some(source) = &rule.source {
        if let Some(index) = rules.iter().position(|candidate| candidate.source.as_ref() == Some(source)) {
            return Some(index + 1);
        }
    }
    rules.iter().position(|candidate| candidate == rule).map(|index| index + 1)
}

/// The one predicate that says why a step holds, and its object. Every
/// step carries exactly one, which is what lets a reader of any of the
/// three proof formats find the justification in the same place.
pub(crate) fn justification(kind: &str, object: String) -> (String, Vec<String>) {
    (format!("pe:{}", kind), vec![object])
}

fn render_proof_block(root: &DerivedFact, entries: &[ProofEntry], rules: &[Rule], prefixes: &BTreeMap<String, String>) -> String {
    let root_graph = graph_for_triple(&root.fact, prefixes);
    let mut out = String::new();
    out.push_str(&root_graph);
    out.push_str(" pe:why {");
    if !entries.is_empty() { out.push('\n'); }
    for (idx, entry) in entries.iter().enumerate() {
        if idx > 0 { out.push('\n'); }
        out.push_str(&render_entry(entry, rules, prefixes));
        out.push('\n');
    }
    out.push_str("}.");
    out
}

fn render_entry(entry: &ProofEntry, rules: &[Rule], prefixes: &BTreeMap<String, String>) -> String {
    match entry {
        ProofEntry::Rule(proof) => render_rule_entry(proof, rules, prefixes),
        ProofEntry::Fact { fact, source } => {
            format!("  {}\n    pe:fact {}.", graph_for_triple(fact, prefixes), quoted_string(&fact_label(source.as_ref())))
        }
        ProofEntry::Builtin { fact, builtin } => {
            format!("  {}\n    pe:builtin {}.", graph_for_triple(fact, prefixes), term_to_n3_object(builtin, prefixes))
        }
        ProofEntry::Unproven { fact, reason } => {
            format!("  {}\n    pe:unproven {}.", graph_for_triple(fact, prefixes), quoted_string(reason))
        }
    }
}

fn render_rule_entry(proof: &DerivedFact, rules: &[Rule], prefixes: &BTreeMap<String, String>) -> String {
    let subject = graph_for_triple(&proof.fact, prefixes);
    let mut groups = Vec::<(String, Vec<String>)>::new();
    groups.push(justification("rule", rule_reference(&proof.rule, rules, prefixes)));

    let bindings = render_binding_items(proof, prefixes);
    if !bindings.is_empty() {
        groups.push(("pe:binding".to_string(), bindings));
    }

    let uses = proof.premises.iter().map(|premise| graph_for_triple(premise, prefixes)).collect::<Vec<_>>();
    if !uses.is_empty() {
        groups.push(("pe:uses".to_string(), uses));
    }

    let mut out = String::new();
    out.push_str("  ");
    out.push_str(&subject);
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
    let mut names = proof
        .bindings
        .keys()
        .filter(|name| rule_vars.contains(*name))
        .cloned()
        .collect::<Vec<_>>();
    names.sort();
    names
        .into_iter()
        .filter_map(|name| {
            let value = proof.bindings.get(&name)?;
            let display = proof.rule.proof_var_source_names.get(&name).unwrap_or(&name);
            Some(format!("[ pe:var {}; pe:value {} ]", quoted_string(display), term_to_n3_object(value, prefixes)))
        })
        .collect()
}

pub(crate) fn render_predicate_objects(predicate: &str, objects: &[String], is_last: bool) -> Vec<String> {
    let end = if is_last { "." } else { ";" };
    if objects.len() == 1 && !objects[0].contains('\n') {
        return vec![format!("    {} {}{}", predicate, objects[0], end)];
    }
    let mut out = vec![format!("    {}", predicate)];
    for (idx, object) in objects.iter().enumerate() {
        let suffix = if idx + 1 == objects.len() { end } else { "," };
        out.push(indent(&with_last_line_suffix(object, suffix), "      "));
    }
    out
}

pub(crate) fn with_last_line_suffix(text: &str, suffix: &str) -> String {
    let mut lines = text.lines().map(ToOwned::to_owned).collect::<Vec<_>>();
    if let Some(last) = lines.last_mut() { last.push_str(suffix); }
    lines.join("\n")
}

fn graph_for_triple(triple: &Triple, prefixes: &BTreeMap<String, String>) -> String {
    let body = triple_to_n3(prefixes, triple).trim_end().to_string();
    if !body.contains('\n') {
        return format!("{{ {} }}", body);
    }
    let mut out = String::new();
    out.push_str("{\n");
    out.push_str(&indent(&body, "    "));
    out.push('\n');
    out.push('}');
    out
}

/// How a step cites the rule it applied.
///
/// A rule written in the source is cited by its number there. A rule the
/// engine *generated* while reasoning is in no document, so a number into
/// a list the reader cannot reproduce would say nothing: the proof carries
/// that rule itself instead. The generated rule is also a derived
/// statement, so the proof contains a step deriving it, and a checker can
/// hold the citation to that (`docs/proof-checking.md` §5.1).
pub(crate) fn rule_reference(rule: &Rule, rules: &[Rule], prefixes: &BTreeMap<String, String>) -> String {
    if rule.source.is_some() {
        if let Some(number) = rule_number(rule, rules) {
            return number.to_string();
        }
    }
    term_to_n3_object(&generated_rule_term(rule), prefixes)
}

/// A generated rule as the statement it is, in its own direction: a
/// forward rule reads `{premises} => {conclusion}` and a backward one
/// `{conclusion} <= {premises}`. Writing it the way the engine derived it
/// is what lets a checker find the step that derived it.
pub(crate) fn generated_rule_term(rule: &Rule) -> Term {
    let statement = if rule.is_forward {
        Triple::new(Term::Formula(rule.premise.clone()), Term::Iri(LOG_IMPLIES.to_string()), Term::Formula(rule.conclusion.clone()))
    } else {
        Triple::new(Term::Formula(rule.conclusion.clone()), Term::Iri(LOG_IMPLIED_BY.to_string()), Term::Formula(rule.premise.clone()))
    };
    Term::Formula(vec![statement])
}

/// How a step cites a fact it was simply given: the document it came from.
pub(crate) fn fact_label(source: Option<&SourceRef>) -> String {
    source.map(|source| source_label_for_proof(&source.label)).unwrap_or_else(|| "<unknown>".to_string())
}

pub(crate) fn source_label_for_proof(label: &str) -> String {
    Path::new(label)
        .file_name()
        .map(|name| name.to_string_lossy().to_string())
        .filter(|name| !name.is_empty())
        .unwrap_or_else(|| label.replace('\\', "/").rsplit('/').next().unwrap_or(label).to_string())
}

fn source_key(source: Option<&SourceRef>) -> String {
    source.map(|s| format!("{}:{}", source_label_for_proof(&s.label), s.line)).unwrap_or_else(|| "<unknown>".to_string())
}

pub(crate) fn vars_in_rule(rule: &Rule) -> BTreeSet<String> {
    let mut out = BTreeSet::new();
    for triple in rule.premise.iter().chain(rule.conclusion.iter()) {
        collect_vars_triple(triple, &mut out);
    }
    out
}

fn collect_vars_triple(triple: &Triple, out: &mut BTreeSet<String>) {
    collect_vars_term(&triple.s, out);
    collect_vars_term(&triple.p, out);
    collect_vars_term(&triple.o, out);
}

fn collect_vars_term(term: &Term, out: &mut BTreeSet<String>) {
    match term {
        Term::Var(name) => { out.insert(name.clone()); }
        Term::List(items) => {
            for item in items { collect_vars_term(item, out); }
        }
        Term::Formula(triples) => {
            for triple in triples { collect_vars_triple(triple, out); }
        }
        _ => {}
    }
}

fn is_builtin_premise(triple: &Triple) -> bool {
    let Term::Iri(iri) = &triple.p else { return false; };
    iri.starts_with(LOG_EQUAL_TO.trim_end_matches("equalTo"))
        || iri.starts_with("http://www.w3.org/2000/10/swap/math#")
        || iri.starts_with("http://www.w3.org/2000/10/swap/list#")
        || iri.starts_with("http://www.w3.org/2000/10/swap/string#")
        || iri.starts_with("http://www.w3.org/2000/10/swap/time#")
        || iri.starts_with("http://www.w3.org/2000/10/swap/crypto#")
}

fn used_prefixes_for_proof(prefixes: &BTreeMap<String, String>, roots: &[(DerivedFact, Vec<ProofEntry>)]) -> BTreeSet<String> {
    let mut used = BTreeSet::new();
    used.insert("pe".to_string());
    for (root, entries) in roots {
        collect_prefixes_triple(&root.fact, prefixes, &mut used);
        for entry in entries {
            match entry {
                ProofEntry::Rule(df) => {
                    collect_prefixes_triple(&df.fact, prefixes, &mut used);
                    for prem in &df.premises { collect_prefixes_triple(prem, prefixes, &mut used); }
                }
                ProofEntry::Fact { fact, .. } => collect_prefixes_triple(fact, prefixes, &mut used),
                ProofEntry::Builtin { fact, builtin } => {
                    collect_prefixes_triple(fact, prefixes, &mut used);
                    collect_prefixes_term(builtin, prefixes, &mut used);
                }
                ProofEntry::Unproven { fact, .. } => collect_prefixes_triple(fact, prefixes, &mut used),
            }
        }
    }
    used
}

pub(crate) fn collect_prefixes_triple(triple: &Triple, prefixes: &BTreeMap<String, String>, used: &mut BTreeSet<String>) {
    collect_prefixes_term(&triple.s, prefixes, used);
    collect_prefixes_term(&triple.p, prefixes, used);
    collect_prefixes_term(&triple.o, prefixes, used);
}

pub(crate) fn collect_prefixes_term(term: &Term, prefixes: &BTreeMap<String, String>, used: &mut BTreeSet<String>) {
    match term {
        Term::Iri(iri) => {
            if let Some(prefix) = best_prefix_for_iri(iri, prefixes) { used.insert(prefix); }
        }
        Term::Literal(lit) => {
            if let Some(dt) = &lit.datatype {
                if datatype_renders_without_prefix(dt, &lit.value) { return; }
                if let Some(prefix) = best_prefix_for_iri(dt, prefixes) { used.insert(prefix); }
            }
        }
        Term::List(items) => {
            for item in items { collect_prefixes_term(item, prefixes, used); }
        }
        Term::Formula(triples) => {
            for triple in triples { collect_prefixes_triple(triple, prefixes, used); }
        }
        _ => {}
    }
}


pub(crate) fn datatype_renders_without_prefix(datatype: &str, value: &str) -> bool {
    matches!(
        datatype,
        "http://www.w3.org/2001/XMLSchema#integer"
            | "http://www.w3.org/2001/XMLSchema#decimal"
            | "http://www.w3.org/2001/XMLSchema#double"
    ) || (datatype == "http://www.w3.org/2001/XMLSchema#boolean" && matches!(value, "true" | "false"))
}

pub(crate) fn best_prefix_for_iri(iri: &str, prefixes: &BTreeMap<String, String>) -> Option<String> {
    let mut best: Option<(&str, &str)> = None;
    for (prefix, base) in prefixes {
        if base.is_empty() || !iri.starts_with(base) { continue; }
        let local = &iri[base.len()..];
        if local.is_empty() || !local.chars().all(|c| c.is_ascii_alphanumeric() || matches!(c, '_' | '-' | '.')) { continue; }
        let replace_best = match best {
            Some((_, old_base)) => base.len() > old_base.len(),
            None => true,
        };
        if replace_best { best = Some((prefix.as_str(), base.as_str())); }
    }
    best.map(|(prefix, _)| prefix.to_string())
}

fn triple_key(triple: &Triple) -> String {
    format!("{:?}\t{:?}\t{:?}", triple.s, triple.p, triple.o)
}

pub(crate) fn indent(text: &str, prefix: &str) -> String {
    text.lines().map(|line| if line.is_empty() { String::new() } else { format!("{}{}", prefix, line) }).collect::<Vec<_>>().join("\n")
}

pub(crate) fn quoted_string(value: &str) -> String {
    let mut out = String::new();
    out.push('"');
    for ch in value.chars() {
        match ch {
            '\\' => out.push_str("\\\\"),
            '"' => out.push_str("\\\""),
            '\n' => out.push_str("\\n"),
            '\r' => out.push_str("\\r"),
            '\t' => out.push_str("\\t"),
            other => out.push(other),
        }
    }
    out.push('"');
    out
}
