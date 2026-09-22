//! Tokenizer for Prolog text (ISO/IEC 13211-1 §6.4, restricted to the
//! token classes the accepted subset uses).
//!
//! Two details of the standard's tokenizer that the parser above depends
//! on are settled here rather than there: a graphic token is a *maximal*
//! run of graphic characters, so `=:=` and `\==` arrive as one token each
//! and no operator has to be reassembled; and every token records whether
//! layout text preceded it, which is how `f(x)` (functional notation) is
//! told apart from `f (x)` (an operator applied to a bracketed term), and
//! how `-1` (a negative integer) is told apart from `- 1` (the compound
//! term `-(1)`).

use num_bigint::BigInt;

use crate::error::{EyeronError, Result};

#[derive(Debug, Clone, PartialEq)]
pub enum TokenKind {
    /// `X`, `_tail`, or the anonymous `_`.
    Var(String),
    /// A name token: an identifier atom, a quoted atom, a graphic token
    /// such as `:-`, or one of the solo atoms `!` and `;`. Already decoded.
    Atom(String),
    /// A double-quoted string, already decoded.
    Str(String),
    Int(BigInt),
    Float(f64),
    LParen,
    RParen,
    LBracket,
    RBracket,
    LBrace,
    RBrace,
    Comma,
    Bar,
    /// The clause terminator: `.` followed by layout text or end of input.
    End,
    Eof,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Token {
    pub kind: TokenKind,
    pub offset: usize,
    /// True iff layout text (whitespace or a comment) came immediately
    /// before this token.
    pub spaced: bool,
}

struct Lexer<'a> {
    source: &'a str,
    bytes: &'a [u8],
    offset: usize,
}

fn is_alnum(byte: u8) -> bool {
    byte.is_ascii_alphanumeric() || byte == b'_'
}

fn is_graphic(byte: u8) -> bool {
    matches!(byte, b'#' | b'$' | b'&' | b'*' | b'+' | b'-' | b'.' | b'/' | b':' | b'<' | b'=' | b'>' | b'?' | b'@' | b'^' | b'~' | b'\\')
}

impl<'a> Lexer<'a> {
    fn at(&self, ahead: usize) -> Option<u8> {
        self.bytes.get(self.offset + ahead).copied()
    }

    /// Consume whitespace and comments; returns true iff any were present.
    fn skip_layout(&mut self) -> Result<bool> {
        let start = self.offset;
        loop {
            match self.at(0) {
                Some(c) if c.is_ascii_whitespace() => self.offset += 1,
                Some(b'%') => {
                    while self.at(0).is_some_and(|c| c != b'\n') {
                        self.offset += 1;
                    }
                }
                Some(b'/') if self.at(1) == Some(b'*') => {
                    let open = self.offset;
                    self.offset += 2;
                    loop {
                        match self.at(0) {
                            None => return Err(EyeronError::at("Unterminated block comment", open)),
                            Some(b'*') if self.at(1) == Some(b'/') => {
                                self.offset += 2;
                                break;
                            }
                            Some(_) => self.offset += 1,
                        }
                    }
                }
                _ => break,
            }
        }
        Ok(self.offset != start)
    }

    /// Decode the body of a quoted token up to its closing `quote`, applying
    /// the escape sequences of ISO/IEC 13211-1 §6.4.2.1. A doubled quote
    /// character stands for one literal quote.
    fn quoted(&mut self, quote: u8) -> Result<String> {
        let open = self.offset;
        self.offset += 1;
        let mut out = String::new();
        loop {
            let Some(c) = self.at(0) else {
                return Err(EyeronError::at("Unterminated quoted token", open));
            };
            if c == quote {
                if self.at(1) == Some(quote) {
                    out.push(quote as char);
                    self.offset += 2;
                    continue;
                }
                self.offset += 1;
                return Ok(out);
            }
            if c == b'\n' {
                return Err(EyeronError::at("Unterminated quoted token", open));
            }
            if c != b'\\' {
                let rest = &self.source[self.offset..];
                let ch = rest.chars().next().expect("offset is at a character boundary");
                out.push(ch);
                self.offset += ch.len_utf8();
                continue;
            }
            let escape = self.offset;
            self.offset += 1;
            let Some(marker) = self.at(0) else {
                return Err(EyeronError::at("Unterminated escape sequence", escape));
            };
            self.offset += 1;
            match marker {
                b'\n' => {}
                b'a' => out.push('\u{7}'),
                b'b' => out.push('\u{8}'),
                b'f' => out.push('\u{c}'),
                b'n' => out.push('\n'),
                b'r' => out.push('\r'),
                b't' => out.push('\t'),
                b'v' => out.push('\u{b}'),
                b'\\' | b'\'' | b'"' | b'`' => out.push(marker as char),
                b'x' => out.push(self.escape_code(escape, 16)?),
                b'0'..=b'7' => {
                    self.offset -= 1;
                    out.push(self.escape_code(escape, 8)?);
                }
                _ => return Err(EyeronError::at("Unknown escape sequence", escape)),
            }
        }
    }

