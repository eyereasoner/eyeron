use std::io::Write;
use std::process::{Command, Output, Stdio};

fn run(args: &[&str]) -> Output {
    Command::new(env!("CARGO_BIN_EXE_eyeron"))
        .current_dir(env!("CARGO_MANIFEST_DIR"))
        .args(args)
        .stdin(Stdio::null())
        .output()
        .expect("run eyeron")
}

fn run_with_stdin(args: &[&str], input: &[u8]) -> Output {
    let mut child = Command::new(env!("CARGO_BIN_EXE_eyeron"))
        .current_dir(env!("CARGO_MANIFEST_DIR"))
        .args(args)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .expect("run eyeron with stdin");
    child.stdin.take().unwrap().write_all(input).unwrap();
    child.wait_with_output().unwrap()
}

#[test]
fn short_and_long_commands_match_the_two_process_proof_check() {
    let source = "examples/dog-license.n3";
    let proof = run(&["-p", source]);
    assert!(
        proof.status.success(),
        "{}",
        String::from_utf8_lossy(&proof.stderr)
    );
    let separate = run_with_stdin(&["--check-proof", "-", source], &proof.stdout);
    assert!(
        separate.status.success(),
        "{}",
        String::from_utf8_lossy(&separate.stderr)
    );

    for flag in ["-c", "--prove-and-check"] {
        let combined = run(&[flag, source]);
        assert_eq!(combined.status, separate.status);
        assert_eq!(combined.stderr, separate.stderr);
        let output = String::from_utf8(combined.stdout).unwrap();
        assert!(output.starts_with("Proof: <generated>\n"), "{output}");
        assert!(output.contains("checked with obligations:"), "{output}");
        assert!(
            output.contains("Trust obligations (accepted without verifying their truth):"),
            "{output}"
        );
        // Only the proof's location differs: no intermediate document is read.
        assert_eq!(
            output.lines().skip(1).collect::<Vec<_>>(),
            String::from_utf8_lossy(&separate.stdout)
                .lines()
                .skip(1)
                .collect::<Vec<_>>()
        );
    }
}

#[test]
fn generated_proof_is_checked_with_the_input_base_iri() {
    let source = b"<alice> <kind> <Human>. { ?x <kind> <Human> } => { ?x <kind> <Mortal> }.";
    let output = run_with_stdin(&["-c", "--base-iri", "https://example.org/", "-"], source);
    assert!(
        output.status.success(),
        "{}\n{}",
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    );
    let text = String::from_utf8(output.stdout).unwrap();
    assert!(text.contains("Source program: <stdin>"), "{text}");
    assert!(
        text.contains("checked: 2 steps, 2 verified, 0 trusted"),
        "{text}"
    );
}

#[test]
fn generated_proof_is_checked_against_separately_scoped_merged_inputs() {
    let output = run(&[
        "-c",
        "examples/shared-existential.n3",
        "examples/explicit-existential-rule.n3",
    ]);
    assert!(
        output.status.success(),
        "{}\n{}",
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    );
    let text = String::from_utf8(output.stdout).unwrap();
    assert!(
        text.contains("checked with obligations: 6 steps, 5 verified, 1 trusted"),
        "{text}"
    );
}

#[test]
fn separately_checked_invalid_proof_still_returns_failure() {
    let proof = String::from_utf8(run(&["-p", "examples/socrates.n3"]).stdout)
        .unwrap()
        .replace("pe:value :Mortal", "pe:value :Immortal");
    let output = run_with_stdin(
        &["--check-proof", "-", "examples/socrates.n3"],
        proof.as_bytes(),
    );
    assert_eq!(output.status.code(), Some(1));
    let text = String::from_utf8(output.stdout).unwrap();
    assert!(text.contains("invalid: 1 failure(s)"), "{text}");
    assert!(text.contains("[C1: resolution]"), "{text}");
}

#[test]
fn prove_and_check_rejects_conflicting_modes() {
    for other in ["--ast", "--proof", "--check-proof", "--stream-messages"] {
        let mut args = vec!["-c", other];
        if other == "--check-proof" {
            args.push("-");
        }
        let output = run(&args);
        assert_eq!(output.status.code(), Some(1));
        assert!(output.stdout.is_empty());
        assert_eq!(
            String::from_utf8_lossy(&output.stderr),
            "eyeron: --prove-and-check cannot be combined with --ast, --proof, --check-proof, or --stream-messages\n"
        );
    }
}

#[test]
fn check_proof_rejects_modes_it_would_ignore() {
    for other in ["--ast", "--proof", "--stream-messages"] {
        let output = run(&["--check-proof", "-", other, "examples/socrates.n3"]);
        assert_eq!(output.status.code(), Some(1));
        assert!(output.stdout.is_empty());
        assert_eq!(
            String::from_utf8_lossy(&output.stderr),
            "eyeron: --check-proof cannot be combined with --ast, --proof, or --stream-messages\n"
        );
    }
}

struct FixtureDir(std::path::PathBuf);

impl FixtureDir {
    fn new() -> Self {
        let stamp = std::time::SystemTime::now()
            .duration_since(std::time::UNIX_EPOCH)
            .unwrap()
            .as_nanos();
        let path =
            std::env::temp_dir().join(format!("eyeron-proof-cli-{}-{stamp}", std::process::id()));
        std::fs::create_dir(&path).unwrap();
        Self(path)
    }

    fn write(&self, name: &str, text: &str) -> String {
        let path = self.0.join(name);
        std::fs::write(&path, text).unwrap();
        path.to_str().unwrap().to_string()
    }
}

impl Drop for FixtureDir {
    fn drop(&mut self) {
        std::fs::remove_dir_all(&self.0).unwrap();
    }
}

