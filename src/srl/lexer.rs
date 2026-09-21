//! Lexer for SPARQL 1.2 RL ("SRL") concrete syntax.
//!
//! This is a separate, dedicated lexer rather than an extension of
//! `crate::lexer` (the N3 lexer). N3's word-reading is greedy and does not
//! break on the characters SRL needs as standalone property-path
//! operators — `/`, `^`, `|`, `*`, `+`, `?`
//! (`crate::lexer`'s `read_word` only stops at whitespace, a
//! narrow set of punctuation, `<`, `>`, and `=` — see its doc comments).
//! Teaching the shared lexer a second dialect would risk regressions in the
//! N3/RDF-1.2 conformance suites that already pass against it, so SRL gets
//! its own small, self-contained tokenizer instead. IRI, string, and number
//! reading below intentionally mirror `crate::lexer`'s so the two dialects
//! agree on literal syntax.

use crate::error::{EyeronError, Result};

#[derive(Debug, Clone, PartialEq)]
pub enum TokenKind {
    Iri(String),
    /// A prefixed name or bare word, e.g. `foaf:knows`, `RULE`, `a`.
    /// Keyword recognition happens in the parser (matching on the exact
    /// text), the same way `crate::lexer` treats most keywords as ordinary
    /// `PName`s.
    Word(String),
    Var(String),
    Blank(String),
    /// `true`/`false`.
    Boolean(bool),
    String(String),
    /// A `"""long"""`/`'''long'''` string, distinguished because it may
    /// legally contain unescaped newlines.
    StringLong(String),
    Number(String),
    Dot,
    Semicolon,
    Comma,
    Pipe,
    LBrace,
    RBrace,
    LBracket,
    RBracket,
    LParen,
    RParen,
    /// `<<(`
    LTripleTerm,
    /// `)>>`
    RTripleTerm,
    /// `<<`
    LTriple,
    /// `>>`
    RTriple,
    /// `{|`
    LAnnotation,
    /// `|}`
    RAnnotation,
    HatHat,
    Assign,
    NotEq,
    Le,
    Ge,
    AndAnd,
    OrOr,
    Eq,
    Lt,
    Gt,
    Plus,
    Minus,
    Star,
    Slash,
    Bang,
    Caret,
    Tilde,
    /// A bare `?`, i.e. one that does not start a variable name — the
    /// zero-or-one property-path modifier.
    Question,
    Lang(String),
    Eof,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Token {
    pub kind: TokenKind,
    pub offset: usize,
}

pub fn lex(input: &str) -> Result<Vec<Token>> {
    let mut lx = Lexer { input, pos: 0, tokens: Vec::new() };
    lx.run()?;
    Ok(lx.tokens)
}

struct Lexer<'a> {
    input: &'a str,
    pos: usize,
    tokens: Vec<Token>,
}

const PUNCT_CHARS: &str = "{}()[].,;|";
const OPERATOR_CHARS: &str = "=<>+-*/!^~";

