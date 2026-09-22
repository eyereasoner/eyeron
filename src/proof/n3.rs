//! Reader and step checker for Notation3 proof documents (specification
//! §8.2).
//!
//! A proof is an N3 document, so it is read with the ordinary N3 parser and
//! its `pe:why` graphs are lifted into the abstract model. Checking a
//! `pe:rule` step re-performs exactly one rule application against the
//! *source* rule: instantiate its premises and conclusion under the step's
//! bindings, and require them to be what the step recorded.

use std::collections::{BTreeMap, BTreeSet};

use crate::ast::{Term, Triple};
use crate::error::Result;
use crate::n3::reasoner::Bindings;

use super::{check, Checked, Document as ProofDocument, Kind, Report, Resolution};

const PE: &str = "https://eyereasoner.github.io/pe#";

/// Built-ins whose value is not a function of the triple they appear in, so
/// re-evaluating them cannot confirm anything (specification §5.3, §6.3).
/// Each reads something outside the proof: the clock, the process, or the
/// network.
const IMPURE_BUILTINS: &[&str] = &[
    // Read the clock.
    "http://www.w3.org/2000/10/swap/time#localTime",
    "http://www.w3.org/2000/10/swap/time#currentTime",
    "http://www.w3.org/2000/10/swap/time#gmTime",
    // Read the network or the filesystem.
    "http://www.w3.org/2000/10/swap/log#content",
    "http://www.w3.org/2000/10/swap/log#semantics",
    "http://www.w3.org/2000/10/swap/log#semanticsOrError",
    // Read a random source.
    "http://www.w3.org/2000/10/swap/math#random",
    // Read the rest of the fact set, which is the reasoner's state rather
    // than anything the step itself carries: whether these hold depends on
    // what else had been derived at the time, so a checker looking only at
    // this triple cannot re-establish them.
    "http://www.w3.org/2000/10/swap/log#collectAllIn",
    "http://www.w3.org/2000/10/swap/log#forAllIn",
    "http://www.w3.org/2000/10/swap/log#includes",
    "http://www.w3.org/2000/10/swap/log#notIncludes",
    "http://www.w3.org/2000/10/swap/log#conclusion",
    "http://www.w3.org/2000/10/swap/log#conjunction",
    // Applies a predicate to each element, which means looking the
    // predicate up in the fact set.
    "http://www.w3.org/2000/10/swap/list#map",
];

type Verdict = std::result::Result<Checked, String>;

fn pe(name: &str) -> Term {
    Term::Iri(format!("{}{}", PE, name))
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
    /// because no document contains it (§5.1).
    carried: Option<(Vec<Triple>, Vec<Triple>, Triple)>,
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
    steps: Vec<Step>,
    claims: Vec<Triple>,
    index: BTreeMap<Triple, usize>,
}

/// Read `proof` as a proof document for the program in `source`, and check
/// it.
pub fn check_proof(source: &str, proof: &str, label: &str) -> Result<Report> {
    let document = crate::n3::parser::parse_n3_with_source(source, None, Some(label))?;
    check_proof_document(&document, proof)
}

/// As `check_proof`, but for a source already parsed — an example assembled
/// from several documents has to be merged before it is numbered.
pub fn check_proof_document(source: &crate::ast::Document, proof: &str) -> Result<Report> {
    let document = N3Proof::read_document(source, proof)?;
    Ok(check(&document))
}

