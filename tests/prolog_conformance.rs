//! Prolog conformance suite: one case per normative statement of
//! `docs/prolog-specification.md`.
//!
//! The cases live in `tests/prolog_conformance/cases.txt` — each one a
//! small program, the specification statement it pins (`[intent]`), and
//! either the result document it must produce (`[output]`) or a substring
//! of the error it must raise (`[error]`).
//!
//! Because the language is ISO/IEC 13211-1 Prolog rather than a local
//! invention, most of these cases can be held against an external
//! authority: `scripts/prolog-conformance` runs every case that stays
//! inside the pure subset through SWI-Prolog, GNU Prolog, SICStus and
//! Scryer as well, and reports any divergence. A failure there names a
//! disagreement with the standard, not a change of preference.
//!
//! Uses a custom harness (`harness = false`), like the other example and
//! conformance binaries, so each case prints its own progress line.

#[path = "support/report.rs"]
mod report;

use eyeron::prolog;
use report::{green, progress_line, red};
use std::collections::BTreeSet;
use std::fmt::Write as _;
use std::path::{Path, PathBuf};

fn manifest_path() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/prolog_conformance/cases.txt")
}

#[derive(Debug)]
enum Expectation {
    /// The exact result document the program must produce.
    Output(String),
    /// A substring of the error message the program must raise.
    Error(String),
}

#[derive(Debug)]
struct Case {
    name: String,
    section: String,
    intent: String,
    program: String,
    expectation: Expectation,
}

/// Parses the manifest format described in the file's own header: a `[case]`
/// line opens a case, `[section]`/`[intent]` are single-line fields, and
/// `[program]`/`[output]` collect the lines that follow them.
fn parse_cases(text: &str) -> Vec<Case> {
    let mut cases = Vec::new();
    let mut name = None::<String>;
    let mut section = String::new();
    let mut intent = String::new();
    let mut program = Vec::<&str>::new();
    let mut output = Vec::<&str>::new();
    let mut error = None::<String>;
    let mut field = "";

    let finish = |name: &mut Option<String>,
                  section: &mut String,
                  intent: &mut String,
                  program: &mut Vec<&str>,
                  output: &mut Vec<&str>,
                  error: &mut Option<String>,
                  cases: &mut Vec<Case>| {
        let Some(name) = name.take() else { return };
        let trim = |lines: &mut Vec<&str>| {
            while lines.last().is_some_and(|line| line.trim().is_empty()) {
                lines.pop();
            }
            let joined = lines.join("\n");
            lines.clear();
            joined
        };
        let program_text = trim(program);
        let output_text = trim(output);
        let expectation = match error.take() {
            Some(message) => Expectation::Error(message),
            None => Expectation::Output(output_text),
        };
        assert!(!section.is_empty(), "{name}: missing [section]");
        assert!(!intent.is_empty(), "{name}: missing [intent]");
        assert!(!program_text.is_empty(), "{name}: missing [program]");
        cases.push(Case {
            name,
            section: std::mem::take(section),
            intent: std::mem::take(intent),
            program: program_text,
            expectation,
        });
    };

    for line in text.lines() {
        if let Some(rest) = line.strip_prefix("[case] ") {
            finish(&mut name, &mut section, &mut intent, &mut program, &mut output, &mut error, &mut cases);
            name = Some(rest.trim().to_string());
            field = "";
            continue;
        }
        if name.is_none() {
            continue; // file header
        }
        if let Some(rest) = line.strip_prefix("[section] ") {
            section = rest.trim().to_string();
        } else if let Some(rest) = line.strip_prefix("[intent] ") {
            intent = rest.trim().to_string();
        } else if line.starts_with("[program]") {
            field = "program";
        } else if line.starts_with("[output]") {
            field = "output";
        } else if let Some(rest) = line.strip_prefix("[error]") {
            error = Some(rest.trim().to_string());
            field = "";
        } else if field == "program" {
            program.push(line);
        } else if field == "output" {
            output.push(line);
        }
    }
    finish(&mut name, &mut section, &mut intent, &mut program, &mut output, &mut error, &mut cases);
    cases
}

fn check(case: &Case) -> Result<(), String> {
    let run = prolog::run(&case.program, prolog::Limits::default());
    match (&case.expectation, run) {
        (Expectation::Output(expected), Ok(result)) => {
            let actual = prolog::output::format_result(&result, false);
            if actual.trim_end() == expected.trim_end() {
                Ok(())
            } else {
                Err(format!(
                    "{}: result document differs\n  intent: {}\n  expected:\n{}\n  actual:\n{}",
                    case.name,
                    case.intent,
                    indent(expected),
                    indent(&actual)
                ))
            }
        }
        (Expectation::Output(_), Err(err)) => {
            Err(format!("{}: expected a result document, got error {:?}\n  intent: {}", case.name, err.message, case.intent))
        }
        (Expectation::Error(expected), Err(err)) => {
            if expected.is_empty() || err.message.contains(expected.as_str()) {
                Ok(())
            } else {
                Err(format!(
                    "{}: error {:?} does not contain {:?}\n  intent: {}",
                    case.name, err.message, expected, case.intent
                ))
            }
        }
        (Expectation::Error(expected), Ok(result)) => Err(format!(
            "{}: expected an error containing {:?}, but the program completed\n  intent: {}\n  actual:\n{}",
            case.name,
            expected,
            case.intent,
            indent(&prolog::output::format_result(&result, false))
        )),
    }
}

fn indent(text: &str) -> String {
    let mut out = String::new();
    for line in text.lines() {
        let _ = writeln!(out, "    {line}");
    }
    out
}

/// Guards against a case quietly losing its coverage: every section of the
/// specification that defines behavior must still be exercised, and the
/// expectations must stay balanced between documents and errors.
fn every_specification_section_is_covered(cases: &[Case]) {
    let covered: BTreeSet<&str> = cases.iter().map(|case| case.section.as_str()).collect();
    for section in ["2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "14", "15"] {
        assert!(covered.contains(section), "no conformance case covers specification section {section}");
    }
    let names: BTreeSet<&str> = cases.iter().map(|case| case.name.as_str()).collect();
    assert_eq!(names.len(), cases.len(), "duplicate case names in the manifest");
}

fn main() {
    let started = std::time::Instant::now();
    let text = std::fs::read_to_string(manifest_path()).unwrap_or_else(|err| panic!("failed to read {}: {err}", manifest_path().display()));
    let cases = parse_cases(&text);
    assert!(cases.len() >= 100, "expected an extensive suite, found {} cases", cases.len());
    every_specification_section_is_covered(&cases);

    progress_line(&format!("running {} prolog conformance cases", cases.len()));
    let mut documents = 0;
    let mut expected_errors = 0;
    for case in &cases {
        let case_started = std::time::Instant::now();
        match check(case) {
            Ok(()) => {
                match case.expectation {
                    Expectation::Output(_) => documents += 1,
                    Expectation::Error(_) => expected_errors += 1,
                }
                progress_line(&format!("§{} {} ... {} ({:.3}s)", case.section, case.name, green("ok"), case_started.elapsed().as_secs_f64()));
            }
            Err(message) => {
                progress_line(&format!("§{} {} ... {} ({:.3}s)", case.section, case.name, red("fail"), case_started.elapsed().as_secs_f64()));
                panic!("{message}");
            }
        }
    }

    let elapsed = started.elapsed().as_secs_f64();
    progress_line(&format!(
        "\nprolog_conformance result: {}. {} passed; 0 failed; finished in {elapsed:.2}s ({documents} by result document, {expected_errors} expected-error)",
        green("ok"),
        cases.len(),
    ));
}
