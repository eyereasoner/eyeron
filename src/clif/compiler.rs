use super::*;
use super::render::{numeric_literal, symbol};
use super::syntax::Expr;
use std::cell::Cell;
use std::collections::BTreeMap;
use std::rc::Rc;

struct Scope {
    terms: BTreeMap<String, Term>,
    source_names: BTreeMap<String, String>,
    next_id: Rc<Cell<usize>>,
}

impl Default for Scope {
    fn default() -> Self {
        Self { terms: BTreeMap::new(), source_names: BTreeMap::new(), next_id: Rc::new(Cell::new(0)) }
    }
}

impl Scope {
    fn child(&self) -> Self {
        Self {
            terms: self.terms.clone(),
            source_names: self.source_names.clone(),
            next_id: Rc::clone(&self.next_id),
        }
    }

    fn bind_variable(&mut self, source: &str) -> Term {
        let id = self.next_id.get();
        self.next_id.set(id + 1);
        let internal = format!("clif_{}_{}", id, sanitize_ident(source));
        let term = Term::Var(internal.clone());
        self.terms.insert(source.to_string(), term.clone());
        self.source_names.insert(internal, source.to_string());
        term
    }

    fn bind_blank(&mut self, source: &str) -> Term {
        let id = self.next_id.get();
        self.next_id.set(id + 1);
        let term = Term::Blank(format!("clif_exists_{}_{}", id, sanitize_ident(source)));
        self.terms.insert(source.to_string(), term.clone());
        term
    }
}

#[derive(Debug, Clone)]
struct BindingSpec {
    name: String,
    guard: Option<Expr>,
}

pub(super) struct Compiler<'a> {
    input: &'a str,
    source_label: Option<&'a str>,
    document: Document,
}

impl<'a> Compiler<'a> {
    pub(super) fn new(input: &'a str, source_label: Option<&'a str>) -> Self {
        Self { input, source_label, document: Document::new() }
    }

    pub(super) fn compile(mut self, expressions: &[Expr]) -> Result<Document> {
        let mut scope = Scope::default();
        for expression in expressions {
            self.compile_top(expression, &mut scope, Vec::new())?;
        }
        Ok(self.document)
    }

    fn compile_top(&mut self, expression: &Expr, scope: &mut Scope, guards: Vec<Triple>) -> Result<()> {
        let Expr::List(items, offset) = expression else {
            return Err(EyeronError::at("CLIF sentence must be an S-expression", expression.offset()));
        };
        if items.is_empty() { return Err(EyeronError::at("empty CLIF sentence", *offset)); }

        match items[0].name() {
            Some("cl:text") => {
                for item in &items[1..] { self.compile_top(item, scope, guards.clone())?; }
                Ok(())
            }
            Some("cl:comment") => {
                let start = if matches!(items.get(1), Some(Expr::String(_, _))) { 2 } else { 1 };
                for item in items.iter().skip(start) {
                    self.compile_top(item, scope, guards.clone())?;
                }
                Ok(())
            }
            Some("cl:prefix") | Some("cl:prefx") => Err(EyeronError::at(
                "CLIF prefix declarations are not implemented in the Cliron core port; use full names", *offset,
            )),
            Some("cl:imports") | Some("cl:restrict") | Some("cl:outdiscourse") => Err(EyeronError::at(
                "CLIF imports, domain restrictions, and discourse declarations are not implemented in the Cliron core port", *offset,
            )),
            Some("forall") => {
                require_len(items, 3, "forall expects a binding list and one sentence", *offset)?;
                let mut nested = scope.child();
                let mut nested_guards = guards;
                for spec in binding_specs(&items[1])? {
                    let variable = nested.bind_variable(&spec.name);
                    if let Some(guard) = spec.guard {
                        nested_guards.push(self.guard_atom(&guard, variable, &nested)?);
                    }
                }
                self.compile_top(&items[2], &mut nested, nested_guards)
            }
            Some("exists") => {
                require_len(items, 3, "exists expects a binding list and one sentence", *offset)?;
                let mut nested = scope.child();
                let mut head = Vec::new();
                for spec in binding_specs(&items[1])? {
                    let blank = nested.bind_blank(&spec.name);
                    if let Some(guard) = spec.guard { head.push(self.guard_atom(&guard, blank, &nested)?); }
                }
                self.collect_head(&items[2], &mut nested, &mut head)?;
                if guards.is_empty() {
                    for fact in head { self.add_fact(fact, expression.offset())?; }
                    Ok(())
                } else {
                    self.add_rule(guards, head, &nested, expression.offset())
                }
            }
            Some("and") => {
                for item in &items[1..] { self.compile_top(item, scope, guards.clone())?; }
                Ok(())
            }
            Some("if") => {
                require_len(items, 3, "if expects antecedent and consequent", *offset)?;
                let mut body = guards;
                self.collect_body(&items[1], scope, &mut body)?;
                let mut head = Vec::new();
                self.collect_head(&items[2], scope, &mut head)?;
                self.add_rule(body, head, scope, expression.offset())
            }
            Some("iff") => {
                require_len(items, 3, "iff expects two sentences", *offset)?;
                let mut left = guards.clone();
                self.collect_body(&items[1], scope, &mut left)?;
                let mut right_head = Vec::new();
                self.collect_head(&items[2], scope, &mut right_head)?;
                self.add_rule(left, right_head, scope, expression.offset())?;

                let mut right = guards;
                self.collect_body(&items[2], scope, &mut right)?;
                let mut left_head = Vec::new();
                self.collect_head(&items[1], scope, &mut left_head)?;
                self.add_rule(right, left_head, scope, expression.offset())
            }
            Some("or") | Some("not") => Err(EyeronError::at(
                "classical disjunction and negation are outside the Horn fragment implemented by Cliron", *offset,
            )),
            _ => {
                let atom = self.atom(expression, scope)?;
                if guards.is_empty() {
                    if !atom.is_ground() {
                        return Err(EyeronError::at("unrestricted universal conclusions require full first-order domain reasoning", expression.offset()));
                    }
                    self.add_fact(atom, expression.offset())
                } else {
                    self.add_rule(guards, vec![atom], scope, expression.offset())
                }
            }
        }
    }

