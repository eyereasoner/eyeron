#[path = "support/golden_n3.rs"]
mod golden_n3;
#[path = "support/report.rs"]
mod report;

use eyeron::{parse_n3, parse_n3_with_source, proof_to_n3, reason_document, ReasonerOptions};
use golden_n3::check_golden_documents;
use report::{green, progress_line, red};
use std::collections::BTreeMap;
use std::fs;
use std::path::{Path, PathBuf};

/// Top-level `.n3` examples with no golden to check output against, and
/// why: `alma-rdf-messages.n3` needs a remote, 9GB+ RDF Message Log its own
/// header comment says is deliberately not checked into the repo;
/// `collection.n3`'s entire derived output is `log:outputString` Markdown
/// decoration (headers and file links), which `support::stable_report_lines`
/// strips as noise before comparing a `.md` golden, leaving nothing
/// substantive a golden could check. Both are still parsed by
/// `every_top_level_n3_example_parses`.
const PARSE_ONLY_EXAMPLES: &[&str] = &["alma-rdf-messages", "collection"];

/// Top-level `.n3` examples that get neither an `examples/proof/` golden
/// nor a documented reason from `PARSE_ONLY_EXAMPLES`, and why not.
/// `n3::proof::proof_to_n3` walks each derived fact's dependency tree
/// independently per fact — no sharing of already-explained ancestors
/// across different top-level facts, unlike `srl::proof::proof_to_srl`'s
/// blank-node-id-deduplicated `DATA` block — so a rule set whose derived
/// facts recurse deeply enough (every pair of a transitive closure, every
/// step of a long taxonomy chain) produces a proof many orders of
/// magnitude bigger than its plain output; not a useful artifact to check
/// into git regardless of the underlying cause.
const NO_PROOF_EXAMPLES: &[(&str, &str)] = &[
    ("check-unsafe", "deliberately derives nothing: its head variable is unsafe/unbound by design"),
    ("monoid-identity-uniqueness", "its printed result comes from a log:query goal, not a forward-derived fact --proof tracks"),
    (
        "proof-audit",
        "its companion input (examples/input/proof-audit.trig) is itself an N3 proof document with quoted formulas, which the CLI's second positional file argument parses in RDF-only mode and rejects",
    ),
    ("deep-taxonomy-100", "quadratic per-fact proof cost; only deep-taxonomy-10 stays small enough to check in"),
    ("deep-taxonomy-1000", "quadratic per-fact proof cost; only deep-taxonomy-10 stays small enough to check in"),
    ("deep-taxonomy-10000", "quadratic per-fact proof cost; only deep-taxonomy-10 stays small enough to check in"),
    ("deep-taxonomy-100000", "quadratic per-fact proof cost; only deep-taxonomy-10 stays small enough to check in"),
    ("dining-philosophers", "quadratic per-fact proof cost: over 1,000,000 lines"),
    ("transitive-closure", "quadratic per-fact proof cost: over 5,000,000 lines"),
    ("rdf-message-cold-chain-recall", "quadratic per-fact proof cost: over 100,000 lines"),
    ("rdf-message-ldes-incremental", "quadratic per-fact proof cost: over 90,000 lines"),
];

fn main() {
    let started = std::time::Instant::now();
    proof_goldens_are_valid_n3_documents();
    every_proof_golden_has_a_source_that_generates_a_valid_proof();
    selected_proof_examples_match_eyeling_style_goldens();
    every_eligible_n3_example_has_a_proof_golden();
    every_top_level_n3_example_parses();
    let golden_checked = all_packaged_example_goldens_match_expected_lines();
    let total = every_n3_example_is_accounted_for(golden_checked);

    let parse_only = PARSE_ONLY_EXAMPLES.len();
    let elapsed = started.elapsed().as_secs_f64();
    progress_line(&format!(
        "\nn3 result: {}. {total} passed; 0 failed; finished in {elapsed:.2}s ({golden_checked} by golden match, {parse_only} parse-only)",
        green("ok"),
    ));
}

/// Guards against a top-level `.n3` example silently getting neither a
/// golden check nor a documented reason why not, by requiring every file to
/// be exactly one or the other. Returns the total example count so the
/// summary line can report every example as checked, not just the ones a
/// golden covers.
fn every_n3_example_is_accounted_for(golden_checked: usize) -> usize {
    let examples_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("examples");
    let total = sorted_n3_files(&examples_dir, "examples").len();
    assert_eq!(
        total,
        golden_checked + PARSE_ONLY_EXAMPLES.len(),
        "expected every one of the {total} top-level .n3 examples to either match a golden ({golden_checked} did) or be listed in PARSE_ONLY_EXAMPLES ({} are); update whichever list is out of date",
        PARSE_ONLY_EXAMPLES.len()
    );
    total
}

fn proof_goldens_are_valid_n3_documents() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let proof_dir = root.join("examples/proof");
    assert!(proof_dir.exists(), "examples/proof directory is missing");

    let files = sorted_n3_files(&proof_dir, "examples/proof");
    assert!(
        !files.is_empty(),
        "no proof goldens found in examples/proof"
    );

    for path in files {
        let source = read(&path);
        parse_n3(&source, None).unwrap_or_else(|err| {
            panic!(
                "proof golden {} is not parseable N3: {}",
                path.display(),
                err
            )
        });
    }
}

