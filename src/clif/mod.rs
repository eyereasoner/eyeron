//! Common Logic Interchange Format (CLIF) Horn/core front-end.
//!
//! This module deliberately implements the executable Horn fragment that can
//! be lowered faithfully to Eyeron's existing rule engine. Unsupported full
//! first-order constructs are rejected instead of being silently weakened.

use crate::ast::{Document, Literal, Rule, Term, Triple, LOG_EQUAL_TO};
use crate::error::{EyeronError, Result};
use crate::reasoner::{reason, ReasonerOptions};

mod compiler;
mod render;
mod syntax;

use compiler::Compiler;
use syntax::{lex, parse_expressions};

pub(crate) const SYMBOL_PREFIX: &str = "urn:cliron:symbol:";
pub(crate) const ARG_MARKER: &str = "urn:cliron:args";
pub(crate) const TRUE_MARKER: &str = "urn:cliron:true";
pub(crate) const FUNCTION_MARKER: &str = "urn:cliron:function";
pub(crate) const XSD_INTEGER: &str = "http://www.w3.org/2001/XMLSchema#integer";
pub(crate) const XSD_DECIMAL: &str = "http://www.w3.org/2001/XMLSchema#decimal";
pub(crate) const XSD_DOUBLE: &str = "http://www.w3.org/2001/XMLSchema#double";

pub fn parse_clif(input: &str) -> Result<Document> {
    parse_clif_with_source(input, None)
}

pub fn parse_clif_with_source(input: &str, source_label: Option<&str>) -> Result<Document> {
    let tokens = lex(input)?;
    let expressions = parse_expressions(&tokens)?;
    Compiler::new(input, source_label).compile(&expressions)
}

pub fn reason_clif(input: &str) -> Result<String> {
    let document = parse_clif(input)?;
    let result = reason(&document, &ReasonerOptions::default());
    if let Some(summary) = result.incomplete_summary() {
        return Err(EyeronError::new(summary));
    }
    Ok(triples_to_clif(&result.derived))
}

pub fn triples_to_clif(triples: &[Triple]) -> String {
    render::triples_to_clif(triples)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn reasons_socrates() {
        let input = r#"
            (cl:text
              (Human Socrates)
              (forall (x) (if (Human x) (Mortal x))))
        "#;
        let output = reason_clif(input).unwrap();
        assert!(output.contains("(Mortal Socrates)"), "{output}");
    }

    #[test]
    fn supports_n_ary_predicates() {
        let input = r#"
            (cl:text
              (Between a b c)
              (forall (x y z) (if (Between x y z) (Related x z))))
        "#;
        let output = reason_clif(input).unwrap();
        assert!(output.contains("(Related a c)"), "{output}");
    }

    #[test]
    fn supports_guarded_quantifiers() {
        let input = r#"
            (cl:text
              (Human Socrates)
              (forall ((x Human)) (Mortal x)))
        "#;
        let output = reason_clif(input).unwrap();
        assert!(output.contains("(Mortal Socrates)"), "{output}");
    }

    #[test]
    fn rejects_classical_negation() {
        let error = parse_clif("(cl:text (not (Human Socrates)))").unwrap_err();
        assert!(error.message.contains("Horn fragment"));
    }
}
