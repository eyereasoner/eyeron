//! `ReasonerOptions::now` pins the clock `time:localTime` reads; an
//! unpinned run reads the wall clock once.

use eyeron::{parse_n3, reason_document, result_to_string, ReasonerOptions};

const RULE: &str = "@prefix time: <http://www.w3.org/2000/10/swap/time#>.\n\
{ \"\" time:localTime ?t } => { <urn:x> <urn:at> ?t }.\n";

#[test]
fn pinned_clock_is_reported_by_local_time() {
    let doc = parse_n3(RULE, None).unwrap();
    let options = ReasonerOptions { now: Some(1_700_000_000_123), ..ReasonerOptions::default() };
    let out = result_to_string(&doc.prefixes, &reason_document(&doc, &options).derived);
    assert!(out.contains("2023-11-14T22:13:20.123"), "{out}");
}

#[test]
fn pinned_clock_is_reproducible() {
    let doc = parse_n3(RULE, None).unwrap();
    let options = ReasonerOptions { now: Some(42_000), ..ReasonerOptions::default() };
    let a = result_to_string(&doc.prefixes, &reason_document(&doc, &options).derived);
    let b = result_to_string(&doc.prefixes, &reason_document(&doc, &options).derived);
    assert_eq!(a, b);
}

#[test]
fn an_unpinned_run_reports_one_instant() {
    // The deferred negation adds a second pass. A clock read per firing
    // would let the first rule fire again there with a later instant.
    let source = format!("{RULE}@prefix log: <http://www.w3.org/2000/10/swap/log#>.\n\
        {{ <urn:x> <urn:at> ?t. ?scope log:notIncludes {{ <urn:a> <urn:b> <urn:c> }} }} => {{ <urn:y> <urn:at> ?t }}.\n");
    let doc = parse_n3(&source, None).unwrap();
    for _ in 0..20 {
        let out = result_to_string(&doc.prefixes, &reason_document(&doc, &ReasonerOptions::default()).derived);
        assert_eq!(out.matches("<urn:x> <urn:at>").count(), 1, "{out}");
    }
}
