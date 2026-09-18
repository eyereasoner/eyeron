//! SPARQL 1.2 RL ("SRL") front end.
//!
//! SRL is a W3C Working-Draft Datalog-style rule language
//! (`RULE { head } WHERE [DATA] { body }`) that borrows SPARQL's lexical
//! vocabulary (`PREFIX`, `FILTER`, property paths, RDF-star triple terms)
//! but is not the SPARQL `SELECT`/`CONSTRUCT` query language. This module
//! parses and evaluates `.srl` rule sets, reusing eyeron's existing
//! `Term`/`Triple`/`Bindings`/`FactIndex`/unification machinery wherever
//! possible while giving rule bodies their own strictly-ordered evaluator
//! (see `eval`) rather than routing through the N3 engine's
//! selectivity-reordering premise matcher.
//!
//! See `SOURCE_CODE_GUIDE.md` for how this module relates to the N3 path.

pub mod ast;
pub mod backward;
pub mod eval;
pub mod expr;
pub mod forward;
pub mod lexer;
pub mod parser;
pub mod stratify;

pub use ast::{BinaryOp, Clause, Expr, PathExpr, SparqlRlProgram, SparqlRlRule, UnaryOp};
pub use backward::{solve_query, BackwardOptions};
pub use eval::query_facts;
pub use forward::reason;
pub use parser::{parse_query_body, parse_sparql_rl};

/// Content-sniff whether `input` looks like a SPARQL 1.2 RL rule set,
/// mirroring `crate::parser::is_rdf_message_log`'s approach: skip leading
/// comments/blank lines and the header directives (`PREFIX`/`BASE`/
/// `VERSION`/`IMPORTS`), then check whether the first substantive line
/// opens with `RULE` or `DATA` — SRL's only two top-level block keywords.
pub fn is_sparql_rl(input: &str) -> bool {
    for line in input.lines() {
        let trimmed = line.trim();
        if trimmed.is_empty() || trimmed.starts_with('#') {
            continue;
        }
        let first_word = trimmed.split(|c: char| c.is_whitespace() || c == '{').next().unwrap_or("").to_ascii_uppercase();
        return match first_word.as_str() {
            "PREFIX" | "BASE" | "VERSION" | "IMPORTS" => continue,
            "RULE" | "DATA" => true,
            _ => false,
        };
    }
    false
}

/// Merge `other` into `target`, matching `crate::ast::Document::merge`'s
/// semantics (later prefixes win, the first `base_iri`/`version` wins, data
/// and rules concatenate) — used to combine multiple `.srl` sources given
/// on one CLI invocation.
pub fn merge_programs(target: &mut SparqlRlProgram, other: SparqlRlProgram) {
    for (k, v) in other.prefixes {
        target.prefixes.insert(k, v);
    }
    if target.base_iri.is_none() {
        target.base_iri = other.base_iri;
    }
    if target.version.is_none() {
        target.version = other.version;
    }
    target.imports.extend(other.imports);
    target.data.extend(other.data);
    target.rules.extend(other.rules);
}
