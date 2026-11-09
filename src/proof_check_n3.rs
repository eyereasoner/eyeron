//! Reader and step checker for Notation3 proof documents (specification
//! §9.8).
//!
//! A proof is an N3 document, so it is read with the ordinary N3 parser and
//! its top-level steps are lifted into the abstract model. Checking a
//! `pe:rule` step re-performs exactly one rule application against the
//! cited source rule or justified carried rule: instantiate its premises
//! and conclusion under the step's bindings, and require them to be what
//! the step recorded.

use std::collections::{BTreeMap, BTreeSet, HashMap, HashSet};

use crate::ast::{Term, Triple};
use crate::error::{EyeronError, Result};
use crate::reasoner::Bindings;

use crate::proof_check::{check, Checked, Closure, Document as ProofDocument, Kind, Report, Resolution, StepCheck};

const PE: &str = "https://eyereasoner.github.io/pe#";
const MAX_PROOF_MATCHES: usize = 200_000;

/// Built-ins whose value is not a function of the triple they appear in, so
/// re-evaluating them cannot confirm anything (specification §9.5.3, §9.6).
/// Each reads something outside the proof: the clock, an external document,
/// the fact set, or the reasoner itself.
pub(crate) const IMPURE_BUILTINS: &[&str] = &[
    // Read the clock.
    "http://www.w3.org/2000/10/swap/time#localTime",
    // Read the network or the filesystem.
    "http://www.w3.org/2000/10/swap/log#content",
    "http://www.w3.org/2000/10/swap/log#semantics",
    "http://www.w3.org/2000/10/swap/log#semanticsOrError",
    // Runs the reasoner on a graph: re-deciding it would trust the engine
    // the proof is checked against.
    "http://www.w3.org/2000/10/swap/log#conclusion",
    // Applies a predicate to each element, which means looking the
    // predicate up in the fact set.
    "http://www.w3.org/2000/10/swap/list#map",
];

const LOG_INCLUDES: &str = "http://www.w3.org/2000/10/swap/log#includes";
const LOG_NOT_INCLUDES: &str = "http://www.w3.org/2000/10/swap/log#notIncludes";
const LOG_COLLECT_ALL_IN: &str = "http://www.w3.org/2000/10/swap/log#collectAllIn";
const LOG_FOR_ALL_IN: &str = "http://www.w3.org/2000/10/swap/log#forAllIn";
const LOG_CONJUNCTION: &str = "http://www.w3.org/2000/10/swap/log#conjunction";

/// What kind of obligation a scoped built-in is, when the scope it tests is
/// the current graph rather than a quoted one: the subject of `log:includes` and
/// `log:notIncludes`, the object of `log:collectAllIn` and `log:forAllIn`.
/// Whether such a test held depends on everything derived, which no proof
/// records, so it is an obligation (§9.6) — but one the proof's own evidence
/// can still contradict (C6). `None` for any other built-in, or a quoted
/// scope, which makes the test a function of its arguments (C5).
pub(crate) fn current_graph_test(triple: &Triple) -> Option<&'static str> {
    let Term::Iri(name) = &triple.p else { return None };
    // Anything but a quoted graph — a variable, a blank, a scope level such
    // as `1` — names the current graph.
    let open = |scope: &Term| !matches!(scope, Term::Formula(_));
    match name.as_str() {
        LOG_INCLUDES if open(&triple.s) => Some("current graph"),
        // An unbound subject is bound to a stand-in graph once the current
        // graph has been tested, so the stand-in marks that test.
        LOG_NOT_INCLUDES if open(&triple.s) || crate::reasoner::is_not_includes_witness(&triple.s) => Some("absent"),
        LOG_COLLECT_ALL_IN | LOG_FOR_ALL_IN if open(&triple.o) => Some("collected"),
        _ => None,
    }
}

/// The predicates a search certificate must list for `test`, a negation,
/// collection or universal test over the current graph, to be settled
/// (§9.6.1): every predicate its clause consults that a forward rule
/// concludes, and those the bodies of such rules consult in turn. `None`
/// when no certificate can settle it: it consults a predicate a backward
/// rule or a general source statement gives, a variable predicate, rules as
/// data, or an external read; a rule may generate rules or unquote its
/// conclusion; or it is a collection over derived facts, whose order a
/// certificate cannot establish.
pub(crate) fn certificate_needs(rules: &[crate::ast::Rule], facts: &[Triple], test: &Triple) -> Option<BTreeSet<Term>> {
    let forward: Vec<&crate::ast::Rule> = rules.iter().filter(|rule| rule.is_forward && !rule.is_query && !rule.is_fuse).collect();
    let generative = |triple: &Triple| matches!(&triple.p, Term::Iri(name)
        if matches!(name.as_str(), crate::ast::LOG_IMPLIES | crate::ast::LOG_IMPLIED_BY | crate::ast::EYERON_UNQUOTE));
    if forward.iter().any(|rule| rule.conclusion.iter().any(generative)) { return None; }
    let mut clauses = Vec::new();
    consulted(&test_scope_clauses(test)?, true, &mut clauses)?;
    let mut pending: Vec<Term> = clauses.iter().map(|(triple, _)| triple.p.clone()).collect();
    let mut needs = BTreeSet::new();
    let mut seen = BTreeSet::new();
    while let Some(predicate) = pending.pop() {
        if !seen.insert(predicate.clone()) { continue; }
        let concludes = |rule: &crate::ast::Rule| rule.conclusion.iter().any(|head| head.p == predicate || matches!(head.p, Term::Var(_)));
        if rules.iter().any(|rule| !rule.is_forward && !rule.is_query && concludes(rule))
            || facts.iter().any(|fact| !fact.is_ground() && (fact.p == predicate || matches!(fact.p, Term::Var(_)))) {
            return None;
        }
        for rule in forward.iter().filter(|rule| concludes(rule)) {
            needs.insert(predicate.clone());
            let mut found = Vec::new();
            consulted(&rule.premise, false, &mut found)?;
            // An existential conclusion is closed when its whole piece is
            // found, so the piece's other predicates are listed too.
            for piece in crate::reasoner::existential_pieces(&rule.conclusion) {
                if piece.iter().any(|&head| rule.conclusion[head].p == predicate || matches!(rule.conclusion[head].p, Term::Var(_))) {
                    consulted(&piece.iter().map(|&head| rule.conclusion[head].clone()).collect::<Vec<_>>(), false, &mut found)?;
                }
            }
            pending.extend(found.into_iter().map(|(triple, _)| triple.p));
        }
    }
    if test.p == Term::iri(LOG_COLLECT_ALL_IN) && !needs.is_empty() { return None; }
    stratified(&forward, &clauses).then_some(needs)
}

/// Whether the forward rules the test's `clauses` can reach are free of a
/// negation inside a cycle, which more than one current graph can satisfy:
/// a stratified program has a single closure for a certificate to show. A
/// body triple depends on a rule when one of the rule's heads can match it,
/// so `?p a :Student` does not depend on a rule concluding `?q a :Person`.
fn stratified(forward: &[&crate::ast::Rule], clauses: &[(Triple, bool)]) -> bool {
    let concluding = |pattern: &Triple| -> Vec<usize> {
        (0..forward.len()).filter(|&rule| forward[rule].conclusion.iter().any(|head| unifiable(head, pattern))).collect()
    };
    let mut reached: BTreeSet<usize> = clauses.iter().flat_map(|(pattern, _)| concluding(pattern)).collect();
    let mut pending: Vec<usize> = reached.iter().copied().collect();
    let mut edges: Vec<(usize, usize, bool)> = Vec::new();
    while let Some(rule) = pending.pop() {
        let mut body = Vec::new();
        if consulted(&forward[rule].premise, false, &mut body).is_none() { return false; }
        for (pattern, negative) in body {
            for next in concluding(&pattern) {
                edges.push((rule, next, negative));
                if reached.insert(next) { pending.push(next); }
            }
        }
    }
    let reaches = |from: usize, to: usize| {
        let mut seen = BTreeSet::from([from]);
        let mut pending = vec![from];
        while let Some(rule) = pending.pop() {
            if rule == to { return true; }
            for &(_, next, _) in edges.iter().filter(|(source, _, _)| *source == rule) {
                if seen.insert(next) { pending.push(next); }
            }
        }
        false
    };
    !edges.iter().any(|&(from, to, negative)| negative && reaches(to, from))
}

/// Whether a rule head and a body triple can match: their constants agree
/// wherever neither has a variable, a blank, a list or a quoted graph.
fn unifiable(head: &Triple, pattern: &Triple) -> bool {
    let open = |term: &Term| matches!(term, Term::Var(_) | Term::Blank(_) | Term::List(_) | Term::Formula(_));
    [(&head.s, &pattern.s), (&head.p, &pattern.p), (&head.o, &pattern.o)].iter()
        .all(|(left, right)| open(left) || open(right) || left == right)
}

/// The clauses a current-graph test runs: `None` for any other triple.
fn test_scope_clauses(test: &Triple) -> Option<Vec<Triple>> {
    current_graph_test(test)?;
    let Term::Iri(name) = &test.p else { return None };
    let graph = |term: &Term| match term { Term::Formula(graph) => Some(graph.triples.clone()), _ => None };
    match (name.as_str(), &test.s) {
        (LOG_NOT_INCLUDES | LOG_INCLUDES, _) => graph(&test.o),
        (LOG_COLLECT_ALL_IN, Term::List(parts)) if parts.len() == 3 => graph(&parts[1]),
        (LOG_FOR_ALL_IN, Term::List(parts)) if parts.len() == 2 => Some(graph(&parts[0])?.into_iter().chain(graph(&parts[1])?).collect()),
        _ => None,
    }
}

/// Add the triples `triples` match in the current graph to `out`, each
/// marked `negative` when a negation, collection or universal test matches
/// it: `None` if one has a variable predicate, is a rule as data, or reads
/// outside the proof.
fn consulted(triples: &[Triple], negative: bool, out: &mut Vec<(Triple, bool)>) -> Option<()> {
    for triple in triples {
        let Term::Iri(name) = &triple.p else { return None };
        if matches!(name.as_str(), crate::ast::LOG_IMPLIES | crate::ast::LOG_IMPLIED_BY) || reads_outside_proof(triple) {
            return None;
        }
        if crate::reasoner::is_builtin_iri(name) {
            if let Some(kind) = current_graph_test(triple) {
                consulted(&test_scope_clauses(triple)?, negative || kind != "current graph", out)?;
            }
            continue;
        }
        out.push((triple.clone(), negative));
    }
    Some(())
}

/// Whether `triple` is a test a search certificate may settle: a negation,
/// collection or universal test over the current graph that reads nothing
/// outside the proof.
pub(crate) fn certifiable_test(triple: &Triple) -> bool {
    matches!(current_graph_test(triple), Some("absent" | "collected")) && !reads_outside_proof(triple)
}

/// Negative tests over the current graph, collections, and universal tests
/// execute clauses, so an external read nested there remains an obligation.
/// Over a quoted graph a negative test only matches quoted statements.
pub(crate) fn reads_outside_proof(triple: &Triple) -> bool {
    let Term::Iri(name) = &triple.p else { return false };
    if IMPURE_BUILTINS.contains(&name.as_str()) { return true; }
    if name.as_str() == LOG_NOT_INCLUDES
        && (!matches!(triple.s, Term::Formula(_)) || crate::reasoner::is_not_includes_witness(&triple.s))
    {
        if let Term::Formula(graph) = &triple.o { return graph.iter().any(reads_outside_proof); }
    }
    if matches!(name.as_str(), LOG_COLLECT_ALL_IN | LOG_FOR_ALL_IN) {
        if let Term::List(parts) = &triple.s {
            return parts.iter().any(|part| matches!(part, Term::Formula(graph) if graph.iter().any(reads_outside_proof)));
        }
    }
    false
}

type Verdict = std::result::Result<Checked, String>;

