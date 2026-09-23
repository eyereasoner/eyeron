//! Result serialization (specification §12): an evaluated run is itself a
//! small Prolog program — the facts it claims, and with `--proof` the
//! `clause/3` records its derivations cite plus the `step/4` facts that
//! explain them. A result document can therefore be loaded and queried by
//! another run, which is what `examples/proof-audit.pl` does.
//!
//! The `step/4` shape is the one `n3::proof` and `srl::proof` also emit:
//! a conclusion, the single term saying why it holds, the bindings that
//! justification used, and the conclusions it used.

use std::collections::BTreeMap;

use super::ast::body_term;
use super::engine::{Premise, ProofEntry, RuleTag};
use super::term::{self, term_key, Term};
use super::{Answer, CheckResult, RunResult};

/// How wide one fact of a result document may be before it is broken
/// across lines.
const WIDTH: usize = 96;

fn node(name: &str, args: Vec<Term>) -> Term {
    term::struct_(name, args)
}

fn integer(value: usize) -> Term {
    Term::Int(num_bigint::BigInt::from(value))
}

/// A variable binding, written the way the standard's `variable_names`
/// read option writes one: `'Name' = Value`.
fn binding(name: &str, value: Term) -> Term {
    node("=", vec![term::atom(name), value])
}

fn bindings_term(bindings: &[(String, Term)]) -> Term {
    term::list(bindings.iter().map(|(name, value)| binding(name, value.clone())).collect())
}

/// Split a `name/arity` indicator back into the `//2` term the standard
/// writes a predicate indicator as.
fn indicator(signature: &str) -> Term {
    match signature.rsplit_once('/') {
        Some((name, arity)) => match arity.parse::<usize>() {
            Ok(arity) => node("/", vec![term::atom(name), integer(arity)]),
            Err(_) => term::atom(signature),
        },
        None => term::atom(signature),
    }
}

/// `--check`-only output: `checked(rules(N), queries(M))` plus one
/// `stratum(Name/Arity, Level)` fact per predicate.
pub fn format_check(result: &CheckResult) -> String {
    let mut facts = vec![node("checked", vec![node("rules", vec![integer(result.rules)]), node("queries", vec![integer(result.queries)])])];
    for (name, level) in &result.strata {
        facts.push(node("stratum", vec![indicator(name), integer(*level)]));
    }
    let lines: Vec<String> = facts.iter().map(|fact| format!("{}.", term::format_fact(fact, WIDTH))).collect();
    format!("{}\n", lines.join("\n"))
}

/// A clause template: its variables become `var('Name')` and
/// `anonymous(N)` terms so that their identity survives being split across
/// separate `clause/3` and `substitution/2` facts, where ordinary
/// variables would each be read back as a fresh one.
fn template_term(value: &Term, anonymous: &mut BTreeMap<u64, usize>) -> Term {
    match value {
        Term::Var(id, name) => {
            if name != "_" {
                node("var", vec![term::atom(name.clone())])
            } else {
                let next = anonymous.len() + 1;
                let n = *anonymous.entry(*id).or_insert(next);
                node("anonymous", vec![integer(n)])
            }
        }
        Term::Struct(name, args) => term::struct_(name.clone(), args.iter().map(|a| template_term(a, anonymous)).collect()),
        other => other.clone(),
    }
}

fn clause_term(entry: &ProofEntry) -> Term {
    let mut anonymous = BTreeMap::new();
    let head = entry.rule_head.as_ref().expect("clause_term is only called for real-rule proof entries");
    let body = entry.rule_body.as_ref().expect("clause_term is only called for real-rule proof entries");
    let rule_id = match entry.rule {
        RuleTag::Rule(id) => id,
        RuleTag::Query => unreachable!("clause_term is only called for real-rule proof entries"),
    };
    node("clause", vec![integer(rule_id), template_term(head, &mut anonymous), template_term(&body_term(body), &mut anonymous)])
}

/// One proof step: a conclusion, the single term saying why it holds, the
/// bindings that justification used, and the conclusions it used.
///
/// This is deliberately the same shape `n3::proof` and `srl::proof` emit —
/// there a step is a conclusion carrying one of `pe:rule`/`pe:fact`/
/// `pe:builtin`/`pe:unproven`, then `pe:binding` and `pe:uses`. Keying a
/// step by its conclusion, rather than by a proof id premises have to be
/// joined back to, is what lets all three be read the same way.
struct Step {
    conclusion: Term,
    by: Term,
    bindings: Vec<(String, Term)>,
    uses: Vec<Term>,
}

