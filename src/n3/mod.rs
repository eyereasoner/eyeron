//! The N3 (Notation3) front end: lexer, parser, forward/backward reasoner,
//! and output (printing/proof). This is the original, primary front end;
//! `crate::srl` is the sibling SPARQL 1.2 RL front end, which reuses the
//! shared `crate::ast::{Term, Triple, Literal}` types plus several of this
//! module's matching/unification primitives (see `crate::srl`'s module
//! doc for which ones and why).

pub mod lexer;
pub mod parser;
pub mod printing;
pub mod proof;
pub mod rdf_compat;
pub mod reasoner;