impl N3Proof {
    pub fn read_document(document: &crate::ast::Document, proof: &str) -> Result<Self> {
        // `reason` numbers the rules it was given, having dropped the query
        // rules; a checker must number them the same way (§5.1).
        let rules: Vec<crate::ast::Rule> = document.rules.iter().filter(|rule| !rule.is_query).cloned().collect();
        // N3 treats a rule as data, so a rule written in the document is
        // itself a statement the document gives.
        let mut given: BTreeSet<Triple> = document.facts.iter().cloned().collect();
        let rule_statements: Vec<Triple> = rules.iter().map(crate::n3::proof::rule_statement).collect();
        given.extend(rule_statements.iter().cloned());
        let general: Vec<Triple> = document.facts.iter().filter(|fact| !fact.is_ground()).cloned().collect();

        let parsed = crate::n3::parser::parse_n3(proof, None)?;
        let mut steps = Vec::new();
        let mut claims = Vec::new();
        for triple in &parsed.facts {
            if triple.p != pe("why") {
                continue;
            }
            if let Some(claim) = formula_triple(&triple.s) {
                claims.push(claim.clone());
            }
            let Term::Formula(body) = &triple.o else { continue };
            steps.extend(read_steps(body));
        }

        let mut index = BTreeMap::new();
        for (position, step) in steps.iter().enumerate() {
            index.entry(step.conclusion.clone()).or_insert(position);
        }
        Ok(Self { rules, given, rule_statements, general, steps, claims, index })
    }

