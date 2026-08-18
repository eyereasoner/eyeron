use super::*;

#[derive(Debug, Clone)]
pub(super) enum Expr {
    Name(String, usize),
    String(String, usize),
    List(Vec<Expr>, usize),
}

impl Expr {
    pub(super) fn offset(&self) -> usize {
        match self {
            Self::Name(_, offset) | Self::String(_, offset) | Self::List(_, offset) => *offset,
        }
    }

    pub(super) fn name(&self) -> Option<&str> {
        match self {
            Self::Name(name, _) => Some(name),
            _ => None,
        }
    }
}

#[derive(Debug, Clone)]
pub(super) struct Token {
    kind: TokenKind,
    offset: usize,
}

#[derive(Debug, Clone)]
enum TokenKind {
    Open,
    Close,
    Name(String),
    String(String),
}

pub(super) fn lex(input: &str) -> Result<Vec<Token>> {
    let bytes = input.as_bytes();
    let mut tokens = Vec::new();
    let mut i = 0usize;
    while i < bytes.len() {
        match bytes[i] {
            b if b.is_ascii_whitespace() => i += 1,
            b';' => while i < bytes.len() && bytes[i] != b'\n' { i += 1; },
            b'/' if bytes.get(i + 1) == Some(&b'*') => {
                let start = i;
                i += 2;
                let mut depth = 1usize;
                while i < bytes.len() && depth > 0 {
                    if bytes[i] == b'/' && bytes.get(i + 1) == Some(&b'*') {
                        depth += 1;
                        i += 2;
                    } else if bytes[i] == b'*' && bytes.get(i + 1) == Some(&b'/') {
                        depth -= 1;
                        i += 2;
                    } else {
                        i += 1;
                    }
                }
                if depth != 0 {
                    return Err(EyeronError::at("unterminated block comment", start));
                }
            }
            b'(' => { tokens.push(Token { kind: TokenKind::Open, offset: i }); i += 1; }
            b')' => { tokens.push(Token { kind: TokenKind::Close, offset: i }); i += 1; }
            b'\'' => {
                let (value, next) = quoted(input, i, b'\'')?;
                tokens.push(Token { kind: TokenKind::String(value), offset: i });
                i = next;
            }
            b'"' => {
                let (value, next) = quoted(input, i, b'"')?;
                tokens.push(Token { kind: TokenKind::Name(value), offset: i });
                i = next;
            }
            _ => {
                let start = i;
                while i < bytes.len()
                    && !bytes[i].is_ascii_whitespace()
                    && bytes[i] != b'('
                    && bytes[i] != b')'
                    && bytes[i] != b';'
                { i += 1; }
                tokens.push(Token {
                    kind: TokenKind::Name(input[start..i].to_string()),
                    offset: start,
                });
            }
        }
    }
    Ok(tokens)
}

fn quoted(input: &str, start: usize, quote: u8) -> Result<(String, usize)> {
    let bytes = input.as_bytes();
    let mut i = start + 1;
    let mut out = String::new();
    while i < bytes.len() {
        if bytes[i] == quote { return Ok((out, i + 1)); }
        if bytes[i] == b'\\' {
            i += 1;
            if i >= bytes.len() { return Err(EyeronError::at("unterminated escape sequence", start)); }
            out.push(match bytes[i] {
                b'n' => '\n', b'r' => '\r', b't' => '\t', b'\\' => '\\',
                b'\'' => '\'', b'"' => '"', other => char::from(other),
            });
            i += 1;
            continue;
        }
        let ch = input[i..].chars().next().ok_or_else(|| EyeronError::at("invalid UTF-8 boundary", i))?;
        out.push(ch);
        i += ch.len_utf8();
    }
    Err(EyeronError::at("unterminated quoted token", start))
}

pub(super) fn parse_expressions(tokens: &[Token]) -> Result<Vec<Expr>> {
    let mut pos = 0usize;
    let mut out = Vec::new();
    while pos < tokens.len() { out.push(parse_expression(tokens, &mut pos)?); }
    Ok(out)
}

fn parse_expression(tokens: &[Token], pos: &mut usize) -> Result<Expr> {
    let Some(token) = tokens.get(*pos) else {
        return Err(EyeronError::new("unexpected end of CLIF input"));
    };
    *pos += 1;
    match &token.kind {
        TokenKind::Name(name) => Ok(Expr::Name(name.clone(), token.offset)),
        TokenKind::String(value) => Ok(Expr::String(value.clone(), token.offset)),
        TokenKind::Close => Err(EyeronError::at("unexpected ')'", token.offset)),
        TokenKind::Open => {
            let mut items = Vec::new();
            while let Some(next) = tokens.get(*pos) {
                if matches!(next.kind, TokenKind::Close) {
                    *pos += 1;
                    return Ok(Expr::List(items, token.offset));
                }
                items.push(parse_expression(tokens, pos)?);
            }
            Err(EyeronError::at("unterminated '('", token.offset))
        }
    }
}