fn step_term(step: &Step) -> Term {
    node("step", vec![step.conclusion.clone(), step.by.clone(), bindings_term(&step.bindings), term::list(step.uses.clone())])
}

/// The conclusion a premise contributes, which is how a step names what it
/// used. A built-in premise is its own goal; `\+` and `findall/3` are named
/// by the goal term that ran, so every use is an ordinary term the reader
/// can find as some other step's conclusion.
fn premise_conclusion(premise: &Premise) -> Term {
    match premise {
        Premise::Answer { call_term, .. } | Premise::Builtin { call_term } => call_term.clone(),
        Premise::Absent { call_term } => node("\\+", vec![call_term.clone()]),
        Premise::Collected { value_term, template, goal, .. } => node("findall", vec![template.clone(), goal.clone(), value_term.clone()]),
    }
}

/// Walks the recorded derivations from the answers outward, collecting one
/// step per conclusion in first-encounter order. Two consequences matter:
/// a conclusion reached twice is explained once, and a derivation the
/// answers do not rest on is not printed at all.
struct Walk<'a> {
    proofs: &'a [ProofEntry],
    steps: Vec<Step>,
    clauses: BTreeMap<usize, Term>,
    seen: std::collections::BTreeSet<String>,
    /// For each conclusion, the earliest derivation of it anywhere in the
    /// run. See `canonical`.
    earliest: BTreeMap<String, usize>,
}

impl<'a> Walk<'a> {
    fn new(proofs: &'a [ProofEntry]) -> Self {
        // A conclusion can be an answer of more than one table — `leq(X, b)`
        // and `leq(a, Y)` are different calls that can both answer
        // `leq(a, b)` — and each table records its own first derivation. A
        // consumer cites whichever table it read, so following citations
        // blindly can produce a derivation of a conclusion that uses that
        // same conclusion, by way of the other table.
        //
        // Proof ids are allocated when an answer is recorded, and a
        // derivation can only use answers that already existed, so every
        // premise's id is smaller than the id of the entry citing it.
        // Taking the *smallest*-id derivation of each conclusion therefore
        // makes every edge point from a larger id to a smaller one, which
        // is acyclic by construction.
        let mut earliest: BTreeMap<String, usize> = BTreeMap::new();
        for entry in proofs {
            if matches!(entry.rule, RuleTag::Rule(_)) {
                earliest.entry(term_key(&entry.conclusion_term)).or_insert(entry.id);
            }
        }
        Self { proofs, steps: Vec::new(), clauses: BTreeMap::new(), seen: std::collections::BTreeSet::new(), earliest }
    }

    /// The derivation this walk uses for whatever `id` concludes.
    fn canonical(&self, id: usize) -> usize {
        self.entry(id)
            .map(|entry| self.earliest.get(&term_key(&entry.conclusion_term)).copied().unwrap_or(id))
            .unwrap_or(id)
    }