    fn resolve(&self, statement: &Triple) -> Resolution {
        // N3 derives ground triples, so resolution is equality; the
        // instance case (C1) cannot arise without variables to instantiate.
        if let Some(position) = self.index.get(statement) {
            return Resolution::Step(*position);
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
    fn derives_rule(&self, statement: &Triple) -> bool {
        let candidates = self
            .steps
            .iter()
            .map(|step| &step.conclusion)
            .chain(self.given.iter())
            .filter(|candidate| candidate.p == statement.p);
        for candidate in candidates {
            if match_triple(candidate, statement, &mut Bindings::new()) {
                return true;
            }
        }
        false
    }

    /// §5.1: re-perform the one rule application this step records.
    fn check_rule(&self, step: &Step) -> Verdict {
        // A generated rule is carried by the step; a written one is taken
        // from the source, never from the document.
        let (premise, conclusion, names, number) = match &step.carried {
            Some((premise, conclusion, statement)) => {
                // The carried rule has to be justified too, or a step could
                // invent any rule it liked.
                if !self.derives_rule(statement) {
                    return Err("carries a generated rule that nothing in the proof derives".to_string());
                }
                (premise.clone(), conclusion.clone(), BTreeMap::new(), "the generated rule it carries".to_string())
            }
            None => {
                let number = step.rule.ok_or_else(|| "cites no rule".to_string())?;
                let rule = self.rules.get(number.wrapping_sub(1)).ok_or_else(|| format!("cites rule {}, which the source does not have", number))?;
                (rule.premise.clone(), rule.conclusion.clone(), rule.proof_var_source_names.clone(), format!("rule {}", number))
            }
        };

        // The proof records a variable by its source name; the rule knows
        // it by its internal one.
        let mut source_names: BTreeMap<&str, &str> = BTreeMap::new();
        for (internal, source) in &names {
            source_names.insert(source.as_str(), internal.as_str());
        }
        let mut bindings = Bindings::new();
        for (name, value) in &step.bindings {
            let internal = source_names.get(name.as_str()).copied().unwrap_or(name.as_str());
            bindings.insert(internal.to_string(), value.clone());
        }

        // `{ :a :b ?C. } => ?C.` takes its conclusion from a term resolved
        // when the rule fires, which the rule alone does not state. The step
        // records the binding, so the conclusion is recoverable from there.
        let unquoted = unquoted_conclusion(&conclusion, &bindings);
        let conclusion = unquoted.unwrap_or(conclusion);

        let rule = RuleView { premise: &premise, conclusion: &conclusion };
        if rule.premise.len() != step.uses.len() {
            return Err(format!("uses {} premise(s), but {} has {}", step.uses.len(), number, rule.premise.len()));
        }
        // One environment across every premise and the conclusion, so a
        // variable the bindings did not mention is still forced to take one
        // consistent value (§5.1). Only the rule's own variables bind: the
        // step may not instantiate itself to meet the rule halfway.
        for (position, (premise, used)) in rule.premise.iter().zip(step.uses.iter()).enumerate() {
            if !match_triple(premise, used, &mut bindings) {
                return Err(format!("premise {} is {}, but {} requires {}", position + 1, describe(used), number, describe(premise)));
            }
        }
        if !rule.conclusion.iter().any(|candidate| match_triple(candidate, &step.conclusion, &mut bindings.clone())) {
            return Err(format!("does not follow from {}: it concludes none of what this step claims", number));
        }
        Ok(Checked::Verified)
    }

    /// A written rule, matched up to renaming: the engine standardizes a
    /// rule's variables apart before using it.
    fn gives_rule(&self, statement: &Triple) -> bool {
        self.rule_statements
            .iter()
            .chain(self.general.iter())
            .any(|candidate| candidate.p == statement.p && match_triple(candidate, statement, &mut Bindings::new()))
    }

    fn check_fact(&self, step: &Step) -> Verdict {
        if self.given.contains(&step.conclusion) || self.gives_rule(&step.conclusion) {
            Ok(Checked::Verified)
        } else {
            Err("is justified as a fact, but the source does not give it".to_string())
        }
    }

    /// §5.3: re-evaluate the built-in on the step's own triple.
    fn check_builtin(&self, step: &Step) -> Verdict {
        let Some(Term::Iri(name)) = step.builtin.clone() else {
            return Err("names no built-in".to_string());
        };
        if IMPURE_BUILTINS.contains(&name.as_str()) {
            return Ok(Checked::Trusted("impure built-in"));
        }
        if crate::n3::reasoner::verify_builtin_triple(&step.conclusion) {
            Ok(Checked::Verified)
        } else {
            Err(format!("re-evaluating {} did not hold", name))
        }
    }
}

/// One-way matching of a rule's pattern against a recorded statement.
/// Only the pattern's variables bind. A blank node in a rule head is an
/// existential, which the engine skolemizes, so it binds too — under a
/// name that cannot collide with a variable's.
pub(crate) fn match_term(pattern: &Term, target: &Term, bindings: &mut Bindings) -> bool {
    let key = match pattern {
        Term::Var(name) => Some(name.clone()),
        Term::Blank(label) => Some(format!("_:{}", label)),
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
            left.len() == right.len() && left.iter().zip(right.iter()).all(|(l, r)| match_triple(l, r, bindings))
        }
        _ => pattern == target,
    }
}

pub(crate) fn match_triple(pattern: &Triple, target: &Triple, bindings: &mut Bindings) -> bool {
    match_term(&pattern.s, &target.s, bindings) && match_term(&pattern.p, &target.p, bindings) && match_term(&pattern.o, &target.o, bindings)
}

/// The triples a rule concludes when its conclusion is not written out but
/// resolved from a term at firing time. `None` when the rule states its
/// conclusion in the ordinary way.
fn unquoted_conclusion(conclusion: &[Triple], bindings: &Bindings) -> Option<Vec<Triple>> {
    let [only] = conclusion else { return None };
    let unquote = Term::Iri(crate::ast::EYERON_UNQUOTE.to_string());
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

/// A rule's two halves, however the step got hold of them.
struct RuleView<'a> {
    premise: &'a [Triple],
    conclusion: &'a [Triple],
}

fn describe(triple: &Triple) -> String {
    crate::n3::printing::triples_to_n3(&BTreeMap::new(), std::slice::from_ref(triple)).trim().to_string()
}

/// Lift the triples of one `pe:why` graph into steps, grouping by the
/// formula subject each step is about.
fn read_steps(body: &[Triple]) -> Vec<Step> {
    // `[ pe:var "A"; pe:value :Human ]` parses into its own blank node plus
    // two triples in this same graph.
    let mut variable: BTreeMap<&Term, String> = BTreeMap::new();
    let mut value: BTreeMap<&Term, Term> = BTreeMap::new();
    for triple in body {
        if triple.p == pe("var") {
            if let Term::Literal(literal) = &triple.o {
                variable.insert(&triple.s, literal.value.clone());
            }
        } else if triple.p == pe("value") {
            value.insert(&triple.s, triple.o.clone());
        }
    }

    let mut order: Vec<&Term> = Vec::new();
    let mut grouped: BTreeMap<&Term, Vec<&Triple>> = BTreeMap::new();
    for triple in body {
        let Term::Formula(_) = &triple.s else { continue };
        if !grouped.contains_key(&triple.s) {
            order.push(&triple.s);
        }
        grouped.entry(&triple.s).or_default().push(triple);
    }

    let mut steps = Vec::new();
    for subject in order {
        let Some(conclusion) = formula_triple(subject) else { continue };
        let mut step = Step {
            conclusion: conclusion.clone(),
            kind: Kind::Unproven,
            rule: None,
            carried: None,
            builtin: None,
            bindings: Vec::new(),
            uses: Vec::new(),
        };
        let mut classified = false;
        for triple in &grouped[subject] {
            match &triple.p {
                p if *p == pe("rule") => {
                    step.kind = Kind::Rule;
                    step.rule = literal_number(&triple.o);
                    step.carried = carried_rule(&triple.o);
                    classified = true;
                }
                p if *p == pe("fact") => {
                    step.kind = Kind::Fact;
                    classified = true;
                }
                p if *p == pe("builtin") => {
                    step.kind = Kind::Builtin;
                    step.builtin = Some(triple.o.clone());
                    classified = true;
                }
                p if *p == pe("unproven") => {
                    step.kind = Kind::Unproven;
                    classified = true;
                }
                p if *p == pe("uses") => {
                    if let Some(used) = formula_triple(&triple.o) {
                        step.uses.push(used.clone());
                    }
                }
                p if *p == pe("binding") => {
                    if let (Some(name), Some(bound)) = (variable.get(&triple.o), value.get(&triple.o)) {
                        step.bindings.push((name.clone(), bound.clone()));
                    }
                }
                _ => {}
            }
        }
        if classified {
            steps.push(step);
        }
    }
    steps
}

/// A `pe:rule { {premises} => {conclusion} }` object: the generated rule
/// the step carries, plus the statement asserting it, which a checker holds
/// the step to.
fn carried_rule(term: &Term) -> Option<(Vec<Triple>, Vec<Triple>, Triple)> {
    let statement = formula_triple(term)?;
    // A forward rule reads `{premises} => {conclusion}`, a backward one
    // `{conclusion} <= {premises}`.
    let forward = statement.p == Term::Iri(crate::ast::LOG_IMPLIES.to_string());
    let backward = statement.p == Term::Iri(crate::ast::LOG_IMPLIED_BY.to_string());
    match (&statement.s, &statement.o) {
        (Term::Formula(left), Term::Formula(right)) if forward => Some((left.clone(), right.clone(), statement.clone())),
        (Term::Formula(left), Term::Formula(right)) if backward => Some((right.clone(), left.clone(), statement.clone())),
        _ => None,
    }
}

fn literal_number(term: &Term) -> Option<usize> {
    match term {
        Term::Literal(literal) => literal.value.parse().ok(),
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
        self.steps[index].uses.iter().map(|used| self.resolve(used)).collect()
    }

    fn claims(&self) -> Vec<String> {
        self.claims.iter().map(describe).collect()
    }

    fn claim_resolution(&self, index: usize) -> Resolution {
        self.resolve(&self.claims[index])
    }

    fn check_step(&self, index: usize) -> Verdict {
        let step = &self.steps[index];
        match step.kind {
            Kind::Rule => self.check_rule(step),
            Kind::Fact => self.check_fact(step),
            Kind::Builtin => self.check_builtin(step),
            Kind::Unproven => Err("is recorded as unproven: the engine could not justify it".to_string()),
            Kind::Absent | Kind::Collected => Ok(Checked::Trusted(step.kind.label())),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const SOURCE: &str = "@prefix : <http://example.org/> .\n@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n:Socrates a :Human .\n:Human rdfs:subClassOf :Mortal .\n{ ?S a ?A . ?A rdfs:subClassOf ?B . } => { ?S a ?B . } .\n";

    fn proof_of(source: &str) -> String {
        let document = crate::n3::parser::parse_n3_with_source(source, None, Some("test.n3")).unwrap();
        let result = crate::n3::reasoner::reason(&document, &crate::n3::reasoner::ReasonerOptions { proof: true, ..Default::default() });
        crate::n3::proof::proof_to_n3(&document.prefixes, &result)
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
