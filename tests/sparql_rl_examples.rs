//! Integration tests for every packaged top-level `.srl` example
//! (`examples/*.srl`) — both eyeron's own hand-written fixtures and the
//! suite ported from the sibling `eyeleng` project. This uses a custom
//! harness (`harness = false` in `Cargo.toml`, matching `tests/examples.rs`)
//! so each example prints its own progress line the same way N3 examples
//! do, instead of being folded into one opaque `#[test] ... ok` line under
//! the default libtest harness. Every example is covered by exactly one
//! of: `every_error_example_fails_with_its_expected_message`,
//! `every_nondeterministic_example_runs`, or
//! `every_example_with_a_golden_matches_by_graph_isomorphism`, and
//! `every_packaged_example_is_accounted_for` enforces that partition so a
//! new example can never silently end up untested. Golden comparison is
//! against `examples/output/*.srl` (N3/Turtle triple syntax) by
//! blank-node-aware graph isomorphism over the reasoner's structured
//! `closure` (the full inference graph: `DATA { ... }` facts plus
//! everything derived), rather than round-tripping through printed text —
//! needed because an example whose closure includes a `log:outputString`
//! fact would otherwise be rendered as plain human-readable text instead
//! of a triple (a convention shared with the N3 front end), spuriously
//! failing a text-based comparison even though the underlying facts are
//! correct. `tests/sparql_rl.rs` covers CLI flags and rule-set-level
//! behavior (content-sniffing, `--query`, stratification rejection on an
//! inline rule set) rather than packaged examples.
//!
//! `deep-taxonomy-10000.srl` and `deep-taxonomy-100000.srl` — eyeleng's own
//! two deepest taxonomy benchmarks — are packaged and covered like any
//! other example; they used to be left out because stratification and the
//! forward fixpoint were both quadratic in the rule count for a long
//! single-premise chain like this one, but `super::stratify`'s
//! `TemplateIndex` and `super::forward`'s `RuleActivation` fixed that (see
//! their doc comments), so both now finish this suite in well under the
//! `cargo test` budget.

#[path = "support/report.rs"]
mod report;

use eyeron::ast::{Literal, Term, Triple};
use eyeron::srl::{parse_sparql_rl, proof_to_srl, reason};
use eyeron::{parse_n3, ReasonerOptions};
use report::{green, progress_line, red};
use std::collections::{BTreeMap, BTreeSet};
use std::fs;
use std::path::Path;

fn manifest_dir() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
}

fn main() {
    let started = std::time::Instant::now();
    every_error_example_fails_with_its_expected_message();
    every_nondeterministic_example_runs();
    let golden_checked = every_example_with_a_golden_matches_by_graph_isomorphism();
    every_packaged_example_is_accounted_for();
    every_example_with_a_proof_golden_matches();
    every_eligible_srl_example_has_a_proof_golden();

    let expected_error = ERROR_EXAMPLES.len();
    let excluded = EXCLUDED_FOR_NONDETERMINISM.len() + EXCLUDED_FOR_MESSAGE_LOG_ENCODING.len();
    let total = golden_checked + expected_error + excluded;
    let elapsed = started.elapsed().as_secs_f64();
    progress_line(&format!(
        "\nsrl result: {}. {total} passed; 0 failed; finished in {elapsed:.2}s ({golden_checked} by golden match, {expected_error} expected-error, {excluded} excluded-nondeterministic)",
        green("ok"),
    ));
}

fn report_case(name: &str, status: &str, started: std::time::Instant) {
    progress_line(&format!("example examples/{name}.srl ... {status} ({:.3}s)", started.elapsed().as_secs_f64()));
}

fn read(path: &Path) -> String {
    fs::read_to_string(path).unwrap_or_else(|err| panic!("failed to read {}: {}", path.display(), err))
}

/// The four packaged examples that deliberately exercise rejection, and
/// the substring their error message must contain.
const ERROR_EXAMPLES: &[(&str, &str)] = &[
    ("check-unsafe", "unbound head variable"),
    ("unstratified-negation", "stratification condition violated"),
    ("variable-predicate-dependency", "stratification condition violated"),
    ("well-formedness-error", "before it is bound"),
];

/// Examples excluded from golden comparison because their output is
/// inherently non-reproducible: they call `NOW()`, `UUID()`/`STRUUID()`,
/// or an unnamed `BNODE()`, and/or resolve a relative URI against the
/// local filesystem, so no fixed golden can match every run/environment.
/// They are still exercised, just checked for successful completion
/// rather than exact output (see `every_nondeterministic_example_runs`).
const EXCLUDED_FOR_NONDETERMINISM: &[&str] = &["builtin-call-complete", "now-and-language-builtins"];

