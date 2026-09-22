//! RDF 1.2 N-Quads bridge (specification §12): imports N-Quads as ground
//! `rdf(S, P, O, G)` facts, exports the `rdf/4` predicate's answers as
//! N-Quads. Reuses eyeron's existing N-Quads *reader*
//! (`crate::n3::rdf_compat::parse_rdf12`); writes one small new serializer
//! for output, since eyeron's existing `triples_to_n3`/`triples_to_trig`
//! writers are Turtle/TriG-shaped, not N-Quads.

use std::collections::BTreeSet;

use crate::ast::{Literal, Term as AstTerm, Triple as AstTriple, LOG_NAME_OF};
use crate::error::{EyeronError, Result};
use crate::n3::rdf_compat::{parse_rdf12, RdfFormat};

use super::term::{self, ground, Term};
use super::QueryResult;

const XSD_STRING: &str = "http://www.w3.org/2001/XMLSchema#string";

/// eyeron folds RDF 1.2 base direction into `Literal.language` as
/// `"en--ltr"` (see `crate::srl::expr`'s helpers of the same name); split
/// that back into the plain language tag and optional direction.
fn base_lang(language: &str) -> &str {
    match language.find("--") {
        Some(idx) => &language[..idx],
        None => language,
    }
}

fn base_dir(language: &str) -> Option<&str> {
    language.find("--").map(|idx| &language[idx + 2..])
}

fn prefix_blank(value: AstTerm, prefix: &str) -> AstTerm {
    match value {
        AstTerm::Blank(label) => AstTerm::Blank(format!("{}{}", prefix, label)),
        AstTerm::Formula(triples) => {
            AstTerm::Formula(triples.into_iter().map(|t| AstTriple::new(prefix_blank(t.s, prefix), prefix_blank(t.p, prefix), prefix_blank(t.o, prefix))).collect())
        }
        AstTerm::List(items) => AstTerm::List(items.into_iter().map(|item| prefix_blank(item, prefix)).collect()),
        other => other,
    }
}

fn literal_to_rdf(lit: &Literal) -> Term {
    let lexical = term::str_(lit.value.clone());
    if let Some(language) = &lit.language {
        let lang = base_lang(language).to_string();
        let descriptor = match base_dir(language) {
            Some(dir) => term::struct_("language", vec![term::str_(lang), term::atom(dir.to_string())]),
            None => term::struct_("language", vec![term::str_(lang)]),
        };
        return term::struct_("literal", vec![lexical, descriptor]);
    }
    let datatype = lit.datatype.clone().unwrap_or_else(|| XSD_STRING.to_string());
    term::struct_("literal", vec![lexical, term::struct_("datatype", vec![term::struct_("iri", vec![term::str_(datatype)])])])
}

fn ast_term_to_rdf(value: &AstTerm) -> Result<Term> {
    match value {
        AstTerm::Iri(iri) => Ok(term::struct_("iri", vec![term::str_(iri.clone())])),
        AstTerm::Blank(label) => Ok(term::struct_("blank", vec![term::str_(label.clone())])),
        AstTerm::Literal(lit) => Ok(literal_to_rdf(lit)),
        AstTerm::Formula(triples) if triples.len() == 1 => {
            let t = &triples[0];
            Ok(term::struct_("triple", vec![ast_term_to_rdf(&t.s)?, ast_term_to_rdf(&t.p)?, ast_term_to_rdf(&t.o)?]))
        }
        other => Err(EyeronError::new(format!("Cannot represent {:?} as an RDF term", other))),
    }
}

/// Strip a leading `VERSION "1.2"` directive line, erroring if present with
/// any other version. RDF 1.2 N-Quads documents open with this directive
/// (spec §13), but `crate::n3::rdf_compat`'s N-Quads reader — built for
/// eyeron's own RDF-conformance corpus, which does not use it — rejects
/// any directive at all in N-Triples/N-Quads mode; this is a thin
/// compatibility shim ahead of it rather than a change to that reader.
fn strip_version_directive(input: &str) -> Result<String> {
    let mut skip = 0;
    for line in input.lines() {
        let trimmed = line.trim();
        if trimmed.is_empty() {
            skip += 1;
            continue;
        }
        if let Some(rest) = trimmed.strip_prefix("VERSION") {
            let rest = rest.trim().split('#').next().unwrap_or("").trim();
            if rest != "\"1.2\"" {
                return Err(EyeronError::new(format!("Only RDF version 1.2 is supported; got VERSION {}", rest)));
            }
            skip += 1;
        }
        break;
    }
    Ok(input.lines().skip(skip).collect::<Vec<_>>().join("\n"))
}