/// As `parse_n3_with_source`, but also merges in `examples/input/{name}.trig`
/// when present — the same companion-input mechanism
/// `all_packaged_example_goldens_match_expected_lines`/`run_golden_case`
/// use for plain-output goldens, needed here too now that
/// `examples/proof/` covers examples (the `rdf-message-*` ones) that
/// derive nothing without their companion data.
fn effective_n3_document(name: &str, source_path: &Path) -> eyeron::Document {
    let source = read(source_path);
    let label = source_path.to_string_lossy();
    let mut doc = parse_n3_with_source(&source, None, Some(label.as_ref())).unwrap_or_else(|err| panic!("failed to parse {}: {}", source_path.display(), err));
    let input_path = Path::new(env!("CARGO_MANIFEST_DIR")).join("examples/input").join(format!("{name}.trig"));
    if input_path.exists() {
        let input = read(&input_path);
        let parsed_input = if eyeron::is_rdf_message_log(&input) {
            eyeron::parse_rdf_message_log(&input, None)
        } else {
            let input_label = input_path.to_string_lossy();
            parse_n3_with_source(&input, None, Some(input_label.as_ref()))
        }
        .unwrap_or_else(|err| panic!("failed to parse {}: {}", input_path.display(), err));
        doc.merge(parsed_input);
    }
    doc
}

fn every_proof_golden_has_a_source_that_generates_a_valid_proof() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let proof_dir = root.join("examples/proof");

    for golden_path in sorted_n3_files(&proof_dir, "examples/proof") {
        let name = golden_path
            .file_name()
            .and_then(|name| name.to_str())
            .expect("utf8 proof name");
        let source_path = root.join("examples").join(name);
        assert!(
            source_path.exists(),
            "{} has no corresponding source example",
            golden_path.display()
        );
        let stem = golden_path.file_stem().and_then(|s| s.to_str()).expect("utf8 proof stem");
        let doc = effective_n3_document(stem, &source_path);
        let result = reason_document(
            &doc,
            &ReasonerOptions {
                proof: true,
                ..ReasonerOptions::default()
            },
        );
        let proof = proof_to_n3(&doc.prefixes, &result);
        assert!(
            !proof.trim().is_empty(),
            "{} generated an empty proof",
            source_path.display()
        );
        parse_n3(&proof, None).unwrap_or_else(|err| {
            panic!(
                "generated proof for {} is not valid N3: {}\n{}",
                name, err, proof
            )
        });
    }
}

fn selected_proof_examples_match_eyeling_style_goldens() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));

    for name in ["backward", "socrates"] {
        let source_path = root.join("examples").join(format!("{name}.n3"));
        let golden_path = root.join("examples/proof").join(format!("{name}.n3"));
        let source = read(&source_path);
        let golden = read(&golden_path);
        let label = source_path.to_string_lossy();
        let doc = parse_n3_with_source(&source, None, Some(label.as_ref()))
            .unwrap_or_else(|err| panic!("failed to parse {}: {}", source_path.display(), err));
        let result = reason_document(
            &doc,
            &ReasonerOptions {
                proof: true,
                ..ReasonerOptions::default()
            },
        );
        let out = proof_to_n3(&doc.prefixes, &result);

        assert_eq!(
            normalize_proof_golden(&golden),
            normalize_proof_golden(&out),
            "proof example {name} did not match {}\nactual:\n{}",
            golden_path.display(),
            out
        );
    }
}

/// Guards against a top-level `.n3` example silently getting no
/// `examples/proof/` golden and no documented reason why not (mirroring
/// `every_n3_example_is_accounted_for`'s guard for output goldens), and
/// against a stale `NO_PROOF_EXAMPLES` entry naming a file that no longer
/// exists.
fn every_eligible_n3_example_has_a_proof_golden() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let examples_dir = root.join("examples");
    let proof_dir = root.join("examples/proof");
    let all = sorted_n3_files(&examples_dir, "examples");

    for (name, _) in NO_PROOF_EXAMPLES {
        assert!(
            all.iter().any(|p| p.file_stem().and_then(|s| s.to_str()) == Some(*name)),
            "NO_PROOF_EXAMPLES names {name:?}, which does not exist under examples/"
        );
    }

    let missing: Vec<String> = all
        .iter()
        .filter_map(|path| {
            let name = path.file_stem().and_then(|s| s.to_str()).expect("utf8 example name");
            if PARSE_ONLY_EXAMPLES.contains(&name) || NO_PROOF_EXAMPLES.iter().any(|(n, _)| *n == name) {
                return None;
            }
            (!proof_dir.join(format!("{name}.n3")).exists()).then(|| name.to_string())
        })
        .collect();
    assert!(missing.is_empty(), "packaged .n3 examples with no proof golden, PARSE_ONLY, or NO_PROOF_EXAMPLES entry: {missing:?}");
}