fn under(condition: &'static str, outcome: Verdict) -> StepCheck {
    StepCheck { condition, outcome }
}

fn pe(name: &str) -> Term {
    Term::Iri(format!("{}{}", PE, name).into())
}

/// True iff `predicate` is one of the step vocabulary's own terms, which
/// describe the proof rather than state a claim.
fn is_proof_vocabulary(predicate: &Term) -> bool {
    matches!(predicate, Term::Iri(iri) if iri.starts_with(PE))
}

/// The single triple a `{ ... }` proof term wraps.
fn formula_triple(term: &Term) -> Option<&Triple> {
    match term {
        Term::Formula(triples) if triples.len() == 1 => Some(&triples[0]),
        _ => None,
    }
}

struct Step {
    conclusion: Triple,
    kind: Kind,
    rule: Option<usize>,
    /// A rule the engine generated while reasoning, carried by the step
    /// because no document contains it (§9.5.1).
    carried: Option<(crate::ast::Graph, crate::ast::Graph, Triple)>,
    builtin: Option<Term>,
    bindings: Vec<(String, Term)>,
    uses: Vec<Triple>,
}

pub struct N3Proof {
    rules: Vec<crate::ast::Rule>,
    given: BTreeSet<Triple>,
    /// Written rules, as the statements they are, for a premise or a
    /// `pe:fact` step that names one up to renaming.
    rule_statements: Vec<Triple>,
    /// Given statements that carry variables. N3 reads those as
    /// universally quantified, so each gives every instance of itself.
    general: Vec<Triple>,
    /// Query rules, as the implications a step answering one carries. An
    /// answer is output, so no step may use it as a premise.
    query_rules: Vec<Triple>,
    queries: Vec<crate::ast::Rule>,
    /// What the query rules output, as patterns a relevant claim instantiates.
    query_patterns: Vec<Triple>,
    /// Blank nodes the source mentions, which no existential can stand for.
    source_blanks: BTreeSet<crate::ast::Name>,
    /// The source's facts, which with the step conclusions are the
    /// evidence C6 looks for contradictions in.
    facts: Vec<Triple>,
    /// Premises of the source's inference fuses, `{ ... } => false`.
    fuses: Vec<crate::ast::Graph>,
    steps: Vec<Step>,
    /// The search certificate: for each listed predicate, every fact the
    /// run derived with it, in the order listed (§9.6.1).
    listings: Listings,
    claims: Vec<Triple>,
    index: HashMap<Triple, usize>,
    /// Steps whose conclusion has free variables, which each conclude every
    /// instance of itself.
    general_steps: Vec<usize>,
}

/// A search certificate's listings: each predicate with the facts listed
/// for it, in the order listed (§9.6.1).
type Listings = Vec<(Term, Vec<Triple>)>;

/// A firing is identified by its rule and complete recorded assignment,
/// including existential patterns in its premises.
type Firing = (String, Vec<(crate::ast::Name, Term)>);

struct Application {
    firing: Firing,
    /// The position of the head triple the step instantiates, for a rule
    /// application.
    head: Option<usize>,
    witnesses: Vec<(crate::ast::Name, Term)>,
    /// Individuals already available to the application cannot be fresh.
    occupied: BTreeSet<crate::ast::Name>,
}

type WitnessOwner = (Firing, crate::ast::Name);

#[derive(Default)]
struct WitnessRegistry {
    introduced: BTreeMap<crate::ast::Name, WitnessOwner>,
    assigned: BTreeMap<WitnessOwner, crate::ast::Name>,
}

#[derive(Default)]
struct WitnessUndo {
    introduced: Vec<crate::ast::Name>,
    assigned: Vec<WitnessOwner>,
}

impl WitnessRegistry {
    fn undo(&mut self, undo: WitnessUndo) {
        for name in undo.introduced { self.introduced.remove(&name); }
        for owner in undo.assigned { self.assigned.remove(&owner); }
    }

    fn register(&mut self, application: &Application, source_blanks: &BTreeSet<crate::ast::Name>) -> std::result::Result<WitnessUndo, String> {
        let mut undo = WitnessUndo::default();
        let result = (|| {
            for (label, value) in &application.witnesses {
                if application.firing.1.iter().any(|(_, value)| has_free_universal(value)) {
                    return Err(format!("introduces existential _:{} with an unbound universal assignment; a dependent witness needs concrete values", label));
                }
                let Term::Blank(witness) = value else {
                    return Err(format!("instantiates existential _:{} with {}, which is not a fresh blank node",
                        label, crate::printing::term_to_n3_object(value, &BTreeMap::new())));
                };
                if source_blanks.contains(witness) || application.occupied.contains(witness) {
                    return Err(format!("instantiates existential _:{} with _:{}, which is not fresh", label, witness));
                }
                let owner = (application.firing.clone(), label.clone());
                if let Some(other) = self.introduced.get(witness) {
                    if *other != owner {
                        let detail = if other.0 != application.firing { "another firing already introduced" } else { "another existential already uses" };
                        return Err(format!("instantiates existential _:{} with _:{}, which {}", label, witness, detail));
                    }
                }
                if let Some(other) = self.assigned.get(&owner) {
                    if other != witness {
                        return Err(format!("instantiates existential _:{} with a different witness (_:{} instead of _:{}) in the same firing", label, witness, other));
                    }
                }
                if !self.introduced.contains_key(witness) {
                    self.introduced.insert(witness.clone(), owner.clone());
                    undo.introduced.push(witness.clone());
                }
                if !self.assigned.contains_key(&owner) {
                    self.assigned.insert(owner.clone(), witness.clone());
                    undo.assigned.push(owner);
                }
            }
            Ok(())
        })();
        match result {
            Ok(()) => Ok(undo),
            Err(detail) => { self.undo(undo); Err(detail) }
        }
    }
}

/// Read `proof` as a proof document for the program in `source`, and check
/// it.
pub fn check_proof(source: &str, proof: &str, label: &str) -> Result<Report> {
    let document = crate::parser::parse_n3_with_source(source, None, Some(label))?;
    check_proof_document(&document, proof)
}

/// As `check_proof`, but for a source already parsed — an example assembled
/// from several documents has to be merged before it is numbered.
pub fn check_proof_document(source: &crate::ast::Document, proof: &str) -> Result<Report> {
    let document = N3Proof::read_document(source, proof)?;
    Ok(check(&document))
}

/// As `check_proof_document`, with the report written as N3: the claims,
/// then the check of them (`report_to_n3`).
pub fn check_proof_report(source: &crate::ast::Document, proof: &str, proof_label: Option<&str>, source_labels: &[String]) -> Result<(Report, String)> {
    let document = N3Proof::read_document(source, proof)?;
    let report = check(&document);
    let text = report_to_n3(&source.prefixes, &document.claims, proof_label, source_labels, &report);
    Ok((report, text))
}

/// A check report as an N3 document (specification §9.9). Its plain
/// statements are the proof's claims, introduced by a comment saying what
/// the check established about them; one `pe:Check` resource then records
/// the proof and sources checked, the verdict, the step counts, each
/// condition, and every obligation and failure. A first comment line gives
/// the verdict in words.
pub fn report_to_n3(prefixes: &BTreeMap<String, String>, claims: &[Triple], proof_label: Option<&str>, source_labels: &[String], report: &Report) -> String {
    let mut prefixes = prefixes.clone();
    prefixes.entry("pe".to_string()).or_insert_with(|| PE.to_string());
    let statements: Vec<Option<Triple>> = report.obligations.iter().map(|obligation| &obligation.conclusion)
        .chain(report.failures.iter().map(|failure| &failure.conclusion))
        .map(|text| crate::parser::parse_n3(text, None).ok()
            .and_then(|parsed| (parsed.facts.len() == 1 && parsed.rules.is_empty()).then(|| parsed.facts[0].clone())))
        .collect();
    let mut mentioned: Vec<Triple> = claims.to_vec();
    mentioned.extend(statements.iter().flatten().cloned());
    mentioned.push(Triple::new(pe("Check"), pe("verdict"), pe("checked")));
    let string = |text: &str| crate::printing::term_to_n3_object(&Term::literal(text), &prefixes);
    let number = |count: usize| count.to_string();
    // A statement goes in a quoted graph; one that does not read as a
    // single triple stays the text the checker described it with.
    let statement = |position: usize, text: &str| match &statements[position] {
        Some(triple) => crate::printing::term_to_n3_object(&Term::formula(vec![triple.clone()]), &prefixes),
        None => string(text),
    };

    let mut out = format!("# {}\n", report.verdict());
    for prefix in crate::printing::used_prefixes(&prefixes, &mentioned) {
        if let Some(base) = prefixes.get(&prefix) {
            out.push_str(&format!("@prefix {}: <{}> .\n", prefix, base));
        }
    }
    out.push('\n');
    out.push_str(if !report.valid() {
        "# Unverified answers: this proof does not establish them.\n"
    } else if !report.obligations.is_empty() {
        "# Conditional answers: these follow from the source program if the obligations below hold.\n"
    } else {
        "# Checked answers: these follow from the source program.\n"
    });
    for claim in claims {
        out.push_str(crate::printing::triple_to_n3(&prefixes, claim).trim_end());
        out.push('\n');
    }

    let mut properties = Vec::new();
    properties.push("a pe:Check".to_string());
    if let Some(label) = proof_label { properties.push(format!("pe:proof {}", string(label))); }
    for label in source_labels { properties.push(format!("pe:source {}", string(label))); }
    let verdict = if !report.valid() { "invalid" } else if report.obligations.is_empty() { "checked" } else { "checkedWithObligations" };
    properties.push(format!("pe:verdict pe:{verdict}"));
    properties.push(format!("pe:steps {}", number(report.steps)));
    properties.push(format!("pe:verified {}", number(report.verified)));
    properties.push(format!("pe:trusted {}", number(report.obligations.len())));
    for (kind, count) in &report.counts {
        properties.push(format!("pe:{kind}Steps {}", number(*count)));
    }
    for (id, name, checked, failed) in report.conditions() {
        properties.push(format!("pe:condition [ pe:id {}; pe:name {}; pe:checked {}; pe:failed {} ]",
            string(id), string(name), number(checked), number(failed)));
    }
    for (position, obligation) in report.obligations.iter().enumerate() {
        properties.push(format!("pe:obligation [\n        pe:kind {};\n        pe:statement {}\n    ]",
            string(obligation.kind), indent_continuation(&statement(position, &obligation.conclusion))));
    }
    for (position, failure) in report.failures.iter().enumerate() {
        properties.push(format!("pe:failure [\n        pe:id {};\n        pe:statement {};\n        pe:detail {}\n    ]",
            string(failure.condition), indent_continuation(&statement(report.obligations.len() + position, &failure.conclusion)), string(&failure.detail)));
    }
    out.push_str("\n# The check of these answers against the source program. Its verdict covers\n");
    out.push_str("# the answers above; it does not establish that they are all the answers.\n");
    out.push_str(&format!("[]\n    {}.\n", properties.join(";\n    ")));
    out
}

/// A multi-line term placed after a property, indented to stay inside its
/// enclosing `[ ]`.
fn indent_continuation(text: &str) -> String {
    text.lines().enumerate().map(|(index, line)| if index == 0 { line.to_string() } else { format!("        {line}") })
        .collect::<Vec<_>>().join("\n")
}

