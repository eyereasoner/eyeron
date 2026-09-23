//! Reader and step checker for Prolog proof documents (specification
//! §8.1).
//!
//! The document is read with the ordinary Prolog reader — a proof is a
//! Prolog program, so nothing special is needed — and its plain facts and
//! `step/4` facts are lifted into the abstract model as claims and steps.
//! Checking a `rule` or `fact` step re-performs exactly one resolution step
//! against the *source* clause, which is what ties the proof to the
//! program.

use std::collections::BTreeMap;

use crate::error::{EyeronError, Result};
use crate::prolog::analyze::signature;
use crate::prolog::ast::{body_term, Rule};
use crate::prolog::builtins;
use crate::prolog::term::{self, array, term_key, unify, variables_in, Bindings, Term, VarCounter};

use super::{check, Checked, Document, Kind, Report, Resolution};

/// What checking one step produced: a verdict, or why it failed. Distinct
/// from `crate::error::Result`, whose error type is for malformed input
/// rather than for an invalid proof.
type Verdict = std::result::Result<Checked, String>;

/// How much work one built-in re-evaluation may do before the checker
/// gives up on it. A checker must terminate on any input, including a
/// document that cites an expensive built-in.
const BUILTIN_STEP_LIMIT: u64 = 2_000_000;

struct Step {
    conclusion: Term,
    kind: Kind,
    /// The clause a `rule`/`fact` step cites.
    clause: Option<usize>,
    bindings: Vec<(String, Term)>,
    uses: Vec<Term>,
}

pub struct PrologProof {
    rules: Vec<Rule>,
    /// Heads of the source clauses that have no body, by predicate
    /// indicator, for resolving a use against a given statement.
    given: BTreeMap<String, Vec<Term>>,
    steps: Vec<Step>,
    claims: Vec<Term>,
    /// Exact-key lookup, then same-predicate candidates: a use is almost
    /// always literally a step's conclusion, and only tabling's most
    /// general answers need the matcher.
    exact: BTreeMap<String, usize>,
    by_predicate: BTreeMap<String, Vec<usize>>,
}

/// One-way matching: does `general` subsume `specific`? Only `general`'s
/// variables may bind, so a use cannot instantiate itself to meet a
/// conclusion halfway (specification §4 C1).
///
/// The two terms always come from different facts of the same parse, whose
/// variables carry distinct ids, so neither needs renaming apart first.
fn subsumes(general: &Term, specific: &Term, env: &mut Bindings) -> bool {
    let general = term::deref(general, env);
    match (&general, specific) {
        (Term::Var(id, _), _) => {
            env.insert(*id, specific.clone());
            true
        }
        (_, Term::Var(..)) => false,
        (Term::Struct(ln, la), Term::Struct(rn, ra)) => {
            ln == rn && la.len() == ra.len() && la.iter().zip(ra.iter()).all(|(l, r)| subsumes(l, r, env))
        }
        _ => general == *specific,
    }
}

/// Read `proof` as a proof document for the program in `source`, and check
/// it.
pub fn check_proof(source: &str, proof: &str) -> Result<Report> {
    let document = PrologProof::read(source, proof)?;
    Ok(check(&document))
}

fn list_items(term: &Term, what: &str) -> Result<Vec<Term>> {
    array(term).map_err(|_| EyeronError::new(format!("{} must be a proper list, found {}", what, term::format(term))))
}

impl PrologProof {
    pub fn read(source: &str, proof: &str) -> Result<Self> {
        let mut counter = VarCounter::new();
        let program = crate::prolog::parser::parse(source, &mut counter)?;
        let document = crate::prolog::parser::parse(proof, &mut counter)?;

        // A statement the source gives outright: a clause with no body.
        let mut given: BTreeMap<String, Vec<Term>> = BTreeMap::new();
        for rule in program.rules.iter().filter(|rule| rule.body.is_empty()) {
            given.entry(signature(&rule.head)).or_default().push(rule.head.clone());
        }

        // A proof document states what it concluded and then why: the
        // claims are its plain facts, and `clause/3` and `step/4` are the
        // proof vocabulary that explains them. This is the same division
        // the N3 and SPARQL-RL documents make.
        let mut steps = Vec::new();
        let mut claims = Vec::new();
        for fact in &document.rules {
            if !fact.body.is_empty() {
                continue;
            }
            let Term::Struct(name, args) = &fact.head else {
                claims.push(fact.head.clone());
                continue;
            };
            match (name.as_str(), args.len()) {
                ("step", 4) => steps.push(read_step(args)?),
                ("clause", 3) => {}
                _ => claims.push(fact.head.clone()),
            }
        }

        let mut exact = BTreeMap::new();
        let mut by_predicate: BTreeMap<String, Vec<usize>> = BTreeMap::new();
        for (index, step) in steps.iter().enumerate() {
            exact.entry(term_key(&step.conclusion)).or_insert(index);
            by_predicate.entry(signature(&step.conclusion)).or_default().push(index);
        }

        Ok(Self { rules: program.rules, given, steps, claims, exact, by_predicate })
    }

