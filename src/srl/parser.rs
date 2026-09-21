//! Recursive-descent parser for SPARQL 1.2 RL ("SRL") concrete syntax.
//!
//! Ported from eyeleng's `src/parser.js`, which is itself hand-written (no
//! SPARQL-algebra library): the parser's output *is* the executable rule
//! IR, there is no separate "SPARQL algebra to rule IR" translation pass.
//! Where eyeron's own N3/RDF-1.2 parser (`crate::parser`) already solves
//! the same sub-problem (numeric/boolean literal lexical conventions, RDF
//! 1.2 triple-term/reifier/annotation representation via
//! `Term::Formula(vec![triple])` linked by `rdf:reifies`), this module
//! reuses that representation so the rest of eyeron (printing, proofs)
//! needs no SRL-specific cases.

use std::collections::BTreeMap;

use crate::ast::{Literal, SourceRef, Term, Triple, RDF_FIRST, RDF_NIL, RDF_REST, RDF_TYPE};
use crate::error::{EyeronError, Result};
use crate::n3::parser::{boolean_literal, number_literal};

use super::ast::{BinaryOp, Clause, Expr, PathExpr, SparqlRlProgram, SparqlRlRule, UnaryOp};
use super::lexer::{lex, Token, TokenKind};

const RDF_REIFIES: &str = "http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies";

/// Parse a `.srl` SPARQL 1.2 RL rule set.
pub fn parse_sparql_rl(input: &str, base_iri: Option<&str>) -> Result<SparqlRlProgram> {
    parse_sparql_rl_with_source(input, base_iri, None)
}

/// As `parse_sparql_rl`, but also stamps each rule's `source` (used only
/// for `--proof` output's `pe:rule "label"; pe:line N`) with `source_label`
/// and the rule's own line number. A plain `parse_sparql_rl` call (no
/// label) leaves every rule's `source` as `None`, matching
/// `n3::parser::parse_n3`'s own "labels are opt-in" convention.
pub fn parse_sparql_rl_with_source(input: &str, base_iri: Option<&str>, source_label: Option<&str>) -> Result<SparqlRlProgram> {
    if looks_like_select_query(input) {
        return Err(EyeronError::new(
            "QUERY/SELECT concrete syntax is not part of the SPARQL-RL rule-set grammar; SPARQL 1.2 RL only supports RULE {...} WHERE {...}",
        ));
    }
    let tokens = lex(input)?;
    let mut line_starts = vec![0];
    for (idx, ch) in input.char_indices() {
        if ch == '\n' { line_starts.push(idx + ch.len_utf8()); }
    }
    Parser::new(tokens, base_iri).with_source(source_label, line_starts).parse_program()
}

/// Parse a raw SRL body pattern (as used by `--query`/`--query-file`, e.g.
/// `{ ?x :parentOf ?y }` or just `?x :parentOf ?y`), returning its clauses
/// and prefixes. Implemented by wrapping the input as `RULE {} WHERE
/// { ... }` (prefixed with `PREFIX` declarations for `inherited_prefixes`,
/// so a query pattern can use the prefixes already declared in the rule
/// set it is being run against) and reusing the ordinary rule-body
/// grammar, matching eyeleng's `parseQuery`.
pub fn parse_query_body(input: &str, base_iri: Option<&str>, inherited_prefixes: &BTreeMap<String, String>) -> Result<(Vec<Clause>, BTreeMap<String, String>)> {
    let trimmed = input.trim();
    let mut wrapped = String::new();
    for (prefix, iri) in inherited_prefixes {
        wrapped.push_str(&format!("PREFIX {}: <{}>\n", prefix, iri));
    }
    if trimmed.starts_with('{') {
        wrapped.push_str(&format!("RULE {{}} WHERE {}", trimmed));
    } else {
        wrapped.push_str(&format!("RULE {{}} WHERE {{ {} }}", trimmed));
    }
    let program = parse_sparql_rl(&wrapped, base_iri)?;
    if program.rules.len() != 1 || !program.data.is_empty() {
        return Err(EyeronError::new("expected exactly one raw body pattern"));
    }
    let rule = program.rules.into_iter().next().unwrap();
    Ok((rule.body, program.prefixes))
}