impl N3Proof {
    pub fn read_document(document: &crate::ast::Document, proof: &str) -> Result<Self> {
        // `reason` numbers the rules it was given, having dropped the query
        // rules; a checker must number them the same way (§9.5.1).
        let rules: Vec<crate::ast::Rule> = document.rules.iter().filter(|rule| !rule.is_query).cloned().collect();
        // N3 treats a rule as data, so a rule written in the document is
        // itself a statement the document gives. That includes the query
        // rules left out of the numbering above, as `log:query` statements.
        // A step recording a query answer carries its rule as an
        // implication instead, which is kept apart in `query_rules`.
        let mut given: BTreeSet<Triple> = document.facts.iter().cloned().collect();
        let rule_statements: Vec<Triple> = document.rules.iter().map(written_rule_statement).collect();
        given.extend(rule_statements.iter().cloned());
        let query_rules: Vec<Triple> = document.rules.iter().filter(|rule| rule.is_query).map(crate::proof_writer::rule_statement).collect();
        let mut source_blanks = document.existentials.clone();
        source_blanks.extend(triple_blank_labels(&document.facts));
        for rule in &document.rules {
            for free in rule.premise.free_variables().into_iter().chain(rule.conclusion.free_variables()) {
                blank_labels(&free, &mut source_blanks);
            }
        }
        let query_patterns = document.rules.iter().filter(|rule| rule.is_query).flat_map(|rule| rule.conclusion.triples.clone()).collect();
        let fuses = document.rules.iter().filter(|rule| rule.is_fuse).map(|rule| rule.premise.clone()).collect();
        let general: Vec<Triple> = document.facts.iter().filter(|fact| !fact.is_ground()).cloned().collect();

        let parsed = crate::parser::parse_n3(proof, None)?;
        // A step is a formula subject carrying the `pe:` vocabulary; what
        // the document claims is written plainly alongside.
        let (steps, listings) = read_steps(&parsed.facts)?;
        let mut claims: Vec<Triple> = parsed
            .facts
            .iter()
            .filter(|triple| !is_proof_vocabulary(&triple.p))
            .cloned()
            .collect();
        claims.extend(parsed.rules.iter().map(written_rule_statement));

        let mut index = HashMap::new();
        for (position, step) in steps.iter().enumerate() {
            index.entry(step.conclusion.clone()).or_insert(position);
        }
        let general_steps = (0..steps.len()).filter(|&position| !steps[position].conclusion.is_ground()).collect();
        Ok(Self {
            rules, given, rule_statements, general, query_rules, queries: document.rules.iter().filter(|rule| rule.is_query).cloned().collect(), query_patterns, source_blanks,
            facts: document.facts.clone(), fuses, steps, listings, claims, index, general_steps,
        })
    }

    fn resolve(&self, statement: &Triple) -> Resolution {
        // Most recorded conclusions resolve directly. General assertions
        // and renamed closed graphs need the additional checks below.
        if let Some(position) = self.index.get(statement) {
            return Resolution::Step(*position);
        }
        // Closed graph terms keep their identity under consistent local
        // quantifier renaming, including between separately printed steps.
        if statement.is_ground() {
            if let Some(position) = self.steps.iter().position(|step| ground_statements_equal(&step.conclusion, statement)) {
                return Resolution::Step(position);
            }
        }
        // An instance of a step that concludes a general statement is that
        // step's, so the step is what it depends on (C2, C7).
        if let Some(&position) = self.general_steps.iter()
            .find(|&&position| match_assertion(&self.steps[position].conclusion, statement)) {
            return Resolution::Step(position);
        }
        if self.given.contains(statement) || self.gives_rule(statement) {
            return Resolution::Given;
        }
        Resolution::Unresolved(describe(statement))
    }

    /// Is the rule this step carries one the proof derives? Backward
    /// search renames a rule's variables apart, so the carried statement is
    /// a variant of the derived one rather than equal to it; a rule is the
    /// same rule under consistent renaming, so this matches instead of
    /// comparing.
    fn resolve_rule(&self, statement: &Triple) -> Resolution {
        if self.given.iter().any(|candidate| matches_rule(candidate, statement)) {
            return Resolution::Given;
        }
        if let Some(index) = self.steps.iter().position(|step| matches_rule(&step.conclusion, statement)) {
            return Resolution::Step(index);
        }
        if self.query_rules.iter().any(|candidate| matches_rule(candidate, statement)) {
            return Resolution::Given;
        }
        Resolution::Unresolved(format!("carried rule {}", describe(statement)))
    }

    /// Does this step answer a query, carrying a query rule and no rule
    /// that may feed further inference?
    fn answers_query(&self, step: &Step) -> bool {
        let Some((_, _, statement)) = &step.carried else { return false };
        self.query_rules.iter().any(|candidate| matches_rule(candidate, statement))
            && !self.given.iter().chain(self.steps.iter().map(|step| &step.conclusion)).any(|candidate| matches_rule(candidate, statement))
    }

    fn query_application(&self, step: &Step) -> bool {
        step.carried.as_ref().is_some_and(|(_, _, statement)|
            self.query_rules.iter().any(|candidate| matches_rule(candidate, statement)))
    }

    fn resolve_premise(&self, statement: &Triple, user: usize) -> Resolution {
        match self.resolve(statement) {
            Resolution::Step(target) if target == user || self.answers_query(&self.steps[target]) => {
                if self.given.contains(statement) || self.gives_rule(statement) { Resolution::Given }
                else { Resolution::Step(target) }
            }
            resolution => resolution,
        }
    }

    /// A query selecting an existing fact may have no separate output
    /// step. Check one complete selection using assertions already proved;
    /// never run rules or invent an unrecorded trust obligation.
    fn query_selection(&self, claim: &Triple) -> std::result::Result<Vec<Resolution>, String> {
        if matches!(self.resolve(claim), Resolution::Step(target) if self.query_application(&self.steps[target])) {
            return Ok(Vec::new());
        }
        let mut remaining = MAX_PROOF_MATCHES;
        for query in &self.queries {
            // Existential output is an introduction, not selection. It
            // needs an explicit rule step so C8 can check its witnesses.
            if !query.conclusion.existentials.is_empty() { continue; }
            for head in &query.conclusion {
                let mut bindings = Bindings::new();
                if !match_triple(head, claim, &mut bindings) { continue; }
                if let Some(dependencies) = self.match_conditions(&query.premise, bindings, &mut remaining)? {
                    return Ok(dependencies);
                }
            }
        }
        Err("is output without a supported query application: the recorded evidence does not satisfy the query's conditions".into())
    }

    /// Join recorded assertions and replay pure built-ins, without deriving
    /// new facts or assuming missing current-graph/external observations.
    fn match_conditions(&self, premises: &[Triple], bindings: Bindings, remaining: &mut usize) -> std::result::Result<Option<Vec<Resolution>>, String> {
        let mut supports = None;
        let mut pending = vec![(0usize, bindings, Vec::new())];
        while let Some((position, bindings, dependencies)) = pending.pop() {
            if position == premises.len() { return Ok(Some(dependencies)); }
            let premise = &premises[position];
            let mapping = bindings.iter().map(|(name, value)| (Term::var(name.clone()), value.clone())).collect();
            let instance = Triple::new(replace_terms(&premise.s, &mapping), replace_terms(&premise.p, &mapping), replace_terms(&premise.o, &mapping));
            if instance.is_ground() {
                let resolved = match self.resolve(&instance) {
                    Resolution::Step(target) if !self.answers_query(&self.steps[target]) => Some(Resolution::Step(target)),
                    _ if self.given.contains(&instance) || (self.gives_rule(&instance)
                        && self.source_instance(&instance).is_none_or(|application| application.witnesses.is_empty())) => Some(Resolution::Given),
                    _ => None,
                };
                if let Some(resolved) = resolved {
                    let mut dependencies = dependencies;
                    dependencies.push(resolved);
                    pending.push((position + 1, bindings, dependencies));
                    continue;
                }
            }
            if !reads_outside_proof(&instance) && current_graph_test(&instance).is_none() {
                for solution in crate::reasoner::Evidence::new(Vec::new()).evaluate(&instance) {
                    if *remaining == 0 { return Err("evidence matching exceeded its match budget".into()); }
                    *remaining -= 1;
                    let mut trial = bindings.clone();
                    trial.extend(solution);
                    let mapping = trial.iter().map(|(name, value)| (Term::var(name.clone()), value.clone())).collect();
                    let conclusion = Triple::new(replace_terms(&premise.s, &mapping), replace_terms(&premise.p, &mapping), replace_terms(&premise.o, &mapping));
                    let probe = Step { builtin: Some(conclusion.p.clone()), conclusion, kind: Kind::Builtin, rule: None, carried: None, bindings: Vec::new(), uses: Vec::new() };
                    if matches!(self.check_builtin(&probe), Ok(Checked::Verified)) {
                        pending.push((position + 1, trial, dependencies.clone()));
                    }
                }
            }
            let supports = supports.get_or_insert_with(|| self.given.iter().map(|triple| (triple, None))
                .chain(self.steps.iter().enumerate().filter(|(_, step)| !self.answers_query(step))
                    .map(|(index, step)| (&step.conclusion, Some(index)))).collect::<Vec<_>>());
            for (support, target) in supports.iter() {
                if *remaining == 0 { return Err("evidence matching exceeded its match budget".into()); }
                *remaining -= 1;
                let mut trial = bindings.clone();
                if match_triple(premise, support, &mut trial) {
                    let mut dependencies = dependencies.clone();
                    dependencies.push(target.map_or(Resolution::Given, Resolution::Step));
                    pending.push((position + 1, trial, dependencies));
                }
            }
        }
        Ok(None)
    }

    fn recorded_bindings(&self, step: &Step) -> std::result::Result<Bindings, String> {
        let (premise, conclusion, names) = match &step.carried {
            Some((premise, conclusion, _)) => (premise, conclusion, None),
            None => {
                let Some(rule) = step.rule.and_then(|number| self.rules.get(number.wrapping_sub(1))) else { return Ok(Bindings::new()); };
                (&rule.premise, &rule.conclusion, Some(&rule.proof_var_source_names))
            }
        };
        let variables: BTreeSet<_> = premise.free_variables().into_iter().chain(conclusion.free_variables())
            .filter_map(|term| if let Term::Var(name) = term { Some(name) } else { None }).collect();
        let mut bindings = Bindings::new();
        for (name, value) in &step.bindings {
            let mapped = names.and_then(|names| names.iter().find(|(_, source)| *source == name)).map(|(internal, _)| internal.as_str());
            let internal = if let Some(mapped) = mapped { mapped }
                else if variables.contains(name.as_str()) { name.as_str() }
                else {
                    // Carried backward rules record standardized variable
                    // names in their formula and source names in bindings.
                    // Accept a short name only when it identifies exactly
                    // one variable that the carried rule actually declares.
                    let mut aliases = variables.iter().filter(|internal| internal.starts_with("__backward_")
                        && internal.rsplit_once("__").is_some_and(|(_, suffix)| suffix == name));
                    let alias = aliases.next().ok_or_else(|| format!("binding {} is not a variable of the cited rule", name))?;
                    if aliases.next().is_some() { return Err(format!("binding {} names more than one variable of the carried rule", name)); }
                    alias.as_str()
                };
            if !variables.contains(internal) { return Err(format!("binding {} is not a variable of the cited rule", name)); }
            if bindings.insert(internal.into(), value.clone()).is_some() {
                return Err(format!("records more than one binding for rule variable {}", name));
            }
        }
        Ok(bindings)
    }

    /// §9.5.1: re-perform the one rule application this step records.
    fn rule_applications(&self, step: &Step) -> std::result::Result<Vec<Application>, String> {
        let (conclusion, number, identity, bindings) = self.matched_premises(step)?;
        // Resolve unquoting after the premises: a partial recorded binding
        // list need not repeat the graph value a premise already supplies.
        let conclusion = unquoted_conclusion(&conclusion, &bindings).unwrap_or(conclusion);
        let mut occupied = BTreeSet::new();
        if !conclusion.existentials.is_empty() {
            occupied = triple_blank_labels(&step.uses);
            for value in bindings.values() { blank_labels(value, &mut occupied); }
        }
        let applications: Vec<_> = conclusion.iter().enumerate().filter_map(|(head, candidate)| {
            let mut trial = bindings.clone();
            // Equal labels in the two quoted sides have separate scopes.
            for label in &conclusion.existentials { trial.remove(format!("_:{}", label).as_str()); }
            if !match_triple(candidate, &step.conclusion, &mut trial) { return None; }
            let witnesses = conclusion.existentials.iter().filter_map(|label|
                trial.get(format!("_:{}", label).as_str()).map(|value| (label.clone(), value.clone()))).collect();
            let assignment = if conclusion.existentials.is_empty() { Vec::new() } else {
                let mut assignment = bindings.clone();
                assignment.extend(trial.into_iter().filter(|(name, _)|
                    !conclusion.existentials.iter().any(|label| name.as_str() == format!("_:{}", label))));
                assignment.into_iter().collect()
            };
            Some(Application { firing: (identity.clone(), assignment), head: Some(head), witnesses, occupied: occupied.clone() })
        }).collect();
        if applications.is_empty() {
            return Err(format!("does not follow from {}: it concludes none of what this step claims", number));
        }
        Ok(applications)
    }

