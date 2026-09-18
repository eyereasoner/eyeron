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
pub mod eval;
pub mod expr;
pub mod forward;
pub mod lexer;
pub mod parser;
pub mod stratify;

pub use ast::{BinaryOp, Clause, Expr, PathExpr, SparqlRlProgram, SparqlRlRule, UnaryOp};
pub use forward::reason;
pub use parser::parse_sparql_rl;