fn looks_like_select_query(input: &str) -> bool {
    let trimmed = input.trim_start();
    let head: String = trimmed.chars().take(8).collect::<String>().to_ascii_uppercase();
    head.starts_with("QUERY") || head.starts_with("SELECT")
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Ctx {
    Data,
    Head,
    Body,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Position {
    Subject,
    Predicate,
    Object,
    Other,
}

#[derive(Clone, Copy)]
struct Opts {
    ctx: Ctx,
    allow_path: bool,
    position: Position,
}

impl Opts {
    fn at(self, position: Position) -> Self {
        Self { position, ..self }
    }
}

/// A body-position predicate: either an ordinary term (IRI/variable) or a
/// property path. Only body clauses may carry a path predicate.
enum PredSlot {
    Plain(Term),
    Path(PathExpr),
}

/// A triple produced while parsing a graph node, before it is classified
/// into `Clause::Triple`/`Clause::Path` (body) or plain `Triple` (data/head).
struct RawTriple {
    s: Term,
    p: PredSlot,
    o: Term,
}

impl RawTriple {
    fn plain(s: Term, p: Term, o: Term) -> Self {
        Self { s, p: PredSlot::Plain(p), o }
    }

    fn into_clause(self) -> Clause {
        match self.p {
            PredSlot::Plain(p) => Clause::Triple(Triple::new(self.s, p, self.o)),
            PredSlot::Path(path) => Clause::Path { s: self.s, p: path, o: self.o },
        }
    }

    fn into_triple(self) -> Result<Triple> {
        match self.p {
            PredSlot::Plain(p) => Ok(Triple::new(self.s, p, self.o)),
            PredSlot::Path(_) => Err(EyeronError::new("property paths are only allowed in a rule body")),
        }
    }
}

struct GraphNode {
    term: Term,
    triples: Vec<RawTriple>,
}

struct Parser {
    tokens: Vec<Token>,
    pos: usize,
    prefixes: BTreeMap<String, String>,
    base_iri: Option<String>,
    version: Option<String>,
    imports: Vec<String>,
    blank_counter: usize,
    /// Blank-node labels (`_:x`) used inside the current rule body are
    /// scoped to that rule and become fresh body variables, matching SRL's
    /// treatment of blank nodes in `WHERE { ... }` (SPARQL semantics: a
    /// blank node in a query pattern behaves like a non-distinguished
    /// variable).
    body_blank_labels: Option<BTreeMap<String, Term>>,
    /// `--proof` source-location tracking, mirroring `n3::parser::Parser`'s
    /// own `source_label`/`line_starts` fields exactly: both stay empty
    /// unless `parse_sparql_rl_with_source` supplied a label, so ordinary
    /// (non-`--proof`) parsing pays nothing extra.
    source_label: Option<String>,
    line_starts: Vec<usize>,
}

impl Parser {
    fn new(tokens: Vec<Token>, base_iri: Option<&str>) -> Self {
        let mut prefixes = BTreeMap::new();
        prefixes.insert("rdf".to_string(), "http://www.w3.org/1999/02/22-rdf-syntax-ns#".to_string());
        prefixes.insert("srl".to_string(), "http://www.w3.org/ns/sparql-rl#".to_string());
        prefixes.insert("xsd".to_string(), "http://www.w3.org/2001/XMLSchema#".to_string());
        Self {
            tokens,
            pos: 0,
            prefixes,
            base_iri: base_iri.map(ToOwned::to_owned),
            version: None,
            imports: Vec::new(),
            blank_counter: 0,
            body_blank_labels: None,
            source_label: None,
            line_starts: Vec::new(),
        }
    }

    fn with_source(mut self, source_label: Option<&str>, line_starts: Vec<usize>) -> Self {
        self.source_label = source_label.map(ToOwned::to_owned);
        self.line_starts = line_starts;
        self
    }

    fn source_ref_at(&self, offset: usize) -> Option<SourceRef> {
        let label = self.source_label.as_ref()?;
        let line = match self.line_starts.binary_search(&offset) {
            Ok(idx) => idx + 1,
            Err(idx) => idx,
        };
        Some(SourceRef { label: label.clone(), line: line.max(1) })
    }

    fn parse_program(&mut self) -> Result<SparqlRlProgram> {
        let mut data = Vec::new();
        let mut data_sources = BTreeMap::new();
        let mut rules = Vec::new();
        while !self.is_eof() {
            if self.match_word("PREFIX") {
                self.parse_prefix()?;
            } else if self.match_word("BASE") {
                self.parse_base()?;
            } else if self.match_word("VERSION") {
                self.parse_version()?;
            } else if self.match_word("IMPORTS") {
                self.parse_imports()?;
            } else if self.match_word("DATA") {
                self.expect_kind(&TokenKind::LBrace)?;
                for (raw, offset) in self.parse_data_triples_block()? {
                    let triple = raw.into_triple()?;
                    if let Some(source) = self.source_ref_at(offset) {
                        data_sources.entry(triple.clone()).or_insert(source);
                    }
                    data.push(triple);
                }
            } else if self.check_word("RULE") {
                let rule_offset = self.peek().offset;
                self.advance();
                let mut rule = self.parse_rule()?;
                rule.source = self.source_ref_at(rule_offset);
                rules.push(rule);
            } else {
                return Err(EyeronError::at(
                    format!("expected PREFIX, BASE, VERSION, IMPORTS, DATA, or RULE; got {}", self.describe_peek()),
                    self.peek().offset,
                ));
            }
        }
        Ok(SparqlRlProgram {
            base_iri: self.base_iri.clone(),
            version: self.version.clone(),
            imports: self.imports.clone(),
            prefixes: self.prefixes.clone(),
            data,
            rules,
            data_sources,
        })
    }

    /// As `parse_triples_block` for a `DATA {...}` block, but also returns
    /// each raw triple's own top-level statement's starting offset (used
    /// for `--proof`'s per-fact `pe:by [pe:fact "label"; pe:line N]`). A
    /// `;`/`,`-grouped statement's several triples all share their
    /// statement's own start line -- a reasonable approximation, matching
    /// how "one fact, one line" already breaks down for genuinely
    /// multi-line facts elsewhere in this proof format.
    fn parse_data_triples_block(&mut self) -> Result<Vec<(RawTriple, usize)>> {
        let mut triples = Vec::new();
        while !self.match_kind(&TokenKind::RBrace) {
            let offset = self.peek().offset;
            let opts = Opts { ctx: Ctx::Data, allow_path: false, position: Position::Other };
            for raw in self.parse_triple_statement(opts)? {
                triples.push((raw, offset));
            }
            self.consume_optional_dot();
        }
        Ok(triples)
    }

    fn parse_prefix(&mut self) -> Result<()> {
        let tok = self.advance();
        let TokenKind::Word(name) = &tok.kind else { return Err(EyeronError::at("expected prefix name", tok.offset)) };
        let name = name.strip_suffix(':').ok_or_else(|| EyeronError::at("prefix name must end with ':'", tok.offset))?.to_string();
        let iri = self.expect_iri()?;
        let resolved = self.resolve_iri(&iri);
        self.prefixes.insert(name, resolved);
        Ok(())
    }

    fn parse_base(&mut self) -> Result<()> {
        let iri = self.expect_iri()?;
        self.base_iri = Some(iri);
        Ok(())
    }

    fn parse_version(&mut self) -> Result<()> {
        let tok = self.advance();
        match tok.kind {
            TokenKind::String(s) | TokenKind::StringLong(s) => {
                self.version = Some(s);
                Ok(())
            }
            _ => Err(EyeronError::at("expected a string literal after VERSION", tok.offset)),
        }
    }

    fn parse_imports(&mut self) -> Result<()> {
        let iri = self.expect_iri()?;
        self.imports.push(self.resolve_iri(&iri));
        self.consume_optional_dot();
        Ok(())
    }

    fn parse_rule(&mut self) -> Result<SparqlRlRule> {
        let name = if !self.check_kind(&TokenKind::LBrace) { Some(self.parse_iri_value()?) } else { None };
        self.expect_kind(&TokenKind::LBrace)?;
        let head_opts = Opts { ctx: Ctx::Head, allow_path: false, position: Position::Other };
        let mut head = Vec::new();
        for raw in self.parse_triples_block(head_opts)? {
            head.push(raw.into_triple()?);
        }
        self.expect_word("WHERE")?;
        let ground_data = self.match_word("DATA");
        self.expect_kind(&TokenKind::LBrace)?;
        self.body_blank_labels = Some(BTreeMap::new());
        let body = self.parse_body_block();
        self.body_blank_labels = None;
        let body = body?;
        let mut rule = SparqlRlRule::new(head, body);
        rule.name = name;
        rule.ground_data = ground_data;
        Ok(rule)
    }

    // ---- triple blocks -------------------------------------------------

    fn parse_triples_block(&mut self, opts: Opts) -> Result<Vec<RawTriple>> {
        let mut triples = Vec::new();
        while !self.match_kind(&TokenKind::RBrace) {
            triples.extend(self.parse_triple_statement(opts)?);
            self.consume_optional_dot();
        }
        Ok(triples)
    }

    fn parse_triple_statement(&mut self, opts: Opts) -> Result<Vec<RawTriple>> {
        let subject_node = self.parse_graph_node(opts.at(Position::Subject))?;
        let mut triples = subject_node.triples;
        triples.extend(self.parse_property_list_for_subject(subject_node.term, opts, &[TokenKind::RBrace])?);
        Ok(triples)
    }

    fn parse_property_list_for_subject(&mut self, subject: Term, opts: Opts, terminators: &[TokenKind]) -> Result<Vec<RawTriple>> {
        let mut triples = Vec::new();
        loop {
            if terminators.iter().any(|t| self.check_kind(t)) || self.check_kind(&TokenKind::Dot) {
                break;
            }
            let predicate = if opts.allow_path { self.parse_verb_path_or_simple(opts)? } else { PredSlot::Plain(self.parse_verb_term(opts)?) };
            loop {
                let object_node = self.parse_graph_node(opts.at(Position::Object))?;
                triples.extend(object_node.triples);
                let predicate_term = match &predicate {
                    PredSlot::Plain(t) => PredSlot::Plain(t.clone()),
                    PredSlot::Path(p) => PredSlot::Path(p.clone()),
                };
                let base = RawTriple { s: subject.clone(), p: predicate_term, o: object_node.term };
                let asserted_for_annotations = base.plain_view();
                triples.push(base);
                if let Some(asserted) = asserted_for_annotations {
                    triples.extend(self.parse_annotations_for_triple(asserted, opts)?);
                }
                if !self.match_kind(&TokenKind::Comma) {
                    break;
                }
            }
            if self.match_kind(&TokenKind::Semicolon) {
                while self.match_kind(&TokenKind::Semicolon) {}
                if self.check_kind(&TokenKind::Dot) || terminators.iter().any(|t| self.check_kind(t)) {
                    break;
                }
            } else {
                break;
            }
        }
        Ok(triples)
    }

    fn parse_graph_node(&mut self, opts: Opts) -> Result<GraphNode> {
        if self.check_kind(&TokenKind::LBracket) {
            return self.parse_blank_node_property_list(opts);
        }
        if self.check_kind(&TokenKind::LParen) {
            return self.parse_collection(opts);
        }
        if self.check_kind(&TokenKind::LTriple) {
            return self.parse_reified_triple_node(opts);
        }
        Ok(GraphNode { term: self.parse_term(opts)?, triples: Vec::new() })
    }

    fn parse_blank_node_property_list(&mut self, opts: Opts) -> Result<GraphNode> {
        self.expect_kind(&TokenKind::LBracket)?;
        let node = self.fresh_graph_node(opts);
        if self.match_kind(&TokenKind::RBracket) {
            return Ok(GraphNode { term: node, triples: Vec::new() });
        }
        let triples = self.parse_property_list_for_subject(node.clone(), opts, &[TokenKind::RBracket])?;
        self.expect_kind(&TokenKind::RBracket)?;
        Ok(GraphNode { term: node, triples })
    }

    fn parse_collection(&mut self, opts: Opts) -> Result<GraphNode> {
        self.expect_kind(&TokenKind::LParen)?;
        if self.match_kind(&TokenKind::RParen) {
            return Ok(GraphNode { term: Term::iri(RDF_NIL), triples: Vec::new() });
        }
        let head = self.fresh_graph_node(opts);
        let mut current = head.clone();
        let mut triples = Vec::new();
        loop {
            let item = self.parse_graph_node(opts)?;
            triples.extend(item.triples);
            triples.push(RawTriple::plain(current.clone(), Term::iri(RDF_FIRST), item.term));
            if self.match_kind(&TokenKind::RParen) {
                triples.push(RawTriple::plain(current, Term::iri(RDF_REST), Term::iri(RDF_NIL)));
                break;
            }
            let rest = self.fresh_graph_node(opts);
            triples.push(RawTriple::plain(current, Term::iri(RDF_REST), rest.clone()));
            current = rest;
        }
        Ok(GraphNode { term: head, triples })
    }

    fn fresh_graph_node(&mut self, opts: Opts) -> Term {
        self.blank_counter += 1;
        let id = format!("b{}", self.blank_counter);
        if opts.ctx == Ctx::Body {
            Term::var(format!("__{}", id))
        } else {
            Term::blank(id)
        }
    }

    fn parse_annotations_for_triple(&mut self, asserted: Triple, opts: Opts) -> Result<Vec<RawTriple>> {
        let mut triples = Vec::new();
        let reified = Term::formula(vec![asserted.clone()]);
        let mut current_reifier: Option<Term> = None;
        loop {
            if self.match_kind(&TokenKind::Tilde) {
                let reifier = self.parse_optional_reifier(opts)?;
                triples.push(RawTriple::plain(reifier.clone(), Term::iri(RDF_REIFIES), reified.clone()));
                current_reifier = Some(reifier);
                continue;
            }
            if self.check_kind(&TokenKind::LAnnotation) {
                let reifier = match current_reifier.take() {
                    Some(r) => r,
                    None => {
                        let r = self.fresh_graph_node(opts);
                        triples.push(RawTriple::plain(r.clone(), Term::iri(RDF_REIFIES), reified.clone()));
                        r
                    }
                };
                self.expect_kind(&TokenKind::LAnnotation)?;
                if self.check_kind(&TokenKind::RAnnotation) {
                    return Err(EyeronError::at("annotation blocks may not be empty", self.peek().offset));
                }
                triples.extend(self.parse_property_list_for_subject(reifier, opts, &[TokenKind::RAnnotation])?);
                self.expect_kind(&TokenKind::RAnnotation)?;
                continue;
            }
            break;
        }
        Ok(triples)
    }

    fn parse_optional_reifier(&mut self, opts: Opts) -> Result<Term> {
        if self.check_kind(&TokenKind::LAnnotation)
            || self.check_kind(&TokenKind::Dot)
            || self.check_kind(&TokenKind::Semicolon)
            || self.check_kind(&TokenKind::Comma)
            || self.check_kind(&TokenKind::RBrace)
            || self.check_kind(&TokenKind::RAnnotation)
            || self.check_kind(&TokenKind::RTriple)
        {
            return Ok(self.fresh_graph_node(opts));
        }
        self.parse_term(opts)
    }

    fn parse_reified_triple_node(&mut self, opts: Opts) -> Result<GraphNode> {
        self.expect_kind(&TokenKind::LTriple)?;
        let s = self.parse_reified_triple_component(opts)?;
        let p = self.parse_verb_term(opts)?;
        let o = self.parse_reified_triple_component(opts)?;
        let mut reifier = None;
        if self.match_kind(&TokenKind::Tilde) {
            reifier = Some(self.parse_optional_reifier(opts)?);
        }
        self.expect_kind(&TokenKind::RTriple)?;
        let reifier = reifier.unwrap_or_else(|| self.fresh_graph_node(opts));
        let mut triples = s.triples;
        triples.extend(o.triples);
        let inner = Triple::new(s.term, p, o.term);
        triples.push(RawTriple::plain(reifier.clone(), Term::iri(RDF_REIFIES), Term::formula(vec![inner])));
        Ok(GraphNode { term: reifier, triples })
    }

    fn parse_reified_triple_component(&mut self, opts: Opts) -> Result<GraphNode> {
        if self.check_kind(&TokenKind::LTriple) {
            return self.parse_reified_triple_node(opts);
        }
        Ok(GraphNode { term: self.parse_term(opts)?, triples: Vec::new() })
    }

    fn parse_verb_term(&mut self, opts: Opts) -> Result<Term> {
        let term = self.parse_term(opts.at(Position::Predicate))?;
        match term {
            Term::Iri(_) | Term::Var(_) => Ok(term),
            _ => Err(EyeronError::new("expected an IRI or variable as predicate")),
        }
    }

    fn parse_verb_path_or_simple(&mut self, opts: Opts) -> Result<PredSlot> {
        if matches!(self.peek_kind(), TokenKind::Var(_)) {
            return Ok(PredSlot::Plain(self.parse_term(opts.at(Position::Predicate))?));
        }
        let path = self.parse_path_sequence(opts)?;
        match path {
            PathExpr::Iri(iri) => Ok(PredSlot::Plain(Term::iri(iri))),
            other => Ok(PredSlot::Path(other)),
        }
    }

    fn parse_path_sequence(&mut self, opts: Opts) -> Result<PathExpr> {
        let mut parts = vec![self.parse_path_elt_or_inverse(opts)?];
        while self.match_kind(&TokenKind::Slash) {
            parts.push(self.parse_path_elt_or_inverse(opts)?);
        }
        if parts.len() == 1 {
            Ok(parts.into_iter().next().unwrap())
        } else {
            Ok(PathExpr::Sequence(parts))
        }
    }

    fn parse_path_elt_or_inverse(&mut self, opts: Opts) -> Result<PathExpr> {
        if self.match_kind(&TokenKind::Caret) {
            return Ok(PathExpr::Inverse(Box::new(self.parse_path_primary(opts)?)));
        }
        self.parse_path_primary(opts)
    }

    fn parse_path_primary(&mut self, opts: Opts) -> Result<PathExpr> {
        if self.match_kind(&TokenKind::LParen) {
            let path = self.parse_path_sequence(opts)?;
            self.expect_kind(&TokenKind::RParen)?;
            return Ok(path);
        }
        match self.peek_kind().clone() {
            TokenKind::Iri(_) | TokenKind::Word(_) => Ok(PathExpr::Iri(self.parse_iri_value()?)),
            other => Err(EyeronError::at(format!("expected path IRI, 'a', '^', or '('; got {:?}", other), self.peek().offset)),
        }
    }

    // ---- body clauses ----------------------------------------------------

    fn parse_body_block(&mut self) -> Result<Vec<Clause>> {
        let opts = Opts { ctx: Ctx::Body, allow_path: true, position: Position::Other };
        let mut clauses = Vec::new();
        while !self.match_kind(&TokenKind::RBrace) {
            if self.match_word("FILTER") {
                clauses.push(self.parse_filter_clause()?);
            } else if self.match_word("SET") {
                clauses.push(self.parse_set_clause()?);
            } else if self.check_word("BIND") {
                return Err(EyeronError::at("BIND is not part of the SPARQL 1.2 RL grammar; use SET(?v := expr)", self.peek().offset));
            } else if self.match_word("NOT") {
                let ground_data = self.match_word("DATA");
                self.expect_kind(&TokenKind::LBrace)?;
                let body = self.parse_body_basic_block()?;
                clauses.push(Clause::Not { body, ground_data });
            } else {
                for raw in self.parse_triple_statement(opts)? {
                    clauses.push(raw.into_clause());
                }
            }
            self.consume_optional_dot();
        }
        Ok(clauses)
    }

    /// The restricted grammar inside `NOT { ... }`: no nested `NOT`, `SET`,
    /// or `BIND` (SPARQL 1.2 RL forbids assignment and further negation
    /// inside a negated sub-pattern).
    fn parse_body_basic_block(&mut self) -> Result<Vec<Clause>> {
        let opts = Opts { ctx: Ctx::Body, allow_path: true, position: Position::Other };
        let mut clauses = Vec::new();
        while !self.match_kind(&TokenKind::RBrace) {
            if self.match_word("FILTER") {
                clauses.push(self.parse_filter_clause()?);
            } else if self.check_word("SET") {
                return Err(EyeronError::at("SET is not allowed inside a NOT block", self.peek().offset));
            } else if self.check_word("BIND") {
                return Err(EyeronError::at("BIND is not allowed inside a NOT block", self.peek().offset));
            } else if self.check_word("NOT") {
                return Err(EyeronError::at("nested NOT is not allowed inside a NOT block", self.peek().offset));
            } else {
                for raw in self.parse_triple_statement(opts)? {
                    clauses.push(raw.into_clause());
                }
            }
            self.consume_optional_dot();
        }
        Ok(clauses)
    }

    fn parse_filter_clause(&mut self) -> Result<Clause> {
        Ok(Clause::Filter(self.parse_expression(0)?))
    }

    fn parse_set_clause(&mut self) -> Result<Clause> {
        self.expect_kind(&TokenKind::LParen)?;
        let var = match self.advance().kind {
            TokenKind::Var(v) => v,
            other => return Err(EyeronError::new(format!("expected a variable after SET(, got {:?}", other))),
        };
        self.expect_kind(&TokenKind::Assign)?;
        let expr = self.parse_expression(0)?;
        self.expect_kind(&TokenKind::RParen)?;
        Ok(Clause::Set { var, expr })
    }

    // ---- terms -------------------------------------------------------

    fn parse_term(&mut self, opts: Opts) -> Result<Term> {
        let tok = self.advance();
        if matches!(tok.kind, TokenKind::Plus | TokenKind::Minus) && matches!(self.peek_kind(), TokenKind::Number(_)) {
            let neg = matches!(tok.kind, TokenKind::Minus);
            let TokenKind::Number(n) = self.advance().kind else { unreachable!() };
            let value = if neg { format!("-{}", n) } else { n };
            return Ok(number_literal(value));
        }
        match tok.kind {
            TokenKind::Var(v) => {
                if opts.ctx == Ctx::Data {
                    return Err(EyeronError::at("DATA blocks may not contain variables", tok.offset));
                }
                Ok(Term::var(v))
            }
            TokenKind::Iri(iri) => Ok(Term::iri(self.resolve_iri(&iri))),
            TokenKind::String(s) | TokenKind::StringLong(s) => self.parse_literal_after(s),
            TokenKind::Number(n) => Ok(number_literal(n)),
            TokenKind::Boolean(b) => Ok(boolean_literal(b)),
            TokenKind::LTripleTerm => self.parse_triple_term_after_open(opts),
            TokenKind::LTriple => Err(EyeronError::at(
                "use << s p o >> as a graph node reifier; use <<( s p o )>> for a triple term",
                tok.offset,
            )),
            TokenKind::Word(word) => {
                if word == "a" {
                    if opts.position != Position::Predicate {
                        return Err(EyeronError::at("'a' is only allowed as a predicate", tok.offset));
                    }
                    return Ok(Term::iri(RDF_TYPE));
                }
                if let Some(label) = word.strip_prefix("_:") {
                    return Ok(if opts.ctx == Ctx::Body { self.body_blank_node_variable(label) } else { Term::blank(label) });
                }
                Ok(Term::iri(self.expand_pname(&word, tok.offset)?))
            }
            other => Err(EyeronError::at(format!("expected term, got {:?}", other), tok.offset)),
        }
    }

    fn parse_triple_term_after_open(&mut self, opts: Opts) -> Result<Term> {
        let s = self.parse_term(opts)?;
        let p = self.parse_verb_term(opts)?;
        let o = self.parse_term(opts)?;
        self.expect_kind(&TokenKind::RTripleTerm)?;
        Ok(Term::formula(vec![Triple::new(s, p, o)]))
    }

    fn parse_literal_after(&mut self, value: String) -> Result<Term> {
        if self.match_kind(&TokenKind::HatHat) {
            let datatype = self.parse_datatype_iri()?;
            return Ok(Term::Literal(Literal { value, datatype: Some(datatype), language: None }));
        }
        if let TokenKind::Lang(tag) = self.peek_kind().clone() {
            self.advance();
            let raw = tag;
            let direction = raw.rfind("--").map(|idx| raw[idx + 2..].to_string());
            if let Some(dir) = &direction {
                if dir != "ltr" && dir != "rtl" {
                    return Err(EyeronError::at(format!("invalid base direction --{}; expected --ltr or --rtl", dir), self.previous().offset));
                }
            }
            let lower = raw.to_ascii_lowercase();
            let language = match direction {
                Some(dir) => format!("{}--{}", &lower[..lower.len() - dir.len() - 2], dir),
                None => lower,
            };
            return Ok(Term::Literal(Literal { value, datatype: None, language: Some(language) }));
        }
        Ok(Term::Literal(Literal::plain(value)))
    }

    fn parse_datatype_iri(&mut self) -> Result<String> {
        let tok = self.advance();
        match tok.kind {
            TokenKind::Iri(iri) => Ok(self.resolve_iri(&iri)),
            TokenKind::Word(word) => self.expand_pname(&word, tok.offset),
            other => Err(EyeronError::at(format!("expected datatype IRI, got {:?}", other), tok.offset)),
        }
    }

    fn body_blank_node_variable(&mut self, label: &str) -> Term {
        if self.body_blank_labels.is_none() {
            self.body_blank_labels = Some(BTreeMap::new());
        }
        if let Some(term) = self.body_blank_labels.as_ref().unwrap().get(label) {
            return term.clone();
        }
        self.blank_counter += 1;
        let term = Term::var(format!("__b{}", self.blank_counter));
        self.body_blank_labels.as_mut().unwrap().insert(label.to_string(), term.clone());
        term
    }

    fn parse_iri_value(&mut self) -> Result<String> {
        let tok = self.advance();
        match tok.kind {
            TokenKind::Iri(iri) => Ok(self.resolve_iri(&iri)),
            TokenKind::Word(word) if word == "a" => Ok(RDF_TYPE.to_string()),
            TokenKind::Word(word) => self.expand_pname(&word, tok.offset),
            other => Err(EyeronError::at(format!("expected IRI or prefixed name, got {:?}", other), tok.offset)),
        }
    }

    fn expand_pname(&self, word: &str, offset: usize) -> Result<String> {
        let colon = word.find(':').ok_or_else(|| EyeronError::at(format!("expected IRI or prefixed name, got {}", word), offset))?;
        let prefix = &word[..colon];
        let local = &word[colon + 1..];
        let base = self.prefixes.get(prefix).ok_or_else(|| EyeronError::at(format!("unknown prefix {}:", prefix), offset))?;
        Ok(format!("{}{}", base, decode_pn_local_escapes(local)))
    }

    fn resolve_iri(&self, value: &str) -> String {
        if has_uri_scheme(value) {
            return value.to_string();
        }
        let Some(base) = &self.base_iri else { return value.to_string() };
        resolve_relative(base, value)
    }

    // ---- expressions -------------------------------------------------

    fn parse_expression(&mut self, min_prec: i32) -> Result<Expr> {
        let mut left = self.parse_unary_expression()?;
        while let Some((op, prec)) = self.peek_binary_operator() {
            if prec < min_prec {
                break;
            }
            self.consume_binary_operator(op)?;
            if matches!(op, BinaryOp::In | BinaryOp::NotIn) {
                let items = self.parse_expression_list_items()?;
                left = Expr::Binary { op, left: Box::new(left), right: Box::new(Expr::List(items)) };
            } else {
                let right = self.parse_expression(prec + 1)?;
                left = Expr::Binary { op, left: Box::new(left), right: Box::new(right) };
            }
        }
        Ok(left)
    }

    fn parse_expression_list_items(&mut self) -> Result<Vec<Expr>> {
        self.expect_kind(&TokenKind::LParen)?;
        let mut items = Vec::new();
        if !self.check_kind(&TokenKind::RParen) {
            loop {
                items.push(self.parse_expression(0)?);
                if !self.match_kind(&TokenKind::Comma) {
                    break;
                }
            }
        }
        self.expect_kind(&TokenKind::RParen)?;
        Ok(items)
    }

    fn peek_binary_operator(&self) -> Option<(BinaryOp, i32)> {
        let op = match self.peek_kind() {
            TokenKind::OrOr => BinaryOp::Or,
            TokenKind::AndAnd => BinaryOp::And,
            TokenKind::Eq => BinaryOp::Eq,
            TokenKind::NotEq => BinaryOp::NotEq,
            TokenKind::Lt => BinaryOp::Lt,
            TokenKind::Le => BinaryOp::Le,
            TokenKind::Gt => BinaryOp::Gt,
            TokenKind::Ge => BinaryOp::Ge,
            TokenKind::Plus => BinaryOp::Add,
            TokenKind::Minus => BinaryOp::Sub,
            TokenKind::Star => BinaryOp::Mul,
            TokenKind::Slash => BinaryOp::Div,
            TokenKind::Word(w) if w.eq_ignore_ascii_case("IN") => BinaryOp::In,
            TokenKind::Word(w) if w.eq_ignore_ascii_case("NOT") => {
                if matches!(self.peek_n(1), Some(TokenKind::Word(w2)) if w2.eq_ignore_ascii_case("IN")) {
                    BinaryOp::NotIn
                } else {
                    return None;
                }
            }
            _ => return None,
        };
        Some((op, binary_precedence(op)))
    }

    fn consume_binary_operator(&mut self, op: BinaryOp) -> Result<()> {
        match op {
            BinaryOp::NotIn => {
                self.expect_word("NOT")?;
                self.expect_word("IN")?;
            }
            BinaryOp::In => {
                self.expect_word("IN")?;
            }
            _ => {
                self.advance();
            }
        }
        Ok(())
    }

    fn parse_unary_expression(&mut self) -> Result<Expr> {
        let op = match self.peek_kind() {
            TokenKind::Bang => Some(UnaryOp::Not),
            TokenKind::Minus => Some(UnaryOp::Neg),
            TokenKind::Plus => Some(UnaryOp::Plus),
            _ => None,
        };
        if let Some(op) = op {
            self.advance();
            return Ok(Expr::Unary { op, expr: Box::new(self.parse_unary_expression()?) });
        }
        self.parse_primary_expression()
    }

    fn parse_primary_expression(&mut self) -> Result<Expr> {
        let tok = self.advance();
        match tok.kind {
            TokenKind::Var(v) => Ok(Expr::Var(v)),
            TokenKind::String(s) | TokenKind::StringLong(s) => self.parse_literal_expression_after(s),
            TokenKind::Number(n) => Ok(Expr::Term(number_literal(n))),
            TokenKind::Boolean(b) => Ok(Expr::Term(boolean_literal(b))),
            TokenKind::Iri(iri) => {
                let name = self.resolve_iri(&iri);
                if self.check_kind(&TokenKind::LParen) {
                    return self.parse_function_call_after_name(name);
                }
                Ok(Expr::Term(Term::iri(name)))
            }
            TokenKind::LTripleTerm => {
                let opts = Opts { ctx: Ctx::Body, allow_path: false, position: Position::Other };
                Ok(Expr::Term(self.parse_triple_term_after_open(opts)?))
            }
            TokenKind::LTriple => Err(EyeronError::at("use <<( s p o )>> for triple terms inside expressions", tok.offset)),
            TokenKind::Word(word) => {
                if word == "true" {
                    return Ok(Expr::Term(boolean_literal(true)));
                }
                if word == "false" {
                    return Ok(Expr::Term(boolean_literal(false)));
                }
                if let Some(label) = word.strip_prefix("_:") {
                    return Ok(Expr::Term(Term::blank(label)));
                }
                if self.check_kind(&TokenKind::LParen) {
                    if word.contains(':') && word != "a" {
                        let name = self.expand_pname(&word, tok.offset)?;
                        return self.parse_function_call_after_name(name);
                    }
                    if super::expr::is_builtin_name(&word) {
                        return self.parse_function_call_after_name(word.to_ascii_uppercase());
                    }
                    return Err(EyeronError::at(
                        format!("unknown built-in or unprefixed function call {}; use an IRI such as :{} for custom functions", word, word),
                        tok.offset,
                    ));
                }
                if word.contains(':') || word == "a" {
                    let value = if word == "a" { RDF_TYPE.to_string() } else { self.expand_pname(&word, tok.offset)? };
                    return Ok(Expr::Term(Term::iri(value)));
                }
                Err(EyeronError::at(format!("expected expression, got {}", word), tok.offset))
            }
            TokenKind::LParen => {
                let expr = self.parse_expression(0)?;
                self.expect_kind(&TokenKind::RParen)?;
                Ok(expr)
            }
            other => Err(EyeronError::at(format!("expected expression, got {:?}", other), tok.offset)),
        }
    }

    fn parse_function_call_after_name(&mut self, name: String) -> Result<Expr> {
        self.expect_kind(&TokenKind::LParen)?;
        let mut args = Vec::new();
        if !self.check_kind(&TokenKind::RParen) {
            loop {
                args.push(self.parse_expression(0)?);
                if !self.match_kind(&TokenKind::Comma) {
                    break;
                }
            }
        }
        self.expect_kind(&TokenKind::RParen)?;
        Ok(Expr::Call { name, args })
    }

    fn parse_literal_expression_after(&mut self, value: String) -> Result<Expr> {
        let term = self.parse_literal_after(value)?;
        if let Term::Literal(lit) = &term {
            if lit.datatype.is_some() || lit.language.is_some() {
                return Ok(Expr::Term(term));
            }
            return Ok(Expr::Term(term));
        }
        Ok(Expr::Term(term))
    }

    // ---- token helpers -------------------------------------------------

    fn consume_optional_dot(&mut self) {
        self.match_kind(&TokenKind::Dot);
    }

    fn is_eof(&self) -> bool {
        matches!(self.peek_kind(), TokenKind::Eof)
    }

    fn peek(&self) -> &Token {
        &self.tokens[self.pos]
    }

    fn peek_kind(&self) -> &TokenKind {
        &self.tokens[self.pos].kind
    }

    fn peek_n(&self, n: usize) -> Option<&TokenKind> {
        self.tokens.get(self.pos + n).map(|t| &t.kind)
    }

    fn previous(&self) -> &Token {
        &self.tokens[self.pos - 1]
    }

    fn advance(&mut self) -> Token {
        let tok = self.tokens[self.pos].clone();
        if !self.is_eof() {
            self.pos += 1;
        }
        tok
    }

    fn check_kind(&self, kind: &TokenKind) -> bool {
        same_kind(self.peek_kind(), kind)
    }

    fn match_kind(&mut self, kind: &TokenKind) -> bool {
        if self.check_kind(kind) {
            self.advance();
            true
        } else {
            false
        }
    }

    fn expect_kind(&mut self, kind: &TokenKind) -> Result<Token> {
        if self.check_kind(kind) {
            Ok(self.advance())
        } else {
            Err(EyeronError::at(format!("expected {:?}, got {}", kind, self.describe_peek()), self.peek().offset))
        }
    }

    fn expect_iri(&mut self) -> Result<String> {
        match self.advance().kind {
            TokenKind::Iri(iri) => Ok(iri),
            other => Err(EyeronError::new(format!("expected an IRI, got {:?}", other))),
        }
    }

    fn check_word(&self, word: &str) -> bool {
        matches!(self.peek_kind(), TokenKind::Word(w) if w.eq_ignore_ascii_case(word))
    }

    fn match_word(&mut self, word: &str) -> bool {
        if self.check_word(word) {
            self.advance();
            true
        } else {
            false
        }
    }

    fn expect_word(&mut self, word: &str) -> Result<()> {
        if self.match_word(word) {
            Ok(())
        } else {
            Err(EyeronError::at(format!("expected {}, got {}", word, self.describe_peek()), self.peek().offset))
        }
    }

    fn describe_peek(&self) -> String {
        match self.peek_kind() {
            TokenKind::Word(w) => w.clone(),
            TokenKind::Eof => "end of input".to_string(),
            other => format!("{:?}", other),
        }
    }
}

impl RawTriple {
    /// If this triple has a plain (non-path) predicate, return the
    /// asserted `Triple` for use as the subject of `~reifier`/`{| ... |}`
    /// annotation syntax. Paths cannot be annotated.
    fn plain_view(&self) -> Option<Triple> {
        match &self.p {
            PredSlot::Plain(p) => Some(Triple::new(self.s.clone(), p.clone(), self.o.clone())),
            PredSlot::Path(_) => None,
        }
    }
}

fn same_kind(a: &TokenKind, b: &TokenKind) -> bool {
    std::mem::discriminant(a) == std::mem::discriminant(b)
}

fn binary_precedence(op: BinaryOp) -> i32 {
    match op {
        BinaryOp::Or => 1,
        BinaryOp::And => 2,
        BinaryOp::Eq | BinaryOp::NotEq | BinaryOp::In | BinaryOp::NotIn => 3,
        BinaryOp::Lt | BinaryOp::Le | BinaryOp::Gt | BinaryOp::Ge => 4,
        BinaryOp::Add | BinaryOp::Sub => 5,
        BinaryOp::Mul | BinaryOp::Div => 6,
    }
}

fn decode_pn_local_escapes(local: &str) -> String {
    let mut out = String::with_capacity(local.len());
    let mut chars = local.chars().peekable();
    while let Some(c) = chars.next() {
        if c == '\\' {
            if let Some(&next) = chars.peek() {
                if "_~.!$&'()*+,;=/?#@%-".contains(next) {
                    out.push(next);
                    chars.next();
                    continue;
                }
            }
        }
        out.push(c);
    }
    out
}

fn has_uri_scheme(value: &str) -> bool {
    let mut chars = value.char_indices();
    let Some((_, first)) = chars.next() else { return false };
    if !first.is_ascii_alphabetic() {
        return false;
    }
    for (idx, c) in chars {
        if c == ':' {
            return idx > 0;
        }
        if !(c.is_ascii_alphanumeric() || matches!(c, '+' | '-' | '.')) {
            return false;
        }
    }
    false
}

fn resolve_relative(base: &str, reference: &str) -> String {
    if has_uri_scheme(reference) {
        return reference.to_string();
    }
    // SRL base-IRI resolution only needs to cover the common cases produced
    // by hand-written rule sets (absolute-path and plain relative
    // references); eyeron's own IRI resolver in `crate::parser` implements
    // the full RFC 3986 algorithm for the N3/RDF-1.2 front end. A minimal,
    // self-contained resolver here avoids depending on that private
    // function while covering the same practical cases as eyeleng's
    // `new URL(value, this.baseIRI).href`.
    if reference.starts_with('/') {
        if let Some(scheme_end) = base.find("://") {
            let authority_end = base[scheme_end + 3..].find('/').map(|i| scheme_end + 3 + i).unwrap_or(base.len());
            return format!("{}{}", &base[..authority_end], reference);
        }
    }
    if reference.is_empty() {
        return base.to_string();
    }
    match base.rfind('/') {
        Some(idx) => format!("{}{}", &base[..=idx], reference),
        None => format!("{}{}", base, reference),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parses_family_example() {
        let src = r#"
            PREFIX : <http://example/>
            DATA {
              :A :fatherOf :X .
              :B :motherOf :X .
            }
            RULE { ?x :childOf ?y } WHERE { ?y :fatherOf ?x }
            RULE { ?x :descendedFrom ?y } WHERE { ?x :childOf ?z . ?z :descendedFrom ?y }
        "#;
        let program = parse_sparql_rl(src, None).unwrap();
        assert_eq!(program.data.len(), 2);
        assert_eq!(program.rules.len(), 2);
        assert_eq!(program.rules[0].head.len(), 1);
        assert_eq!(program.rules[0].body.len(), 1);
    }

    #[test]
    fn parses_filter_with_comparison() {
        let src = r#"
            PREFIX : <http://example.com/>
            RULE { ?x a :largeTown } WHERE { ?x :population ?p . FILTER(?p > 1500) }
        "#;
        let program = parse_sparql_rl(src, None).unwrap();
        assert_eq!(program.rules[0].body.len(), 2);
        assert!(matches!(program.rules[0].body[1], Clause::Filter(Expr::Binary { op: BinaryOp::Gt, .. })));
    }

    #[test]
    fn parses_set_clause() {
        let src = r#"
            PREFIX : <http://example/>
            RULE { ?x :double ?y } WHERE { ?x :n ?n . SET(?y := ?n * 2) }
        "#;
        let program = parse_sparql_rl(src, None).unwrap();
        assert!(matches!(program.rules[0].body[1], Clause::Set { .. }));
        assert!(program.rules[0].run_once);
    }

    #[test]
    fn parses_not_clause() {
        let src = r#"
            PREFIX : <http://example/>
            RULE { ?x :orphan true } WHERE { ?x a :Person . NOT { ?x :childOf ?y } }
        "#;
        let program = parse_sparql_rl(src, None).unwrap();
        assert!(matches!(program.rules[0].body[1], Clause::Not { .. }));
    }

    #[test]
    fn parses_property_path() {
        let src = r#"
            PREFIX : <http://example/>
            RULE { ?x :grandparentOf ?z } WHERE { ?x :parentOf/:parentOf ?z }
        "#;
        let program = parse_sparql_rl(src, None).unwrap();
        assert!(matches!(program.rules[0].body[0], Clause::Path { .. }));
    }

    /// The path grammar is `Path ::= PathSequence`, `PathEltOrInverse ::=
    /// PathElt | '^' PathElt`, `PathElt ::= ( iri | 'a' | '(' Path ')' )`
    /// (SPARQL 1.2 RL §7.6, productions [85]–[88]): sequence, inverse and
    /// grouping only. Alternation and the length modifiers are SPARQL
    /// syntax that SRL deliberately leaves out, so each has to be a
    /// syntax error rather than something quietly misread — `:p?` in
    /// particular used to lex as the single name `p?`.
    #[test]
    fn rejects_path_syntax_outside_the_srl_grammar() {
        for path in [":p|:q", ":p?", ":p+", ":p*", "(:p|:q)", ":p/:q+"] {
            let src = format!("PREFIX : <http://example/>\nRULE {{ ?x :r ?y }} WHERE {{ ?x {} ?y }}", path);
            assert!(parse_sparql_rl(&src, None).is_err(), "{path} should not parse: SRL has no such path syntax");
        }
    }

    #[test]
    fn parses_grouped_and_inverse_sequence_paths() {
        for path in [":p/:q", "^:p", ":p/^:q", "(:p/:q)/:r", "^(:p/:q)", "a/:p"] {
            let src = format!("PREFIX : <http://example/>\nRULE {{ ?x :r ?y }} WHERE {{ ?x {} ?y }}", path);
            assert!(parse_sparql_rl(&src, None).is_ok(), "{path} is valid SRL path syntax");
        }
    }

    #[test]
    fn parses_inverse_path() {
        let src = r#"
            PREFIX : <http://example/>
            RULE { ?x :hasParent ?y } WHERE { ?x ^:parentOf ?y }
        "#;
        let program = parse_sparql_rl(src, None).unwrap();
        assert!(matches!(program.rules[0].body[0], Clause::Path { p: PathExpr::Inverse(_), .. }));
    }

    #[test]
    fn rejects_select_query_syntax() {
        let err = parse_sparql_rl("SELECT * WHERE { ?s ?p ?o }", None).unwrap_err();
        assert!(err.message.contains("SPARQL-RL"), "{}", err.message);
    }

    #[test]
    fn rejects_bind() {
        let src = "PREFIX : <http://example/>\nRULE { ?x :y ?z } WHERE { BIND(1 AS ?z) }";
        let err = parse_sparql_rl(src, None).unwrap_err();
        assert!(err.message.contains("SET"), "{}", err.message);
    }

    #[test]
    fn rejects_data_variables() {
        let src = "PREFIX : <http://example/>\nDATA { ?x :a :b }";
        assert!(parse_sparql_rl(src, None).is_err());
    }

    #[test]
    fn parses_triple_term_expression() {
        let src = r#"
            PREFIX : <http://example/>
            RULE { ?x :ok true } WHERE { ?x :claims ?t . FILTER(isTRIPLE(?t)) }
        "#;
        let program = parse_sparql_rl(src, None).unwrap();
        assert_eq!(program.rules[0].body.len(), 2);
    }
}