    /// The rule a step applies, and the bindings its recorded premises give
    /// that rule: its conclusion, how to name it, the identity of its
    /// firings, and the bindings.
    fn matched_premises(&self, step: &Step) -> std::result::Result<(crate::ast::Graph, String, String, Bindings), String> {
        let (premise, conclusion, number, identity) = self.applied_rule(step)?;
        let mut bindings = self.recorded_bindings(step)?;
        // Existentials outside the rule's two sides denote existing
        // individuals. Only blanks bound by a premise or head may match.
        for free in premise.free_variables().into_iter().chain(conclusion.free_variables()) {
            if let Term::Blank(name) = &free {
                bindings.insert(format!("_:{}", name).into(), free.clone());
            }
        }

        if premise.len() != step.uses.len() {
            return Err(format!("uses {} premise(s), but {} has {}", step.uses.len(), number, premise.len()));
        }
        // One environment across every premise and the conclusion, so a
        // variable the bindings did not mention is still forced to take one
        // consistent value (§9.5.1). Only the rule's own variables bind: the
        // step may not instantiate itself to meet the rule halfway.
        for (position, (premise, used)) in premise.iter().zip(step.uses.iter()).enumerate() {
            if !match_triple(premise, used, &mut bindings) {
                return Err(format!("premise {} is {}, but {} requires {}", position + 1, describe(used), number, describe(premise)));
            }
        }
        Ok((conclusion, number, identity, bindings))
    }

    /// The premise and conclusion of the rule a step applies, how to name
    /// it, and the identity its firings share.
    fn applied_rule(&self, step: &Step) -> std::result::Result<(crate::ast::Graph, crate::ast::Graph, String, String), String> {
        // A generated rule is carried by the step; a written one is taken
        // from the source, never from the document.
        match &step.carried {
            Some((premise, conclusion, statement)) => {
                // The carried rule has to be justified too, or a step could
                // invent any rule it liked.
                if matches!(self.resolve_rule(statement), Resolution::Unresolved(_)) {
                    return Err("carries a generated rule that nothing in the proof derives".to_string());
                }
                Ok((premise.clone(), conclusion.clone(), "the generated rule it carries".to_string(), describe(statement)))
            }
            None => {
                let number = step.rule.ok_or_else(|| "cites no rule".to_string())?;
                let rule = self.rules.get(number.wrapping_sub(1)).ok_or_else(|| format!("cites rule {}, which the source does not have", number))?;
                Ok((rule.premise.clone(), rule.conclusion.clone(), format!("rule {}", number), format!("rule {}", number)))
            }
        }
    }

    /// C10 for one rule step: each negative, collecting or universal test
    /// among its premises is the call the rule makes. A variable that only
    /// test clauses mention is local to its test, which the reasoner runs
    /// once the rule's other premises have bound theirs, so it must stay a
    /// variable: binding it would turn "no `?x` has this" into "this one
    /// does not".
    fn called_tests(&self, step: &Step) -> std::result::Result<(), String> {
        let Ok((premise, _, number, _)) = self.applied_rule(step) else { return Ok(()) };
        let local = local_test_variables(&premise);
        if local.is_empty() { return Ok(()); }
        // C1 reports a step whose premises do not match its rule.
        let Ok((_, _, _, bindings)) = self.matched_premises(step) else { return Ok(()) };
        let mut renamed = BTreeMap::new();
        for name in &local {
            match bindings.get(name.as_str()) {
                None => {}
                Some(Term::Var(other)) => {
                    if let Some(first) = renamed.insert(other.clone(), name.clone()) {
                        return Err(format!("merges the local variables ?{} and ?{} of a test in {}", first, name, number));
                    }
                }
                Some(value) => return Err(format!(
                    "binds ?{}, which only a test clause of {} mentions, to {}; the rule tests that clause with ?{} unbound",
                    name, number, crate::printing::term_to_n3_object(value, &BTreeMap::new()), name)),
            }
        }
        Ok(())
    }

    fn source_instance(&self, statement: &Triple) -> Option<Application> {
        self.general.iter().find_map(|candidate| {
            let mut bindings = Bindings::new();
            if !match_triple(candidate, statement, &mut bindings) { return None; }
            let (existentials, assignment): (Vec<_>, Vec<_>) = bindings.into_iter().partition(|(name, _)| name.starts_with("_:"));
            let witnesses = existentials.into_iter().map(|(name, value)| (name[2..].into(), value)).collect();
            let mut occupied = BTreeSet::new();
            for (_, value) in &assignment { blank_labels(value, &mut occupied); }
            Some(Application { firing: ("source assertions".into(), assignment), head: None, witnesses, occupied })
        })
    }

    /// A written rule, matched up to renaming: the engine standardizes a
    /// rule's variables apart before using it.
    fn gives_rule(&self, statement: &Triple) -> bool {
        self.rule_statements
            .iter()
            .any(|candidate| candidate.p == statement.p && match_assertion(candidate, statement))
            || self.source_instance(statement).is_some()
            || self.given.iter().any(|candidate| ground_statements_equal(candidate, statement))
    }

    /// The conclusion of the forward rule a step applies, when that rule
    /// introduces existentials only where no fact already satisfies them:
    /// it has premises and is not a query (§4.2).
    fn lean_conclusion<'s>(&'s self, step: &'s Step) -> Option<&'s crate::ast::Graph> {
        let (premise, conclusion) = match &step.carried {
            Some((premise, conclusion, statement)) => {
                if statement.p != Term::iri(crate::ast::LOG_IMPLIES) || self.query_application(step) { return None; }
                (premise, conclusion)
            }
            None => {
                let rule = step.rule.and_then(|number| self.rules.get(number.wrapping_sub(1)))?;
                if !rule.is_forward || rule.is_fuse { return None; }
                (&rule.premise, &rule.conclusion)
            }
        };
        (!premise.is_empty() && conclusion.universals.is_empty() && !conclusion.existentials.is_empty()).then_some(conclusion)
    }