/// `rdf-messages.srl` matches its base graph's message-log encoding
/// against `eymsg:payloadTriple <<...>>` RDF-star triple terms, which is
/// eyeleng's own reference encoding; Eyeron's `parse_rdf_message_log`
/// instead asserts a payload's triples via `log:nameOf` on a quoted `{ }`
/// formula, so the rule body's pattern never matches and nothing is
/// derived. Eyeleng's own golden also embeds a random per-run
/// message-log id (`urn:eyeleng:message-log:<hex>#...`), so it could not
/// be matched byte-for-byte even if the encodings agreed. Excluded from
/// golden comparison for both reasons; still smoke-tested for successful
/// completion in `every_nondeterministic_example_runs`, with its base
/// graph loaded via `parse_rdf_message_log` (matching how `--data` would
/// content-sniff `examples/rdf-messages.trig`, despite its `.trig`
/// extension).
const EXCLUDED_FOR_MESSAGE_LOG_ENCODING: &[&str] = &["rdf-messages"];

/// Non-error, non-excluded `.srl` examples that still get no
/// `examples/proof/` golden, and why: `import-lib.srl` is a library rule
/// set meant to be pulled in by `import-main.srl`'s `IMPORTS` — it has no
/// `DATA` of its own, so nothing is ever derived to explain. Every other
/// example has a proof golden: the dependency walk `srl::proof` shares
/// with `n3::proof` is linear, so even `deep-taxonomy-100000.srl` is
/// explained in seconds.
const NO_PROOF_EXAMPLES: &[(&str, &str)] = &[
    ("import-lib", "a library rule set with no DATA of its own; nothing is ever derived"),
];

fn all_srl_example_names() -> BTreeSet<String> {
    let dir = manifest_dir().join("examples");
    fs::read_dir(&dir)
        .unwrap_or_else(|err| panic!("failed to read {}: {}", dir.display(), err))
        .filter_map(|entry| entry.ok())
        .map(|entry| entry.path())
        .filter(|path| path.extension().and_then(|ext| ext.to_str()) == Some("srl"))
        .map(|path| path.file_stem().and_then(|s| s.to_str()).expect("utf8 example name").to_string())
        .collect()
}

fn example_names() -> Vec<String> {
    let names: Vec<String> = all_srl_example_names()
        .into_iter()
        .filter(|name| !EXCLUDED_FOR_NONDETERMINISM.contains(&name.as_str()))
        .filter(|name| !EXCLUDED_FOR_MESSAGE_LOG_ENCODING.contains(&name.as_str()))
        .collect();
    names
}

fn source_for(name: &str) -> String {
    read(&manifest_dir().join("examples").join(format!("{name}.srl")))
}

fn file_base_iri(path: &Path) -> String {
    let abs = fs::canonicalize(path).unwrap_or_else(|err| panic!("failed to canonicalize {}: {}", path.display(), err));
    format!("file://{}", abs.display())
}

/// Parses `{name}.srl` and, if it has an `IMPORTS` directive, resolves and
/// merges every imported rule set (local files only, matching the ported
/// examples' own use of `IMPORTS`; see `import-main.srl`/`import-lib.srl`).
/// Always parses with source tracking (matching `main.rs`'s own `--proof`
/// path for both the top-level source and every import it resolves) so
/// `check_proof_golden` sees real `pe:rule`/`pe:fact` file:line references
/// rather than `"<unknown>"`; harmless for the plain-output checks, which
/// never look at source refs.
fn program_for(name: &str) -> eyeron::srl::SparqlRlProgram {
    let path = manifest_dir().join("examples").join(format!("{name}.srl"));
    let source = read(&path);
    let base = file_base_iri(&path);
    let label = format!("{name}.srl");
    let mut program = eyeron::srl::parse_sparql_rl_with_source(&source, Some(&base), Some(&label)).unwrap_or_else(|err| panic!("{name}: parse error: {err}"));
    let mut pending = std::mem::take(&mut program.imports);
    while let Some(target) = pending.pop() {
        let import_path = target.strip_prefix("file://").unwrap_or_else(|| panic!("{name}: unsupported import IRI {target}"));
        let import_source = read(Path::new(import_path));
        let imported = eyeron::srl::parse_sparql_rl_with_source(&import_source, Some(&target), Some(&target))
            .unwrap_or_else(|err| panic!("{name}: import parse error: {err}"));
        pending.extend(imported.imports.clone());
        eyeron::srl::merge_programs(&mut program, imported);
    }
    program
}

