//! Checks every packaged proof document against the program it was
//! produced from, using `docs/proof-checking.md`'s reference
//! implementation.
//!
//! This is the suite that says what a proof is worth. It is not a golden
//! comparison: a proof that matched its golden byte for byte could still
//! be nonsense, so each document is re-checked here — every recorded
//! inference re-performed against the source rule, every premise resolved,
//! the derivation graph tested for cycles, and every claim accounted for.
//!
//! Uses a custom harness (`harness = false`), like the other example
//! suites, so each document prints its own line.

#[path = "support/report.rs"]
mod report;

use eyeron::proof::Report;
use report::{green, progress_line, red};
use std::fs;
use std::path::{Path, PathBuf};

/// Documents that do not check yet, and the defect each one exposes.
/// These are gaps in eyeron's proof *generation*, not in the checker: the
/// specification says what a valid proof must contain, and these do not
/// contain it. Removing an entry from this list is what fixing one looks
/// like.
const KNOWN_GAPS: &[(&str, &str)] = &[
    ("n3/critical-path-schedule", "records pe:unproven: the writer could not justify a premise (§7.1)"),
    ("n3/dijkstra", "records pe:unproven: the writer could not justify a premise (§7.1)"),
    ("n3/fibonacci", "records pe:unproven: the writer could not justify a premise (§7.1)"),
    ("n3/quoted-head-unquote-select", "records pe:unproven: the writer could not justify a premise (§7.1)"),
    ("n3/rdf-messages", "records pe:unproven: the writer could not justify a premise (§7.1)"),
    ("n3/rule-matching", "records pe:unproven: the writer could not justify a premise (§7.1)"),
    ("n3/wolf-goat-cabbage", "records pe:unproven: the writer could not justify a premise (§7.1)"),
    ("n3/cat-koko", "cites a rule the engine generated while reasoning, which neither the source nor the proof carries (§5.1)"),
    ("n3/derived-backward-rule", "cites a rule the engine generated while reasoning, which neither the source nor the proof carries (§5.1)"),
    ("n3/derived-backward-rule-2", "cites a rule the engine generated while reasoning, which neither the source nor the proof carries (§5.1)"),
    ("n3/derived-rule", "cites a rule the engine generated while reasoning, which neither the source nor the proof carries (§5.1)"),
    ("n3/log-not-includes", "cites a rule the engine generated while reasoning, which neither the source nor the proof carries (§5.1)"),
    ("n3/quoted-head-unquote", "cites a rule the engine generated while reasoning, which neither the source nor the proof carries (§5.1)"),
    ("srl/import-main", "cites a rule an IMPORTS directive brought in, which the source numbers differently (§5.1)"),
    ("srl/collection", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
    ("srl/collection-nesting", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
    ("srl/collections-and-blank-nodes", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
    ("srl/family-cousins", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
    ("srl/grammar", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
    ("srl/list-iterate", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
    ("srl/lists", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
    ("srl/property-paths", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
    ("srl/rdf-list", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
    ("srl/reordering", "records fewer premises than the rule has patterns: a property path or a blank-node property list is not reified (§5.1)"),
];

fn manifest_dir() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
}

fn sorted_proofs(extension: &str) -> Vec<PathBuf> {
    let mut paths: Vec<PathBuf> = fs::read_dir(manifest_dir().join("examples/proof"))
        .expect("read examples/proof")
        .filter_map(|entry| entry.ok())
        .map(|entry| entry.path())
        .filter(|path| path.extension().and_then(|e| e.to_str()) == Some(extension))
        .collect();
    paths.sort();
    paths
}

/// The program a proof was produced from, assembled the way the example
/// suites assemble it.
fn check(extension: &str, name: &str) -> Result<Report, String> {
    let examples = manifest_dir().join("examples");
    let source_path = examples.join(format!("{name}.{extension}"));
    let source = fs::read_to_string(&source_path).map_err(|e| e.to_string())?;
    let proof = fs::read_to_string(examples.join(format!("proof/{name}.{extension}"))).map_err(|e| e.to_string())?;

    match extension {
        "pl" => {
            let source = match name {
                "proof-audit" => format!("{}\n{}", fs::read_to_string(examples.join("proof/socrates.pl")).unwrap(), source),
                "rdf12-interoperability" => {
                    let quads = fs::read_to_string(examples.join("rdf12-interoperability.nq")).unwrap();
                    let facts = eyeron::prolog::rdf::parse_nquads(&quads, "d0_").unwrap();
                    format!("{}{}", eyeron::prolog::rdf::facts_to_prolog(&facts), source)
                }
                _ => source,
            };
            eyeron::proof::prolog::check_proof(&source, &proof).map_err(|e| e.message)
        }
        "srl" => eyeron::proof::srl::check_proof(&source, &proof).map_err(|e| e.message),
        _ => {
            let mut document =
                eyeron::parse_n3_with_source(&source, None, Some(&format!("{name}.n3"))).map_err(|e| e.message)?;
            let companion = examples.join(format!("input/{name}.trig"));
            if companion.exists() {
                let text = fs::read_to_string(&companion).unwrap();
                let parsed = if eyeron::is_rdf_message_log(&text) {
                    eyeron::parse_rdf_message_log(&text, None)
                } else {
                    eyeron::parse_n3_with_source(&text, None, Some(&format!("input/{name}.trig")))
                }
                .map_err(|e| e.message)?;
                document.merge(parsed);
            }
            eyeron::proof::n3::check_proof_document(&document, &proof).map_err(|e| e.message)
        }
    }
}

fn main() {
    let started = std::time::Instant::now();
    let mut passed = 0usize;
    let mut failed = 0usize;
    let mut steps = 0usize;
    let mut verified = 0usize;
    let mut trusted = 0usize;
    let mut gaps_seen: Vec<&str> = Vec::new();

    for extension in ["n3", "srl", "pl"] {
        for path in sorted_proofs(extension) {
            let name = path.file_stem().and_then(|s| s.to_str()).expect("utf8 name").to_string();
            let key = format!("{extension}/{name}");
            let expected_gap = KNOWN_GAPS.iter().find(|(entry, _)| *entry == key);
            let outcome = check(extension, &name);
            let (valid, summary) = match &outcome {
                Ok(report) => {
                    steps += report.steps;
                    verified += report.verified;
                    trusted += report.obligations.len();
                    (report.valid(), report.verdict())
                }
                Err(message) => (false, format!("could not be read: {message}")),
            };

            match (valid, expected_gap) {
                (true, None) => {
                    passed += 1;
                    progress_line(&format!("proof examples/proof/{key} ... {} ({summary})", green("ok")));
                }
                (false, Some((_, reason))) => {
                    passed += 1;
                    gaps_seen.push(reason);
                    progress_line(&format!("proof examples/proof/{key} ... {} ({reason})", green("known gap")));
                }
                (true, Some((_, reason))) => {
                    failed += 1;
                    progress_line(&format!("proof examples/proof/{key} ... {} (now checks; remove from KNOWN_GAPS: {reason})", red("fail")));
                }
                (false, None) => {
                    failed += 1;
                    progress_line(&format!("proof examples/proof/{key} ... {} ({summary})", red("fail")));
                    if let Ok(report) = &outcome {
                        for failure in report.failures.iter().take(2) {
                            progress_line(&format!("    [{}] {} -- {}", failure.condition, failure.conclusion, failure.detail));
                        }
                    }
                }
            }
        }
    }

    let elapsed = started.elapsed().as_secs_f64();
    progress_line(&format!(
        "\nproof_checking result: {}. {passed} passed; {failed} failed; finished in {elapsed:.2}s \
         ({steps} steps, {verified} verified, {trusted} trusted, {} known gaps)",
        if failed == 0 { green("ok") } else { red("FAILED") },
        gaps_seen.len(),
    ));
    assert_eq!(failed, 0, "{failed} proof document(s) did not check as expected");
}