    /// The application a step introduces existentials in, if it does:
    /// every way of reading the step instantiates an existential.
    fn introduction<'s>(&'s self, step: &'s Step) -> Option<(&'s crate::ast::Graph, Application)> {
        let conclusion = self.lean_conclusion(step)?;
        let mut applications = self.rule_applications(step).ok()?;
        if applications.iter().any(|application| application.witnesses.is_empty()) { return None; }
        Some((conclusion, applications.swap_remove(0)))
    }

    /// C6 for introductions: each assumes no fact satisfied its piece, the
    /// head triples sharing its existentials, under the firing's frontier
    /// values. Evidence that does so contradicts the assumption, unless it
    /// is the firing's own: a statement that mentions one of its witnesses,
    /// or that depends on such a statement. Returns how many pieces were
    /// examined.
    fn unsatisfied_existentials(&self, evidence: &crate::reasoner::Evidence,
        introductions: &[(&Step, &crate::ast::Graph, Application)], contradictions: &mut Vec<(String, String)>) -> usize {
        let mut witnesses: BTreeMap<&Firing, BTreeSet<crate::ast::Name>> = BTreeMap::new();
        for (_, _, application) in introductions {
            let entry = witnesses.entry(&application.firing).or_default();
            for (_, value) in &application.witnesses { blank_labels(value, entry); }
        }
        let mut examined = BTreeSet::new();
        for (step, conclusion, application) in introductions {
            let Some(head) = application.head else { continue };
            let Some(piece) = crate::reasoner::existential_pieces(conclusion).into_iter().find(|piece| piece.contains(&head)) else { continue };
            if !examined.insert((&application.firing, piece.clone())) { continue; }
            let mut mapping: BTreeMap<Term, Term> = application.firing.1.iter()
                .filter(|(name, _)| !name.starts_with("_:"))
                .map(|(name, value)| (Term::Var(name.clone()), value.clone())).collect();
            for label in &conclusion.existentials {
                mapping.insert(Term::Blank(label.clone()), Term::var(format!("__exists_{}", label)));
            }
            let pattern: Vec<Triple> = piece.iter().map(|&position| {
                let triple = &conclusion[position];
                Triple::new(replace_terms(&triple.s, &mapping), replace_terms(&triple.p, &mapping), replace_terms(&triple.o, &mapping))
            }).collect();
            let own = &witnesses[&application.firing];
            for solution in evidence.satisfying(&pattern) {
                let solved: BTreeMap<Term, Term> = solution.iter().map(|(name, value)| (Term::Var(name.clone()), value.clone())).collect();
                let support: Vec<Triple> = pattern.iter().map(|triple| Triple::new(
                    replace_terms(&triple.s, &solved), replace_terms(&triple.p, &solved), replace_terms(&triple.o, &solved))).collect();
                if support.iter().all(|triple| !self.depends_on_witnesses(triple, own)) {
                    contradictions.push((describe(&step.conclusion), format!(
                        "introduces an existential, but the proof's own evidence already satisfies it: {}", describe(&support[0]))));
                    break;
                }
            }
        }
        examined.len()
    }

    /// Whether `statement` mentions one of `witnesses` or is derived from
    /// a statement that does.
    fn depends_on_witnesses(&self, statement: &Triple, witnesses: &BTreeSet<crate::ast::Name>) -> bool {
        let mentions = |triple: &Triple| {
            let mut labels = BTreeSet::new();
            for term in [&triple.s, &triple.p, &triple.o] { blank_labels(term, &mut labels); }
            !labels.is_disjoint(witnesses)
        };
        if mentions(statement) { return true; }
        let Resolution::Step(start) = self.resolve(statement) else { return false };
        let mut seen = BTreeSet::from([start]);
        let mut pending = vec![start];
        while let Some(index) = pending.pop() {
            if mentions(&self.steps[index].conclusion) { return true; }
            for dependency in ProofDocument::dependencies(self, index) {
                if let Resolution::Step(next) = dependency {
                    if seen.insert(next) { pending.push(next); }
                }
            }
        }
        false
    }

    /// The steps whose tests a search certificate may settle: negations,
    /// collections and universal tests over the current graph that read
    /// nothing outside the proof.
    fn certifiable(&self, step: &Step) -> bool {
        step.kind == Kind::Builtin && step.builtin.as_ref() == Some(&step.conclusion.p) && certifiable_test(&step.conclusion)
    }

    /// Whether `test` holds with `evidence` as the current graph: `None`
    /// when that cannot decide it — a collection whose list differs only
    /// in what a certificate cannot establish, or a search over budget.
    fn decide(&self, evidence: &crate::reasoner::Evidence, test: &Triple) -> Option<bool> {
        // Re-evaluating a test gives a solution exactly when it holds.
        let scope = Term::blank("current_graph");
        match &test.p {
            Term::Iri(name) if name.as_str() == LOG_NOT_INCLUDES =>
                Some(!evidence.try_evaluate(&Triple::new(scope, test.p.clone(), test.o.clone())).ok()?.is_empty()),
            Term::Iri(name) if name.as_str() == LOG_FOR_ALL_IN =>
                Some(!evidence.try_evaluate(&Triple::new(test.s.clone(), test.p.clone(), scope)).ok()?.is_empty()),
            Term::Iri(name) if name.as_str() == LOG_COLLECT_ALL_IN => {
                let Term::List(parts) = &test.s else { return None };
                let [template, condition, collected] = parts.as_slice() else { return None };
                let retest = Triple::new(Term::List(vec![template.clone(), condition.clone(), Term::var("__collected")]), test.p.clone(), scope);
                let found = evidence.try_evaluate(&retest).ok()?.into_iter().find_map(|bindings| bindings.get("__collected").cloned());
                // The order of a collection over the current graph is not
                // the certificate's to establish, so a list that differs is
                // left to C6 rather than refuted here.
                (found.as_ref().and_then(list_items) == list_items(collected)).then_some(true)
            }
            _ => None,
        }
    }

    /// Whether `facts`, the certificate's listing of `predicate`, is closed:
    /// every solution of a forward rule's premise over `evidence` gives
    /// conclusions with that predicate that are listed or given, and
    /// satisfies each existential piece that has one. `Err(None)` when the
    /// checker could not finish.
    fn listing_closed(&self, evidence: &crate::reasoner::Evidence, predicate: &Term, facts: &BTreeSet<&Triple>, listed: &BTreeSet<&Term>)
        -> std::result::Result<(), Option<String>> {
        for (number, rule) in self.rules.iter().enumerate() {
            if !rule.is_forward || rule.is_fuse { continue; }
            let heads: Vec<usize> = (0..rule.conclusion.len())
                .filter(|&head| rule.conclusion[head].p == *predicate || matches!(rule.conclusion[head].p, Term::Var(_))).collect();
            if heads.is_empty() { continue; }
            let pieces = crate::reasoner::existential_pieces(&rule.conclusion);
            for solution in evidence.try_solutions(&rule.premise).map_err(|_| None)? {
                let mapping: BTreeMap<Term, Term> = solution.iter().map(|(name, value)| (Term::Var(name.clone()), value.clone())).collect();
                for &head in &heads {
                    let instance = |triple: &Triple, mapping: &BTreeMap<Term, Term>|
                        Triple::new(replace_terms(&triple.s, mapping), replace_terms(&triple.p, mapping), replace_terms(&triple.o, mapping));
                    if let Some(piece) = pieces.iter().find(|piece| piece.contains(&head)) {
                        // An existential conclusion holds when some
                        // individual satisfies its whole piece.
                        let mut open = mapping.clone();
                        for label in &rule.conclusion.existentials {
                            open.insert(Term::Blank(label.clone()), Term::var(format!("__exists_{}", label)));
                        }
                        let pattern: Vec<Triple> = piece.iter().map(|&position| instance(&rule.conclusion[position], &open)).collect();
                        // A piece over a derived predicate the certificate
                        // does not list cannot be looked for in it.
                        if pattern.iter().any(|triple| !matches!(triple.p, Term::Iri(_)) || (!listed.contains(&triple.p)
                            && self.rules.iter().any(|rule| !rule.is_query && !rule.is_fuse
                                && rule.conclusion.iter().any(|head| head.p == triple.p || matches!(head.p, Term::Var(_)))))) {
                            return Err(None);
                        }
                        if evidence.satisfying(&pattern).is_empty() {
                            return Err(Some(format!("is not closed: rule {} requires {}, which the certificate does not contain",
                                number + 1, describe(&pattern[0]))));
                        }
                        continue;
                    }
                    let derived = instance(&rule.conclusion[head], &mapping);
                    if derived.p != *predicate { continue; }
                    if !derived.is_ground() { return Err(None); }
                    if !facts.contains(&derived) && !self.given.contains(&derived) {
                        return Err(Some(format!("is not closed: rule {} derives {}, which it does not list", number + 1, describe(&derived))));
                    }
                }
            }
        }
        Ok(())
    }

    fn check_fact(&self, step: &Step) -> Verdict {
        if !step.uses.is_empty() {
            return Err("a source fact step must not have premises".to_string());
        }
        if self.given.contains(&step.conclusion) || self.gives_rule(&step.conclusion) {
            Ok(Checked::Verified)
        } else {
            Err("is justified as a fact, but the source does not give it".to_string())
        }
    }

    /// §9.5.3: re-evaluate the built-in on the step's own triple.
    fn check_builtin(&self, step: &Step) -> Verdict {
        let Some(Term::Iri(name)) = step.builtin.clone() else {
            return Err("names no built-in".to_string());
        };
        if step.builtin.as_ref() != Some(&step.conclusion.p) {
            return Err(format!("names built-in {}, but the conclusion has predicate {}", name,
                crate::printing::term_to_n3_predicate(&step.conclusion.p, &BTreeMap::new())));
        }
        // Re-evaluation fills in whatever is left open, which would turn a
        // computed value into a universal claim. A collection's template
        // and condition are meant to be open; only its result is a value.
        let triple = &step.conclusion;
        let current = current_graph_test(triple);
        if matches!(name.as_str(), LOG_INCLUDES | LOG_NOT_INCLUDES) && !matches!(triple.o, Term::Formula(_)) {
            return Err(format!("{} requires a quoted graph as its object", name));
        }
        let values: Vec<&Term> = match (&triple.s, name.as_str()) {
            (Term::List(parts), LOG_COLLECT_ALL_IN) if parts.len() == 3 => {
                if !matches!(parts[1], Term::Formula(_)) || list_items(&parts[2]).is_none() {
                    return Err("log:collectAllIn requires a template, a condition graph, and a result list".into());
                }
                if current.is_some() { vec![&parts[2]] } else { vec![&parts[2], &triple.o] }
            }
            (_, LOG_COLLECT_ALL_IN) => return Err("log:collectAllIn requires a three-item list".into()),
            (Term::List(parts), LOG_FOR_ALL_IN) if parts.len() == 2 && parts.iter().all(|part| matches!(part, Term::Formula(_))) => {
                if current.is_some() { vec![] } else { vec![&triple.o] }
            }
            (_, LOG_FOR_ALL_IN) => return Err("log:forAllIn requires two quoted graphs".into()),
            (_, LOG_INCLUDES | LOG_NOT_INCLUDES) if current.is_some() => vec![&triple.o],
            // Impure graph-producing relations can return open formulae;
            // their truth is explicitly an obligation, never verified.
            _ if IMPURE_BUILTINS.contains(&name.as_str()) => {
                if [&triple.s, &triple.o].into_iter().any(has_open_variable) {
                    return Err(format!("leaves a variable of {} unbound", name));
                }
                let shaped = match name.as_str() {
                    "http://www.w3.org/2000/10/swap/time#localTime" => matches!(triple.o, Term::Literal(_))
                        && crate::reasoner::verify_builtin_triple(triple),
                    "http://www.w3.org/2000/10/swap/log#content" => matches!(triple.s, Term::Iri(_)) && plain_string(&triple.o).is_some(),
                    "http://www.w3.org/2000/10/swap/log#semantics" => matches!((&triple.s, &triple.o), (Term::Iri(_), Term::Formula(_))),
                    "http://www.w3.org/2000/10/swap/log#semanticsOrError" => matches!(triple.s, Term::Iri(_))
                        && (matches!(triple.o, Term::Formula(_)) || plain_string(&triple.o).is_some()),
                    "http://www.w3.org/2000/10/swap/log#conclusion" => matches!((&triple.s, &triple.o), (Term::Formula(_), Term::Formula(_))),
                    "http://www.w3.org/2000/10/swap/list#map" => match (&triple.s, list_items(&triple.o)) {
                        (Term::List(parts), Some(_)) => matches!(parts.as_slice(), [input, Term::Iri(_)]
                            if list_items(input).is_some_and(|items| items.iter().all(Term::is_ground))),
                        _ => false,
                    },
                    _ => false,
                };
                if !shaped { return Err(format!("records incompatible argument types or values for {}", name)); }
                return Ok(Checked::Trusted("impure built-in"));
            }
            _ => vec![&triple.s, &triple.o],
        };
        if values.iter().any(|value| has_open_variable(value)) {
            return Err(format!("leaves a variable of {} unbound", name));
        }
        if reads_outside_proof(triple) { return Ok(Checked::Trusted("impure built-in")); }
        if let Some(kind) = current {
            return Ok(Checked::Trusted(kind));
        }
        if !matches!(name.as_str(), LOG_INCLUDES | LOG_NOT_INCLUDES | LOG_COLLECT_ALL_IN | LOG_FOR_ALL_IN | LOG_CONJUNCTION)
            && values.iter().any(|value| has_free_universal(value)) {
            return Err(format!("leaves a quoted variable of {} unbound", name));
        }
        // Quoted arguments may contain symbolic statements, but replay may
        // not make the recorded relation true by assigning their free
        // universals. Templates and conditions above are intentional
        // patterns; value arguments must retain their recorded meaning.
        let mut variables = BTreeSet::new();
        for value in values { free_universals(value, &mut variables); }
        let matches = crate::reasoner::Evidence::new(Vec::new()).evaluate(triple);
        if matches.iter().any(|bindings| variables.iter().all(|name|
            bindings.get(name).is_none_or(|value| *value == Term::var(name.clone())))) {
            Ok(Checked::Verified)
        } else if !matches.is_empty() {
            Err(format!("leaves a quoted variable of {} unbound; re-evaluation would assign it a value", name))
        } else {
            Err(format!("re-evaluating {} did not hold", name))
        }
    }
}

/// Is `statement` the rule `candidate` asserts, up to renaming and the
/// direction its implication is written in?
fn matches_rule(candidate: &Triple, statement: &Triple) -> bool {
    if candidate.p == statement.p && match_assertion(candidate, statement) {
        return true;
    }
    // Forward and backward implication assert the same rule with
    // their subject and object reversed. Quantified assertions are
    // registered as empty-premise backward rules for goal search.
    let reversed = match &candidate.p {
        Term::Iri(iri) if iri.as_str() == crate::ast::LOG_IMPLIES => Some(crate::ast::LOG_IMPLIED_BY),
        Term::Iri(iri) if iri.as_str() == crate::ast::LOG_IMPLIED_BY => Some(crate::ast::LOG_IMPLIES),
        _ => None,
    };
    if let Some(predicate) = reversed {
        let equivalent = Triple::new(candidate.o.clone(), Term::iri(predicate), candidate.s.clone());
        if equivalent.p == statement.p && match_assertion(&equivalent, statement) {
            return true;
        }
    }
    false
}

/// A derived assertion or rule statement keeps its free blank identities.
/// Only universals can be specialized when using it as evidence.
fn match_assertion(pattern: &Triple, target: &Triple) -> bool {
    let mut bindings = Bindings::new();
    for name in triple_blank_labels(std::slice::from_ref(pattern)) {
        bindings.insert(format!("_:{}", name).into(), Term::blank(name));
    }
    match_triple(pattern, target, &mut bindings)
}

/// Preserve query predicates and false conclusions when lifting rule claims.
fn written_rule_statement(rule: &crate::ast::Rule) -> Triple {
    let mut statement = crate::proof_writer::rule_statement(rule);
    if rule.is_query { statement.p = Term::iri(crate::ast::LOG_QUERY); }
    if rule.is_fuse {
        statement.o = Term::Literal(crate::ast::Literal {
            value: "false".into(),
            datatype: Some("http://www.w3.org/2001/XMLSchema#boolean".into()),
            language: None,
        });
    }
    statement
}

/// Ground statements compare their closed graph terms modulo local renaming.
fn ground_statements_equal(left: &Triple, right: &Triple) -> bool {
    left.is_ground() && right.is_ground()
        && crate::reasoner::terms_equal_semantic(&left.s, &right.s)
        && crate::reasoner::terms_equal_semantic(&left.p, &right.p)
        && crate::reasoner::terms_equal_semantic(&left.o, &right.o)
}