/// Parse `input` as RDF 1.2 N-Quads and return one ground `rdf(S,P,O,G)`
/// fact per quad, deduplicated. Blank node labels are prefixed with
/// `blank_prefix` so multiple `--rdf-input` files never collide (mirrors
/// `rdf.js`'s per-file `blankNodePrefix`).
pub fn parse_nquads(input: &str, blank_prefix: &str) -> Result<Vec<Term>> {
    let input = strip_version_directive(input)?;
    let doc = parse_rdf12(&input, None, RdfFormat::NQuads)?;
    let mut facts = Vec::new();
    let mut seen = BTreeSet::new();
    for triple in &doc.facts {
        let is_named_graph_wrapper = triple.p == AstTerm::Iri(LOG_NAME_OF.to_string());
        let (s, p, o, g) = if is_named_graph_wrapper {
            match &triple.o {
                AstTerm::Formula(inner) if inner.len() == 1 => (inner[0].s.clone(), inner[0].p.clone(), inner[0].o.clone(), Some(triple.s.clone())),
                _ => (triple.s.clone(), triple.p.clone(), triple.o.clone(), None),
            }
        } else {
            (triple.s.clone(), triple.p.clone(), triple.o.clone(), None)
        };
        let s = prefix_blank(s, blank_prefix);
        let p = prefix_blank(p, blank_prefix);
        let o = prefix_blank(o, blank_prefix);
        let g = g.map(|g| prefix_blank(g, blank_prefix));
        let graph_term = match &g {
            Some(g) => ast_term_to_rdf(g)?,
            None => term::atom("default_graph"),
        };
        let quad = term::struct_("rdf", vec![ast_term_to_rdf(&s)?, ast_term_to_rdf(&p)?, ast_term_to_rdf(&o)?, graph_term]);
        if seen.insert(term::term_key(&quad)) {
            facts.push(quad);
        }
    }
    Ok(facts)
}

/// Render `facts` (each a ground `rdf(S,P,O,G)` compound term) as a
/// Prolog source fragment of ordinary facts, used to splice `--rdf-input`
/// in ahead of the rest of the program.
pub fn facts_to_prolog(facts: &[Term]) -> String {
    let lines: Vec<String> = facts.iter().map(|f| format!("{}.", term::format(f))).collect();
    if lines.is_empty() {
        String::new()
    } else {
        format!("{}\n", lines.join("\n"))
    }
}

fn bad_term(term: &Term) -> EyeronError {
    EyeronError::new(format!("Invalid RDF term {}", term::format(term)))
}

fn string_escape(value: &str) -> String {
    let mut out = String::from("\"");
    for ch in value.chars() {
        match ch {
            '\t' => out.push_str("\\t"),
            '\u{8}' => out.push_str("\\b"),
            '\n' => out.push_str("\\n"),
            '\r' => out.push_str("\\r"),
            '\u{c}' => out.push_str("\\f"),
            '"' => out.push_str("\\\""),
            '\\' => out.push_str("\\\\"),
            c if (c as u32) < 0x20 => out.push_str(&format!("\\u{:04x}", c as u32)),
            c => out.push(c),
        }
    }
    out.push('"');
    out
}

fn iri_escape(value: &str) -> String {
    let mut out = String::from("<");
    for ch in value.chars() {
        let code = ch as u32;
        if code <= 0x20 || "<>\"{}|^`\\".contains(ch) {
            if code <= 0xffff {
                out.push_str(&format!("\\u{:04x}", code));
            } else {
                out.push_str(&format!("\\U{:08x}", code));
            }
        } else {
            out.push(ch);
        }
    }
    out.push('>');
    out
}