fn run_reported<F: FnOnce() -> Result<(), String>>(name: &str, check: F) {
    let started = std::time::Instant::now();
    match check() {
        Ok(()) => report_case(name, &green("ok"), started),
        Err(msg) => {
            report_case(name, &red("fail"), started);
            panic!("{msg}");
        }
    }
}

fn check_error_example(name: &str, expected_substring: &str) -> Result<(), String> {
    let source = source_for(name);
    let program = parse_sparql_rl(&source, None).map_err(|err| format!("{name}: unexpected parse error: {err}"))?;
    let err = match reason(&program, &[], &ReasonerOptions::default()) {
        Ok(_) => return Err(format!("{name} was expected to fail but succeeded")),
        Err(err) => err,
    };
    if err.message.to_ascii_lowercase().contains(expected_substring) {
        Ok(())
    } else {
        Err(format!("{name}: error {:?} did not contain {:?}", err.message, expected_substring))
    }
}

fn every_error_example_fails_with_its_expected_message() {
    for (name, expected_substring) in ERROR_EXAMPLES {
        run_reported(name, || check_error_example(name, expected_substring));
    }
}

fn check_golden_example(name: &str) -> Result<(), String> {
    let golden_path = manifest_dir().join("examples/output").join(format!("{name}.srl"));
    if !golden_path.exists() {
        return Err(format!("{name}: every non-error, non-excluded .srl example must have a golden, missing {}", golden_path.display()));
    }
    let program = program_for(name);
    let result = reason(&program, &[], &ReasonerOptions::default()).map_err(|err| format!("{name}: reasoning error: {err}"))?;
    if let Some(summary) = result.incomplete_summary() {
        return Err(format!("{name}: {summary:?}"));
    }

    // Golden files (ported from eyeleng's own example suite) use the
    // ruleset's own PREFIX names but do not redeclare them, so parse
    // them together with a preamble built from the parsed program's
    // own prefix map rather than as a standalone N3 document.
    let golden_text = read(&golden_path);
    let preamble: String = program.prefixes.iter().map(|(name, iri)| format!("@prefix {name}: <{iri}> .\n")).collect();
    let expected = parse_n3(&format!("{preamble}{golden_text}"), None).map_err(|err| format!("golden for {name} is not valid N3: {err}"))?.facts;

    if graphs_isomorphic(&result.closure, &expected) {
        Ok(())
    } else {
        Err(format!(
            "{name}: closure does not match its golden\nactual ({} triples):\n{}\nexpected ({} triples):\n{}",
            result.closure.len(),
            result.closure.iter().map(|t| format!("{t:?}")).collect::<Vec<_>>().join("\n"),
            expected.len(),
            expected.iter().map(|t| format!("{t:?}")).collect::<Vec<_>>().join("\n"),
        ))
    }
}

fn every_example_with_a_golden_matches_by_graph_isomorphism() -> usize {
    let mut checked = 0;
    for name in example_names() {
        if ERROR_EXAMPLES.iter().any(|(n, _)| *n == name) {
            continue;
        }
        run_reported(&name, || check_golden_example(&name));
        checked += 1;
    }
    let expected = example_names().len() - ERROR_EXAMPLES.len();
    assert_eq!(checked, expected, "expected every non-error, non-excluded .srl example ({expected}) to have a golden checked, got {checked}");
    checked
}

fn check_proof_golden(name: &str) -> Result<(), String> {
    let golden_path = manifest_dir().join("examples/proof").join(format!("{name}.srl"));
    if !golden_path.exists() {
        return Err(format!("{name}: every eligible .srl example must have a proof golden, missing {}", golden_path.display()));
    }
    let program = program_for(name);
    let result =
        reason(&program, &[], &ReasonerOptions { proof: true, ..ReasonerOptions::default() }).map_err(|err| format!("{name}: reasoning error: {err}"))?;
    if let Some(summary) = result.incomplete_summary() {
        return Err(format!("{name}: {summary:?}"));
    }
    let actual = proof_to_srl(&program.prefixes, &result);
    let expected = read(&golden_path);
    if actual == expected {
        Ok(())
    } else {
        Err(format!("{name}: proof does not match its golden\nactual:\n{actual}\nexpected:\n{expected}"))
    }
}