/// One-way matching of a rule's pattern against a recorded statement.
/// Only the pattern's variables bind. A blank node in a rule head is an
/// existential, which the engine skolemizes, so it binds too — under a
/// name that cannot collide with a variable's.
pub(crate) fn match_term(pattern: &Term, target: &Term, bindings: &mut Bindings) -> bool {
    let key = match pattern {
        Term::Var(name) => Some(name.clone()),
        Term::Blank(label) => Some(format!("_:{}", label)).map(Into::into),
        _ => None,
    };
    if let Some(key) = key {
        return match bindings.get(&key) {
            Some(bound) => bound == target,
            None => {
                bindings.insert(key, target.clone());
                true
            }
        };
    }
    match (pattern, target) {
        (Term::List(left), Term::List(right)) => {
            left.len() == right.len() && left.iter().zip(right.iter()).all(|(l, r)| match_term(l, r, bindings))
        }
        (Term::Formula(left), Term::Formula(right)) => {
            // Free existential placeholders belong to the enclosing rule;
            // let them bind just as blank patterns in ordinary triples do.
            // Locally quantified blanks remain rigid alpha variables.
            let mapping = left.free_variables().into_iter().filter_map(|term| {
                if let Term::Blank(name) = &term {
                    Some((term.clone(), Term::var(format!("_:{}", name))))
                } else {
                    None
                }
            }).collect();
            let left = left.substitute(&mapping);
            // A recorded use substitutes the rule's free variables. Its
            // blank values are identities from the recorded environment,
            // even when the proof's quoted syntax locally binds their labels.
            let mut captured = BTreeSet::new();
            for free in left.free_variables() {
                if let Term::Var(n) = free {
                    if let Some(value) = bindings.get(&n) { blank_labels(value, &mut captured); }
                }
            }
            fn recorded_term(term: &Term, captured: &BTreeSet<crate::ast::Name>) -> Term {
                match term {
                    Term::Formula(g) => Term::Formula(recorded_graph(g,captured)),
                    Term::List(items) => Term::List(items.iter().map(|t|recorded_term(t,captured)).collect()),
                    _ => term.clone(),
                }
            }
            fn recorded_graph(graph: &crate::ast::Graph, captured: &BTreeSet<crate::ast::Name>) -> crate::ast::Graph {
                let mut out=graph.map_triples(|t|Triple::new(recorded_term(&t.s,captured),recorded_term(&t.p,captured),recorded_term(&t.o,captured)));
                out.existentials.retain(|n|!captured.contains(n));
                out
            }
            let recorded = recorded_graph(right,&captured);
            // Matching is one-way: the recorded side's free variables are
            // rigid, or a proof could carry `{ ?a ?b ?c } => { ?d ?e ?f }`
            // as an instance of any rule. Freeze them as fresh IRIs absent
            // from both inputs, and thaw what the unification bound.
            let initial = "urn:eyeron:proof-check:frozen:";
            let mut prefix = initial.to_string();
            let mut suffix = 0usize;
            // Both documents are untrusted. Choose a namespace absent from
            // their terms and binding values rather than reserving a public
            // IRI that a forged proof could write itself.
            while contains_iri_prefix(&Term::Formula(left.clone()), &prefix)
                || contains_iri_prefix(&Term::Formula(recorded.clone()), &prefix)
                || bindings.values().any(|value| contains_iri_prefix(value, &prefix)) {
                prefix = format!("{}{}:", initial, suffix);
                suffix += 1;
            }
            let frozen: BTreeMap<Term, Term> = recorded.free_variables().into_iter()
                .filter_map(|term| match &term {
                    Term::Var(name) => Some((term.clone(), Term::iri(format!("{}{}", prefix, name)))),
                    _ => None,
                })
                .collect();
            if frozen.is_empty() {
                return crate::reasoner::unify_term(&Term::Formula(left), &Term::Formula(recorded), bindings);
            }
            let thawed: BTreeMap<Term, Term> = frozen.iter().map(|(var, iri)| (iri.clone(), var.clone())).collect();
            let mut trial: Bindings = bindings.iter().map(|(name, value)| (name.clone(), replace_terms(value, &frozen))).collect();
            if !crate::reasoner::unify_term(&Term::Formula(left), &Term::Formula(recorded.substitute(&frozen)), &mut trial) {
                return false;
            }
            *bindings = trial.into_iter().map(|(name, value)| (name, replace_terms(&value, &thawed))).collect();
            true
        }
        _ => pattern == target,
    }
}

fn contains_iri_prefix(term: &Term, prefix: &str) -> bool {
    match term {
        Term::Iri(iri) => iri.starts_with(prefix),
        Term::List(items) => items.iter().any(|item| contains_iri_prefix(item, prefix)),
        Term::Formula(graph) => graph.iter().any(|triple|
            [&triple.s, &triple.p, &triple.o].into_iter().any(|term| contains_iri_prefix(term, prefix))),
        _ => false,
    }
}

fn replace_terms(term: &Term, mapping: &BTreeMap<Term, Term>) -> Term {
    if let Some(value) = mapping.get(term) {
        return value.clone();
    }
    match term {
        Term::List(items) => Term::List(items.iter().map(|item| replace_terms(item, mapping)).collect()),
        Term::Formula(graph) => Term::Formula(graph.substitute(mapping)),
        _ => term.clone(),
    }
}

/// A variable outside any graph term: a built-in step has to state the
/// values it was evaluated on, not leave them open.
/// The scoped tests a rule runs on a clause rather than matching: the
/// clause terms of `log:notIncludes`, `log:collectAllIn` (template and
/// condition) and `log:forAllIn`. Other positions, such as a scope or a
/// collection's result, bind as ordinary terms.
fn test_clauses(triple: &Triple) -> Option<Vec<&Term>> {
    let Term::Iri(name) = &triple.p else { return None };
    match (name.as_str(), &triple.s) {
        (LOG_NOT_INCLUDES, _) => Some(vec![&triple.o]),
        (LOG_COLLECT_ALL_IN, Term::List(parts)) if parts.len() == 3 => Some(vec![&parts[0], &parts[1]]),
        (LOG_FOR_ALL_IN, Term::List(parts)) => Some(parts.iter().collect()),
        _ => None,
    }
}

/// The variables of a rule's premise that only its test clauses mention,
/// so that each test runs with them unbound.
fn local_test_variables(premise: &crate::ast::Graph) -> BTreeSet<crate::ast::Name> {
    let mut inside = BTreeSet::new();
    let mut outside = BTreeSet::new();
    for triple in premise.iter() {
        let clauses = test_clauses(triple).unwrap_or_default();
        let is_clause = |term: &Term| clauses.iter().any(|clause| std::ptr::eq(*clause, term));
        for term in [&triple.s, &triple.p, &triple.o] {
            match term {
                _ if is_clause(term) => free_universals(term, &mut inside),
                Term::List(parts) if !clauses.is_empty() => for part in parts {
                    free_universals(part, if is_clause(part) { &mut inside } else { &mut outside });
                },
                _ => free_universals(term, &mut outside),
            }
        }
    }
    inside.difference(&outside).cloned().collect()
}

fn has_open_variable(term: &Term) -> bool {
    match term {
        Term::Var(_) => true,
        Term::List(items) => items.iter().any(has_open_variable),
        _ => false,
    }
}

fn list_items(term: &Term) -> Option<&[Term]> {
    match term {
        Term::List(items) => Some(items),
        Term::Iri(iri) if iri == crate::ast::RDF_NIL => Some(&[]),
        _ => None,
    }
}

fn has_free_universal(term: &Term) -> bool {
    match term {
        Term::Var(_) => true,
        Term::List(items) => items.iter().any(has_free_universal),
        Term::Formula(graph) => graph.free_variables().iter().any(|term| matches!(term, Term::Var(_))),
        _ => false,
    }
}

fn free_universals(term: &Term, out: &mut BTreeSet<crate::ast::Name>) {
    match term {
        Term::Var(name) => { out.insert(name.clone()); }
        Term::List(items) => for item in items { free_universals(item, out); },
        Term::Formula(graph) => for free in graph.free_variables() {
            if let Term::Var(name) = free { out.insert(name); }
        },
        _ => {}
    }
}

/// Blank labels a term mentions, including those free in its graph terms.
fn blank_labels(term: &Term, out: &mut BTreeSet<crate::ast::Name>) {
    match term {
        Term::Blank(name) => { out.insert(name.clone()); }
        Term::List(items) => for item in items { blank_labels(item, out); },
        Term::Formula(graph) => for free in graph.free_variables() { blank_labels(&free, out); },
        _ => {}
    }
}

fn triple_blank_labels(triples: &[Triple]) -> BTreeSet<crate::ast::Name> {
    let mut out = BTreeSet::new();
    for triple in triples {
        for term in [&triple.s, &triple.p, &triple.o] {
            blank_labels(term, &mut out);
        }
    }
    out
}

pub(crate) fn match_triple(pattern: &Triple, target: &Triple, bindings: &mut Bindings) -> bool {
    match_term(&pattern.s, &target.s, bindings) && match_term(&pattern.p, &target.p, bindings) && match_term(&pattern.o, &target.o, bindings)
}

/// The triples a rule concludes when its conclusion is not written out but
/// resolved from a term at firing time. `None` when the rule states its
/// conclusion in the ordinary way.
fn unquoted_conclusion(conclusion: &[Triple], bindings: &Bindings) -> Option<crate::ast::Graph> {
    let [only] = conclusion else { return None };
    let unquote = Term::Iri(crate::ast::EYERON_UNQUOTE.to_string().into());
    if only.s != unquote || only.p != unquote {
        return None;
    }
    let resolved = match &only.o {
        Term::Var(name) => bindings.get(name)?,
        other => other,
    };
    match resolved {
        Term::Formula(triples) => Some(triples.clone()),
        _ => None,
    }
}

fn describe(triple: &Triple) -> String {
    crate::printing::triples_to_n3(&BTreeMap::new(), std::slice::from_ref(triple)).trim().to_string()
}