fn every_top_level_n3_example_parses() {
    let examples_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("examples");
    let files = sorted_n3_files(&examples_dir, "examples");
    assert!(!files.is_empty(), "no top-level N3 examples found");

    for path in files {
        let source = read(&path);
        let label = path.to_string_lossy();
        parse_n3_with_source(&source, None, Some(label.as_ref()))
            .unwrap_or_else(|err| panic!("example {} is not valid N3: {}", path.display(), err));
    }
}

fn all_packaged_example_goldens_match_expected_lines() -> usize {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let output_dir = root.join("examples/output");
    let mut by_name: BTreeMap<String, PathBuf> = BTreeMap::new();

    for entry in fs::read_dir(&output_dir).expect("examples/output directory exists") {
        let path = entry.expect("read examples/output entry").path();
        let ext = path.extension().and_then(|ext| ext.to_str());
        if !matches!(ext, Some("n3") | Some("md")) {
            continue;
        }

        let name = path
            .file_stem()
            .and_then(|stem| stem.to_str())
            .expect("utf8 example name")
            .to_string();
        let source_path = root.join("examples").join(format!("{name}.n3"));
        if !source_path.exists() {
            continue;
        }

        match by_name.get(&name) {
            Some(existing)
                if existing.extension().and_then(|ext| ext.to_str()) == Some("n3")
                    && ext == Some("md") =>
            {
                // Prefer .md goldens when both formats are present.
                by_name.insert(name, path);
            }
            None => {
                by_name.insert(name, path);
            }
            _ => {}
        }
    }

    let cases = by_name
        .into_iter()
        .map(|(name, golden_path)| {
            let source_path = root.join("examples").join(format!("{name}.n3"));
            (name, source_path, golden_path)
        })
        .collect::<Vec<_>>();
    assert!(!cases.is_empty(), "no example/golden pairs found");

    let count = cases.len();
    progress_line(&format!(
        "running {count} example{}",
        if count == 1 { "" } else { "s" }
    ));

    for (name, source_path, golden_path) in cases {
        run_golden_case(root, name, source_path, golden_path);
    }

    count
}

fn run_golden_case(root: &Path, name: String, source_path: PathBuf, golden_path: PathBuf) {
    let started = std::time::Instant::now();
    let source = read(&source_path);
    let input_path = root.join("examples/input").join(format!("{name}.trig"));
    let input = input_path.exists().then(|| read(&input_path));
    let golden = read(&golden_path);
    let golden_is_n3 = golden_path.extension().and_then(|ext| ext.to_str()) == Some("n3");

    let (tx, rx) = std::sync::mpsc::channel();
    let thread_name = name.clone();
    std::thread::Builder::new()
        .name(format!("example-{name}"))
        .stack_size(16 * 1024 * 1024)
        .spawn(move || {
            let mut sources = vec![("rules", source.as_str())];
            if let Some(input) = input.as_ref() {
                sources.push(("input", input.as_str()));
            }
            let _ = tx.send(check_golden_documents(&thread_name, sources, &golden, golden_is_n3));
        })
        .expect("spawn example golden-test worker");

    let timeout = if name.starts_with("deep-taxonomy-")
        || name.starts_with("rdf-message-")
        || name == "dining-philosophers"
    {
        std::time::Duration::from_secs(60)
    } else {
        std::time::Duration::from_secs(20)
    };

    match rx.recv_timeout(timeout) {
        Ok(Ok(())) => report_case(&name, &green("ok"), started),
        Ok(Err(msg)) => {
            report_case(&name, &red("fail"), started);
            panic!("{msg}");
        }
        Err(std::sync::mpsc::RecvTimeoutError::Timeout) => {
            report_case(&name, &red("fail"), started);
            panic!(
                "{name} exceeded the {:.0}s per-example golden-test limit after {:.3}s",
                timeout.as_secs_f64(),
                started.elapsed().as_secs_f64()
            );
        }
        Err(std::sync::mpsc::RecvTimeoutError::Disconnected) => {
            report_case(&name, &red("fail"), started);
            panic!("{name} golden-test worker terminated without reporting a result");
        }
    }
}

fn report_case(name: &str, status: &str, started: std::time::Instant) {
    progress_line(&format!(
        "example examples/{name}.n3 ... {status} ({:.3}s)",
        started.elapsed().as_secs_f64()
    ));
}

fn sorted_n3_files(directory: &Path, label: &str) -> Vec<PathBuf> {
    let mut files = fs::read_dir(directory)
        .unwrap_or_else(|err| panic!("failed to read {label}: {err}"))
        .map(|entry| {
            entry
                .unwrap_or_else(|err| panic!("failed to read {label} entry: {err}"))
                .path()
        })
        .filter(|path| {
            path.is_file() && path.extension().and_then(|ext| ext.to_str()) == Some("n3")
        })
        .collect::<Vec<_>>();
    files.sort();
    files
}

fn read(path: &Path) -> String {
    fs::read_to_string(path)
        .unwrap_or_else(|err| panic!("failed to read {}: {}", path.display(), err))
}

fn normalize_proof_golden(text: &str) -> String {
    text.replace("\r\n", "\n").trim().to_string()
}
