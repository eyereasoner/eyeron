#[path = "support/examples.rs"]
mod examples;

use std::collections::BTreeMap;
use std::sync::{Arc, Barrier, atomic::{AtomicUsize, Ordering}};

fn check(name: &str) -> Result<usize, String> {
    match name {
        "error" => Err("failed case".into()),
        "panic" => panic!("failed worker"),
        _ => Ok(name.len()),
    }
}

#[test]
fn parallel_cases_report_every_success_error_and_panicked_worker_once() {
    let names = ["first", "error", "second", "panic", "last"];
    let mut outcomes = BTreeMap::new();
    examples::run_cases(names.iter().map(|name| name.to_string()).collect(), 2, check, |name, outcome, _| {
        assert!(outcomes.insert(name, outcome).is_none(), "case ran twice");
    });
    assert_eq!(outcomes.len(), names.len());
    assert_eq!(outcomes["first"], Ok(5));
    assert_eq!(outcomes["second"], Ok(6));
    assert_eq!(outcomes["last"], Ok(4));
    assert_eq!(outcomes["error"], Err("failed case".into()));
    assert!(outcomes["panic"].as_ref().unwrap_err().contains("terminated without reporting"));
}

#[test]
fn one_worker_preserves_source_order() {
    let names = vec!["second".to_string(), "first".to_string()];
    let mut completed = Vec::new();
    examples::run_cases(names.clone(), 1, check, |name, _, _| completed.push(name));
    assert_eq!(completed, names);
}

#[test]
fn two_cases_can_run_at_the_same_time() {
    // A barrier requires two checks to overlap; a sequential scheduler would
    // hit the per-case timeout instead of silently passing this test.
    static BARRIER: std::sync::OnceLock<Arc<Barrier>> = std::sync::OnceLock::new();
    static COMPLETED: AtomicUsize = AtomicUsize::new(0);
    fn concurrent(_: &str) -> Result<(), String> {
        BARRIER.get().unwrap().wait();
        COMPLETED.fetch_add(1, Ordering::SeqCst);
        Ok(())
    }
    BARRIER.set(Arc::new(Barrier::new(2))).unwrap();
    examples::run_cases(vec!["a".into(), "b".into()], 2, concurrent, |_, outcome, _| outcome.unwrap());
    assert_eq!(COMPLETED.load(Ordering::SeqCst), 2);
}

#[cfg(unix)]
mod totals {
    use std::{fs, path::{Path, PathBuf}, process::{Command, Output}};

    struct Fixture(PathBuf);

    impl Fixture {
        fn new() -> Self {
            let stamp = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).unwrap().as_nanos();
            let root = std::env::temp_dir().join(format!("eyeron-test-totals-{}-{stamp}", std::process::id()));
            fs::create_dir_all(root.join("scripts")).unwrap();
            for name in ["test-runner", "test-rustdoc", "test-summary", "test-counts.awk"] {
                fs::copy(Path::new(env!("CARGO_MANIFEST_DIR")).join("scripts").join(name), root.join("scripts").join(name)).unwrap();
            }
            Self(root)
        }

        fn write(&self, name: &str, text: &str) -> PathBuf {
            let path = self.0.join(name);
            fs::write(&path, text).unwrap();
            path
        }

        fn cargo(&self, body: &str, subcommand: &str) -> Output {
            self.write("suite", "printf '\\ntest result: ok. %s passed; 0 failed; finished in 0.01s\\n' \"$1\"\nexit \"${2:-0}\"\n");
            let cargo = self.write("cargo", body);
            Command::new("bash").arg(cargo).arg(subcommand).current_dir(&self.0)
                .env("EYERON_TEST_SUMMARY", "1").output().unwrap()
        }
    }

    impl Drop for Fixture {
        fn drop(&mut self) { fs::remove_dir_all(&self.0).unwrap(); }
    }

    fn stdout(output: &Output) -> String { String::from_utf8(output.stdout.clone()).unwrap() }

    #[test]
    fn direct_cargo_totals_accumulate_suites_and_reset_for_each_invocation() {
        let fixture = Fixture::new();
        for _ in 0..2 {
            let output = fixture.cargo("bash scripts/test-runner bash suite 2\nbash scripts/test-runner bash suite 3\n", "test");
            assert!(output.status.success(), "{}", String::from_utf8_lossy(&output.stderr));
            let text = stdout(&output);
            let totals: Vec<_> = text.lines().filter(|line| line.starts_with("Tests:")).collect();
            assert_eq!(totals.len(), 2, "{text}");
            assert!(totals[0].starts_with("Tests: 2 run; 100.0% OK;"), "{text}");
            assert!(totals[1].starts_with("Tests: 5 run; 100.0% OK;"), "{text}");
            assert!(totals[1].ends_with("s total"), "{text}");
        }
    }

    #[test]
    fn cargo_run_is_unchanged_and_test_failure_status_survives_later_suites() {
        let fixture = Fixture::new();
        let output = fixture.cargo("bash scripts/test-runner bash suite 2\n", "run");
        assert!(output.status.success());
        assert!(!stdout(&output).contains("Tests:"));
        let output = fixture.cargo("bash scripts/test-runner bash suite 2 7\nstatus=$?\nbash scripts/test-runner bash suite 3\nexit \"$status\"\n", "test");
        assert_eq!(output.status.code(), Some(7));
        assert!(stdout(&output).contains("Tests: 5 run; 100.0% OK;"));
        assert!(stdout(&output).trim_end().ends_with("(FAILED)"));
    }

    #[test]
    fn summary_counts_conformance_cases_once_and_names_crashed_suites() {
        let fixture = Fixture::new();
        let log = fixture.write("output", "Running unit\ntest result: FAILED. 1 passed; 1 failed; finished in 0.01s\nRunning n3\nnotation3tests score: 87.5% (7/8), unsupported:1 in 0.01s\ntest result: ok. 1 passed; 0 failed; finished in 0.01s\nRunning rdf\nw3c cases: 9 run; 9 OK\ntest result: ok. 13 passed; 0 failed; finished in 0.01s\nRunning crashed\n");
        let output = Command::new("bash").arg(fixture.0.join("scripts/test-summary")).arg(log).args(["101", "1.25"]).output().unwrap();
        assert!(output.status.success());
        let text = stdout(&output);
        assert!(text.contains("Tests: 19 run; 94.7% OK; 1.25s total (FAILED)"), "{text}");
        assert!(text.contains("No result (not counted): crashed"), "{text}");
    }

    #[test]
    fn doctest_results_are_included_in_the_same_cargo_total() {
        use std::os::unix::fs::PermissionsExt;
        let fixture = Fixture::new();
        let rustdoc = fixture.write("rustdoc", "#!/usr/bin/env bash\nprintf '\\ntest result: ok. 3 passed; 0 failed; finished in 0.01s\\n'\n");
        fs::set_permissions(rustdoc, fs::Permissions::from_mode(0o755)).unwrap();
        let output = fixture.cargo("bash scripts/test-runner bash suite 2\nPATH=\"$PWD:$PATH\" bash scripts/test-rustdoc --test src/lib.rs\n", "test");
        assert!(output.status.success(), "{}", String::from_utf8_lossy(&output.stderr));
        assert!(stdout(&output).contains("Tests: 5 run; 100.0% OK;"), "{}", stdout(&output));
    }
}