    /// Where `statement` resolves under (C1).
    fn resolve(&self, statement: &Term) -> Resolution {
        if let Some(index) = self.exact.get(&term_key(statement)) {
            return Resolution::Step(*index);
        }
        let indicator = signature(statement);
        for index in self.by_predicate.get(&indicator).map(Vec::as_slice).unwrap_or(&[]) {
            if subsumes(&self.steps[*index].conclusion, statement, &mut Bindings::new()) {
                return Resolution::Step(*index);
            }
        }
        for head in self.given.get(&indicator).map(Vec::as_slice).unwrap_or(&[]) {
            if subsumes(head, statement, &mut Bindings::new()) {
                return Resolution::Given;
            }
        }
        Resolution::Unresolved(term::format(statement))
    }

    /// The source clause a step cites, renamed apart so its variables
    /// cannot collide with terms recorded in the document.
    fn instantiated_clause(&self, step: &Step) -> std::result::Result<(Term, Vec<Term>, Bindings), String> {
        let number = step.clause.ok_or_else(|| "cites no clause".to_string())?;
        let rule = self.rules.get(number.wrapping_sub(1)).ok_or_else(|| format!("cites clause {}, which the source does not have", number))?;

        let mut counter = VarCounter::new();
        let mut renaming = BTreeMap::new();
        let head = term::fresh(&rule.head, &mut renaming, &mut counter);
        let body: Vec<Term> = rule.body.iter().map(|goal| term::fresh(goal, &mut renaming, &mut counter)).collect();

        // Bind the clause's own variables to the values the step recorded.
        let mut named: Vec<(u64, Term)> = Vec::new();
        variables_in(&head, &mut named);
        for goal in &body {
            variables_in(goal, &mut named);
        }
        let mut env = Bindings::new();
        for (name, value) in &step.bindings {
            let Some((_, variable)) = named.iter().find(|(_, v)| matches!(v, Term::Var(_, n) if n == name)) else {
                // A name the clause does not have binds nothing; the
                // unifications below still have to account for the step.
                continue;
            };
            if !unify(variable, value, &mut env) {
                return Err(format!("binding '{}' = {} contradicts an earlier binding", name, term::format(value)));
            }
        }
        Ok((head, body, env))
    }

    /// §5.1/§5.2: re-perform the one inference this step records.
    fn check_inference(&self, step: &Step) -> Verdict {
        let (head, body, mut env) = self.instantiated_clause(step)?;

        if step.kind == Kind::Fact {
            if !body.is_empty() {
                return Err(format!("is justified as a fact, but clause {} has a body", step.clause.unwrap_or(0)));
            }
            if !step.uses.is_empty() {
                return Err("is justified as a fact, but uses premises".to_string());
            }
        }
        if body.len() != step.uses.len() {
            return Err(format!("uses {} premise(s), but clause {} has {}", step.uses.len(), step.clause.unwrap_or(0), body.len()));
        }
        if !unify(&head, &step.conclusion, &mut env) {
            return Err(format!("does not follow from clause {}: its head is {}", step.clause.unwrap_or(0), term::format(&head)));
        }
        for (index, (goal, used)) in body.iter().zip(step.uses.iter()).enumerate() {
            if !unify(goal, used, &mut env) {
                return Err(format!("premise {} is {}, but clause {} requires {}", index + 1, term::format(used), step.clause.unwrap_or(0), term::format(goal)));
            }
        }
        Ok(Checked::Verified)
    }

