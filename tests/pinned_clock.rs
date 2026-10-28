//! `ReasonerOptions::now` pins the clock `time:localTime` reads.

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