/// Every non-error, non-`NO_PROOF_EXAMPLES` `.srl` example's `--proof`
/// output, byte for byte against `examples/proof/<name>.srl` — the SRL
/// counterpart to `tests/eye.rs`'s own strict plain-and-proof golden
/// matching (SRL's forward reasoner, like the Prolog front end's, is fully
/// deterministic outside the already-excluded `EXCLUDED_FOR_NONDETERMINISM`/
/// `EXCLUDED_FOR_MESSAGE_LOG_ENCODING` examples, so an exact match is
/// appropriate here — unlike N3's proof goldens, most of which are only
/// checked for well-formedness because a handful legitimately embed a
/// live timestamp).
fn every_example_with_a_proof_golden_matches() {
    let mut checked = 0;
    for name in example_names() {
        if ERROR_EXAMPLES.iter().any(|(n, _)| *n == name) {
            continue;
        }
        if NO_PROOF_EXAMPLES.iter().any(|(n, _)| *n == name) {
            continue;
        }
        if let Err(msg) = check_proof_golden(&name) {
            panic!("{msg}");
        }
        checked += 1;
    }
    let expected = example_names().len() - ERROR_EXAMPLES.len() - NO_PROOF_EXAMPLES.len();
    assert_eq!(checked, expected, "expected every eligible .srl example ({expected}) to have a proof golden checked, got {checked}");
}

/// Guards against a stale `NO_PROOF_EXAMPLES` entry naming a file that no
/// longer exists, mirroring `every_packaged_example_is_accounted_for`'s
/// same guard for `ERROR_EXAMPLES`/`EXCLUDED_FOR_*`.
fn every_eligible_srl_example_has_a_proof_golden() {
    let all = all_srl_example_names();
    for (name, _) in NO_PROOF_EXAMPLES {
        assert!(all.contains(*name), "NO_PROOF_EXAMPLES names {name:?}, which does not exist under examples/");
    }
}

fn check_nondeterministic_example(name: &str) -> Result<(), String> {
    let base_graph = if EXCLUDED_FOR_MESSAGE_LOG_ENCODING.contains(&name) {
        let log_text = read(&manifest_dir().join("examples/rdf-messages.trig"));
        eyeron::parse_rdf_message_log(&log_text, None).map_err(|err| format!("failed to parse examples/rdf-messages.trig: {err}"))?.facts
    } else {
        Vec::new()
    };
    let program = program_for(name);
    let result = reason(&program, &base_graph, &ReasonerOptions::default()).map_err(|err| format!("{name}: reasoning error: {err}"))?;
    match result.incomplete_summary() {
        None => Ok(()),
        Some(summary) => Err(format!("{name}: {summary:?}")),
    }
}

fn every_nondeterministic_example_runs() {
    for name in EXCLUDED_FOR_NONDETERMINISM.iter().chain(EXCLUDED_FOR_MESSAGE_LOG_ENCODING) {
        run_reported(name, || check_nondeterministic_example(name));
    }
}

/// Guards against a packaged `.srl` example silently falling through every
/// bucket above (no golden, not an error example, not in either exclusion
/// list) and against a stale exclusion-list entry naming a file that no
/// longer exists (which is exactly how `EXCLUDED_FOR_PERFORMANCE` was
/// caught as dead code: those three example names were never actually
/// copied into `examples/`, so filtering them out of `example_names()`
/// silently filtered nothing).
fn every_packaged_example_is_accounted_for() {
    let all = all_srl_example_names();
    assert!(all.len() >= 50, "expected at least 50 packaged .srl examples on disk, found {}", all.len());

    for (name, _) in ERROR_EXAMPLES {
        assert!(all.contains(*name), "ERROR_EXAMPLES names {name:?}, which does not exist under examples/");
    }
    for name in EXCLUDED_FOR_NONDETERMINISM {
        assert!(all.contains(*name), "EXCLUDED_FOR_NONDETERMINISM names {name:?}, which does not exist under examples/");
    }
    for name in EXCLUDED_FOR_MESSAGE_LOG_ENCODING {
        assert!(all.contains(*name), "EXCLUDED_FOR_MESSAGE_LOG_ENCODING names {name:?}, which does not exist under examples/");
    }

    let unaccounted: Vec<&String> = all
        .iter()
        .filter(|name| {
            let has_golden = manifest_dir().join("examples/output").join(format!("{name}.srl")).exists();
            let is_error = ERROR_EXAMPLES.iter().any(|(n, _)| *n == name.as_str());
            let is_excluded = EXCLUDED_FOR_NONDETERMINISM.contains(&name.as_str()) || EXCLUDED_FOR_MESSAGE_LOG_ENCODING.contains(&name.as_str());
            !has_golden && !is_error && !is_excluded
        })
        .collect();
    assert!(unaccounted.is_empty(), "packaged .srl examples with no golden, error expectation, or documented exclusion: {unaccounted:?}");
}

// ---- Blank-node-aware triple-set isomorphism, duplicated (rather than
// shared) from tests/w3c_sparql_rl/runner.rs's own copy, matching this
// project's convention of independent conformance/example harnesses. ----

