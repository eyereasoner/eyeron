//! Result serialization (specification §11): an evaluated run is itself a
//! small Prolog program of `query/3`, `result/3` and `answer/2` facts, and
//! `--proof` adds `clause/3`, `substitution/2` and `proof/4` facts for
//! every derivation step. A result document can therefore be loaded and
//! queried by another run — which is what `examples/proof-audit.pl` does.

use std::collections::BTreeMap;

use super::ast::body_term;
use super::engine::{Premise, ProofEntry, RuleTag};
use super::term::{self, Term};
use super::{Answer, CheckResult, RunResult};

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
    let lines: Vec<String> = facts.iter().map(|fact| format!("{}.", term::format(fact))).collect();
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

fn premise_term(premise: &Premise) -> Term {
    match premise {
        Premise::Answer { proof, call_term } => node("uses", vec![integer(*proof), call_term.clone()]),
        Premise::Builtin { call_term } => node("builtin", vec![call_term.clone()]),
        Premise::Absent { call_term } => node("absent", vec![call_term.clone(), term::atom("complete")]),
        Premise::Collected { value_term, template, goal, proofs } => node(
            "collected",
            vec![value_term.clone(), template.clone(), goal.clone(), term::list(proofs.iter().map(|p| integer(*p)).collect()), term::atom("complete")],
        ),
    }
}

fn query_binding_term(variables: &[Term]) -> Term {
    term::list(
        variables
            .iter()
            .map(|v| {
                let name = match v {
                    Term::Var(_, name) => name.clone(),
                    _ => unreachable!("a query projection is always a list of variables"),
                };
                binding(&name, v.clone())
            })
            .collect(),
    )
}

fn answer_bindings_term(answer: &Answer) -> Term {
    bindings_term(&answer.bindings)
}

/// Serialize a completed run as a Prolog program of `query`/`result`/
/// `answer` facts (and, with `proof`, `clause`/`substitution`/`proof`
/// facts).
pub fn format_result(result: &RunResult, proof: bool) -> String {
    let mut lines = vec!["% Prolog result format 3".to_string()];
    let emit = |lines: &mut Vec<String>, t: &Term| lines.push(format!("{}.", term::format(t)));

    for (index, query) in result.queries.iter().enumerate() {
        let id = integer(index + 1);
        emit(&mut lines, &node("query", vec![id.clone(), body_term(&query.body), query_binding_term(&query.variables)]));
        emit(&mut lines, &node("result", vec![id.clone(), term::atom("complete"), integer(query.answers.len())]));
        for answer in &query.answers {
            let values = answer_bindings_term(answer);
            emit(&mut lines, &node("answer", vec![id.clone(), values.clone()]));
            if proof {
                emit(&mut lines, &node("why", vec![id.clone(), values, integer(answer.proof)]));
            }
        }
    }

    if proof {
        let mut clauses: BTreeMap<usize, Term> = BTreeMap::new();
        for entry in &result.proofs {
            if let RuleTag::Rule(rule_id) = entry.rule {
                clauses.entry(rule_id).or_insert_with(|| clause_term(entry));
            }
        }
        for clause_fact in clauses.values() {
            emit(&mut lines, clause_fact);
        }
        for entry in &result.proofs {
            let (conclusion, source) = match entry.rule {
                RuleTag::Query => {
                    let args = match &entry.conclusion_term {
                        Term::Struct(_, args) => args.clone(),
                        _ => unreachable!("a query proof's conclusion is always a '$query'(...) term"),
                    };
                    (node("solution", vec![term::list(args)]), term::atom("query"))
                }
                RuleTag::Rule(id) => (entry.conclusion_term.clone(), node("rule", vec![integer(id)])),
            };
            emit(&mut lines, &node("substitution", vec![integer(entry.id), bindings_term(&entry.substitution)]));
            emit(
                &mut lines,
                &node("proof", vec![integer(entry.id), conclusion, source, term::list(entry.premises.iter().map(premise_term).collect())]),
            );
        }
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
