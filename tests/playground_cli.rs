use eyeron::cli::run_browser_request;
use serde_json::{Value, json};
use std::fs;
use std::io::{ErrorKind, Write};
use std::process::{Command, Stdio};

fn compare(args: &[&str], stdin: &str, proof: Option<(&str, &str)>) -> String {
    let mut native = Command::new(env!("CARGO_BIN_EXE_eyeron"))
        .args(args).stdin(Stdio::piped()).stdout(Stdio::piped()).stderr(Stdio::piped())
        .spawn().unwrap();
    // Invalid options, help, and version can exit before reading any input.
    if let Err(error) = native.stdin.take().unwrap().write_all(stdin.as_bytes()) {
        assert_eq!(error.kind(), ErrorKind::BrokenPipe, "writing CLI stdin: {error}");
    }
    let native = native.wait_with_output().unwrap();
    let sources = args.iter().filter_map(|name| {
        if *name == "-" {
            Some(json!({ "name": name, "text": stdin }))
        } else if fs::metadata(name).is_ok() {
            Some(json!({ "name": name, "text": fs::read_to_string(name).unwrap(),
                "baseIri": format!("file://{}", fs::canonicalize(name).unwrap().display()) }))
        } else { None }
    }).collect::<Vec<_>>();
    let mut request = json!({ "args": args, "sources": sources });
    if let Some((name, text)) = proof {
        request["proof"] = json!({ "name": name, "text": text });
    }
    let mut output = String::new();
    let result = run_browser_request(&request.to_string(), &mut |text| { output.push_str(text); Ok(()) });
    assert_eq!(result["exitCode"], native.status.code().unwrap(), "{args:?}: {result}");
    assert_eq!(result["ok"], native.status.success(), "{args:?}");
    assert_eq!(result["stderr"], String::from_utf8(native.stderr).unwrap(), "{args:?}");
    assert_eq!(output, String::from_utf8(native.stdout).unwrap(), "{args:?}");
    output
}

#[test]
fn browser_modes_match_native_output_and_exit_status() {
    for args in [
        vec!["examples/socrates.n3"],
        vec!["-a", "examples/socrates.n3"],
        vec!["--proof", "examples/socrates.n3"],
        vec!["--proof-comments", "examples/socrates.n3"],
        vec!["-c", "examples/socrates.n3"],
        vec!["-r", "examples/rdf-dataset.n3", "examples/input/rdf-dataset.trig"],
        vec!["-s", "examples/socrates.n3"],
        vec!["--max-backward-depth", "0", "examples/backward.n3"],
        vec!["--max-backward-depth", "64", "examples/backward.n3"],
        vec!["--base-iri", "https://example.org/", "-a", "-"],
        vec!["examples/fuse.n3"],
        vec!["--help"],
        vec!["--version"],
    ] {
        compare(&args, "<alice> <knows> <bob> .", None);
    }
}

#[test]
fn browser_and_native_reject_invalidated_scoped_assumptions_without_check_mode() {
    for source in [
        include_str!("fixtures/scoped-consistency/negative-cycle.n3"),
        include_str!("fixtures/scoped-consistency/negative-existential-cycle.n3"),
        include_str!("fixtures/scoped-consistency/growing-collection.n3"),
    ] {
        let output = compare(&["-"], source, None);
        assert!(output.contains("# Contradiction:"), "{output}");
    }
}

#[test]
fn browser_and_native_reuse_the_existing_examiner() {
    let source = include_str!("fixtures/scoped-consistency/examiner-count.n3");
    let output = compare(&["-"], source, None);
    assert!(output.contains(":numberOfExaminers 1"), "{output}");
    assert!(!output.contains(":examiner _:"), "{output}");
    compare(&["-c", "-"], source, None);
}

#[test]
fn browser_rejects_the_same_invalid_options_and_inputs() {
    for args in [
        vec!["--max-backward-depth", "many", "-"],
        vec!["--max-backward-depth"],
        vec!["--base-iri"],
        vec!["--check-proof"],
        vec!["--unknown-option"],
        vec!["--prove-and-check", "--proof", "-"],
        vec!["--check-proof", "-", "-"],
        vec!["--stream-messages", "-"],
        vec!["--stream-messages", "--rdf", "--ast", "-"],
        vec!["--stream-messages", "--rdf", "examples/socrates.n3"],
        vec!["-r", "-"],
    ] {
        compare(&args, ":unknown :prefix :fails .", None);
    }
}