fn graphs_isomorphic(actual: &[Triple], expected: &[Triple]) -> bool {
    let actual = unique_triples(actual);
    let expected = unique_triples(expected);
    if actual.len() != expected.len() {
        return false;
    }
    let actual_blanks = collect_blanks(&actual);
    let expected_blanks = collect_blanks(&expected);
    if actual_blanks.len() != expected_blanks.len() {
        return false;
    }
    let expected_set: BTreeSet<String> = expected.iter().map(|t| render_triple(t, &BTreeMap::new(), false)).collect();
    if actual_blanks.is_empty() {
        return actual.iter().all(|t| expected_set.contains(&render_triple(t, &BTreeMap::new(), false)));
    }
    let mut order: Vec<String> = actual_blanks.into_iter().collect();
    order.sort();
    let candidates: Vec<String> = expected_blanks.into_iter().collect();
    search_blank_mapping(0, &order, &candidates, &mut BTreeMap::new(), &mut BTreeSet::new(), &actual, &expected_set)
}

fn unique_triples(triples: &[Triple]) -> Vec<Triple> {
    let mut seen = BTreeSet::new();
    let mut out = Vec::new();
    for t in triples {
        let key = render_triple(t, &BTreeMap::new(), false);
        if seen.insert(key) {
            out.push(t.clone());
        }
    }
    out
}

#[allow(clippy::too_many_arguments)]
fn search_blank_mapping(
    index: usize,
    order: &[String],
    candidates: &[String],
    mapping: &mut BTreeMap<String, String>,
    used: &mut BTreeSet<String>,
    actual: &[Triple],
    expected_set: &BTreeSet<String>,
) -> bool {
    if index >= order.len() {
        return actual.iter().all(|t| expected_set.contains(&render_triple(t, mapping, true)));
    }
    let a = &order[index];
    for b in candidates {
        if used.contains(b) {
            continue;
        }
        mapping.insert(a.clone(), b.clone());
        used.insert(b.clone());
        if search_blank_mapping(index + 1, order, candidates, mapping, used, actual, expected_set) {
            return true;
        }
        used.remove(b);
        mapping.remove(a);
    }
    false
}

fn collect_blanks(triples: &[Triple]) -> BTreeSet<String> {
    let mut out = BTreeSet::new();
    for t in triples {
        collect_term_blanks(&t.s, &mut out);
        collect_term_blanks(&t.p, &mut out);
        collect_term_blanks(&t.o, &mut out);
    }
    out
}

fn collect_term_blanks(term: &Term, out: &mut BTreeSet<String>) {
    match term {
        Term::Blank(id) => {
            out.insert(id.clone());
        }
        Term::Formula(triples) => triples.iter().for_each(|t| {
            collect_term_blanks(&t.s, out);
            collect_term_blanks(&t.p, out);
            collect_term_blanks(&t.o, out);
        }),
        Term::List(items) => items.iter().for_each(|t| collect_term_blanks(t, out)),
        _ => {}
    }
}

fn render_triple(t: &Triple, mapping: &BTreeMap<String, String>, require_mapping: bool) -> String {
    format!(
        "{} {} {}",
        render_term(&t.s, mapping, require_mapping).unwrap_or_default(),
        render_term(&t.p, mapping, require_mapping).unwrap_or_default(),
        render_term(&t.o, mapping, require_mapping).unwrap_or_default()
    )
}

fn render_term(term: &Term, mapping: &BTreeMap<String, String>, require_mapping: bool) -> Option<String> {
    match term {
        Term::Iri(iri) => Some(format!("<{iri}>")),
        Term::Blank(id) => match mapping.get(id) {
            Some(mapped) => Some(format!("_:{mapped}")),
            None if require_mapping => None,
            None => Some(format!("_:{id}")),
        },
        Term::Literal(Literal { value, datatype, language }) => match (datatype, language) {
            (_, Some(lang)) => Some(format!("{value:?}@{lang}")),
            (Some(dt), None) => Some(format!("{value:?}^^<{dt}>")),
            (None, None) => Some(format!("{value:?}")),
        },
        Term::List(items) => {
            let mut parts = Vec::with_capacity(items.len());
            for item in items {
                parts.push(render_term(item, mapping, require_mapping)?);
            }
            Some(format!("({})", parts.join(" ")))
        }
        Term::Formula(triples) => {
            let mut parts = Vec::with_capacity(triples.len());
            for t in triples {
                parts.push(render_triple(t, mapping, require_mapping));
            }
            Some(format!("{{{}}}", parts.join(" . ")))
        }
        Term::Var(name) => Some(format!("?{name}")),
    }
}