fn rdf_term_text(value: &Term, position: &str) -> Result<String> {
    match value {
        Term::Struct(name, args) if name == "iri" && args.len() == 1 => match &args[0] {
            Term::Str(s) => Ok(iri_escape(s)),
            _ => Err(bad_term(value)),
        },
        Term::Struct(name, args) if name == "blank" && args.len() == 1 && position != "predicate" => match &args[0] {
            Term::Str(label) => Ok(format!("_:{}", label)),
            _ => Err(bad_term(value)),
        },
        Term::Struct(name, args) if name == "literal" && args.len() == 2 && position == "object" => {
            let lexical = match &args[0] {
                Term::Str(s) => string_escape(s),
                _ => return Err(bad_term(value)),
            };
            match &args[1] {
                Term::Struct(dn, dargs) if dn == "datatype" && dargs.len() == 1 => {
                    let is_xsd_string = matches!(&dargs[0], Term::Struct(n, a) if n == "iri" && a.len() == 1 && a[0] == term::str_(XSD_STRING));
                    if is_xsd_string {
                        Ok(lexical)
                    } else {
                        Ok(format!("{}^^{}", lexical, rdf_term_text(&dargs[0], "predicate")?))
                    }
                }
                Term::Struct(dn, dargs) if dn == "language" && (dargs.len() == 1 || dargs.len() == 2) => {
                    let lang = match &dargs[0] {
                        Term::Str(s) => s.to_ascii_lowercase(),
                        _ => return Err(bad_term(value)),
                    };
                    if dargs.len() == 2 {
                        let dir = match &dargs[1] {
                            Term::Struct(a, empty) if empty.is_empty() && (a == "ltr" || a == "rtl") => a.clone(),
                            _ => return Err(bad_term(value)),
                        };
                        Ok(format!("{}@{}--{}", lexical, lang, dir))
                    } else {
                        Ok(format!("{}@{}", lexical, lang))
                    }
                }
                _ => Err(bad_term(value)),
            }
        }
        Term::Struct(name, args) if name == "triple" && args.len() == 3 && position == "object" => {
            Ok(format!("<<( {} {} {} )>>", rdf_term_text(&args[0], "subject")?, rdf_term_text(&args[1], "predicate")?, rdf_term_text(&args[2], "object")?))
        }
        _ => Err(bad_term(value)),
    }
}

/// Render ground `rdf/4` terms as RDF 1.2 N-Quads, deduplicated and sorted
/// (mirrors `formatNQuads`).
pub fn format_nquads(quads: &[Term]) -> Result<String> {
    let mut lines = BTreeSet::new();
    for quad in quads {
        if !ground(quad) {
            return Err(EyeronError::new(format!("Expected a ground rdf/4 term; got {}", term::format(quad))));
        }
        let (s, p, o, g) = match quad {
            Term::Struct(name, args) if name == "rdf" && args.len() == 4 => (&args[0], &args[1], &args[2], &args[3]),
            _ => return Err(EyeronError::new(format!("Expected a ground rdf/4 term; got {}", term::format(quad)))),
        };
        let graph_text = match g {
            Term::Struct(a, empty) if empty.is_empty() && a == "default_graph" => String::new(),
            _ => format!(" {}", rdf_term_text(g, "graph")?),
        };
        lines.insert(format!("{} {} {}{} .", rdf_term_text(s, "subject")?, rdf_term_text(p, "predicate")?, rdf_term_text(o, "object")?, graph_text));
    }
    if lines.is_empty() {
        Ok(String::new())
    } else {
        Ok(format!("VERSION \"1.2\"\n{}\n", lines.into_iter().collect::<Vec<_>>().join("\n")))
    }
}

/// Render a `--rdf-output` query's answers (from
/// `?- rdf(Subject, Predicate, Object, Graph).`) as N-Quads.
pub fn answers_to_nquads(query: &QueryResult) -> Result<String> {
    let quads: Vec<Term> = query
        .answers
        .iter()
        .map(|answer| {
            let get = |name: &str| answer.bindings.iter().find(|(n, _)| n.eq_ignore_ascii_case(name)).map(|(_, v)| v.clone()).unwrap_or_else(|| term::atom("undefined"));
            term::struct_("rdf", vec![get("subject"), get("predicate"), get("object"), get("graph")])
        })
        .collect();
    format_nquads(&quads)
}