#[test]
fn browser_modes_that_exit_early_do_not_need_to_read_stdin() {
    // More than a pipe buffer forces a write to encounter an early CLI exit.
    let input = "x".repeat(1024 * 1024);
    for args in [vec!["--unknown-option", "-"], vec!["--help"], vec!["--version"]] {
        compare(&args, &input, None);
    }
}

#[test]
fn browser_checks_saved_proofs_and_rejects_a_forged_claim() {
    let generated = Command::new(env!("CARGO_BIN_EXE_eyeron")).args(["-p", "examples/socrates.n3"]).output().unwrap();
    let saved = String::from_utf8(generated.stdout).unwrap();
    let checked = compare(&["--check-proof", "-", "examples/socrates.n3"], &saved, Some(("-", &saved)));
    assert!(checked.contains("checked: 3 steps"));
    let forged = "<http://example.org/forged> <http://example.org/claim> true .";
    let invalid = compare(&["--check-proof", "-", "examples/socrates.n3"], forged, Some(("-", forged)));
    assert!(invalid.contains("invalid:"));
    assert!(!invalid.lines().any(|line| line.starts_with("checked")));
}

#[test]
fn browser_streaming_emits_independent_message_results() {
    let args = ["-r", "--stream-messages", "examples/alma-rdf-messages.n3", "tests/input/alma-rdf-messages-small.nt"];
    let output = compare(&args, "", None);
    assert!(output.contains("Young's Market Company"));

    let request = json!({ "args": ["--rdf", "--stream-messages", "rules.n3", "log.trig"],
        "sources": [
            { "name": "rules.n3", "text": "@prefix : <http://example.org/> . @prefix log: <http://www.w3.org/2000/10/swap/log#> . { ?g log:nameOf ?payload . ?payload log:includes { ?x :value ?y } } => { ?x :copy ?y } ." },
            { "name": "log.trig", "text": "VERSION \"1.2-messages\"\nPREFIX : <http://example.org/>\n:a :value 1 .\nMESSAGE\n:b :value 2 .\nMESSAGE\n" }
        ] });
    let mut chunks = Vec::new();
    let result = run_browser_request(&request.to_string(), &mut |text| { chunks.push(text.to_string()); Ok(()) });
    assert_eq!(result["exitCode"], 0, "{result}");
    assert_eq!(chunks.len(), 3); // Two messages and the trailing empty message.
    assert!(chunks[0].contains("<http://example.org/a>"));
    assert!(!chunks[1].contains("<http://example.org/a>"));
    assert!(chunks[1].contains("<http://example.org/b>"));
}

#[test]
fn separately_parsed_browser_inputs_keep_blank_node_scopes() {
    let request = json!({ "args": ["a.n3", "b.n3", "rules.n3"], "sources": [
        { "name": "a.n3", "text": "_:x <urn:p> 1 ." },
        { "name": "b.n3", "text": "_:x <urn:q> 2 ." },
        { "name": "rules.n3", "text": "{ ?x <urn:p> 1 . ?x <urn:q> 2 } => { <urn:bad> <urn:joined> true } ." }
    ] });
    let mut output = String::new();
    let result = run_browser_request(&request.to_string(), &mut |text| { output.push_str(text); Ok(()) });
    assert_eq!(result["exitCode"], 0);
    assert!(output.is_empty(), "{output}");
}

#[test]
fn malformed_browser_requests_return_errors_instead_of_panicking() {
    for request in ["not json", "{}", "{\"args\":[1]}", "{\"args\":[\"a.n3\"],\"sources\":[]}"] {
        let result: Value = run_browser_request(request, &mut |_| Ok(()));
        assert_eq!(result["exitCode"], 1);
        assert_eq!(result["ok"], false);
        assert!(result["stderr"].as_str().unwrap().starts_with("eyeron:"));
    }
}
