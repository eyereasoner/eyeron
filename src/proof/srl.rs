//! Reader and step checker for SPARQL 1.2 RL proof documents
//! (specification §8.3).
//!
//! A proof is an `.srl` rule set whose `DATA` block holds the conclusions
//! and one `_:stepN` node per step. Checking a `pe:rule` step re-performs
//! that one rule application against the *source* rule's own positive body
//! patterns — the same patterns the forward reasoner matched.

use std::collections::{BTreeMap, BTreeSet};

use crate::ast::{Term, Triple};
use crate::error::Result;
use crate::n3::reasoner::Bindings;
use crate::srl::stratify::rule_positive_patterns;

use super::{check, Checked, Document as ProofDocument, Kind, Report, Resolution};

const PE: &str = "https://eyereasoner.github.io/pe#";
const RDF_REIFIES: &str = "http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies";

type Verdict = std::result::Result<Checked, String>;

fn pe(name: &str) -> Term {
    Term::Iri(format!("{}{}", PE, name))
}

/// The single triple an `<<( s p o )>>` triple term wraps. SPARQL-RL reuses
/// `Term::Formula` for it, as its own parser documents.
fn triple_term(term: &Term) -> Option<&Triple> {
    match term {
        Term::Formula(triples) if triples.len() == 1 => Some(&triples[0]),
        _ => None,
    }
}

struct Step {
    node: Term,
    conclusion: Triple,
    kind: Kind,
    rule: Option<usize>,
    builtin: Option<Term>,
    bindings: Vec<(String, Term)>,
    /// A use names either another step's node or a statement outright.
    uses: Vec<Term>,
}

pub struct SrlProof {
    rules: Vec<crate::srl::ast::SparqlRlRule>,
    given: BTreeSet<Triple>,
    steps: Vec<Step>,
    claims: Vec<Triple>,
    by_node: BTreeMap<Term, usize>,
    by_conclusion: BTreeMap<Triple, usize>,
}

/// Read `proof` as a proof document for the rule set in `source`, and check
/// it.
pub fn check_proof(source: &str, proof: &str) -> Result<Report> {
    check_proof_program(&crate::srl::parse_sparql_rl(source, None)?, proof)
}

/// As `check_proof`, but for a rule set already parsed — an `IMPORTS`
/// directive has to be resolved before the rules can be numbered.
pub fn check_proof_program(source: &crate::srl::SparqlRlProgram, proof: &str) -> Result<Report> {
    let document = SrlProof::read_program(source, proof)?;
    Ok(check(&document))
}

