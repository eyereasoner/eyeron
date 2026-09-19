//! Tokenizer for Eyelang concrete syntax, mirroring `parser.js`'s single
//! hand-rolled regex tokenizer.

use crate::error::{EyeronError, Result};

#[derive(Debug, Clone, PartialEq)]
pub enum TokenKind {
    /// `?name` (name without the leading `?`); `?_` and bare `_` both
    /// denote the anonymous variable, handled by the parser.
    Var(String),
    /// A bare identifier; keyword recognition (`ask`/`if`/`not`/`let`/
    /// `collect`/`where`/`true`/`false`) happens in the parser.
    Word(String),
    /// Raw text between (and including) the surrounding double quotes,
    /// still JSON-escaped; the parser decodes it.
    Str(String),
    /// Raw digits, optionally with a `.` fractional part and/or an
    /// exponent; the parser decides integer vs. float from the text shape.
    Number(String),
    LParen,
    RParen,
    LBracket,
    RBracket,
    LBrace,
    RBrace,
    Comma,
    Dot,
    Pipe,
    Eq,
    NotEq,
    Le,
    Ge,
    Lt,
    Gt,
    Plus,
    Minus,
    Star,
    Slash,
    SlashSlash,
    Percent,
    Eof,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Token {
    pub kind: TokenKind,
    pub offset: usize,
}

pub fn tokenize(source: &str) -> Result<Vec<Token>> {
    let bytes = source.as_bytes();
    let mut tokens = Vec::new();
    let mut offset = 0usize;
    while offset < bytes.len() {
        let ch = bytes[offset];
        if ch.is_ascii_whitespace() {
            offset += 1;
            continue;
        }
        if ch == b'#' {
            while offset < bytes.len() && bytes[offset] != b'\n' {
                offset += 1;
            }
            continue;
        }
        let start = offset;
        if ch == b'"' {
            offset += 1;
            let mut escaped = false;
            loop {
                if offset >= bytes.len() {
                    return Err(EyeronError::at("Unterminated string", start));
                }
                let c = bytes[offset];
                if c == b'\n' || c == b'\r' {
                    return Err(EyeronError::at("Unterminated string", start));
                }
                offset += 1;
                if escaped {
                    escaped = false;
                    continue;
                }
                if c == b'\\' {
                    escaped = true;
                    continue;
                }
                if c == b'"' {
                    break;
                }
            }
            tokens.push(Token { kind: TokenKind::Str(source[start..offset].to_string()), offset: start });
            continue;
        }
        if ch == b'?' {
            offset += 1;
            let name_start = offset;
            while offset < bytes.len() && (bytes[offset].is_ascii_alphanumeric() || bytes[offset] == b'_') {
                offset += 1;
            }
            if offset == name_start {
                return Err(EyeronError::at("Expected a variable name after '?'", start));
            }
            tokens.push(Token { kind: TokenKind::Var(source[name_start..offset].to_string()), offset: start });
            continue;
        }
        if ch.is_ascii_alphabetic() || ch == b'_' {
            while offset < bytes.len() && (bytes[offset].is_ascii_alphanumeric() || bytes[offset] == b'_') {
                offset += 1;
            }
            tokens.push(Token { kind: TokenKind::Word(source[start..offset].to_string()), offset: start });
            continue;
        }
        if ch.is_ascii_digit() {
            while offset < bytes.len() && bytes[offset].is_ascii_digit() {
                offset += 1;
            }
            if offset + 1 < bytes.len() && bytes[offset] == b'.' && bytes[offset + 1].is_ascii_digit() {
                offset += 1;
                while offset < bytes.len() && bytes[offset].is_ascii_digit() {
                    offset += 1;
                }
            }
            if offset < bytes.len() && (bytes[offset] == b'e' || bytes[offset] == b'E') {
                let mut lookahead = offset + 1;
                if lookahead < bytes.len() && (bytes[lookahead] == b'+' || bytes[lookahead] == b'-') {
                    lookahead += 1;
                }
                if lookahead < bytes.len() && bytes[lookahead].is_ascii_digit() {
                    offset = lookahead;
                    while offset < bytes.len() && bytes[offset].is_ascii_digit() {
                        offset += 1;
                    }
                }
            }
            tokens.push(Token { kind: TokenKind::Number(source[start..offset].to_string()), offset: start });
            continue;
        }
        let two = if offset + 1 < bytes.len() { &source[offset..offset + 2] } else { "" };
        let (kind, len) = match two {
            "!=" => (TokenKind::NotEq, 2),
            "<=" => (TokenKind::Le, 2),
            ">=" => (TokenKind::Ge, 2),
            "//" => (TokenKind::SlashSlash, 2),
            _ => match ch {
                b'(' => (TokenKind::LParen, 1),
                b')' => (TokenKind::RParen, 1),
                b'[' => (TokenKind::LBracket, 1),
                b']' => (TokenKind::RBracket, 1),
                b'{' => (TokenKind::LBrace, 1),
                b'}' => (TokenKind::RBrace, 1),
                b',' => (TokenKind::Comma, 1),
                b'.' => (TokenKind::Dot, 1),
                b'|' => (TokenKind::Pipe, 1),
                b'=' => (TokenKind::Eq, 1),
                b'+' => (TokenKind::Plus, 1),
                b'*' => (TokenKind::Star, 1),
                b'/' => (TokenKind::Slash, 1),
                b'%' => (TokenKind::Percent, 1),
                b'<' => (TokenKind::Lt, 1),
                b'>' => (TokenKind::Gt, 1),
                b'-' => (TokenKind::Minus, 1),
                _ => return Err(EyeronError::at(format!("Unexpected character {:?}", ch as char), start)),
            },
        };
        tokens.push(Token { kind, offset: start });
        offset += len;
    }
    tokens.push(Token { kind: TokenKind::Eof, offset: bytes.len() });
    Ok(tokens)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn kinds(source: &str) -> Vec<TokenKind> {
        tokenize(source).unwrap().into_iter().map(|t| t.kind).collect()
    }

    #[test]
    fn tokenizes_a_simple_fact() {
        assert_eq!(
            kinds("parent(alice, bob)."),
            vec![
                TokenKind::Word("parent".into()),
                TokenKind::LParen,
                TokenKind::Word("alice".into()),
                TokenKind::Comma,
                TokenKind::Word("bob".into()),
                TokenKind::RParen,
                TokenKind::Dot,
                TokenKind::Eof,
            ]
        );
    }

    #[test]
    fn tokenizes_var_and_number_and_string() {
        assert_eq!(
            kinds("?x != 3.5"),
            vec![TokenKind::Var("x".into()), TokenKind::NotEq, TokenKind::Number("3.5".into()), TokenKind::Eof]
        );
        assert_eq!(kinds("\"hi\\n\""), vec![TokenKind::Str("\"hi\\n\"".into()), TokenKind::Eof]);
    }

    #[test]
    fn skips_comments() {
        assert_eq!(kinds("# comment\nfoo"), vec![TokenKind::Word("foo".into()), TokenKind::Eof]);
    }

    #[test]
    fn integer_division_is_two_slashes() {
        assert_eq!(kinds("1 // 2"), vec![TokenKind::Number("1".into()), TokenKind::SlashSlash, TokenKind::Number("2".into()), TokenKind::Eof]);
    }
}