    fn collect_body(&self, expression: &Expr, scope: &mut Scope, out: &mut Vec<Triple>) -> Result<()> {
        let Expr::List(items, offset) = expression else {
            return Err(EyeronError::at("rule antecedent must be a CLIF sentence", expression.offset()));
        };
        if items.is_empty() { return Err(EyeronError::at("empty antecedent", *offset)); }
        match items[0].name() {
            Some("and") => {
                for item in &items[1..] { self.collect_body(item, scope, out)?; }
                Ok(())
            }
            Some("exists") => {
                require_len(items, 3, "exists expects a binding list and one sentence", *offset)?;
                let mut nested = scope.child();
                for spec in binding_specs(&items[1])? {
                    let variable = nested.bind_variable(&spec.name);
                    if let Some(guard) = spec.guard { out.push(self.guard_atom(&guard, variable, &nested)?); }
                }
                self.collect_body(&items[2], &mut nested, out)
            }
            Some("=") => {
                require_len(items, 3, "= expects exactly two terms", *offset)?;
                out.push(Triple::new(
                    self.term(&items[1], scope)?,
                    Term::Iri(LOG_EQUAL_TO.to_string()),
                    self.term(&items[2], scope)?,
                ));
                Ok(())
            }
            Some("or") | Some("not") | Some("if") | Some("iff") | Some("forall") => Err(EyeronError::at(
                "this antecedent is outside the Horn fragment implemented by Cliron", *offset,
            )),
            _ => { out.push(self.atom(expression, scope)?); Ok(()) }
        }
    }

    fn collect_head(&self, expression: &Expr, scope: &mut Scope, out: &mut Vec<Triple>) -> Result<()> {
        let Expr::List(items, offset) = expression else {
            return Err(EyeronError::at("rule consequent must be a CLIF sentence", expression.offset()));
        };
        if items.is_empty() { return Err(EyeronError::at("empty consequent", *offset)); }
        match items[0].name() {
            Some("and") => {
                for item in &items[1..] { self.collect_head(item, scope, out)?; }
                Ok(())
            }
            Some("exists") => {
                require_len(items, 3, "exists expects a binding list and one sentence", *offset)?;
                let mut nested = scope.child();
                for spec in binding_specs(&items[1])? {
                    let blank = nested.bind_blank(&spec.name);
                    if let Some(guard) = spec.guard { out.push(self.guard_atom(&guard, blank, &nested)?); }
                }
                self.collect_head(&items[2], &mut nested, out)
            }
            Some("=") => Err(EyeronError::at(
                "equations in rule conclusions require equality materialization, which is not implemented in Cliron yet", *offset,
            )),
            Some("or") | Some("not") | Some("if") | Some("iff") | Some("forall") => Err(EyeronError::at(
                "this consequent is outside the Horn fragment implemented by Cliron", *offset,
            )),
            _ => { out.push(self.atom(expression, scope)?); Ok(()) }
        }
    }