/// Lift a proof document's triples into steps, grouping by the
/// formula subject each step is about, and its search certificate into
/// listings, grouping by the predicate each lists.
fn read_steps(body: &[Triple]) -> Result<(Vec<Step>, Listings)> {
    #[derive(Default)]
    struct Binding<'a> {
        name: Option<&'a str>,
        value: Option<&'a Term>,
        used: bool,
    }
    // Keyed by whole step formulas, so these are hash maps: an ordered map
    // compares nested graphs at every level of its search. The vectors keep
    // the proof's own order for the steps and for error reporting.
    let mut bindings: HashMap<&Term, Binding<'_>> = HashMap::new();
    let mut binding_order = Vec::new();
    let mut order = Vec::new();
    let mut grouped: HashMap<&Term, Vec<&Triple>> = HashMap::new();
    let mut listings: Listings = Vec::new();
    let mut listed = HashSet::new();
    for triple in body {
        if !is_proof_vocabulary(&triple.p) { continue; }
        let Term::Iri(predicate) = &triple.p else { unreachable!() };
        match &predicate[PE.len()..] {
            "var" | "value" => {
                if !matches!(triple.s, Term::Blank(_) | Term::Iri(_)) {
                    return Err(metadata_error(&triple.s, "a binding must be identified by a blank node or IRI"));
                }
                let binding = bindings.entry(&triple.s).or_insert_with(|| {
                    binding_order.push(&triple.s);
                    Binding::default()
                });
                if triple.p == pe("var") {
                    let name = plain_string(&triple.o).filter(|name| !name.is_empty())
                        .ok_or_else(|| metadata_error(&triple.s, "pe:var requires a nonempty string"))?;
                    if binding.name.replace(name).is_some() {
                        return Err(metadata_error(&triple.s, "a binding must have exactly one pe:var"));
                    }
                } else if binding.value.replace(&triple.o).is_some() {
                    return Err(metadata_error(&triple.s, "a binding must have exactly one pe:value"));
                }
            }
            "derived" => {
                if !matches!(triple.s, Term::Iri(_)) {
                    return Err(metadata_error(&triple.s, "pe:derived requires the predicate it lists as its subject"));
                }
                // `{}` lists a predicate the run derived nothing with.
                let fact = match &triple.o {
                    Term::Formula(graph) if graph.is_empty() => None,
                    _ => Some(formula_triple(&triple.o).filter(|fact| fact.p == triple.s).ok_or_else(||
                        metadata_error(&triple.s, "pe:derived must wrap exactly one triple with the listed predicate, or none"))?),
                };
                if let Some(fact) = fact {
                    if !listed.insert(fact) {
                        return Err(metadata_error(&triple.s, &format!("pe:derived lists {} twice", describe(fact))));
                    }
                }
                match listings.iter_mut().find(|(predicate, _)| *predicate == triple.s) {
                    Some((_, facts)) => facts.extend(fact.cloned()),
                    None => listings.push((triple.s.clone(), fact.into_iter().cloned().collect())),
                }
            }
            "rule" | "fact" | "builtin" | "unproven" | "uses" | "binding" => {
                if formula_triple(&triple.s).is_none() {
                    return Err(metadata_error(&triple.s, "a step subject must be a graph containing exactly one triple"));
                }
                grouped.entry(&triple.s).or_insert_with(|| {
                    order.push(&triple.s);
                    Vec::new()
                }).push(triple);
            }
            _ => return Err(metadata_error(&triple.s, &format!("unknown proof predicate {}", predicate))),
        }
    }

    let mut steps = Vec::new();
    for subject in order {
        let conclusion = formula_triple(subject).expect("validated step subject");
        let mut step = Step {
            conclusion: conclusion.clone(), kind: Kind::Unproven, rule: None,
            carried: None, builtin: None, bindings: Vec::new(), uses: Vec::new(),
        };
        let mut justifications = 0;
        let mut names = BTreeSet::new();
        for triple in &grouped[subject] {
            let Term::Iri(predicate) = &triple.p else { unreachable!() };
            let kind = &predicate[PE.len()..];
            if matches!(kind, "rule" | "fact" | "builtin" | "unproven") {
                justifications += 1;
            }
            match kind {
                "rule" => {
                    step.kind = Kind::Rule;
                    step.rule = literal_number(&triple.o);
                    step.carried = carried_rule(&triple.o);
                    if step.rule.is_none() && step.carried.is_none() {
                        return Err(metadata_error(subject, "pe:rule requires a positive integer or a graph containing one implication"));
                    }
                }
                "fact" => {
                    step.kind = Kind::Fact;
                    if plain_string(&triple.o).is_none() {
                        return Err(metadata_error(subject, "pe:fact requires a string source label"));
                    }
                }
                "builtin" => {
                    step.kind = Kind::Builtin;
                    if !matches!(triple.o, Term::Iri(_)) {
                        return Err(metadata_error(subject, "pe:builtin requires a predicate IRI"));
                    }
                    step.builtin = Some(triple.o.clone());
                }
                "unproven" => {
                    step.kind = Kind::Unproven;
                    if plain_string(&triple.o).is_none() {
                        return Err(metadata_error(subject, "pe:unproven requires a string reason"));
                    }
                }
                "uses" => {
                    let used = formula_triple(&triple.o).ok_or_else(||
                        metadata_error(subject, "pe:uses must wrap exactly one premise triple"))?;
                    step.uses.push(used.clone());
                }
                "binding" => {
                    let binding = bindings.get_mut(&triple.o).ok_or_else(||
                        metadata_error(subject, "pe:binding must refer to a node with pe:var and pe:value"))?;
                    let (Some(name), Some(value)) = (binding.name, binding.value) else {
                        return Err(metadata_error(subject, "each binding requires exactly one pe:var and one pe:value"));
                    };
                    if !names.insert(name) {
                        return Err(metadata_error(subject, &format!("duplicate binding for variable {}", name)));
                    }
                    binding.used = true;
                    step.bindings.push((name.to_string(), value.clone()));
                }
                _ => unreachable!(),
            }
        }
        if justifications != 1 {
            return Err(metadata_error(subject, "a step must have exactly one justification (pe:rule, pe:fact, pe:builtin, or pe:unproven)"));
        }
        if step.kind != Kind::Rule && !step.bindings.is_empty() {
            return Err(metadata_error(subject, "pe:binding is only valid on a rule step"));
        }
        steps.push(step);
    }
    for node in binding_order {
        if !bindings[node].used {
            return Err(metadata_error(node, "binding metadata is not referenced by any step"));
        }
    }
    Ok((steps, listings))
}

fn metadata_error(subject: &Term, detail: &str) -> EyeronError {
    EyeronError::new(format!("invalid proof metadata for {}: {}",
        crate::printing::term_to_n3_object(subject, &BTreeMap::new()), detail))
}

fn plain_string(term: &Term) -> Option<&str> {
    match term {
        Term::Literal(literal) if literal.language.is_none()
            && literal.datatype.as_deref().is_none_or(|dt| dt == "http://www.w3.org/2001/XMLSchema#string") => Some(&literal.value),
        _ => None,
    }
}

/// A `pe:rule { {premises} => {conclusion} }` object: the generated rule
/// the step carries, plus the statement asserting it, which a checker holds
/// the step to.
fn carried_rule(term: &Term) -> Option<(crate::ast::Graph, crate::ast::Graph, Triple)> {
    let statement = formula_triple(term)?;
    // A forward rule reads `{premises} => {conclusion}`, a backward one
    // `{conclusion} <= {premises}`.
    let forward = statement.p == Term::Iri(crate::ast::LOG_IMPLIES.to_string().into());
    let backward = statement.p == Term::Iri(crate::ast::LOG_IMPLIED_BY.to_string().into());
    match (&statement.s, &statement.o) {
        (Term::Formula(left), Term::Formula(right)) if forward => Some((left.clone(), right.clone(), statement.clone())),
        (Term::Formula(left), Term::Formula(right)) if backward => Some((right.clone(), left.clone(), statement.clone())),
        _ => None,
    }
}

fn literal_number(term: &Term) -> Option<usize> {
    match term {
        Term::Literal(literal) if literal.language.is_none()
            && literal.datatype.as_deref() == Some("http://www.w3.org/2001/XMLSchema#integer") => {
            literal.value.parse::<usize>().ok().filter(|number| *number > 0)
        },
        _ => None,
    }
}

impl ProofDocument for N3Proof {
    fn step_count(&self) -> usize {
        self.steps.len()
    }

    fn kind(&self, index: usize) -> Kind {
        self.steps[index].kind
    }

    fn describe(&self, index: usize) -> String {
        describe(&self.steps[index].conclusion)
    }

    fn dependencies(&self, index: usize) -> Vec<Resolution> {
        let step = &self.steps[index];
        let mut dependencies: Vec<_> = step.uses.iter().map(|used| self.resolve_premise(used, index)).collect();
        if let Some((_, _, statement)) = &step.carried {
            dependencies.push(self.resolve_rule(statement));
        }
        dependencies
    }

    fn claims(&self) -> Vec<String> {
        self.claims.iter().map(describe).collect()
    }

    fn claim_resolution(&self, index: usize) -> Resolution {
        self.resolve(&self.claims[index])
    }

    fn claim_dependencies(&self, index: usize) -> Vec<Resolution> {
        if self.query_rules.is_empty() { return Vec::new(); }
        self.query_selection(&self.claims[index]).unwrap_or_default()
    }

    fn check_step(&self, index: usize) -> StepCheck {
        let step = &self.steps[index];
        if step.kind == Kind::Rule {
            if let Err(detail) = self.recorded_bindings(step) { return under("C3", Err(detail)); }
        }
        match step.kind {
            Kind::Rule if step.rule.is_none() && step.carried.is_none() => under("C3", Err("cites no rule".to_string())),
            // A built-in's statements are exactly those it holds for, so a
            // rule cannot derive one it rejects; the run trips a fuse instead.
            Kind::Rule if crate::reasoner::contradicts_builtin(&step.conclusion) => {
                under("C5", Err("concludes a built-in statement that re-evaluation rejects".to_string()))
            }
            // An introduction assumes that no fact already satisfied its
            // existentials, which depends on the whole current graph (§9.6).
            Kind::Rule => under("C1", self.rule_applications(step).map(|applications| {
                if self.lean_conclusion(step).is_some() && applications.iter().all(|application| !application.witnesses.is_empty()) {
                    Checked::Trusted("unsatisfied")
                } else {
                    Checked::Verified
                }
            })),
            Kind::Fact if !step.uses.is_empty() => under("C3", self.check_fact(step)),
            Kind::Fact => under("C1", self.check_fact(step)),
            Kind::Builtin if step.builtin.as_ref() != Some(&step.conclusion.p) => under("C3", self.check_builtin(step)),
            Kind::Builtin if !step.uses.is_empty() => under("C3", Err("a built-in step must not have premises".into())),
            Kind::Builtin => under("C5", self.check_builtin(step)),
            Kind::Unproven => under("C3", Err("is recorded as unproven: the engine could not justify it".to_string())),
            Kind::Absent | Kind::Collected => under("C3", Ok(Checked::Trusted(step.kind.label()))),
        }
    }

    fn boundary(&self) -> (usize, Vec<(String, String)>) {
        let tests: Vec<&Step> = self.steps.iter()
            .filter(|step| step.kind == Kind::Builtin && current_graph_test(&step.conclusion).is_some() && !reads_outside_proof(&step.conclusion))
            .collect();
        let introductions: Vec<(&Step, &crate::ast::Graph, Application)> = self.steps.iter()
            .filter(|step| step.kind == Kind::Rule)
            .filter_map(|step| self.introduction(step).map(|(conclusion, application)| (step, conclusion, application)))
            .collect();
        if tests.is_empty() && self.fuses.is_empty() && introductions.is_empty() {
            return (0, Vec::new());
        }
        let evidence = crate::reasoner::Evidence::new(
            self.facts.iter().cloned().chain(self.steps.iter().filter(|step| !self.answers_query(step)).map(|step| step.conclusion.clone())).collect());
        let mut contradictions = Vec::new();
        for step in &tests {
            match contradiction(&evidence, "the proof's own evidence", &step.conclusion) {
                Ok(Some(detail)) => contradictions.push((describe(&step.conclusion), detail)),
                Ok(None) => {},
                Err(detail) => contradictions.push((describe(&step.conclusion), format!("could not finish checking this current-graph test: {detail}"))),
            }
        }
        let examined_introductions = self.unsatisfied_existentials(&evidence, &introductions, &mut contradictions);
        // A fuse forbids its premise outright, so evidence satisfying one
        // records a situation the source rules out.
        for fuse in &self.fuses {
            let statement = Triple::new(Term::Formula(fuse.clone()), Term::iri(crate::ast::LOG_IMPLIES), Term::Literal(crate::ast::Literal {
                value: "false".into(),
                datatype: Some("http://www.w3.org/2001/XMLSchema#boolean".into()),
                language: None,
            }));
            let mut remaining = MAX_PROOF_MATCHES;
            match self.match_conditions(fuse, Bindings::new(), &mut remaining) {
                Ok(Some(_)) => contradictions.push((describe(&statement), "the proof's own evidence satisfies the premise of this inference fuse".to_string())),
                Ok(None) => {}
                Err(detail) => contradictions.push((describe(&statement), format!("could not finish checking this inference fuse: {}", detail))),
            }
        }
        (tests.len() + self.fuses.len() + examined_introductions, contradictions)
    }