impl SrlProof {
    pub fn read_program(source: &crate::srl::SparqlRlProgram, proof: &str) -> Result<Self> {
        let mut program = source.clone();
        // The reasoner expands property paths before it proves anything, so
        // a checker must read the rules the same way or the patterns it
        // compares against are not the ones that matched.
        crate::srl::eval::expand_rule_paths(&mut program.rules);
        let given: BTreeSet<Triple> = program.data.iter().cloned().collect();
        let parsed = crate::srl::parse_sparql_rl(proof, None)?;

        // `[ pe:var "N"; pe:value V ]` parses into its own blank node.
        let mut variable: BTreeMap<&Term, String> = BTreeMap::new();
        let mut value: BTreeMap<&Term, Term> = BTreeMap::new();
        for triple in &parsed.data {
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
        for triple in &parsed.data {
            if triple.p == Term::Iri(RDF_REIFIES.to_string()) && !grouped.contains_key(&triple.s) {
                order.push(&triple.s);
            }
            grouped.entry(&triple.s).or_default().push(triple);
        }

        let mut steps = Vec::new();
        for node in order {
            let triples = &grouped[node];
            let Some(conclusion) = triples
                .iter()
                .find(|t| t.p == Term::Iri(RDF_REIFIES.to_string()))
                .and_then(|t| triple_term(&t.o))
            else {
                continue;
            };
            let mut step = Step {
                node: (*node).clone(),
                conclusion: conclusion.clone(),
                kind: Kind::Unproven,
                rule: None,
                builtin: None,
                bindings: Vec::new(),
                uses: Vec::new(),
            };
            for triple in triples {
                match &triple.p {
                    p if *p == pe("rule") => {
                        step.kind = Kind::Rule;
                        step.rule = literal_number(&triple.o);
                    }
                    p if *p == pe("fact") => step.kind = Kind::Fact,
                    p if *p == pe("builtin") => {
                        step.kind = Kind::Builtin;
                        step.builtin = Some(triple.o.clone());
                    }
                    p if *p == pe("unproven") => step.kind = Kind::Unproven,
                    p if *p == pe("uses") => step.uses.push(triple.o.clone()),
                    p if *p == pe("binding") => {
                        if let (Some(name), Some(bound)) = (variable.get(&triple.o), value.get(&triple.o)) {
                            step.bindings.push((name.clone(), bound.clone()));
                        }
                    }
                    _ => {}
                }
            }
            steps.push(step);
        }

        // A conclusion asserted in the proof's own `DATA` block, with no
        // step vocabulary of its own, is a claim.
        let step_nodes: BTreeSet<Term> = steps.iter().map(|step| step.node.clone()).collect();
        let described: BTreeSet<Term> = variable.keys().chain(value.keys()).map(|t| (*t).clone()).collect();
        let claims: Vec<Triple> = parsed
            .data
            .iter()
            .filter(|t| !step_nodes.contains(&t.s) && !described.contains(&t.s))
            .cloned()
            .collect();

        let mut by_node = BTreeMap::new();
        let mut by_conclusion = BTreeMap::new();
        for (position, step) in steps.iter().enumerate() {
            by_node.entry(step.node.clone()).or_insert(position);
            by_conclusion.entry(step.conclusion.clone()).or_insert(position);
        }
        Ok(Self { rules: program.rules, given, steps, claims, by_node, by_conclusion })
    }

    /// A use names either a step node or, for a statement given in `DATA`
    /// or the base graph, the statement itself (§8.3).
    fn resolve_use(&self, used: &Term) -> Resolution {
        if let Some(position) = self.by_node.get(used) {
            return Resolution::Step(*position);
        }
        if let Some(statement) = triple_term(used) {
            return self.resolve_statement(statement);
        }
        Resolution::Unresolved(format!("{:?}", used))
    }

    fn resolve_statement(&self, statement: &Triple) -> Resolution {
        if let Some(position) = self.by_conclusion.get(statement) {
            return Resolution::Step(*position);
        }
        if self.given.contains(statement) {
            return Resolution::Given;
        }
        Resolution::Unresolved(describe(statement))
    }

    /// §5.1: re-perform the one rule application this step records.
    fn check_rule(&self, step: &Step) -> Verdict {
        let number = step.rule.ok_or_else(|| "cites no rule".to_string())?;
        let rule = self.rules.get(number.wrapping_sub(1)).ok_or_else(|| format!("cites rule {}, which the source does not have", number))?;

        let mut bindings = Bindings::new();
        for (name, value) in &step.bindings {
            bindings.insert(name.clone(), value.clone());
        }

        let premises = rule_positive_patterns(rule);
        if premises.len() != step.uses.len() {
            return Err(format!("uses {} premise(s), but rule {} has {}", step.uses.len(), number, premises.len()));
        }
        for (position, (premise, used)) in premises.iter().zip(step.uses.iter()).enumerate() {
            let statement = match self.by_node.get(used) {
                Some(index) => self.steps[*index].conclusion.clone(),
                None => match triple_term(used) {
                    Some(statement) => statement.clone(),
                    None => return Err(format!("premise {} names neither a step nor a statement", position + 1)),
                },
            };
            if !super::n3::match_triple(premise, &statement, &mut bindings) {
                return Err(format!("premise {} is {}, but rule {} requires {}", position + 1, describe(&statement), number, describe(premise)));
            }
        }
        if !rule.head.iter().any(|candidate| super::n3::match_triple(candidate, &step.conclusion, &mut bindings.clone())) {
            return Err(format!("does not follow from rule {}: it concludes none of what this step claims", number));
        }
        Ok(Checked::Verified)
    }
}

fn describe(triple: &Triple) -> String {
    crate::n3::printing::triples_to_n3(&BTreeMap::new(), std::slice::from_ref(triple)).trim().to_string()
}

fn literal_number(term: &Term) -> Option<usize> {
    match term {
        Term::Literal(literal) => literal.value.parse().ok(),
        _ => None,
    }
}

impl ProofDocument for SrlProof {
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
        self.steps[index].uses.iter().map(|used| self.resolve_use(used)).collect()
    }

    fn claims(&self) -> Vec<String> {
        self.claims.iter().map(describe).collect()
    }

    fn claim_resolution(&self, index: usize) -> Resolution {
        self.resolve_statement(&self.claims[index])
    }

    fn check_step(&self, index: usize) -> Verdict {
        let step = &self.steps[index];
        match step.kind {
            Kind::Rule => self.check_rule(step),
            Kind::Fact => {
                if self.given.contains(&step.conclusion) {
                    Ok(Checked::Verified)
                } else {
                    Err("is justified as a fact, but the source does not give it".to_string())
                }
            }
            Kind::Builtin => {
                let _ = &step.builtin;
                Ok(Checked::Trusted("built-in"))
            }
            Kind::Unproven => Err("is recorded as unproven: the engine could not justify it".to_string()),
            Kind::Absent | Kind::Collected => Ok(Checked::Trusted(step.kind.label())),
        }
    }
}
