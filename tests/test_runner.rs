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