    /// Proof ids are 1-based and allocated in recording order, so they
    /// index the list directly.
    fn entry(&self, id: usize) -> Option<&'a ProofEntry> {
        self.proofs.get(id.wrapping_sub(1))
    }

    /// The goals a query-tagged proof proved, which is what a completed
    /// `findall/3` collected.
    fn goals(&self, id: usize) -> Vec<Term> {
        self.entry(id).map(|entry| entry.premises.iter().map(premise_conclusion).collect()).unwrap_or_default()
    }

    fn add(&mut self, conclusion: Term, by: Term, bindings: Vec<(String, Term)>, uses: Vec<Term>) -> bool {
        if !self.seen.insert(term_key(&conclusion)) {
            return false;
        }
        self.steps.push(Step { conclusion, by, bindings, uses });
        true
    }

    /// Walks depth first from `roots` (each an answer's own proof), with an
    /// explicit worklist rather than recursion: a long chain of
    /// derivations is exactly what this front end gets used for, and
    /// `deep-taxonomy-100000.pl` nests 100,000 of them.
    fn run(&mut self, roots: Vec<usize>) {
        let mut stack: Vec<Task> = roots.into_iter().rev().map(Task::Query).collect();
        while let Some(task) = stack.pop() {
            match task {
                Task::Query(id) => {
                    if let Some(entry) = self.entry(id) {
                        push_premises(&entry.premises, &mut stack);
                    }
                }
                Task::Premise(premise) => self.expand(&premise, &mut stack),
            }
        }
    }

    fn expand(&mut self, premise: &Premise, stack: &mut Vec<Task>) {
        match premise {
            Premise::Answer { proof, .. } => self.expand_derived(*proof, stack),
            Premise::Builtin { call_term } => {
                self.add(call_term.clone(), term::atom("builtin"), Vec::new(), Vec::new());
            }
            Premise::Absent { .. } => {
                self.add(premise_conclusion(premise), term::atom("absent"), Vec::new(), Vec::new());
            }
            Premise::Collected { proofs, .. } => {
                let uses: Vec<Term> = proofs.iter().flat_map(|id| self.goals(*id)).collect();
                if self.add(premise_conclusion(premise), term::atom("collected"), Vec::new(), uses) {
                    for id in proofs.iter().rev() {
                        stack.push(Task::Query(*id));
                    }
                }
            }
        }
    }

    fn expand_derived(&mut self, id: usize, stack: &mut Vec<Task>) {
        let Some(entry) = self.entry(self.canonical(id)) else { return };
        let RuleTag::Rule(clause_id) = entry.rule else { return };
        // A clause with no body was simply given, which is what `pe:fact`
        // says in the other two formats.
        let given = entry.rule_body.as_ref().is_some_and(|body| body.is_empty());
        let by = node(if given { "fact" } else { "rule" }, vec![integer(clause_id)]);
        let uses: Vec<Term> = entry.premises.iter().map(premise_conclusion).collect();
        if !self.add(entry.conclusion_term.clone(), by, entry.substitution.clone(), uses) {
            return;
        }
        self.clauses.entry(clause_id).or_insert_with(|| clause_term(entry));
        push_premises(&entry.premises, stack);
    }
}

/// One item of `Walk`'s worklist: a query-tagged proof whose premises are
/// still to be explored, or one premise of an already-explored step.
enum Task {
    Query(usize),
    Premise(Premise),
}

/// Pushes `premises` so the worklist pops them left to right, which keeps
/// the emitted order the one a reader follows: each step, then what it
/// used, in the order the body used it.
fn push_premises(premises: &[Premise], stack: &mut Vec<Task>) {
    for premise in premises.iter().rev() {
        stack.push(Task::Premise(premise.clone()));
    }
}



/// What a run claims: each goal of each query, instantiated by an answer.
///
/// A query proves its goals, so an answer *is* those goals with its
/// bindings applied — the same thing N3 prints as a derived triple and
/// SPARQL-RL as its inference graph. A goal whose variable no answer binds
/// keeps that variable, since that is what was proved. A claim reached by
/// more than one answer is stated once.
fn claims(result: &RunResult) -> Vec<Term> {
    let mut seen = std::collections::BTreeSet::new();
    let mut out = Vec::new();
    for query in &result.queries {
        for answer in &query.answers {
            let bindings: BTreeMap<&str, &Term> = answer.bindings.iter().map(|(name, value)| (name.as_str(), value)).collect();
            for goal in &query.body {
                let claim = instantiate(goal, &bindings);
                if seen.insert(term_key(&claim)) {
                    out.push(claim);
                }
            }
        }
    }
    out
}

fn instantiate(term: &Term, bindings: &BTreeMap<&str, &Term>) -> Term {
    match term {
        Term::Var(_, name) => bindings.get(name.as_str()).map(|value| (*value).clone()).unwrap_or_else(|| term.clone()),
        Term::Struct(name, args) => term::struct_(name.clone(), args.iter().map(|arg| instantiate(arg, bindings)).collect()),
        other => other.clone(),
    }
}