impl<'a> Lexer<'a> {
    fn run(&mut self) -> Result<()> {
        loop {
            self.skip_ws_and_comments();
            let offset = self.pos;
            let Some(ch) = self.peek() else {
                self.tokens.push(Token { kind: TokenKind::Eof, offset });
                return Ok(());
            };

            if self.starts_with("<<(") {
                self.bump_n(3);
                self.push(TokenKind::LTripleTerm, offset);
                continue;
            }
            if self.starts_with(")>>") {
                self.bump_n(3);
                self.push(TokenKind::RTripleTerm, offset);
                continue;
            }
            if self.starts_with("<<") {
                self.bump_n(2);
                self.push(TokenKind::LTriple, offset);
                continue;
            }
            if self.starts_with(">>") {
                self.bump_n(2);
                self.push(TokenKind::RTriple, offset);
                continue;
            }
            if self.starts_with("{|") {
                self.bump_n(2);
                self.push(TokenKind::LAnnotation, offset);
                continue;
            }
            if self.starts_with("|}") {
                self.bump_n(2);
                self.push(TokenKind::RAnnotation, offset);
                continue;
            }

            if ch == '<' && self.looks_like_iri() {
                self.read_iri()?;
                continue;
            }

            if (ch == '"' && self.starts_with("\"\"\"")) || (ch == '\'' && self.starts_with("'''")) {
                self.read_long_string(ch)?;
                continue;
            }
            if ch == '"' || ch == '\'' {
                self.read_short_string(ch)?;
                continue;
            }

            if ch == '@' {
                self.read_lang_tag()?;
                continue;
            }

            if ch == '?' && !self.input[self.pos + 1..].starts_with(is_var_name_char) {
                self.bump();
                self.push(TokenKind::Question, offset);
                continue;
            }

            if ch == '?' || ch == '$' {
                self.read_variable()?;
                continue;
            }

            if self.starts_numeric_literal() {
                self.read_number()?;
                continue;
            }

            let two: String = self.input[self.pos..].chars().take(2).collect();
            let two_kind = match two.as_str() {
                ":=" => Some(TokenKind::Assign),
                "!=" => Some(TokenKind::NotEq),
                "<=" => Some(TokenKind::Le),
                ">=" => Some(TokenKind::Ge),
                "&&" => Some(TokenKind::AndAnd),
                "||" => Some(TokenKind::OrOr),
                "^^" => Some(TokenKind::HatHat),
                _ => None,
            };
            if let Some(kind) = two_kind {
                self.bump_n(2);
                self.push(kind, offset);
                continue;
            }

            if PUNCT_CHARS.contains(ch) {
                self.bump();
                let kind = match ch {
                    '{' => TokenKind::LBrace,
                    '}' => TokenKind::RBrace,
                    '(' => TokenKind::LParen,
                    ')' => TokenKind::RParen,
                    '[' => TokenKind::LBracket,
                    ']' => TokenKind::RBracket,
                    '.' => TokenKind::Dot,
                    ',' => TokenKind::Comma,
                    ';' => TokenKind::Semicolon,
                    '|' => TokenKind::Pipe,
                    _ => unreachable!(),
                };
                self.push(kind, offset);
                continue;
            }

            if OPERATOR_CHARS.contains(ch) {
                self.bump();
                let kind = match ch {
                    '=' => TokenKind::Eq,
                    '<' => TokenKind::Lt,
                    '>' => TokenKind::Gt,
                    '+' => TokenKind::Plus,
                    '-' => TokenKind::Minus,
                    '*' => TokenKind::Star,
                    '/' => TokenKind::Slash,
                    '!' => TokenKind::Bang,
                    '^' => TokenKind::Caret,
                    '~' => TokenKind::Tilde,
                    _ => unreachable!(),
                };
                self.push(kind, offset);
                continue;
            }

            self.read_word()?;
        }
    }

    fn push(&mut self, kind: TokenKind, offset: usize) {
        self.tokens.push(Token { kind, offset });
    }

    fn skip_ws_and_comments(&mut self) {
        loop {
            while self.peek().is_some_and(|c| c.is_whitespace()) {
                self.bump();
            }
            if self.peek() == Some('#') {
                while let Some(c) = self.peek() {
                    self.bump();
                    if c == '\n' {
                        break;
                    }
                }
                continue;
            }
            break;
        }
    }

    fn starts_numeric_literal(&self) -> bool {
        let Some(ch) = self.peek() else { return false };
        if ch.is_ascii_digit() {
            return true;
        }
        if ch == '.' {
            return self.peek_next().is_some_and(|c| c.is_ascii_digit());
        }
        false
    }

    fn read_number(&mut self) -> Result<()> {
        let offset = self.pos;
        let mut value = String::new();
        while self.peek().is_some_and(|c| c.is_ascii_digit()) {
            value.push(self.bump().unwrap());
        }
        if self.peek() == Some('.') && self.peek_next().is_some_and(|c| c.is_ascii_digit()) {
            value.push(self.bump().unwrap());
            while self.peek().is_some_and(|c| c.is_ascii_digit()) {
                value.push(self.bump().unwrap());
            }
        }
        if matches!(self.peek(), Some('e' | 'E')) {
            let save = self.pos;
            let mut exponent = String::new();
            exponent.push(self.bump().unwrap());
            if matches!(self.peek(), Some('+' | '-')) {
                exponent.push(self.bump().unwrap());
            }
            if self.peek().is_some_and(|c| c.is_ascii_digit()) {
                while self.peek().is_some_and(|c| c.is_ascii_digit()) {
                    exponent.push(self.bump().unwrap());
                }
                value.push_str(&exponent);
            } else {
                self.pos = save;
            }
        }
        self.push(TokenKind::Number(value), offset);
        Ok(())
    }

    fn read_variable(&mut self) -> Result<()> {
        let offset = self.pos;
        self.bump(); // ? or $
        let mut name = String::new();
        while self.peek().is_some_and(is_var_name_char) {
            name.push(self.bump().unwrap());
        }
        if name.is_empty() {
            return Err(EyeronError::at("expected variable name", offset));
        }
        self.push(TokenKind::Var(name), offset);
        Ok(())
    }