    /// The `\xHEX\` and `\OCTAL\` escapes: digits in `radix`, closed by a
    /// mandatory `\`.
    fn escape_code(&mut self, escape: usize, radix: u32) -> Result<char> {
        let start = self.offset;
        while self.at(0).is_some_and(|c| (c as char).is_digit(radix)) {
            self.offset += 1;
        }
        if start == self.offset || self.at(0) != Some(b'\\') {
            return Err(EyeronError::at("Malformed character-code escape sequence", escape));
        }
        let digits = &self.source[start..self.offset];
        self.offset += 1;
        u32::from_str_radix(digits, radix)
            .ok()
            .and_then(char::from_u32)
            .ok_or_else(|| EyeronError::at("Character-code escape sequence is not a character", escape))
    }

    fn number(&mut self) -> Result<TokenKind> {
        let start = self.offset;
        while self.at(0).is_some_and(|c| c.is_ascii_digit()) {
            self.offset += 1;
        }
        // A fraction only counts as one when a digit follows the `.`;
        // otherwise the `.` is the clause terminator, as in `p(1).`.
        let mut is_float = false;
        if self.at(0) == Some(b'.') && self.at(1).is_some_and(|c| c.is_ascii_digit()) {
            is_float = true;
            self.offset += 1;
            while self.at(0).is_some_and(|c| c.is_ascii_digit()) {
                self.offset += 1;
            }
        }
        // ISO allows an exponent only on a term that already has a
        // fraction, so `1e10` is not a float token.
        if is_float && matches!(self.at(0), Some(b'e') | Some(b'E')) {
            let mut ahead = 1;
            if matches!(self.at(ahead), Some(b'+') | Some(b'-')) {
                ahead += 1;
            }
            if self.at(ahead).is_some_and(|c| c.is_ascii_digit()) {
                self.offset += ahead;
                while self.at(0).is_some_and(|c| c.is_ascii_digit()) {
                    self.offset += 1;
                }
            }
        }
        let text = &self.source[start..self.offset];
        if is_float {
            let value: f64 = text.parse().map_err(|_| EyeronError::at("Malformed float", start))?;
            if !value.is_finite() {
                return Err(EyeronError::at("Float must be finite", start));
            }
            Ok(TokenKind::Float(value))
        } else {
            let value: BigInt = text.parse().map_err(|_| EyeronError::at("Malformed integer", start))?;
            Ok(TokenKind::Int(value))
        }
    }

    fn next_token(&mut self) -> Result<Token> {
        let spaced = self.skip_layout()?;
        let offset = self.offset;
        let make = |kind| Token { kind, offset, spaced };
        let Some(c) = self.at(0) else {
            return Ok(make(TokenKind::Eof));
        };
        if c == b'\'' {
            return Ok(make(TokenKind::Atom(self.quoted(b'\'')?)));
        }
        if c == b'"' {
            return Ok(make(TokenKind::Str(self.quoted(b'"')?)));
        }
        if c.is_ascii_digit() {
            return Ok(make(self.number()?));
        }
        if c == b'_' || c.is_ascii_uppercase() {
            while self.at(0).is_some_and(is_alnum) {
                self.offset += 1;
            }
            return Ok(make(TokenKind::Var(self.source[offset..self.offset].to_string())));
        }
        if c.is_ascii_lowercase() {
            while self.at(0).is_some_and(is_alnum) {
                self.offset += 1;
            }
            return Ok(make(TokenKind::Atom(self.source[offset..self.offset].to_string())));
        }
        // `.` ends a clause when layout or end of input follows it;
        // otherwise it is an ordinary graphic character.
        if c == b'.' && self.at(1).map_or(true, |n| n.is_ascii_whitespace() || n == b'%') {
            self.offset += 1;
            return Ok(make(TokenKind::End));
        }
        if is_graphic(c) {
            while self.at(0).is_some_and(is_graphic) {
                self.offset += 1;
            }
            return Ok(make(TokenKind::Atom(self.source[offset..self.offset].to_string())));
        }
        self.offset += 1;
        let kind = match c {
            b'(' => TokenKind::LParen,
            b')' => TokenKind::RParen,
            b'[' => TokenKind::LBracket,
            b']' => TokenKind::RBracket,
            b'{' => TokenKind::LBrace,
            b'}' => TokenKind::RBrace,
            b',' => TokenKind::Comma,
            b'|' => TokenKind::Bar,
            b'!' => TokenKind::Atom("!".to_string()),
            b';' => TokenKind::Atom(";".to_string()),
            _ => return Err(EyeronError::at(format!("Unexpected character {:?}", c as char), offset)),
        };
        Ok(make(kind))
    }
}