/// Serialize a completed run as a Prolog program: the facts it claims, and
/// with `proof` the `clause/3` records its derivations cite and one
/// `step/4` fact per justified conclusion.
///
/// That is the shape `n3::proof` and `srl::proof` write too — what was
/// concluded, then why — so one reading serves all three. A run that
/// answered nothing writes nothing.
pub fn format_result(result: &RunResult, proof: bool) -> String {
    let emit = |lines: &mut Vec<String>, t: &Term| lines.push(format!("{}.", term::format_fact(t, WIDTH)));
    let mut lines = Vec::new();
    for claim in claims(result) {
        emit(&mut lines, &claim);
    }

    if proof {
        let mut walk = Walk::new(&result.proofs);
        walk.run(result.queries.iter().flat_map(|query| query.answers.iter().map(|answer| answer.proof)).collect());
        for block in [walk.clauses.values().cloned().collect::<Vec<_>>(), walk.steps.iter().map(step_term).collect()] {
            if block.is_empty() {
                continue;
            }
            lines.push(String::new());
            for fact in &block {
                emit(&mut lines, fact);
            }
        }
    }

    if lines.is_empty() {
        return String::new();
    }
    format!("{}\n", lines.join("\n"))
}

fn json_string(value: &str) -> String {
    let mut out = String::from("\"");
    for ch in value.chars() {
        match ch {
            '"' => out.push_str("\\\""),
            '\\' => out.push_str("\\\\"),
            '\n' => out.push_str("\\n"),
            '\r' => out.push_str("\\r"),
            '\t' => out.push_str("\\t"),
            c if (c as u32) < 0x20 => out.push_str(&format!("\\u{:04x}", c as u32)),
            c => out.push(c),
        }
    }
    out.push('"');
    out
}

/// A JSON mirror of `Term`'s tagged shape (`{"kind":"compound",...}` etc.)
/// — used for `--json`. eyeron hand-builds JSON text here rather than
/// depending on `serde_json` (which is unavailable on the `wasm32`
/// target), matching the convention already established by
/// `crate::n3::printing::rdf12_json`.
fn term_json(value: &Term) -> String {
    match value {
        Term::Var(id, name) => format!("{{\"kind\":\"var\",\"name\":{},\"id\":{}}}", json_string(name), id),
        Term::Struct(name, args) => {
            format!("{{\"kind\":\"compound\",\"name\":{},\"args\":[{}]}}", json_string(name), args.iter().map(term_json).collect::<Vec<_>>().join(","))
        }
        Term::Str(s) => format!("{{\"kind\":\"string\",\"value\":{}}}", json_string(s)),
        Term::Int(v) => format!("{{\"kind\":\"integer\",\"value\":{}}}", json_string(&v.to_string())),
        Term::Float(f) => {
            if f.is_finite() {
                format!("{{\"kind\":\"float\",\"value\":{}}}", f)
            } else {
                "{\"kind\":\"float\",\"value\":null}".to_string()
            }
        }
    }
}

fn bindings_json(bindings: &[(String, Term)]) -> String {
    let entries: Vec<String> = bindings.iter().map(|(name, value)| format!("{}:{}", json_string(name), term_json(value))).collect();
    format!("{{{}}}", entries.join(","))
}

fn answer_json(answer: &Answer) -> String {
    format!("{{\"bindings\":{},\"proof\":{}}}", bindings_json(&answer.bindings), answer.proof)
}

fn query_result_json(query: &super::QueryResult) -> String {
    format!(
        "{{\"goal\":{},\"variables\":[{}],\"answers\":[{}]}}",
        term_json(&body_term(&query.body)),
        query.variables.iter().map(term_json).collect::<Vec<_>>().join(","),
        query.answers.iter().map(answer_json).collect::<Vec<_>>().join(",")
    )
}

/// A `--json` rendering of a completed run: query goals/variables/answers
/// plus evaluation stats. Unlike `format_result`, this does not reify the
/// proof list (a lower-value feature for a secondary output format); use
/// the text `format_result(..., proof: true)` output for proofs.
pub fn run_result_json(result: &RunResult) -> String {
    let queries: Vec<String> = result.queries.iter().map(query_result_json).collect();
    format!(
        "{{\"status\":\"complete\",\"queries\":[{}],\"stats\":{{\"steps\":{},\"tables\":{},\"answers\":{}}}}}\n",
        queries.join(","),
        result.stats.steps,
        result.stats.tables,
        result.stats.answers
    )
}

/// A `--json` rendering of a `--check` run.
pub fn check_result_json(result: &CheckResult) -> String {
    let strata: Vec<String> = result.strata.iter().map(|(name, level)| format!("{}:{}", json_string(name), level)).collect();
    format!("{{\"rules\":{},\"queries\":{},\"strata\":{{{}}}}}\n", result.rules, result.queries, strata.join(","))
}