    fn read_lang_tag(&mut self) -> Result<()> {
        let offset = self.pos;
        self.bump(); // @
        let mut value = String::new();
        while self.peek().is_some_and(is_lang_tag_char) {
            value.push(self.bump().unwrap());
        }
        if value.is_empty() {
            return Err(EyeronError::at("expected language tag", offset));
        }
        self.push(TokenKind::Lang(value), offset);
        Ok(())
    }

    fn looks_like_iri(&self) -> bool {
        let rest = &self.input[self.pos + 1..];
        match rest.chars().next() {
            None => return false,
            Some(c) if c.is_whitespace() || c == '=' => return false,
            _ => {}
        }
        for c in rest.chars() {
            if c == '>' {
                return true;
            }
            if c.is_whitespace() {
                return false;
            }
        }
        false
    }

    fn read_iri(&mut self) -> Result<()> {
        let offset = self.pos;
        self.bump(); // <
        let mut value = String::new();
        loop {
            let Some(ch) = self.peek() else { return Err(EyeronError::at("unterminated IRI reference", offset)) };
            if ch == '>' {
                self.bump();
                self.push(TokenKind::Iri(value), offset);
                return Ok(());
            }
            if ch == '\\' {
                self.bump();
                let Some(esc) = self.peek() else { return Err(EyeronError::at("unterminated IRI escape", offset)) };
                if esc != 'u' && esc != 'U' {
                    return Err(EyeronError::at(format!("invalid IRI escape \\{}", esc), offset));
                }
                self.bump();
                let count = if esc == 'u' { 4 } else { 8 };
                value.push(self.read_hex_escape(count, offset)?);
                continue;
            }
            value.push(ch);
            self.bump();
        }
    }

    fn read_hex_escape(&mut self, count: usize, offset: usize) -> Result<char> {
        let mut hex = String::new();
        for _ in 0..count {
            let Some(h) = self.peek() else { return Err(EyeronError::at("unterminated unicode escape", offset)) };
            hex.push(h);
            self.bump();
        }
        let code = u32::from_str_radix(&hex, 16).map_err(|_| EyeronError::at("invalid unicode escape", offset))?;
        char::from_u32(code).ok_or_else(|| EyeronError::at("invalid unicode scalar value", offset))
    }

    fn read_escape(&mut self, offset: usize) -> Result<String> {
        self.bump(); // backslash
        let Some(esc) = self.peek() else { return Err(EyeronError::at("unterminated string escape", offset)) };
        self.bump();
        Ok(match esc {
            'n' => "\n".to_string(),
            'r' => "\r".to_string(),
            't' => "\t".to_string(),
            'b' => "\u{0008}".to_string(),
            'f' => "\u{000C}".to_string(),
            '"' => "\"".to_string(),
            '\'' => "'".to_string(),
            '\\' => "\\".to_string(),
            'u' | 'U' => {
                let count = if esc == 'u' { 4 } else { 8 };
                self.read_hex_escape(count, offset)?.to_string()
            }
            other => return Err(EyeronError::at(format!("invalid string escape \\{}", other), offset)),
        })
    }

    fn read_short_string(&mut self, quote: char) -> Result<()> {
        let offset = self.pos;
        self.bump();
        let mut value = String::new();
        loop {
            let Some(ch) = self.peek() else { return Err(EyeronError::at("unterminated string literal", offset)) };
            if ch == quote {
                self.bump();
                self.push(TokenKind::String(value), offset);
                return Ok(());
            }
            if ch == '\n' || ch == '\r' {
                return Err(EyeronError::at("unterminated string literal", offset));
            }
            if ch == '\\' {
                value.push_str(&self.read_escape(offset)?);
                continue;
            }
            value.push(ch);
            self.bump();
        }
    }

    fn read_long_string(&mut self, quote: char) -> Result<()> {
        let offset = self.pos;
        self.bump_n(3);
        let close: String = std::iter::repeat_n(quote, 3).collect();
        let mut value = String::new();
        while !self.starts_with(&close) {
            let Some(ch) = self.peek() else { return Err(EyeronError::at("unterminated long string literal", offset)) };
            if ch == '\\' {
                value.push_str(&self.read_escape(offset)?);
                continue;
            }
            value.push(ch);
            self.bump();
        }
        self.bump_n(3);
        self.push(TokenKind::StringLong(value), offset);
        Ok(())
    }

