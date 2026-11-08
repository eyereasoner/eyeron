use crate::ast::*;
use crate::printing::{term_to_n3_object, triple_to_n3};
use crate::reasoner::{explain_backward_indexed, index_of_facts, BackwardStep, DerivedFact, FactIndex, ReasonerResult};
use std::collections::{BTreeMap, BTreeSet, HashSet};
use std::path::Path;

const PE_NS: &str = "https://eyereasoner.github.io/pe#";

pub fn proof_to_n3(prefixes: &BTreeMap<String, String>, result: &ReasonerResult) -> String {
    if result.derived.is_empty() { return String::new(); }

    // A proof claims what the run outputs — with queries, their answers
    // alone — and records only the steps those claims depend on.
    let output = result.derived.iter().collect::<BTreeSet<_>>();
    let mut roots = unique_proofs(&result.proofs);
    roots.retain(|root| output.contains(&root.fact));
    let mut claimed = roots.iter().map(|root| &root.fact).collect::<BTreeSet<_>>();
    // Identity queries do not record a circular query application. Their
    // answers can still come from source facts or backward-only rules.
    let other_claims = result.derived.iter().filter(|fact| claimed.insert(fact)).collect::<Vec<_>>();
    let claims = roots.iter().map(|root| &root.fact).chain(other_claims.iter().copied()).collect::<Vec<_>>();
    let derived_by_fact = index_by_conclusion(&result.proofs);
    let explicit_facts = result.explicit.iter().cloned().collect::<BTreeSet<_>>();

    let mut entries = collect_all_proof_entries(
        &roots,
        &other_claims,
        &derived_by_fact,
        &explicit_facts,
        &result.explicit_sources,
        &result.closure,
        &result.rules,
    );
    let listings = search_certificate(result, &roots, &other_claims, &derived_by_fact, &explicit_facts, &mut entries);

    let mut proof_prefixes = prefixes.clone();
    proof_prefixes.entry("pe".to_string()).or_insert_with(|| PE_NS.to_string());
    let used = used_prefixes_for_proof(&proof_prefixes, &claims, &entries);

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

    // What was derived, then one step per conclusion. A step names what it
    // used by that premise's own triple, so the steps need no nesting and
    // no wrapper.
    for claim in claims {
        parts.push(triple_to_n3(&proof_prefixes, claim));
    }

    let numbering = RuleNumbering::new(&result.rules);
    for entry in &entries {
        parts.push(String::new());
        parts.push(outdent(&render_entry(entry, &numbering, &proof_prefixes)));
    }

    // The search certificate, after the steps its listed facts have.
    for (predicate, facts) in &listings {
        let facts = facts.iter().map(|fact| indent(&graph_for_triple(fact, &proof_prefixes), "    ")).collect::<Vec<_>>();
        let listed = if facts.is_empty() { " {}".to_string() } else { format!("\n{}", facts.join(",\n")) };
        parts.push(String::new());
        parts.push(format!("{} pe:derived{}.", term_to_n3_object(predicate, &proof_prefixes), listed));
    }

    parts.join("\n").trim_end().to_string() + "\n"
}

/// More listed facts than this and a proof keeps its tests over the current
/// graph as obligations rather than grow a certificate that large.
const MAX_CERTIFICATE_FACTS: usize = 10_000;

