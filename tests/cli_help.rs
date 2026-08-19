use std::process::Command;

#[test]
fn no_arguments_is_the_same_as_short_help() {
    let no_args = Command::new(env!("CARGO_BIN_EXE_eyeron"))
        .output()
        .expect("run eyeron without arguments");
    let short_help = Command::new(env!("CARGO_BIN_EXE_eyeron"))
        .arg("-h")
        .output()
        .expect("run eyeron -h");

    assert_eq!(no_args.status, short_help.status);
    assert_eq!(no_args.stdout, short_help.stdout);
    assert_eq!(no_args.stderr, short_help.stderr);
}

#[test]
fn internal_reasoning_limit_flags_are_not_accepted() {
    for flag in [
        "--max-iterations",
        "--max-match-steps",
        "--max-backward-solutions",
    ] {
        let output = Command::new(env!("CARGO_BIN_EXE_eyeron"))
            .args([flag, "1"])
            .output()
            .expect("run eyeron with removed flag");

        assert!(!output.status.success(), "{flag} should be rejected");
        assert_eq!(output.stdout, b"");
        let stderr = String::from_utf8_lossy(&output.stderr);
        assert_eq!(stderr.as_ref(), format!("eyeron: unknown option {flag}\n"));
    }
}

#[test]
fn max_backward_depth_is_a_supported_cli_option() {
    let help = Command::new(env!("CARGO_BIN_EXE_eyeron"))
        .arg("--help")
        .output()
        .expect("run eyeron --help");
    assert!(help.status.success());
    assert!(String::from_utf8_lossy(&help.stdout).contains("--max-backward-depth N"));

    let output = Command::new(env!("CARGO_BIN_EXE_eyeron"))
        .args(["--max-backward-depth", "64", "examples/socrates.n3"])
        .output()
        .expect("run eyeron with backward-depth override");
    assert!(
        output.status.success(),
        "{}",
        String::from_utf8_lossy(&output.stderr)
    );
}

#[test]
fn max_backward_depth_rejects_non_numeric_values() {
    let output = Command::new(env!("CARGO_BIN_EXE_eyeron"))
        .args(["--max-backward-depth", "many", "examples/socrates.n3"])
        .output()
        .expect("run eyeron with invalid backward-depth override");

    assert!(!output.status.success());
    assert_eq!(output.stdout, b"");
    assert_eq!(
        String::from_utf8_lossy(&output.stderr),
        "eyeron: --max-backward-depth requires a non-negative integer, got many\n"
    );
}
