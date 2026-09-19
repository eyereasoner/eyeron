#[path = "w3c_sparql_rl/runner.rs"]
mod runner;

use std::env;
use std::ffi::OsString;
use std::process;
use std::time::Instant;

const LABEL: &str = "w3c_sparql_rl_01_all_manifests_203_earl_report";
const EXPECTED_TOTAL: usize = 203;

fn main() {
    let args = env::args_os().skip(1).collect::<Vec<_>>();
    let config = HarnessConfig::from_args(&args);
    if config.help {
        print_help();
        return;
    }
    if config.list {
        println!("{LABEL}: test");
        return;
    }

    let run = config.matches(LABEL);
    let total_tests = usize::from(run);

    println!("running {total_tests} test{}", if total_tests == 1 { "" } else { "s" });
    if total_tests == 0 {
        println!("\ntest result: {}. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s", colour(&config, "ok", Colour::Green));
        return;
    }

    let started = Instant::now();
    let quiet_guard = QuietGuard::enable_unless_verbose(config.verbose);
    let mut passed = 0usize;
    let mut failed = 0usize;

    let expected = if runner::has_filter() { None } else { Some(EXPECTED_TOTAL) };
    match runner::run_default_suite().and_then(|counts| runner::assert_clean_counts(LABEL, &counts, expected).map(|()| counts)) {
        Ok(counts) => {
            print_result(&config, LABEL, TestOutcome::Ok, &format!("{}/{} tests + EARL report", counts.pass, counts.total));
            passed += 1;
        }
        Err(err) => {
            print_result(&config, LABEL, TestOutcome::Failed, &err);
            failed += 1;
        }
    }

    drop(quiet_guard);

    let elapsed = started.elapsed().as_secs_f64();
    let status = if failed == 0 { colour(&config, "ok", Colour::Green) } else { colour(&config, "FAILED", Colour::Red) };
    println!("\ntest result: {status}. {passed} passed; {failed} failed; 0 ignored; 0 measured; 0 filtered out; finished in {elapsed:.2}s");
    if failed > 0 {
        process::exit(1);
    }
}

#[derive(Debug)]
struct HarnessConfig {
    filters: Vec<String>,
    list: bool,
    help: bool,
    colour: ColourMode,
    verbose: bool,
}

impl HarnessConfig {
    fn from_args(args: &[OsString]) -> Self {
        let mut filters = Vec::new();
        let mut list = false;
        let mut help = false;
        let mut colour = ColourMode::Auto;
        let mut verbose = env_flag("EYERON_W3C_SPARQL_RL_VERBOSE");
        let mut i = 0;
        while i < args.len() {
            let arg = args[i].to_string_lossy();
            match arg.as_ref() {
                "--list" => list = true,
                "-h" | "--help" => help = true,
                "--nocapture" | "--show-output" | "--format" | "pretty" | "terse" | "json" => {}
                "--exact" | "--skip" | "--test-threads" | "--report-time" | "--ensure-time" => {
                    i += 1;
                }
                "--color" | "--colour" => {
                    if let Some(value) = args.get(i + 1).map(|s| s.to_string_lossy()) {
                        colour = ColourMode::from_str(&value);
                        i += 1;
                    }
                }
                "--verbose" => verbose = true,
                other if other.starts_with("--color=") => {
                    colour = ColourMode::from_str(other.trim_start_matches("--color="));
                }
                other if other.starts_with('-') => {}
                other => filters.push(other.to_string()),
            }
            i += 1;
        }
        HarnessConfig { filters, list, help, colour, verbose }
    }

    fn matches(&self, label: &str) -> bool {
        self.filters.is_empty() || self.filters.iter().any(|filter| label.contains(filter))
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum ColourMode {
    Auto,
    Always,
    Never,
}

impl ColourMode {
    fn from_str(value: &str) -> Self {
        match value {
            "always" => ColourMode::Always,
            "never" => ColourMode::Never,
            _ => ColourMode::Auto,
        }
    }
}

#[derive(Debug, Clone, Copy)]
enum Colour {
    Green,
    Red,
}

fn colour(config: &HarnessConfig, text: &str, colour: Colour) -> String {
    if !use_colour(config) {
        return text.to_string();
    }
    let code = match colour {
        Colour::Green => "32",
        Colour::Red => "31",
    };
    format!("\x1b[{code}m{text}\x1b[0m")
}

fn use_colour(config: &HarnessConfig) -> bool {
    if env::var_os("NO_COLOR").is_some() {
        return false;
    }
    match config.colour {
        ColourMode::Always => true,
        ColourMode::Never => false,
        ColourMode::Auto => env::var("CARGO_TERM_COLOR").map(|value| value != "never").unwrap_or(true),
    }
}

enum TestOutcome {
    Ok,
    Failed,
}

fn print_result(config: &HarnessConfig, label: &str, outcome: TestOutcome, detail: &str) {
    match outcome {
        TestOutcome::Ok => println!("test {label} ... {} ({detail})", colour(config, "ok", Colour::Green)),
        TestOutcome::Failed => println!("test {label} ... {}\n    {detail}", colour(config, "FAILED", Colour::Red)),
    }
}

struct QuietGuard {
    previous: Option<OsString>,
    changed: bool,
}

impl QuietGuard {
    fn enable_unless_verbose(verbose: bool) -> Self {
        if verbose {
            return QuietGuard { previous: None, changed: false };
        }
        let previous = env::var_os("EYERON_W3C_SPARQL_RL_QUIET");
        env::set_var("EYERON_W3C_SPARQL_RL_QUIET", "1");
        QuietGuard { previous, changed: true }
    }
}

impl Drop for QuietGuard {
    fn drop(&mut self) {
        if !self.changed {
            return;
        }
        if let Some(previous) = self.previous.take() {
            env::set_var("EYERON_W3C_SPARQL_RL_QUIET", previous);
        } else {
            env::remove_var("EYERON_W3C_SPARQL_RL_QUIET");
        }
    }
}

fn print_help() {
    println!("Custom W3C SPARQL 1.2 RL conformance harness for Eyeron");
    println!();
    println!("Usage:");
    println!("  cargo test --release --test w3c_sparql_rl");
    println!();
    println!("The harness prints a libtest-style line with a coloured ok/FAILED status word.");
    println!("It always fetches {} live (no local vendored mirror yet).", runner::DEFAULT_MANIFEST);
    println!();
    println!("Useful environment variables:");
    println!("  EYERON_W3C_SPARQL_RL_VERBOSE=1   show runner progress in addition to the harness line");
    println!("  EYERON_W3C_SPARQL_RL_FILTER=txt  filter cases inside the manifest (by name/type/ruleset path)");
    println!("  EYERON_W3C_SPARQL_RL_EARL=PATH   choose the EARL report output path");
}

fn env_flag(name: &str) -> bool {
    env::var(name).map(|value| matches!(value.as_str(), "1" | "true" | "TRUE" | "yes" | "YES" | "on" | "ON")).unwrap_or(false)
}