    fn atom(&self, expression: &Expr, scope: &Scope) -> Result<Triple> {
        let Expr::List(items, offset) = expression else {
            return Err(EyeronError::at("atomic sentence must be an S-expression", expression.offset()));
        };
        if items.is_empty() { return Err(EyeronError::at("empty atomic sentence", *offset)); }
        if matches!(items[0].name(), Some("=" | "and" | "or" | "not" | "if" | "iff" | "forall" | "exists")) {
            return Err(EyeronError::at("logical operator used where an atomic predicate was required", *offset));
        }
        let mut args = vec![Term::Iri(ARG_MARKER.to_string())];
        for item in &items[1..] { args.push(self.term(item, scope)?); }
        Ok(Triple::new(Term::List(args), self.term(&items[0], scope)?, Term::Iri(TRUE_MARKER.to_string())))
    }

    fn guard_atom(&self, guard: &Expr, variable: Term, scope: &Scope) -> Result<Triple> {
        Ok(Triple::new(
            Term::List(vec![Term::Iri(ARG_MARKER.to_string()), variable]),
            self.term(guard, scope)?,
            Term::Iri(TRUE_MARKER.to_string()),
        ))
    }

    fn term(&self, expression: &Expr, scope: &Scope) -> Result<Term> {
        match expression {
            Expr::String(value, _) => Ok(Term::Literal(Literal::plain(value.clone()))),
            Expr::Name(name, _) => {
                if let Some(bound) = scope.terms.get(name) { return Ok(bound.clone()); }
                if let Some((value, datatype)) = numeric_literal(name) {
                    return Ok(Term::Literal(Literal { value, datatype: Some(datatype.to_string()), language: None }));
                }
                Ok(symbol(name))
            }
            Expr::List(items, offset) => {
                if items.is_empty() { return Err(EyeronError::at("empty function term", *offset)); }
                let mut encoded = vec![Term::Iri(FUNCTION_MARKER.to_string()), self.term(&items[0], scope)?];
                for item in &items[1..] { encoded.push(self.term(item, scope)?); }
                Ok(Term::List(encoded))
            }
        }
    }

    fn add_fact(&mut self, fact: Triple, offset: usize) -> Result<()> {
        if !fact.is_ground() { return Err(EyeronError::at("CLIF fact contains an unbound variable", offset)); }
        if let Some(label) = self.source_label {
            self.document.fact_sources.insert(
                fact.clone(),
                crate::ast::SourceRef { label: label.to_string(), line: line_at(self.input, offset) },
            );
        }
        self.document.facts.push(fact);
        Ok(())
    }

    fn add_rule(&mut self, body: Vec<Triple>, head: Vec<Triple>, scope: &Scope, offset: usize) -> Result<()> {
        if head.is_empty() { return Err(EyeronError::at("Horn rule must have a non-empty consequent", offset)); }
        if body.is_empty() && head.iter().any(|triple| !triple.is_ground()) {
            return Err(EyeronError::at("unrestricted universal conclusions require domain reasoning not provided by the current engine", offset));
        }
        let mut rule = Rule::new(body, head, true);
        rule.proof_var_source_names = scope.source_names.clone();
        if let Some(label) = self.source_label {
            rule.source = Some(crate::ast::SourceRef { label: label.to_string(), line: line_at(self.input, offset) });
        }
        self.document.rules.push(rule);
        Ok(())
    }
}

fn binding_specs(expression: &Expr) -> Result<Vec<BindingSpec>> {
    let Expr::List(items, offset) = expression else {
        return Err(EyeronError::at("quantifier bindings must be a parenthesized list", expression.offset()));
    };
    let mut out = Vec::new();
    for item in items {
        match item {
            Expr::Name(name, _) => out.push(BindingSpec { name: name.clone(), guard: None }),
            Expr::List(parts, item_offset) if parts.len() == 2 => {
                let Some(name) = parts[0].name() else {
                    return Err(EyeronError::at("guarded binding variable must be a name", *item_offset));
                };
                out.push(BindingSpec { name: name.to_string(), guard: Some(parts[1].clone()) });
            }
            _ => return Err(EyeronError::at("invalid CLIF quantifier binding", *offset)),
        }
    }
    Ok(out)
}

fn require_len(items: &[Expr], len: usize, message: &str, offset: usize) -> Result<()> {
    if items.len() == len { Ok(()) } else { Err(EyeronError::at(message, offset)) }
}

fn sanitize_ident(value: &str) -> String {
    value.chars().map(|ch| if ch.is_ascii_alphanumeric() || ch == '_' { ch } else { '_' }).collect()
}

fn line_at(input: &str, offset: usize) -> usize {
    input[..offset.min(input.len())].bytes().filter(|byte| *byte == b'\n').count() + 1
}
