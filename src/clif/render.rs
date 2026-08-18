use super::*;

pub(super) fn symbol(name: &str) -> Term {
    Term::Iri(format!("{}{}", SYMBOL_PREFIX, percent_encode(name.as_bytes())))
}

pub(super) fn numeric_literal(name: &str) -> Option<(String, &'static str)> {
    if name.parse::<i128>().is_ok() {
        return Some((name.to_string(), XSD_INTEGER));
    }
    if (name.contains('.') || name.contains('e') || name.contains('E')) && name.parse::<f64>().is_ok() {
        return Some((
            name.to_string(),
            if name.contains('e') || name.contains('E') { XSD_DOUBLE } else { XSD_DECIMAL },
        ));
    }
    None
}

pub(super) fn triples_to_clif(triples: &[Triple]) -> String {
    let mut out = String::from("(cl:text");
    if triples.is_empty() {
        out.push_str(")\n");
        return out;
    }
    out.push('\n');
    for triple in triples {
        if let Some(atom) = render_triple(triple) {
            out.push_str("  ");
            out.push_str(&atom);
            out.push('\n');
        }
    }
    out.push_str(")\n");
    out
}

fn render_triple(triple: &Triple) -> Option<String> {
    if matches!(&triple.p, Term::Iri(iri) if iri == LOG_EQUAL_TO) {
        return Some(format!("(= {} {})", render_term(&triple.s), render_term(&triple.o)));
    }
    let Term::Iri(marker) = &triple.o else { return None; };
    if marker != TRUE_MARKER { return None; }
    let Term::List(items) = &triple.s else { return None; };
    if !matches!(items.first(), Some(Term::Iri(marker)) if marker == ARG_MARKER) { return None; }
    let mut out = format!("({}", render_term(&triple.p));
    for arg in &items[1..] {
        out.push(' ');
        out.push_str(&render_term(arg));
    }
    out.push(')');
    Some(out)
}

fn render_term(term: &Term) -> String {
    match term {
        Term::Iri(iri) if iri.starts_with(SYMBOL_PREFIX) => {
            let value = percent_decode(&iri[SYMBOL_PREFIX.len()..]).unwrap_or_else(|| iri.clone());
            render_name(&value)
        }
        Term::Iri(iri) => render_name(iri),
        Term::Var(name) => render_name(name),
        Term::Blank(name) => render_name(&format!("_:{}", name)),
        Term::Literal(literal) => {
            if matches!(literal.datatype.as_deref(), Some(dt) if dt == XSD_INTEGER || dt == XSD_DECIMAL || dt == XSD_DOUBLE) {
                literal.value.clone()
            } else {
                format!("'{}'", escape_quoted(&literal.value, '\''))
            }
        }
        Term::List(items)
            if matches!(items.first(), Some(Term::Iri(marker)) if marker == FUNCTION_MARKER)
                && items.len() >= 2 =>
        {
            let mut out = format!("({}", render_term(&items[1]));
            for arg in &items[2..] {
                out.push(' ');
                out.push_str(&render_term(arg));
            }
            out.push(')');
            out
        }
        Term::List(items) => format!(
            "(cliron:list {})",
            items.iter().map(render_term).collect::<Vec<_>>().join(" ")
        ),
        Term::Formula(_) => "\"urn:cliron:formula\"".to_string(),
    }
}

fn render_name(value: &str) -> String {
    let reserved = matches!(
        value,
        "=" | "and" | "or" | "not" | "if" | "iff" | "forall" | "exists"
            | "cl:text" | "cl:comment" | "cl:imports" | "cl:restrict"
            | "cl:outdiscourse" | "cl:prefix" | "cl:prefx"
    );
    let safe = !reserved
        && !value.is_empty()
        && !value.chars().any(|ch| ch.is_whitespace() || matches!(ch, '(' | ')' | '\'' | '"' | '\\'))
        && numeric_literal(value).is_none();
    if safe { value.to_string() } else { format!("\"{}\"", escape_quoted(value, '"')) }
}

fn escape_quoted(value: &str, quote: char) -> String {
    let mut out = String::new();
    for ch in value.chars() {
        match ch {
            '\\' => out.push_str("\\\\"),
            '\n' => out.push_str("\\n"),
            '\r' => out.push_str("\\r"),
            '\t' => out.push_str("\\t"),
            other if other == quote => { out.push('\\'); out.push(other); }
            other => out.push(other),
        }
    }
    out
}

fn percent_encode(bytes: &[u8]) -> String {
    let mut out = String::new();
    for byte in bytes {
        match *byte {
            b'A'..=b'Z' | b'a'..=b'z' | b'0'..=b'9' | b'-' | b'_' | b'.' | b':' => out.push(char::from(*byte)),
            other => out.push_str(&format!("%{:02X}", other)),
        }
    }
    out
}

fn percent_decode(value: &str) -> Option<String> {
    let bytes = value.as_bytes();
    let mut out = Vec::new();
    let mut i = 0usize;
    while i < bytes.len() {
        if bytes[i] == b'%' {
            if i + 2 >= bytes.len() { return None; }
            out.push((hex(bytes[i + 1])? << 4) | hex(bytes[i + 2])?);
            i += 3;
        } else {
            out.push(bytes[i]);
            i += 1;
        }
    }
    String::from_utf8(out).ok()
}

fn hex(value: u8) -> Option<u8> {
    match value {
        b'0'..=b'9' => Some(value - b'0'),
        b'a'..=b'f' => Some(value - b'a' + 10),
        b'A'..=b'F' => Some(value - b'A' + 10),
        _ => None,
    }
}