/// The search certificate that settles the proof's tests over the current
/// graph (`SPEC.md` §9.6.1): for each predicate they depend on, every fact
/// the run derived with it, in the order derived. Each listed fact needs a
/// step of its own, which can bring further tests, so `entries` grows until
/// the predicates to list stop changing. Empty when there is nothing to
/// settle, or more than `MAX_CERTIFICATE_FACTS` to list.
fn search_certificate<'a>(
    result: &'a ReasonerResult,
    roots: &[&'a DerivedFact],
    other_claims: &[&'a Triple],
    derived_by_fact: &BTreeMap<&'a Triple, Vec<&'a DerivedFact>>,
    explicit_facts: &'a BTreeSet<Triple>,
    entries: &mut Vec<ProofEntry<'a>>,
) -> Vec<(Term, Vec<Triple>)> {
    let rules: Vec<Rule> = result.rules.iter().filter(|rule| rule.source.is_some()).cloned().collect();
    // The steps before any were added for listed facts.
    let mut original = None;
    let mut listed = BTreeSet::<Term>::new();
    loop {
        let mut needs = BTreeSet::new();
        for entry in entries.iter() {
            if let ProofEntry::Builtin { fact, .. } = entry {
                if crate::proof_check_n3::certifiable_test(fact) {
                    needs.extend(crate::proof_check_n3::certificate_needs(&rules, &result.explicit, fact).unwrap_or_default());
                }
            }
        }
        needs.extend(listed.iter().cloned());
        if needs == listed { break; }
        listed = needs;
        let facts: Vec<&Triple> = result.closure.iter()
            .filter(|fact| listed.contains(&fact.p) && !explicit_facts.contains(*fact)).collect();
        if facts.len() > MAX_CERTIFICATE_FACTS {
            // Steps added for an abandoned certificate would serve nothing.
            if let Some(original) = original { *entries = original; }
            return Vec::new();
        }
        let mut starts = roots.to_vec();
        let mut claims = other_claims.to_vec();
        for fact in facts {
            match derived_by_fact.get(fact).and_then(|derivations| derivations.first()) {
                Some(derivation) => starts.push(derivation),
                None => claims.push(fact),
            }
        }
        let expanded = collect_all_proof_entries(&starts, &claims, derived_by_fact, explicit_facts,
            &result.explicit_sources, &result.closure, &result.rules);
        let previous = std::mem::replace(entries, expanded);
        original.get_or_insert(previous);
    }
    let mut listings: Vec<(Term, Vec<Triple>)> = Vec::new();
    for fact in result.closure.iter().filter(|fact| listed.contains(&fact.p) && !explicit_facts.contains(*fact)) {
        match listings.iter_mut().find(|(predicate, _)| *predicate == fact.p) {
            Some((_, facts)) => facts.push(fact.clone()),
            None => listings.push((fact.p.clone(), vec![fact.clone()])),
        }
    }
    // A predicate the run derived nothing with is listed empty.
    for predicate in listed {
        if !listings.iter().any(|(listed, _)| *listed == predicate) { listings.push((predicate, Vec::new())); }
    }
    listings
}

/// The derivations to explain: one per distinct conclusion, the first
/// recorded. These borrow from the run's own proof list rather than copying
/// it -- a long chain records one derivation per link, and a copy of each is
/// a copy of the whole run.
///
/// A universal statement a rule concluded is recorded with its variables
/// open, so that an instance of it can be explained; it is no fact the run
/// derived, and so no conclusion to explain in its own right.
pub(crate) fn unique_proofs(proofs: &[DerivedFact]) -> Vec<&DerivedFact> {
    let mut seen = BTreeSet::<&Triple>::new();
    let mut out = Vec::new();
    for proof in proofs {
        let fact = &proof.fact;
        if [&fact.s, &fact.p, &fact.o].iter().any(|term| matches!(term, Term::Var(_))) {
            continue;
        }
        if seen.insert(&proof.fact) {
            out.push(proof);
        }
    }
    out
}

/// Every recorded derivation, found by what it concludes.
pub(crate) fn index_by_conclusion(proofs: &[DerivedFact]) -> BTreeMap<&Triple, Vec<&DerivedFact>> {
    let mut index = BTreeMap::<&Triple, Vec<&DerivedFact>>::new();
    for proof in proofs {
        index.entry(&proof.fact).or_default().push(proof);
    }
    index
}

/// A rule step borrows the derivation the run already recorded; only a step
/// an explanation had to construct (a backward proof) is owned.
#[derive(Debug, Clone)]
pub(crate) enum ProofEntry<'a> {
    Rule(std::borrow::Cow<'a, DerivedFact>),
    Fact { fact: Triple, source: Option<SourceRef> },
    Builtin { fact: Triple, builtin: Term },
    Unproven { fact: Triple, reason: String },
}

/// Every step needed to explain all of `roots`, each conclusion explained
/// once.
///
/// Explaining each root independently repeats every shared premise under
/// every root that uses it, so a chain of N derived facts costs N² to walk
/// and to write. One collector across all roots makes both linear, and
/// loses nothing: a step names what it used by those premises' own
/// triples, so a reader finds them wherever they are.
pub(crate) fn collect_all_proof_entries<'a>(
    roots: &[&'a DerivedFact],
    other_claims: &[&'a Triple],
    derived_by_fact: &BTreeMap<&'a Triple, Vec<&'a DerivedFact>>,
    explicit_facts: &'a BTreeSet<Triple>,
    explicit_sources: &'a BTreeMap<Triple, SourceRef>,
    base_facts: &'a [Triple],
    rules: &'a [Rule],
) -> Vec<ProofEntry<'a>> {
    let mut collector = ProofCollector {
        derived_by_fact,
        general_derived: derived_by_fact.values().flatten().copied().filter(|proof| !proof.fact.is_ground()).collect(),
        explicit_facts,
        explicit_sources,
        base_facts,
        base_index: index_of_facts(base_facts),
        rules,
        seen: HashSet::new(),
        entries: Vec::new(),
    };
    collector.visit_roots(roots, other_claims);
    collector.entries
}

struct ProofCollector<'a, 'b> {
    derived_by_fact: &'b BTreeMap<&'a Triple, Vec<&'a DerivedFact>>,
    /// Open conclusions may be used at a more specific universal instance.
    /// Keep these separately so ordinary ground proofs do not scan the store.
    general_derived: Vec<&'a DerivedFact>,
    explicit_facts: &'a BTreeSet<Triple>,
    explicit_sources: &'a BTreeMap<Triple, SourceRef>,
    base_facts: &'a [Triple],
    /// Built once: `explain_backward_indexed` is asked for every premise in
    /// the proof, and each call would otherwise index every fact again.
    base_index: FactIndex,
    rules: &'a [Rule],
    seen: HashSet<String>,
    entries: Vec<ProofEntry<'a>>,
}

enum PendingProof<'a> {
    Derived(&'a DerivedFact),
    Premise(&'a Triple, Option<&'a Triple>),
    InstancePremise(Box<Triple>),
}

impl<'a> ProofCollector<'a, '_> {
    fn visit_roots(&mut self, roots: &[&'a DerivedFact], other_claims: &[&'a Triple]) {
        // A query can select only the last fact of a very long chain.
        // Keep the traversal on the heap rather than the native/Wasm stack.
        let mut pending = Vec::new();
        let starts = roots.iter().copied().map(PendingProof::Derived)
            .chain(other_claims.iter().map(|&claim| PendingProof::Premise(claim, None)));
        for root in starts {
            pending.push(root);
            while let Some(next) = pending.pop() {
                match next {
                    PendingProof::Derived(proof) => self.visit_derived_fact(proof, &mut pending),
                    PendingProof::Premise(premise, parent) => self.visit_premise(premise, parent, &mut pending),
                    PendingProof::InstancePremise(premise) => self.visit_premise(&premise, None, &mut pending),
                }
            }
        }
    }

    fn visit_derived_fact(&mut self, proof: &'a DerivedFact, pending: &mut Vec<PendingProof<'a>>) {
        let key = format!("rule:{}:{}", triple_key(&proof.fact), source_key(proof.rule.source.as_ref()));
        if !self.seen.insert(key) { return; }
        // Pushed first so carried-rule provenance follows the premises,
        // preserving the order in which the proof has always been written.
        if proof.rule.source.is_none() {
            if let Some(derivation) = self.rule_derivation(&proof.rule) {
                pending.push(PendingProof::Derived(derivation));
            }
        }
        // A rule that concludes one of its own premises -- polygon.n3's
        // `{ (..) polygon:area ?A } => { (..) polygon:area ?A }`, which exists
        // to force a backward goal to be evaluated -- is what puts the fact in
        // the closure, so the fact stays a claim the proof makes. But writing
        // the rule application as its step would say the fact holds because it
        // holds. What actually holds it up is whatever proved the premise, so
        // that is what the step below records -- and that premise alone, as
        // nothing in the proof uses the others.
        if proof.premises.contains(&proof.fact) {
            pending.push(PendingProof::Premise(&proof.fact, Some(&proof.fact)));
        } else {
            self.entries.push(ProofEntry::Rule(std::borrow::Cow::Borrowed(proof)));
            for premise in proof.premises.iter().rev() {
                pending.push(PendingProof::Premise(premise, Some(&proof.fact)));
            }
        }
    }

    /// The derivation of the statement asserting `rule`, written either way
    /// round and up to the renaming of its variables.
    fn rule_derivation(&self, rule: &Rule) -> Option<&'a DerivedFact> {
        let statement = rule_statement(rule);
        let reversed = Triple::new(statement.o.clone(), Term::iri(if rule.is_forward { LOG_IMPLIED_BY } else { LOG_IMPLIES }), statement.s.clone());
        let same = |fact: &Triple, wanted: &Triple| fact.p == wanted.p
            && crate::reasoner::match_triple(fact, wanted, &mut BTreeMap::new());
        self.derived_by_fact
            .iter()
            .find(|(fact, _)| same(fact, &statement) || same(fact, &reversed))
            .and_then(|(_, derivations)| derivations.first().copied())
    }

    fn remember_backward_step(&mut self, step: BackwardStep) {
        match step {
            BackwardStep::Rule(df) => {
                let key = format!("rule:{}:{}", triple_key(&df.fact), source_key(df.rule.source.as_ref()));
                if self.seen.insert(key) {
                    self.entries.push(ProofEntry::Rule(std::borrow::Cow::Owned(df)));
                }
            }
            BackwardStep::Fact { fact } => {
                // An instance of a universal statement is given by that
                // statement, so it is cited from where that one was written.
                let source = self.explicit_sources.get(&fact).cloned().or_else(|| {
                    self.explicit_facts
                        .iter()
                        .filter(|candidate| !candidate.is_ground())
                        .find(|candidate| crate::reasoner::match_triple(candidate, &fact, &mut BTreeMap::new()))
                        .and_then(|candidate| self.explicit_sources.get(candidate).cloned())
                });
                self.remember_entry(ProofEntry::Fact { fact, source });
            }
            BackwardStep::Builtin { fact, builtin } => self.remember_entry(ProofEntry::Builtin { fact, builtin }),
            BackwardStep::Unproven { fact, reason } => self.remember_entry(ProofEntry::Unproven { fact, reason }),
        }
    }

    fn visit_premise(&mut self, premise: &Triple, parent: Option<&Triple>, pending: &mut Vec<PendingProof<'a>>) {
        if let Some(candidates) = self.derived_by_fact.get(premise) {
            if let Some(child) = candidates.iter().find(|candidate| parent.is_none_or(|p| candidate.fact != *p)) {
                pending.push(PendingProof::Derived(child));
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

        // Substitution can instantiate free universals inside a quoted
        // closure. The resulting premise is no longer the earlier step's
        // exact conclusion: replay that derivation at the same instance,
        // including its premises and bindings, so the reader can check it
        // without weakening resolution or trusting an unsupported fact.
        if parent.is_none_or(|parent| *parent != *premise) {
            for candidate in &self.general_derived {
                if let Some(instance) = instantiate_derivation(candidate, premise) {
                    let key = format!("rule:{}:{}", triple_key(&instance.fact), source_key(instance.rule.source.as_ref()));
                    if !self.seen.insert(key) { return; }
                    let premises = instance.premises.clone();
                    self.entries.push(ProofEntry::Rule(std::borrow::Cow::Owned(instance)));
                    for used in premises.into_iter().rev() {
                        pending.push(PendingProof::InstancePremise(Box::new(used)));
                    }
                    return;
                }
            }
        }

        // The explanation comes back as a flat set of steps rather than a
        // tree, so a premise used more than once is explained once.
        let mut steps = Vec::new();
        if explain_backward_indexed(premise, self.base_facts, &self.base_index, self.explicit_facts, self.rules, 4096, &mut |step| steps.push(step)) {
            for step in steps {
                self.remember_backward_step(step);
            }
            return;
        }

        // A statement the document gives may carry variables, and N3 reads
        // those as universally quantified: `:ruleCat :formula { {?X a :Cat}
        // => ... }` gives every instance of itself. A premise is therefore
        // given when some explicit statement matches it, not only when one
        // equals it.
        for candidate in self.explicit_facts.iter().filter(|fact| !fact.is_ground()) {
            let mut bindings = BTreeMap::new();
            if crate::reasoner::match_triple(candidate, premise, &mut bindings) {
                let source = self.explicit_sources.get(candidate).cloned();
                self.remember_entry(ProofEntry::Fact { fact: premise.clone(), source });
                return;
            }
        }

        // N3 treats a rule as data, so a rule *written in the source* is a
        // statement the document gives. A premise matching one — which is
        // how `{ ?A => ?B } => { ... }` fires — is given, not unproven.
        for rule in self.rules.iter().filter(|rule| rule.source.is_some()) {
            let mut bindings = BTreeMap::new();
            if crate::reasoner::match_triple(&rule_statement(rule), premise, &mut bindings) {
                self.remember_entry(ProofEntry::Fact { fact: premise.clone(), source: rule.source.clone() });
                return;
            }
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

    fn remember_entry(&mut self, entry: ProofEntry<'a>) {
        let key = match &entry {
            ProofEntry::Rule(df) => format!("rule:{}:{}", triple_key(&df.fact), source_key(df.rule.source.as_ref())),
            ProofEntry::Fact { fact, source } => format!("fact:{}:{}", triple_key(fact), source_key(source.as_ref())),
            ProofEntry::Builtin { fact, .. } => format!("builtin:{}", triple_key(fact)),
            ProofEntry::Unproven { fact, .. } => format!("unproven:{}", triple_key(fact)),
        };
        if self.seen.insert(key) { self.entries.push(entry); }
    }
}

/// Instantiate only free universal variables. Concrete blank nodes retain
/// their identity, and `Graph::substitute` masks nested local quantifiers.
fn instantiate_derivation(proof: &DerivedFact, target: &Triple) -> Option<DerivedFact> {
    let mut bindings = BTreeMap::new();
    if !crate::reasoner::match_triple(&proof.fact, target, &mut bindings) { return None; }
    let mapping: BTreeMap<Term, Term> = bindings.into_iter()
        .filter(|(name, _)| !name.starts_with("_:"))
        .map(|(name, value)| (Term::var(name), value)).collect();
    let substitute = |triple: &Triple| {
        Graph { triples: vec![triple.clone()], ..Graph::default() }
            .substitute(&mapping).triples.pop().expect("one triple")
    };
    let fact = substitute(&proof.fact);
    // Matching is more permissive about blank patterns and literal values
    // than an instance is. Require the substitution to produce the exact use.
    if fact != *target { return None; }
    let mut recorded: BTreeMap<Name, Term> = proof.bindings.iter().map(|(name, value)| {
        let triple = substitute(&Triple::new(Term::iri("urn:eyeron:binding"), Term::iri("urn:eyeron:value"), value.clone()));
        (name.clone(), triple.o)
    }).collect();
    for (variable, value) in &mapping {
        let Term::Var(name) = variable else { unreachable!() };
        recorded.entry(name.clone()).or_insert_with(|| value.clone());
    }
    Some(DerivedFact {
        fact,
        rule: proof.rule.clone(),
        premises: proof.premises.iter().map(substitute).collect(),
        bindings: recorded.into_iter().collect(),
    })
}

/// The 1-based position of `rule` in the document's rule list — the number
/// a proof step cites.
///
/// A rule's source location is tried first and structural equality only as
/// a fallback, because the rule a `DerivedFact` carries is not always
/// `==` to the one in the document: backward chaining and rule generation
/// both rewrite a rule's premises or conclusion while leaving its source
/// alone. A rule with no source at all (one the reasoner generated at run
/// time) has no number to cite.
pub(crate) struct RuleNumbering<'a> {
    rules: &'a [Rule],
    by_source: BTreeMap<(&'a str, usize), usize>,
}

impl<'a> RuleNumbering<'a> {
    /// Built once per proof. Finding a rule's number by scanning the
    /// document for each step costs the product of the two, which for a
    /// long rule chain -- where every rule fires once, so there are as
    /// many steps as rules -- is the square of the program.
    pub(crate) fn new(rules: &'a [Rule]) -> Self {
        let mut by_source = BTreeMap::new();
        for (index, rule) in rules.iter().enumerate() {
            if let Some(source) = &rule.source {
                by_source.entry((source.label.as_str(), source.line)).or_insert(index + 1);
            }
        }
        Self { rules, by_source }
    }

    pub(crate) fn number(&self, rule: &Rule) -> Option<usize> {
        if let Some(source) = &rule.source {
            if let Some(number) = self.by_source.get(&(source.label.as_str(), source.line)) {
                return Some(*number);
            }
        }
        // A rule the engine generated has no source to look up, and there
        // are few of them, so structural search is affordable here.
        self.rules.iter().position(|candidate| candidate == rule).map(|index| index + 1)
    }
}

/// The one predicate that says why a step holds, and its object. Every
/// step carries exactly one, which is what lets a reader of any of the
/// three proof formats find the justification in the same place.
pub(crate) fn justification(kind: &str, object: String) -> (String, Vec<String>) {
    (format!("pe:{}", kind), vec![object])
}

/// The line-building helpers below indent a step by two spaces. An N3 step
/// stands at the margin, so the indent comes back off here.
fn outdent(block: &str) -> String {
    block.lines().map(|line| line.strip_prefix("  ").unwrap_or(line)).collect::<Vec<_>>().join("\n")
}

fn render_entry(entry: &ProofEntry, numbering: &RuleNumbering, prefixes: &BTreeMap<String, String>) -> String {
    match entry {
        ProofEntry::Rule(proof) => render_rule_entry(proof, numbering, prefixes),
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

fn render_rule_entry(proof: &DerivedFact, numbering: &RuleNumbering, prefixes: &BTreeMap<String, String>) -> String {
    let subject = graph_for_triple(&proof.fact, prefixes);
    let mut groups = Vec::<(String, Vec<String>)>::new();
    groups.push(justification("rule", rule_reference(&proof.rule, numbering, prefixes)));

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
    let mut items = proof
        .bindings
        .iter()
        .filter(|(name, _)| rule_vars.contains(name.as_str()))
        .map(|(name, value)| {
            let display = proof.rule.proof_var_source_names.get(name.as_str()).map(String::as_str).unwrap_or(name.as_str());
            (display.to_string(), format!("[ pe:var {}; pe:value {} ]", quoted_string(display), term_to_n3_object(value, prefixes)))
        })
        .collect::<Vec<_>>();
    items.sort();
    items.into_iter().map(|(_, item)| item).collect()
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
/// hold the citation to that (`SPEC.md` §9.5.1).
pub(crate) fn rule_reference(rule: &Rule, numbering: &RuleNumbering, prefixes: &BTreeMap<String, String>) -> String {
    if rule.source.is_some() {
        if let Some(number) = numbering.number(rule) {
            return number.to_string();
        }
    }
    term_to_n3_object(&generated_rule_term(rule), prefixes)
}

/// A rule as the statement it is, in its own direction: a
/// forward rule reads `{premises} => {conclusion}` and a backward one
/// `{conclusion} <= {premises}`. Writing it the way the engine derived it
/// is what lets a checker find the step that derived it.
pub(crate) fn generated_rule_term(rule: &Rule) -> Term {
    Term::formula(vec![rule_statement(rule)])
}

/// The triple a rule *is*, which N3 can match like any other: `{premises}
/// log:implies {conclusion}`, or the `log:impliedBy` form for a backward
/// rule.
pub fn rule_statement(rule: &Rule) -> Triple {
    if rule.is_forward {
        Triple::new(Term::Formula(rule.premise.clone()), Term::Iri(LOG_IMPLIES.to_string().into()), Term::Formula(rule.conclusion.clone()))
    } else {
        Triple::new(Term::Formula(rule.conclusion.clone()), Term::Iri(LOG_IMPLIED_BY.to_string().into()), Term::Formula(rule.premise.clone()))
    }
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
    rule.premise.free_variables().into_iter().chain(rule.conclusion.free_variables())
        .filter_map(|term| if let Term::Var(n)=term { Some(n.to_string()) } else { None }).collect()
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

fn used_prefixes_for_proof(prefixes: &BTreeMap<String, String>, claims: &[&Triple], entries: &[ProofEntry]) -> BTreeSet<String> {
    let mut used = BTreeSet::new();
    used.insert("pe".to_string());
    for claim in claims {
        collect_prefixes_triple(claim, prefixes, &mut used);
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
            ProofEntry::Builtin { fact, builtin } => {
                collect_prefixes_triple(fact, prefixes, &mut used);
                collect_prefixes_term(builtin, prefixes, &mut used);
            }
            ProofEntry::Unproven { fact, .. } => collect_prefixes_triple(fact, prefixes, &mut used),
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