    /// §5.3: re-evaluate the built-in on the conclusion's own arguments.
    fn check_builtin(&self, step: &Step) -> Verdict {
        let goal = &step.conclusion;
        let indicator = signature(goal);
        if indicator == "clause/2" {
            return self.check_clause_builtin(goal);
        }
        if builtins::is_engine_relation(&indicator) {
            // `\+`, `call` and `findall` need a nested evaluation, which a
            // checker does not perform (§2).
            return Ok(Checked::Trusted("engine built-in"));
        }
        if !builtins::is_builtin_relation(&indicator) {
            return Err(format!("is justified as a built-in, but {} is not one", indicator));
        }
        let mut steps = 0u64;
        let mut tick = || {
            steps += 1;
            if steps > BUILTIN_STEP_LIMIT {
                return Err(EyeronError::new("built-in re-evaluation exceeded the checker's step limit"));
            }
            Ok(())
        };
        match builtins::call_builtin(goal, &Bindings::new(), &mut tick) {
            Ok(solutions) if !solutions.is_empty() => Ok(Checked::Verified),
            Ok(_) => Err(format!("re-evaluating {} did not succeed", indicator)),
            Err(error) => Err(format!("re-evaluating {} raised {}", indicator, error.message)),
        }
    }

    /// `clause/2` reads the program, which the checker has, so it is
    /// checkable rather than trusted.
    fn check_clause_builtin(&self, goal: &Term) -> Verdict {
        let Term::Struct(_, args) = goal else { return Err("clause/2 goal is not callable".to_string()) };
        for rule in &self.rules {
            let mut counter = VarCounter::new();
            let mut renaming = BTreeMap::new();
            let head = term::fresh(&rule.head, &mut renaming, &mut counter);
            let body: Vec<Term> = rule.body.iter().map(|goal| term::fresh(goal, &mut renaming, &mut counter)).collect();
            let mut env = Bindings::new();
            if unify(&args[0], &head, &mut env) && unify(&args[1], &body_term(&body), &mut env) {
                return Ok(Checked::Verified);
            }
        }
        Err("no clause of the source matches this clause/2 answer".to_string())
    }
}

fn read_step(args: &[Term]) -> Result<Step> {
    let (kind, clause) = read_justification(&args[1])?;
    let bindings = list_items(&args[2], "a step's bindings")?
        .iter()
        .map(|pair| match pair {
            Term::Struct(name, sides) if name == "=" && sides.len() == 2 => match &sides[0] {
                Term::Struct(variable, empty) if empty.is_empty() => Ok((variable.clone(), sides[1].clone())),
                other => Err(EyeronError::new(format!("a binding name must be an atom, found {}", term::format(other)))),
            },
            other => Err(EyeronError::new(format!("a binding must be 'Name' = Value, found {}", term::format(other)))),
        })
        .collect::<Result<Vec<_>>>()?;
    Ok(Step { conclusion: args[0].clone(), kind, clause, bindings, uses: list_items(&args[3], "a step's uses")? })
}

fn read_justification(term: &Term) -> Result<(Kind, Option<usize>)> {
    let Term::Struct(name, args) = term else {
        return Err(EyeronError::new(format!("a justification must be callable, found {}", term::format(term))));
    };
    let number = || -> Result<usize> {
        match args.first() {
            Some(Term::Int(value)) => value.to_string().parse().map_err(|_| EyeronError::new("a clause number must fit in a machine integer")),
            _ => Err(EyeronError::new(format!("{} must name a clause number", name))),
        }
    };
    match (name.as_str(), args.len()) {
        ("rule", 1) => Ok((Kind::Rule, Some(number()?))),
        ("fact", 1) => Ok((Kind::Fact, Some(number()?))),
        ("builtin", 0) => Ok((Kind::Builtin, None)),
        ("absent", 0) => Ok((Kind::Absent, None)),
        ("collected", 0) => Ok((Kind::Collected, None)),
        ("unproven", _) => Ok((Kind::Unproven, None)),
        _ => Err(EyeronError::new(format!("unknown justification {}", term::format(term)))),
    }
}

impl Document for PrologProof {
    fn claims(&self) -> Vec<String> {
        self.claims.iter().map(term::format).collect()
    }

    fn step_count(&self) -> usize {
        self.steps.len()
    }

