//! Progress-line printing and color helpers shared by every `harness =
//! false` test binary (see `Cargo.toml`), so each one can report its own
//! per-case lines (`example examples/foo.n3 ... ok (0.001s)`) the same way,
//! independent of the default libtest harness's own `test foo ... ok`
//! reporting and output capturing.

pub fn progress_line(message: &str) {
    use std::io::Write;

    let line = format!("{message}\n");
    #[cfg(unix)]
    {
        if let Ok(mut stderr) = std::fs::OpenOptions::new().write(true).open("/dev/stderr") {
            let _ = stderr.write_all(line.as_bytes());
            let _ = stderr.flush();
            return;
        }
    }
    eprint!("{line}");
}

fn colour_enabled() -> bool {
    use std::io::IsTerminal;

    if std::env::var_os("NO_COLOR").is_some() {
        return false;
    }
    match std::env::var("CARGO_TERM_COLOR").as_deref() {
        Ok("always") => true,
        Ok("never") => false,
        _ => std::io::stderr().is_terminal(),
    }
}

pub fn green(text: &str) -> String {
    if colour_enabled() { format!("\x1b[32m{text}\x1b[0m") } else { text.to_string() }
}

pub fn red(text: &str) -> String {
    if colour_enabled() { format!("\x1b[31m{text}\x1b[0m") } else { text.to_string() }
}