    fn read_word(&mut self) -> Result<()> {
        let offset = self.pos;
        let mut word = String::new();
        while let Some(ch) = self.peek() {
            if ch == '\\' && self.peek_next().is_some() {
                word.push(ch);
                self.bump();
                word.push(self.peek().unwrap());
                self.bump();
                continue;
            }
            // `?` cannot occur in a prefixed name's local part, and ends a
            // word so that `:p?` lexes as the path `:p` plus a zero-or-one
            // modifier rather than as one name.
            if ch.is_whitespace() || ch == '?' || PUNCT_CHARS.contains(ch) || OPERATOR_CHARS.contains(ch) {
                break;
            }
            if ch == '.' {
                match self.peek_next() {
                    None => break,
                    Some(n) if n.is_whitespace() || PUNCT_CHARS.contains(n) || OPERATOR_CHARS.contains(n) => break,
                    _ => {}
                }
            }
            if ch == '#' {
                break;
            }
            word.push(ch);
            self.bump();
        }
        if word.is_empty() {
            return Err(EyeronError::at(format!("unexpected character {:?}", self.peek()), offset));
        }
        let kind = match word.as_str() {
            "true" => TokenKind::Boolean(true),
            "false" => TokenKind::Boolean(false),
            _ => TokenKind::Word(word),
        };
        self.push(kind, offset);
        Ok(())
    }

    fn starts_with(&self, s: &str) -> bool {
        self.input[self.pos..].starts_with(s)
    }

    fn peek(&self) -> Option<char> {
        self.input[self.pos..].chars().next()
    }

    fn peek_next(&self) -> Option<char> {
        let mut it = self.input[self.pos..].chars();
        it.next()?;
        it.next()
    }

    fn bump(&mut self) -> Option<char> {
        let ch = self.peek()?;
        self.pos += ch.len_utf8();
        Some(ch)
    }

    fn bump_n(&mut self, n: usize) {
        for _ in 0..n {
            self.bump();
        }
    }
}

fn is_var_name_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
}

fn is_lang_tag_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '-'
}

#[cfg(test)]
mod tests {
    use super::*;

    fn kinds(src: &str) -> Vec<TokenKind> {
        lex(src).unwrap().into_iter().map(|t| t.kind).collect()
    }

    #[test]
    fn keywords_lex_as_words() {
        assert_eq!(
            kinds("RULE WHERE DATA FILTER SET NOT PREFIX BASE VERSION IMPORTS AS"),
            vec![
                TokenKind::Word("RULE".into()),
                TokenKind::Word("WHERE".into()),
                TokenKind::Word("DATA".into()),
                TokenKind::Word("FILTER".into()),
                TokenKind::Word("SET".into()),
                TokenKind::Word("NOT".into()),
                TokenKind::Word("PREFIX".into()),
                TokenKind::Word("BASE".into()),
                TokenKind::Word("VERSION".into()),
                TokenKind::Word("IMPORTS".into()),
                TokenKind::Word("AS".into()),
                TokenKind::Eof,
            ]
        );
    }

    #[test]
    fn path_operators_are_standalone() {
        assert_eq!(
            kinds(":a/:b"),
            vec![
                TokenKind::Word(":a".into()),
                TokenKind::Slash,
                TokenKind::Word(":b".into()),
                TokenKind::Eof,
            ]
        );
        assert_eq!(
            kinds("^:a"),
            vec![TokenKind::Caret, TokenKind::Word(":a".into()), TokenKind::Eof]
        );
    }

    #[test]
    fn assignment_and_comparison_operators() {
        assert_eq!(
            kinds(":= != <= >= && ||"),
            vec![
                TokenKind::Assign,
                TokenKind::NotEq,
                TokenKind::Le,
                TokenKind::Ge,
                TokenKind::AndAnd,
                TokenKind::OrOr,
                TokenKind::Eof,
            ]
        );
    }

    #[test]
    fn rdf_star_punctuation() {
        assert_eq!(
            kinds("<<( :s :p :o )>> << :s :p :o >> {| :ann 1 |}"),
            vec![
                TokenKind::LTripleTerm,
                TokenKind::Word(":s".into()),
                TokenKind::Word(":p".into()),
                TokenKind::Word(":o".into()),
                TokenKind::RTripleTerm,
                TokenKind::LTriple,
                TokenKind::Word(":s".into()),
                TokenKind::Word(":p".into()),
                TokenKind::Word(":o".into()),
                TokenKind::RTriple,
                TokenKind::LAnnotation,
                TokenKind::Word(":ann".into()),
                TokenKind::Number("1".into()),
                TokenKind::RAnnotation,
                TokenKind::Eof,
            ]
        );
    }

    #[test]
    fn iri_and_variable() {
        assert_eq!(
            kinds("<http://example/> ?x $y"),
            vec![
                TokenKind::Iri("http://example/".into()),
                TokenKind::Var("x".into()),
                TokenKind::Var("y".into()),
                TokenKind::Eof,
            ]
        );
    }
}