fn assert_separate_roundtrip(args: &[&str], source_stdin: Option<&[u8]>) {
    let mut generation = vec!["-p"];
    generation.extend_from_slice(args);
    let proof = match source_stdin {
        Some(input) => run_with_stdin(&generation, input),
        None => run(&generation),
    };
    assert!(
        proof.status.success(),
        "{}",
        String::from_utf8_lossy(&proof.stderr)
    );
    assert!(
        !proof.stdout.is_empty(),
        "the fixture must produce an actual proof"
    );
    let fixture = FixtureDir::new();
    let saved = fixture.write(
        "saved-proof.n3",
        std::str::from_utf8(&proof.stdout).unwrap(),
    );
    let mut checking = vec!["--check-proof", saved.as_str()];
    checking.extend_from_slice(args);
    let checked = match source_stdin {
        Some(input) => run_with_stdin(&checking, input),
        None => run(&checking),
    };
    assert!(
        checked.status.success(),
        "{}\n{}",
        String::from_utf8_lossy(&checked.stdout),
        String::from_utf8_lossy(&checked.stderr)
    );
    assert!(
        String::from_utf8_lossy(&checked.stdout).lines().any(|line| line.starts_with("checked")),
        "{}",
        String::from_utf8_lossy(&checked.stdout)
    );
}

#[test]
fn saved_proofs_use_default_file_bases_and_explicit_base_overrides() {
    let fixture = FixtureDir::new();
    let source = fixture.write(
        "relative.n3",
        "<alice> <kind> <Human>. { ?x <kind> <Human> } => { ?x <kind> <Mortal> }.",
    );
    assert_separate_roundtrip(&[&source], None);
    assert_separate_roundtrip(&["--base-iri", "https://example.org/", &source], None);
}

#[test]
fn saved_proofs_preserve_separate_quantifier_and_prefix_scopes() {
    assert_separate_roundtrip(
        &[
            "examples/shared-existential.n3",
            "examples/explicit-existential-rule.n3",
        ],
        None,
    );
    let fixture = FixtureDir::new();
    let first = fixture.write(
        "first.n3",
        "@prefix : <http://first.example/>. @forSome :x. :x :p :a. { ?s :p :a } => { ?s :q :a }.",
    );
    let second = fixture.write(
        "second.n3",
        "@prefix : <http://second.example/>. @forSome :x. :x :p :b. { ?s :p :b } => { ?s :q :b }.",
    );
    assert_separate_roundtrip(&[&first, &second], None);
}

#[test]
fn saved_proofs_parse_rdf_formats_and_stdin_as_the_generator_does() {
    let fixture = FixtureDir::new();
    let rules = fixture.write("rules.n3", "@prefix : <http://example.org/>. @prefix log: <http://www.w3.org/2000/10/swap/log#>. { :g log:nameOf { :a :p :b } } => { :ok :holds true }.");
    let nq = fixture.write("data.nq", "<http://example.org/a> <http://example.org/p> <http://example.org/b> <http://example.org/g> .");
    let trig = fixture.write("data.trig", "<http://example.org/g> { <http://example.org/a> <http://example.org/p> <http://example.org/b> . }");
    assert_separate_roundtrip(&[&rules, &nq], None);
    assert_separate_roundtrip(&[&rules, &trig], None);
    let simple_rules = fixture.write(
        "simple.n3",
        "@prefix : <http://example.org/>. { ?s :p :b } => { ?s :q :b }.",
    );
    let data = b"@prefix : <http://example.org/>. :a :p :b.";
    assert_separate_roundtrip(&["--rdf", &simple_rules, "-"], Some(data));
    assert_separate_roundtrip(
        &["--base-iri", "https://example.org/", "-"],
        Some(b"<a> <p> <b>. { ?s <p> <b> } => { ?s <q> <b> }."),
    );
}

#[test]
fn proof_and_source_cannot_both_read_stdin() {
    for args in [
        &["--check-proof", "-"][..],
        &["--check-proof", "-", "-"][..],
    ] {
        let output = run(args);
        assert_eq!(output.status.code(), Some(1));
        assert!(String::from_utf8_lossy(&output.stderr).contains("stdin cannot supply both"));
    }
}

#[test]
fn malformed_proof_metadata_is_a_cli_error() {
    let proof = b"@prefix pe: <https://eyereasoner.github.io/pe#>. @prefix : <http://example.org/>. { :a :p :b } pe:fact \"source\"; pe:uses {}.";
    let output = run_with_stdin(&["--check-proof", "-", "examples/socrates.n3"], proof);
    assert_eq!(output.status.code(), Some(1));
    assert!(output.stdout.is_empty());
    assert!(String::from_utf8_lossy(&output.stderr).contains("exactly one premise triple"));
}

#[test]
fn inconsistent_scoped_inference_fails_in_every_output_mode() {
    for source in [
        include_str!("fixtures/scoped-consistency/negative-cycle.n3"),
        include_str!("fixtures/scoped-consistency/negative-existential-cycle.n3"),
        include_str!("fixtures/scoped-consistency/examiner-count.n3"),
    ] {
        for flags in [&["-"][..], &["-p", "-"], &["-c", "-"]] {
            let output = run_with_stdin(flags, source.as_bytes());
            assert_eq!(output.status.code(), Some(65), "{flags:?}: {output:?}");
            let report = String::from_utf8(output.stdout).unwrap();
            assert!(report.contains("# Contradiction:"), "{report}");
            assert!(report.lines().all(|line| line.starts_with('#')), "{report}");
        }
        let fixture = FixtureDir::new();
        let path = fixture.write("inconsistent.n3", source);
        let output = run(&["--rdf", &path]);
        assert_eq!(output.status.code(), Some(65), "{output:?}");
        assert!(String::from_utf8_lossy(&output.stdout).contains("# Contradiction:"));
    }
}