    fn dependencies(&self, index: usize) -> Vec<Resolution> {
        self.steps[index].uses.iter().map(|used| self.resolve(used)).collect()
    }

    fn claim_resolution(&self, index: usize) -> Resolution {
        self.resolve(&self.claims[index])
    }

    fn kind(&self, index: usize) -> Kind {
        self.steps[index].kind
    }

    fn describe(&self, index: usize) -> String {
        term::format(&self.steps[index].conclusion)
    }

    fn check_step(&self, index: usize) -> Verdict {
        let step = &self.steps[index];
        match step.kind {
            Kind::Rule | Kind::Fact => self.check_inference(step),
            Kind::Builtin => self.check_builtin(step),
            Kind::Absent => Ok(Checked::Trusted("absent")),
            Kind::Collected => Ok(Checked::Trusted("collected")),
            Kind::Unproven => Err("is recorded as unproven: the engine could not justify it".to_string()),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const SOURCE: &str = "parent(alice, bob).\nancestor(X, Y) :- parent(X, Y).\n?- ancestor(alice, Who).";

    fn report(proof: &str) -> Report {
        check_proof(SOURCE, proof).unwrap_or_else(|err| panic!("{err}"))
    }

    #[test]
    fn a_faithful_proof_checks() {
        let out = report(
            "ancestor(alice, bob).\n\
             step(ancestor(alice, bob), rule(2), ['X' = alice, 'Y' = bob], [parent(alice, bob)]).\n\
             step(parent(alice, bob), fact(1), [], []).",
        );
        assert!(out.valid(), "{:?}", out.failures);
        assert_eq!(out.verified, 2);
        assert!(out.obligations.is_empty());
    }

    #[test]
    fn a_conclusion_the_clause_does_not_yield_is_rejected() {
        let out = report(
            "ancestor(alice, carol).\n\
             step(ancestor(alice, carol), rule(2), ['X' = alice, 'Y' = bob], [parent(alice, bob)]).\n\
             step(parent(alice, bob), fact(1), [], []).",
        );
        assert!(!out.valid());
        assert_eq!(out.failures[0].condition, "C3");
    }

    #[test]
    fn a_premise_that_is_not_the_clauses_own_is_rejected() {
        let out = report(
            "ancestor(alice, bob).\n\
             step(ancestor(alice, bob), rule(2), ['X' = alice, 'Y' = bob], [parent(alice, zoe)]).\n\
             step(parent(alice, zoe), fact(1), [], []).",
        );
        assert!(!out.valid());
    }

    #[test]
    fn an_unresolved_premise_fails_c1() {
        // The inference itself is sound, so only (C1) can object: nothing
        // in the document or the source establishes `parent(alice, zoe)`.
        let out = report(
            "ancestor(alice, zoe).\n\
             step(ancestor(alice, zoe), rule(2), ['X' = alice, 'Y' = zoe], [parent(alice, zoe)]).",
        );
        assert!(out.failures.iter().any(|f| f.condition == "C1"), "{:?}", out.failures);
        assert!(out.failures.iter().all(|f| f.condition == "C1"), "{:?}", out.failures);
    }

    #[test]
    fn a_premise_the_source_gives_needs_no_step_of_its_own() {
        let out = report(
            "ancestor(alice, bob).\n\
             step(ancestor(alice, bob), rule(2), ['X' = alice, 'Y' = bob], [parent(alice, bob)]).",
        );
        assert!(out.valid(), "{:?}", out.failures);
    }

    #[test]
    fn a_step_that_uses_itself_fails_c2() {
        let out = report(
            "ancestor(alice, bob).\n\
             step(ancestor(alice, bob), rule(2), ['X' = alice, 'Y' = bob], [ancestor(alice, bob)]).",
        );
        assert!(out.failures.iter().any(|f| f.condition == "C2"), "{:?}", out.failures);
    }

    #[test]
    fn an_unclaimed_conclusion_fails_c4() {
        let out = report("ancestor(alice, zoe).");
        assert!(out.failures.iter().any(|f| f.condition == "C4"), "{:?}", out.failures);
    }

    #[test]
    fn a_missing_clause_is_rejected() {
        let out = report("ancestor(alice, bob).\nstep(ancestor(alice, bob), rule(99), [], []).");
        assert!(!out.valid());
    }
}