pub fn tokenize(source: &str) -> Result<Vec<Token>> {
    let mut lexer = Lexer { source, bytes: source.as_bytes(), offset: 0 };
    let mut tokens = Vec::new();
    loop {
        let token = lexer.next_token()?;
        let done = token.kind == TokenKind::Eof;
        tokens.push(token);
        if done {
            return Ok(tokens);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn kinds(source: &str) -> Vec<TokenKind> {
        tokenize(source).unwrap().into_iter().map(|t| t.kind).collect()
    }

    #[test]
    fn tokenizes_a_fact() {
        assert_eq!(
            kinds("parent(alice, bob)."),
            vec![
                TokenKind::Atom("parent".into()),
                TokenKind::LParen,
                TokenKind::Atom("alice".into()),
                TokenKind::Comma,
                TokenKind::Atom("bob".into()),
                TokenKind::RParen,
                TokenKind::End,
                TokenKind::Eof,
            ]
        );
    }

    #[test]
    fn graphic_tokens_use_maximal_munch() {
        assert_eq!(kinds("X=:=Y"), vec![TokenKind::Var("X".into()), TokenKind::Atom("=:=".into()), TokenKind::Var("Y".into()), TokenKind::Eof]);
        assert_eq!(kinds("a:-b"), vec![TokenKind::Atom("a".into()), TokenKind::Atom(":-".into()), TokenKind::Atom("b".into()), TokenKind::Eof]);
    }

    #[test]
    fn skips_line_and_block_comments() {
        assert_eq!(kinds("% comment\nfoo /* inline */ bar"), vec![TokenKind::Atom("foo".into()), TokenKind::Atom("bar".into()), TokenKind::Eof]);
    }

    #[test]
    fn a_float_needs_a_fraction_before_its_exponent() {
        assert_eq!(kinds("1.5e3"), vec![TokenKind::Float(1500.0), TokenKind::Eof]);
        assert_eq!(kinds("1e3"), vec![TokenKind::Int(BigInt::from(1)), TokenKind::Atom("e3".into()), TokenKind::Eof]);
    }

    #[test]
    fn a_trailing_dot_ends_the_clause_but_a_decimal_point_does_not() {
        assert_eq!(kinds("p(1)."), vec![
            TokenKind::Atom("p".into()),
            TokenKind::LParen,
            TokenKind::Int(BigInt::from(1)),
            TokenKind::RParen,
            TokenKind::End,
            TokenKind::Eof
        ]);
        assert_eq!(kinds("1.25"), vec![TokenKind::Float(1.25), TokenKind::Eof]);
    }

    #[test]
    fn decodes_quoted_atoms_and_strings() {
        assert_eq!(kinds("'it''s'"), vec![TokenKind::Atom("it's".into()), TokenKind::Eof]);
        assert_eq!(kinds(r#""tab\there""#), vec![TokenKind::Str("tab\there".into()), TokenKind::Eof]);
        assert_eq!(kinds(r#""\x41\""#), vec![TokenKind::Str("A".into()), TokenKind::Eof]);
        assert_eq!(kinds(r#""\101\""#), vec![TokenKind::Str("A".into()), TokenKind::Eof]);
    }

    #[test]
    fn records_whether_layout_preceded_a_token() {
        let tokens = tokenize("f(x) g (y)").unwrap();
        assert!(!tokens[1].spaced, "f( is functional notation");
        assert!(tokens[5].spaced, "g ( is an atom followed by a bracketed term");
    }
}
