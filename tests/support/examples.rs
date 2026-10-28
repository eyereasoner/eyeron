//! The packaged examples as the example and proof-checking harnesses read
//! them, used via `#[path = "support/examples.rs"] mod examples;`: which
//! examples each harness runs, how an example and its companion input are
//! parsed into one document, and how long one may take.

#![allow(dead_code)]

use eyeron::{parse_n3_with_source, Document};
use std::fs;
use std::path::{Path, PathBuf};
use std::time::Duration;

/// Top-level `.n3` examples with no golden to check output against, and
/// why: `alma-rdf-messages.n3` needs a remote, 9GB+ RDF Message Log its own
/// header comment says is deliberately not checked into the repo;
/// `collection.n3`'s entire derived output is `log:outputString` Markdown
/// decoration (headers and file links), which `support::stable_report_lines`
/// strips as noise before comparing a `.md` golden, leaving nothing
/// substantive a golden could check. Both are still parsed.
pub const PARSE_ONLY_EXAMPLES: &[&str] = &["alma-rdf-messages", "collection"];

/// Top-level `.n3` examples that derive nothing, which leaves a proof
/// nothing to record, and why. Every other example's proof is generated
/// and checked, including `deep-taxonomy-100000` and the ones whose whole
/// printed result comes from a `log:query` goal: a proof is linear in the
/// size of the derivation it explains, so none is left out for size.
pub const NO_PROOF_EXAMPLES: &[(&str, &str)] = &[
    ("check-unsafe", "deliberately derives nothing: its head variable is unsafe/unbound by design"),
    ("fuse", "it trips an inference fuse, so the run stops with nothing derived and nothing to prove"),
    ("liar", "it trips an inference fuse, so the run stops with nothing derived and nothing to prove"),
    ("variable-predicate-dependency", "its negative cycle invalidates an absence assumption and trips an inference fuse"),
];

pub fn manifest_dir() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
}

pub fn sorted_n3_files(directory: &Path) -> Vec<PathBuf> {
    let mut files = fs::read_dir(directory)
        .unwrap_or_else(|err| panic!("failed to read {}: {err}", directory.display()))
        .map(|entry| entry.unwrap_or_else(|err| panic!("failed to read {} entry: {err}", directory.display())).path())
        .filter(|path| path.is_file() && path.extension().and_then(|ext| ext.to_str()) == Some("n3"))
        .collect::<Vec<_>>();
    files.sort();
    files
}

pub fn read(path: &Path) -> String {
    fs::read_to_string(path).unwrap_or_else(|err| panic!("failed to read {}: {}", path.display(), err))
}

/// Parses an example together with its `examples/input/<name>.n3` or
/// `.trig` companion, when it has one, into the document the reasoner sees.
pub fn parse_document(source_path: &Path, name: &str) -> Document {
    let source = read(source_path);
    let label = source_path.to_string_lossy();
    let mut doc = parse_n3_with_source(&source, None, Some(label.as_ref()))
        .unwrap_or_else(|err| panic!("example {} is not valid N3: {}", source_path.display(), err));

    // A companion input is N3 when it is named `.n3` -- an eyeron proof
    // document is one, and reading it as RDF would reject its quoted formulas
    // -- and otherwise a `.trig` the reader below works out.
    let mut input_path = manifest_dir().join("examples/input").join(format!("{name}.n3"));
    if !input_path.exists() {
        input_path = manifest_dir().join("examples/input").join(format!("{name}.trig"));
    }
    if input_path.exists() {
        let input = read(&input_path);
        // A `.trig` companion is either an RDF Message Log or real TriG with
        // named graphs; an `.n3` one parses as N3 either way.
        let input_label = input_path.to_string_lossy();
        let parsed = if eyeron::is_rdf_message_log(&input) {
            eyeron::parse_rdf_message_log(&input, None)
        } else {
            parse_n3_with_source(&input, None, Some(input_label.as_ref()))
                .or_else(|_| eyeron::parse_rdf12(&input, None, eyeron::RdfFormat::Trig))
        }
        .unwrap_or_else(|err| panic!("failed to parse {}: {}", input_path.display(), err));
        doc.merge(parsed);
    }
    doc
}

/// How long one example may take. A CI runner measures about four times
/// slower than a developer machine here, so an example needs its limit set
/// against that, not against the local number.
pub fn example_timeout(name: &str) -> Duration {
    if name == "kaprekar-6174" {
        // Searches every 4-digit number for its Kaprekar chain, and proves
        // all 10,000 of them. The remaining gap with eyeling is the seven
        // unrolled chain rules, each re-joined by the agenda for every one
        // of the 10,000 kap:step facts; that is worth closing, not a reason
        // to leave the example out.
        Duration::from_secs(240)
    } else if name.starts_with("deep-taxonomy-")
        || name.starts_with("rdf-message-")
        || name == "dining-philosophers"
        // Takeuchi's function, checked with a proof: about 1.5s here.
        || name == "takeuchi"
        // Proving its answer means re-deriving it: the fact comes from a
        // backward rule with 2,000 premises, and nothing forward-chained it,
        // so the proof walk has to run that search again. About 7.7s here.
        || name == "relational-cube-lookup"
    {
        Duration::from_secs(90)
    } else {
        Duration::from_secs(30)
    }
}

/// Runs `work` for example `name` on a worker thread with a large stack, so
/// a rule set that stops making progress fails on a timeout instead of
/// hanging the suite.
pub fn run_with_timeout<T: Send + 'static>(name: &str, work: impl FnOnce() -> Result<T, String> + Send + 'static) -> Result<T, String> {
    let (tx, rx) = std::sync::mpsc::channel();
    std::thread::Builder::new()
        .name(format!("example-{name}"))
        .stack_size(16 * 1024 * 1024)
        .spawn(move || { let _ = tx.send(work()); })
        .expect("spawn example worker");
    let timeout = example_timeout(name);
    match rx.recv_timeout(timeout) {
        Ok(outcome) => outcome,
        Err(std::sync::mpsc::RecvTimeoutError::Timeout) => {
            Err(format!("{name} exceeded the {:.0}s per-example limit", timeout.as_secs_f64()))
        }
        Err(std::sync::mpsc::RecvTimeoutError::Disconnected) => {
            Err(format!("{name} worker terminated without reporting a result"))
        }
    }
}