    fn search_closure(&self) -> Closure {
        let mut closure = Closure::default();
        let tests: Vec<usize> = (0..self.steps.len()).filter(|&index| self.certifiable(&self.steps[index])).collect();
        if tests.is_empty() && self.listings.is_empty() { return closure; }
        // Each listed fact is a fact the proof supports, and no query answer.
        let mut supported: BTreeMap<&Term, Vec<usize>> = BTreeMap::new();
        let mut broken = BTreeSet::new();
        for (predicate, facts) in &self.listings {
            closure.examined += 1;
            let steps = supported.entry(predicate).or_default();
            for fact in facts {
                let failure = match self.resolve(fact) {
                    _ if has_free_universal(&fact.s) || has_free_universal(&fact.o) => Some("which is not a fact: it has a variable"),
                    Resolution::Step(target) if self.answers_query(&self.steps[target]) => Some("which is a query answer, not a derived fact"),
                    Resolution::Step(target) => { steps.push(target); None }
                    Resolution::Given => None,
                    Resolution::Unresolved(_) => Some("which no step concludes and the source does not give"),
                };
                if let Some(failure) = failure {
                    closure.failures.push((describe(fact), format!("the search certificate lists {}, {}", describe(fact), failure)));
                    broken.insert(predicate);
                }
            }
        }
        let listed: BTreeSet<&Term> = self.listings.iter().map(|(predicate, _)| predicate).collect();
        let evidence = crate::reasoner::Evidence::new(self.facts.iter().cloned()
            .chain(self.listings.iter().flat_map(|(_, facts)| facts.iter().cloned())).collect());
        let mut undecided = BTreeSet::new();
        for (predicate, facts) in &self.listings {
            if broken.contains(predicate) { continue; }
            let facts: BTreeSet<&Triple> = facts.iter().collect();
            match self.listing_closed(&evidence, predicate, &facts, &listed) {
                Ok(()) => {}
                Err(Some(detail)) => {
                    closure.failures.push((describe(&Triple::new(predicate.clone(), pe("derived"), Term::formula(Vec::new()))),
                        format!("the search certificate's listing of this predicate {}", detail)));
                    broken.insert(predicate);
                }
                Err(None) => { undecided.insert(predicate); }
            }
        }
        // Whether a test can rest on the certificate, and whether it holds
        // over it; decided once per step.
        let mut decided: BTreeMap<usize, Option<bool>> = BTreeMap::new();
        let mut decide = |index: usize, closure: &mut Closure| -> Option<bool> {
            if let Some(outcome) = decided.get(&index) { return *outcome; }
            let test = &self.steps[index].conclusion;
            let outcome = certificate_needs(&self.rules, &self.facts, test)
                .filter(|needs| needs.iter().all(|predicate| listed.contains(predicate)))
                .and_then(|needs| {
                    for predicate in &needs {
                        for &target in &supported[predicate] { closure.serves.push((index, target)); }
                    }
                    if needs.iter().any(|predicate| broken.contains(predicate) || undecided.contains(predicate)) { return None; }
                    self.decide(&evidence, test)
                });
            decided.insert(index, outcome);
            outcome
        };
        for &index in &tests {
            closure.examined += 1;
            match decide(index, &mut closure) {
                Some(true) => {}
                Some(false) => {
                    let detail = if self.steps[index].conclusion.p == Term::iri(LOG_NOT_INCLUDES) {
                        "assumes the current graph lacks this, but the search certificate includes it"
                    } else {
                        "does not hold over the search certificate"
                    };
                    closure.failures.push((describe(&self.steps[index].conclusion), detail.into()));
                    continue;
                }
                None => continue,
            }
            // The listed facts are the current graph only if each was
            // derived under tests that the same graph upholds.
            let Some(needs) = certificate_needs(&self.rules, &self.facts, &self.steps[index].conclusion) else { continue };
            let mut pending: Vec<usize> = needs.iter().flat_map(|predicate| supported[predicate].iter().copied()).collect();
            let mut seen: BTreeSet<usize> = pending.iter().copied().collect();
            let mut upheld = true;
            while let Some(step) = pending.pop() {
                if self.certifiable(&self.steps[step]) && decide(step, &mut closure) != Some(true) {
                    upheld = false;
                    break;
                }
                for dependency in ProofDocument::dependencies(self, step) {
                    if let Resolution::Step(next) = dependency {
                        if seen.insert(next) { pending.push(next); }
                    }
                }
            }
            if upheld { closure.settled.push(index); }
        }
        closure.serves.sort_unstable();
        closure.serves.dedup();
        closure
    }

    fn claim_relevance(&self, index: usize) -> std::result::Result<(), String> {
        // A program with queries asks for their answers, and its output is
        // those answers alone. That the claim was derived is C4's concern.
        if self.query_rules.is_empty() {
            return Ok(());
        }
        let claim = &self.claims[index];
        if self.query_patterns.iter().any(|pattern| match_triple(pattern, claim, &mut Bindings::new())) {
            Ok(())
        } else {
            Err("answers none of the source's log:query rules".to_string())
        }
    }

    fn witnesses(&self) -> (usize, Vec<(String, String)>) {
        let mut applications = Vec::new();
        for step in &self.steps {
            if step.kind == Kind::Rule {
                let conclusion = match &step.carried {
                    Some((_, conclusion, _)) => Some(conclusion),
                    None => step.rule.and_then(|number| self.rules.get(number.wrapping_sub(1))).map(|rule| &rule.conclusion),
                };
                // Ordinary ground rules have no witnesses to register.
                if conclusion.is_some_and(|graph| !graph.existentials.is_empty()
                    || graph.iter().any(|triple| triple.p == Term::iri(crate::ast::EYERON_UNQUOTE))) {
                    if let Ok(alternatives) = self.rule_applications(step) {
                        applications.push((&step.conclusion, alternatives));
                    }
                }
            }
            if step.kind == Kind::Fact && (!self.given.contains(&step.conclusion) || !step.conclusion.is_ground()) {
                if let Some(application) = self.source_instance(&step.conclusion) {
                    applications.push((&step.conclusion, vec![application]));
                }
            }
            for used in &step.uses {
                if matches!(self.resolve(used), Resolution::Given) && !self.given.contains(used) {
                    if let Some(application) = self.source_instance(used) { applications.push((used, vec![application])); }
                }
            }
        }
        for claim in &self.claims {
            if matches!(self.resolve(claim), Resolution::Given) && !self.given.contains(claim) {
                if let Some(application) = self.source_instance(claim) { applications.push((claim, vec![application])); }
            }
        }
        // An indistinguishable head triple can match several existential
        // labels. Choose their identities consistently across the whole
        // proof, rather than committing to the first matching head.
        applications.sort_by_key(|(_, alternatives)| alternatives.len());
        let examined = applications.iter().map(|(_, alternatives)| alternatives.iter().map(|application| application.witnesses.len()).max().unwrap_or(0)).sum();
        let mut registry = WitnessRegistry::default();
        let mut choices = vec![0usize; applications.len()];
        let mut undos = Vec::new();
        let mut cursor = 0usize;
        let mut remaining = MAX_PROOF_MATCHES;
        let mut failure = None;
        while cursor < applications.len() {
            let (statement, alternatives) = &applications[cursor];
            if choices[cursor] == alternatives.len() {
                choices[cursor] = 0;
                if cursor == 0 { return (examined, failure.into_iter().collect()); }
                cursor -= 1;
                registry.undo(undos.pop().expect("one undo per chosen application"));
                continue;
            }
            if remaining == 0 {
                return (examined, vec![(describe(statement), "existential witness verification exceeded its match budget".into())]);
            }
            remaining -= 1;
            let application = &alternatives[choices[cursor]];
            choices[cursor] += 1;
            match registry.register(application, &self.source_blanks) {
                Ok(undo) => { undos.push(undo); cursor += 1; }
                Err(detail) => { failure = Some((describe(statement), detail)); }
            }
        }
        (examined, Vec::new())
    }

    fn call_fidelity(&self) -> (usize, Vec<(String, String)>) {
        let mut failures = Vec::new();
        let mut examined = 0;
        for step in self.steps.iter().filter(|step| step.kind == Kind::Rule) {
            examined += 1;
            if let Err(detail) = self.called_tests(step) {
                failures.push((describe(&step.conclusion), detail));
            }
        }
        if self.query_rules.is_empty() { return (examined, failures); }
        examined += self.claims.len();
        for (index, step) in self.steps.iter().enumerate() {
            for dependency in self.dependencies(index) {
                examined += 1;
                if let Resolution::Step(target) = dependency {
                    if self.answers_query(&self.steps[target]) {
                        failures.push((describe(&step.conclusion), format!("uses the query answer {} as inference evidence; query answers are output only", describe(&self.steps[target].conclusion))));
                    }
                }
            }
        }
        for claim in &self.claims {
            if let Err(detail) = self.query_selection(claim) {
                failures.push((describe(claim), detail));
            }
        }
        (examined, failures)
    }
}

/// What in `evidence` contradicts the current-graph test `test` records,
/// if anything, naming `evidence` as `source` in the detail. Evidence that
/// is only what a proof records may fail to contradict a wrong test; a test
/// it does contradict cannot have held.
pub(crate) fn contradiction(evidence: &crate::reasoner::Evidence, source: &str, test: &Triple) -> std::result::Result<Option<String>, String> {
    let Term::Iri(name) = &test.p else { return Ok(None) };
    let scope = Term::blank("current_graph");
    match name.as_str() {
        LOG_NOT_INCLUDES => {
            let retest = Triple::new(scope, test.p.clone(), test.o.clone());
            Ok(evidence.try_evaluate(&retest)?.is_empty()
                .then(|| format!("assumes the current graph lacks this, but {source} includes it")))
        }
        LOG_INCLUDES => Ok(None),
        LOG_COLLECT_ALL_IN => {
            let Term::List(parts) = &test.s else { return Ok(None) };
            let [template, condition, collected] = parts.as_slice() else { return Ok(None) };
            let Some(collected) = list_items(collected) else { return Ok(None) };
            let result = Term::var("__collected");
            let retest = Triple::new(Term::List(vec![template.clone(), condition.clone(), result]), test.p.clone(), scope);
            let visible = evidence.try_evaluate(&retest)?.into_iter()
                .find_map(|bindings| bindings.get("__collected").cloned());
            let Some(Term::List(visible)) = visible else { return Ok(None) };
            Ok(visible.iter().find(|item| !collected.contains(item)).map(|missing| format!(
                "omits {}, which {source} supplies",
                crate::printing::term_to_n3_object(missing, &BTreeMap::new()))))
        }
        LOG_FOR_ALL_IN => {
            let Term::List(parts) = &test.s else { return Ok(None) };
            let [Term::Formula(condition), Term::Formula(conclusion)] = parts.as_slice() else { return Ok(None) };
            // Only a conclusion made of built-ins can be refuted: an
            // ordinary triple the proof does not record may still hold.
            for bindings in evidence.try_solutions(condition)? {
                let mapping: BTreeMap<Term, Term> = bindings.iter().map(|(name, value)| (Term::Var(name.clone()), value.clone())).collect();
                let instance = conclusion.substitute(&mapping);
                if crate::reasoner::Evidence::is_decidable(&instance) && evidence.try_solutions(&instance)?.is_empty() {
                    return Ok(Some(format!("has a counterexample in {source}: {}", describe(&instance.triples[0]))));
                }
            }
            Ok(None)
        }
        _ => Ok(None),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const SOURCE: &str = "@prefix : <http://example.org/> .\n@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n:Socrates a :Human .\n:Human rdfs:subClassOf :Mortal .\n{ ?S a ?A . ?A rdfs:subClassOf ?B . } => { ?S a ?B . } .\n";

    fn proof_of(source: &str) -> String {
        let document = crate::parser::parse_n3_with_source(source, None, Some("test.n3")).unwrap();
        let result = crate::reasoner::reason(&document, &crate::reasoner::ReasonerOptions { proof: true, ..Default::default() });
        crate::proof_writer::proof_to_n3(&document.prefixes, &result)
    }

    #[test]
    fn a_generated_proof_checks() {
        let report = check_proof(SOURCE, &proof_of(SOURCE), "test.n3").unwrap();
        assert!(report.valid(), "{:?}", report.failures);
        assert!(report.verified >= 3);
    }

    #[test]
    fn a_tampered_conclusion_is_rejected() {
        let proof = proof_of(SOURCE).replace(":Socrates a :Mortal", ":Plato a :Mortal");
        let report = check_proof(SOURCE, &proof, "test.n3").unwrap();
        assert!(!report.valid());
    }
}
