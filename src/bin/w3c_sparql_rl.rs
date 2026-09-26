//! Rust-only W3C SPARQL 1.2 RL manifest runner for Eyeron.
//!
//! Modeled on `src/bin/w3c_rdf.rs`, but scoped down to the much simpler
//! SPARQL-RL manifest vocabulary: no quads, no entailment regimes, no RDFS
//! closure computation. Fetches the live W3C manifest over the network
//! (eyeleng's own conformance tool, `tools/w3c-sparql-rl.js`, does the
//! same — there is no local vendored mirror of this suite yet; that is a
//! documented follow-up, see the README).
//!
//! The manifest has seven test categories, given by the `rdf:type` of each
//! entry: `RulesPositiveSyntaxTest`/`RulesNegativeSyntaxTest` (does
//! `parse_sparql_rl` accept/reject the `.srl` file), `RulesPositive-
//! /RulesNegativeWellFormednessTest` (does `check_rule_well_formed`
//! accept/reject it), `RulesPositive-/RulesNegativeStratificationTest`
//! (does `stratify` accept/reject it), and `RulesEvalTest` (run the rule
//! set — `srlt:ruleset` — forward over an external base graph —
//! `srlt:data`, via `--data`'s semantics — and compare the resulting
//! *inference graph* — `program.data` plus everything derived, i.e.
//! `ReasonerResult::closure`, not `::derived` — against `mf:result` by
//! graph isomorphism).

use eyeron::ast::{Literal, Term, Triple};
use eyeron::srl::{self, SparqlRlProgram};
use eyeron::{parse_rdf12, Document, RdfFormat};
use std::collections::{BTreeMap, BTreeSet, HashMap};
use std::env;
use std::fs;
use std::path::{Path, PathBuf};
use std::time::Instant;

const MF_ENTRIES: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#entries";
const MF_INCLUDE: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#include";
const MF_NAME: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#name";
const MF_ACTION: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#action";
const MF_RESULT: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#result";
const RDF_TYPE: &str = "http://www.w3.org/1999/02/22-rdf-syntax-ns#type";
const SRLT: &str = "http://www.w3.org/ns/sparql-rl-tests#";
const SRLT_RULESET: &str = "http://www.w3.org/ns/sparql-rl-tests#ruleset";
const SRLT_DATA: &str = "http://www.w3.org/ns/sparql-rl-tests#data";

const DEFAULT_MANIFEST: &str = "https://w3c.github.io/data-shapes/shacl12-test-suite/tests/sparql-rl/manifest-sparql-rl.ttl";

#[derive(Debug, Default)]
struct Options {
    resource: Option<String>,
    output: PathBuf,
    no_report: bool,
    earl_stdout: bool,
    json: bool,
    quiet: bool,
    filter: Option<String>,
}

#[derive(Debug, Clone)]
struct ManifestCase {
    name: String,
    types: Vec<String>,
    /// The rule set to load: either `mf:action`'s IRI directly (syntax /
    /// well-formedness / stratification tests) or `srlt:ruleset` from the
    /// `mf:action` blank node (eval tests).
    ruleset: String,
    /// `srlt:data` from an eval test's `mf:action` blank node: an external
    /// RDF document forming the immutable base graph.
    data: Option<String>,
    /// `mf:result`: the expected derived-facts graph, for eval tests.
    result: Option<String>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum CaseKind {
    PositiveSyntax,
    NegativeSyntax,
    PositiveWellFormed,
    NegativeWellFormed,
    PositiveStratification,
    NegativeStratification,
    Eval,
    Unknown,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Status {
    Pass,
    Fail,
    Skip,
}

#[derive(Debug, Clone)]
struct CaseResult {
    case: ManifestCase,
    status: Status,
    message: String,
    duration_ms: u128,
}

#[derive(Debug, Default, Clone)]
struct Counts {
    total: usize,
    pass: usize,
    fail: usize,
    skip: usize,
}

struct Runner {
    cache: HashMap<String, String>,
}

fn main() {
    if let Err(err) = run() {
        eprintln!("w3c_sparql_rl: {err}");
        std::process::exit(2);
    }
}

fn run() -> Result<(), String> {
    let opt = parse_args(env::args().skip(1).collect())?;
    let resource = opt.resource.clone().unwrap_or_else(|| DEFAULT_MANIFEST.to_string());

    let mut runner = Runner { cache: HashMap::new() };
    let started = Instant::now();
    if !opt.quiet {
        eprintln!("== W3C SPARQL-RL manifest: {resource}");
    }
    let mut seen = BTreeSet::new();
    let cases = runner.load_manifest_recursive(&resource, &mut seen)?;

    let mut results = Vec::new();
    for (idx, case) in cases.into_iter().enumerate() {
        if let Some(filter) = &opt.filter {
            let hay = format!("{} {} {}", case.name, case.types.join(" "), case.ruleset);
            if !hay.contains(filter) {
                continue;
            }
        }
        let item = runner.run_case(case);
        if !opt.quiet {
            eprintln!("{}", format_progress_line(&item, idx));
        }
        results.push(item);
    }
    let duration_ms = started.elapsed().as_millis();
    let counts = total_counts(&results);

    let earl = to_earl(&results);
    if !opt.no_report {
        if let Some(parent) = opt.output.parent() {
            fs::create_dir_all(parent).map_err(|e| e.to_string())?;
        }
        fs::write(&opt.output, format!("{earl}\n")).map_err(|e| format!("failed to write {}: {e}", opt.output.display()))?;
        if !opt.quiet {
            eprintln!("EARL report: {}", opt.output.display());
        }
    }
    if opt.earl_stdout {
        println!("{earl}");
    } else if opt.json {
        print_json_summary(&counts, duration_ms);
    } else {
        println!("{} {}/{} tests passed ({} ms)", if counts.fail == 0 { "OK" } else { "FAIL" }, counts.pass, counts.total, duration_ms);
        if counts.skip > 0 {
            println!("{} skipped", counts.skip);
        }
    }
    if counts.fail > 0 {
        std::process::exit(1);
    }
    Ok(())
}

fn parse_args(args: Vec<String>) -> Result<Options, String> {
    let mut opt = Options { output: PathBuf::from("reports/w3c-sparql-rl-earl.ttl"), ..Options::default() };
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "-h" | "--help" => {
                print_help();
                std::process::exit(0);
            }
            "--quiet" => opt.quiet = true,
            "--json" => opt.json = true,
            "--earl" => opt.earl_stdout = true,
            "--no-report" => opt.no_report = true,
            "--output" => {
                i += 1;
                let value = args.get(i).ok_or_else(|| "--output requires a path".to_string())?;
                opt.output = PathBuf::from(value);
            }
            "--filter" => {
                i += 1;
                let value = args.get(i).ok_or_else(|| "--filter requires text".to_string())?;
                opt.filter = Some(value.clone());
            }
            other if other.starts_with('-') => return Err(format!("unknown option: {other}")),
            resource => opt.resource = Some(resource.to_string()),
        }
        i += 1;
    }
    Ok(opt)
}

fn print_help() {
    println!("Rust-only W3C SPARQL 1.2 RL manifest runner for Eyeron");
    println!();
    println!("Usage:");
    println!("  cargo run --release --bin w3c_sparql_rl -- [options] [manifest-url-or-path]");
    println!();
    println!("By default, runs {DEFAULT_MANIFEST} and writes reports/w3c-sparql-rl-earl.ttl.");
    println!();
    println!("Options:");
    println!("  --filter TEXT     Only run cases whose name/type/ruleset path contains TEXT");
    println!("  --output PATH     EARL report path (default reports/w3c-sparql-rl-earl.ttl)");
    println!("  --no-report       Do not write an EARL report file");
    println!("  --earl            Print the EARL report to stdout");
    println!("  --json            Print a JSON summary instead of plain text");
    println!("  --quiet           Suppress per-manifest and per-case progress lines");
    println!("  -h, --help        Show this help");
}

impl Runner {
    fn load_manifest_recursive(&mut self, resource: &str, seen: &mut BTreeSet<String>) -> Result<Vec<ManifestCase>, String> {
        let resource = normalize_resource(resource);
        if !seen.insert(resource.clone()) {
            return Ok(Vec::new());
        }
        let text = self.read_resource(&resource)?;
        let doc = parse_rdf12(&text, Some(&resource), RdfFormat::Turtle).map_err(|err| format!("failed to parse manifest {resource}: {err}"))?;
        let mut cases = manifest_cases(&doc, &resource)?;
        for include in manifest_includes(&doc, &resource) {
            cases.extend(self.load_manifest_recursive(&include, seen)?);
        }
        Ok(cases)
    }

    fn read_resource(&mut self, resource: &str) -> Result<String, String> {
        if let Some(cached) = self.cache.get(resource) {
            return Ok(cached.clone());
        }
        let text = if is_url(resource) {
            ureq::get(resource).call().map_err(|err| format!("failed to fetch {resource}: {err}"))?.into_body().read_to_string().map_err(|err| format!("failed to read response from {resource}: {err}"))?
        } else {
            fs::read_to_string(resource).map_err(|err| format!("failed to read {resource}: {err}"))?
        };
        self.cache.insert(resource.to_string(), text.clone());
        Ok(text)
    }

    fn read_ruleset(&mut self, path: &str) -> Result<(String, SparqlRlProgram), String> {
        let text = self.read_resource(path)?;
        let program = srl::parse_sparql_rl(&text, Some(path)).map_err(|err| err.with_source_location(&text, path))?;
        Ok((text, program))
    }

    fn read_data(&mut self, path: &str) -> Result<Document, String> {
        let text = self.read_resource(path)?;
        let format = format_from_extension(path).unwrap_or(RdfFormat::Turtle);
        parse_rdf12(&text, Some(path), format).map_err(|err| err.with_source_location(&text, path))
    }

    fn run_case(&mut self, case: ManifestCase) -> CaseResult {
        let start = Instant::now();
        let outcome = self.run_case_inner(&case);
        let duration_ms = start.elapsed().as_millis();
        match outcome {
            Ok((status, message)) => CaseResult { case, status, message, duration_ms },
            Err(message) => CaseResult { case, status: Status::Fail, message, duration_ms },
        }
    }

    fn run_case_inner(&mut self, case: &ManifestCase) -> Result<(Status, String), String> {
        match case_kind(&case.types) {
            CaseKind::PositiveSyntax => match self.read_ruleset(&case.ruleset) {
                Ok(_) => Ok((Status::Pass, "accepted as expected".to_string())),
                Err(err) => Err(err),
            },
            CaseKind::NegativeSyntax => match self.read_ruleset(&case.ruleset) {
                Ok(_) => Err("negative syntax test was accepted".to_string()),
                Err(err) => Ok((Status::Pass, format!("rejected as expected: {err}"))),
            },
            CaseKind::PositiveWellFormed => {
                let (_, program) = self.read_ruleset(&case.ruleset)?;
                for (i, rule) in program.rules.iter().enumerate() {
                    srl::check_rule_well_formed(rule, i).map_err(|err| err.to_string())?;
                }
                Ok((Status::Pass, "accepted as well-formed".to_string()))
            }
            CaseKind::NegativeWellFormed => {
                let (_, program) = self.read_ruleset(&case.ruleset)?;
                let mut errors = Vec::new();
                for (i, rule) in program.rules.iter().enumerate() {
                    if let Err(err) = srl::check_rule_well_formed(rule, i) {
                        errors.push(err.to_string());
                    }
                }
                if errors.is_empty() {
                    Err("negative well-formedness test was accepted".to_string())
                } else {
                    Ok((Status::Pass, format!("rejected as expected: {}", errors.join("; "))))
                }
            }
            CaseKind::PositiveStratification => {
                let (_, program) = self.read_ruleset(&case.ruleset)?;
                srl::stratify(&program.rules).map_err(|err| err.to_string())?;
                Ok((Status::Pass, "stratified as expected".to_string()))
            }
            CaseKind::NegativeStratification => {
                let (_, program) = self.read_ruleset(&case.ruleset)?;
                match srl::stratify(&program.rules) {
                    Ok(_) => Err("negative stratification test was accepted".to_string()),
                    Err(err) => Ok((Status::Pass, format!("rejected as expected: {err}"))),
                }
            }
            CaseKind::Eval => self.run_eval_case(case),
            CaseKind::Unknown => Ok((Status::Skip, "unsupported SPARQL-RL test type".to_string())),
        }
    }

    fn run_eval_case(&mut self, case: &ManifestCase) -> Result<(Status, String), String> {
        let (_, program) = self.read_ruleset(&case.ruleset)?;
        let base_graph = match &case.data {
            Some(path) => self.read_data(path)?.facts,
            None => Vec::new(),
        };
        let result = srl::reason(&program, &base_graph, &eyeron::n3::reasoner::ReasonerOptions::default()).map_err(|err| err.to_string())?;

        let expected_path = case.result.as_ref().ok_or_else(|| "missing mf:result".to_string())?;
        let expected_doc = self.read_data(expected_path)?;

        if graphs_isomorphic(&result.closure, &expected_doc.facts) {
            Ok((Status::Pass, "derived facts match the expected result graph".to_string()))
        } else {
            Err(triples_diff(&result.closure, &expected_doc.facts))
        }
    }
}

fn manifest_cases(doc: &Document, manifest: &str) -> Result<Vec<ManifestCase>, String> {
    let mut subjects = Vec::new();
    for entries in objects(doc, None, MF_ENTRIES) {
        subjects.extend(list_items(entries).into_iter().cloned());
    }
    let mut out = Vec::new();
    for subject in subjects {
        let types: Vec<String> = objects(doc, Some(&subject), RDF_TYPE).into_iter().filter_map(iri_value).collect();
        if !types.iter().any(|t| t.starts_with(SRLT)) {
            continue;
        }
        let name = first_literal_object(doc, &subject, MF_NAME).unwrap_or_else(|| term_label(&subject));
        let action = objects(doc, Some(&subject), MF_ACTION).into_iter().next().cloned();
        let Some(action) = action else { continue };
        let (ruleset, data) = match &action {
            Term::Iri(iri) => (resolve_resource(iri, manifest), None),
            Term::Blank(_) => {
                let ruleset = first_iri_object(doc, &action, SRLT_RULESET).map(|iri| resolve_resource(&iri, manifest)).ok_or_else(|| format!("{name}: mf:action has no srlt:ruleset"))?;
                let data = first_iri_object(doc, &action, SRLT_DATA).map(|iri| resolve_resource(&iri, manifest));
                (ruleset, data)
            }
            other => return Err(format!("{name}: unsupported mf:action term {other:?}")),
        };
        let result = first_iri_object(doc, &subject, MF_RESULT).map(|iri| resolve_resource(&iri, manifest));
        out.push(ManifestCase { name, types, ruleset, data, result });
    }
    Ok(out)
}

fn manifest_includes(doc: &Document, base: &str) -> Vec<String> {
    let mut out = Vec::new();
    for includes in objects(doc, None, MF_INCLUDE) {
        for item in list_items(includes) {
            if let Term::Iri(iri) = item {
                out.push(resolve_resource(iri, base));
            }
        }
    }
    out
}

fn case_kind(types: &[String]) -> CaseKind {
    if types.iter().any(|t| t.ends_with("RulesPositiveSyntaxTest")) {
        CaseKind::PositiveSyntax
    } else if types.iter().any(|t| t.ends_with("RulesNegativeSyntaxTest")) {
        CaseKind::NegativeSyntax
    } else if types.iter().any(|t| t.ends_with("RulesPositiveWellFormednessTest")) {
        CaseKind::PositiveWellFormed
    } else if types.iter().any(|t| t.ends_with("RulesNegativeWellFormednessTest")) {
        CaseKind::NegativeWellFormed
    } else if types.iter().any(|t| t.ends_with("RulesPositiveStratificationTest")) {
        CaseKind::PositiveStratification
    } else if types.iter().any(|t| t.ends_with("RulesNegativeStratificationTest")) {
        CaseKind::NegativeStratification
    } else if types.iter().any(|t| t.ends_with("RulesEvalTest")) {
        CaseKind::Eval
    } else {
        CaseKind::Unknown
    }
}

fn objects<'a>(doc: &'a Document, subject: Option<&Term>, predicate: &str) -> Vec<&'a Term> {
    doc.facts.iter().filter(|t| subject.is_none_or(|s| &t.s == s)).filter(|t| matches!(&t.p, Term::Iri(p) if p == predicate)).map(|t| &t.o).collect()
}

fn iri_value(term: &Term) -> Option<String> {
    match term {
        Term::Iri(iri) => Some(iri.clone()),
        _ => None,
    }
}

fn first_iri_object(doc: &Document, subject: &Term, predicate: &str) -> Option<String> {
    objects(doc, Some(subject), predicate).into_iter().find_map(iri_value)
}

fn first_literal_object(doc: &Document, subject: &Term, predicate: &str) -> Option<String> {
    objects(doc, Some(subject), predicate).into_iter().find_map(|term| match term {
        Term::Literal(lit) => Some(lit.value.clone()),
        Term::Iri(iri) => Some(iri.clone()),
        _ => None,
    })
}

fn list_items(term: &Term) -> Vec<&Term> {
    match term {
        Term::List(items) => items.iter().collect(),
        other => vec![other],
    }
}

fn term_label(term: &Term) -> String {
    match term {
        Term::Iri(iri) => iri.clone(),
        Term::Blank(id) => format!("_:{id}"),
        Term::Literal(lit) => lit.value.clone(),
        other => format!("{other:?}"),
    }
}

fn normalize_resource(resource: &str) -> String {
    if is_url(resource) {
        resource.to_string()
    } else {
        PathBuf::from(resource).to_string_lossy().to_string()
    }
}

fn is_url(value: &str) -> bool {
    value.starts_with("http://") || value.starts_with("https://")
}

fn resolve_resource(reference: &str, base: &str) -> String {
    if is_url(reference) {
        return reference.to_string();
    }
    if is_url(base) {
        return join_url(base, reference);
    }
    let base_path = Path::new(base).parent().unwrap_or_else(|| Path::new("."));
    base_path.join(reference).to_string_lossy().to_string()
}

fn join_url(base: &str, reference: &str) -> String {
    let dir = match base.rfind('/') {
        Some(idx) => &base[..idx + 1],
        None => base,
    };
    format!("{dir}{reference}")
}

fn format_from_extension(path: &str) -> Option<RdfFormat> {
    let ext = Path::new(path.split(['?', '#']).next().unwrap_or(path)).extension()?.to_str()?.to_ascii_lowercase();
    RdfFormat::parse(&ext)
}

fn total_counts(results: &[CaseResult]) -> Counts {
    let mut c = Counts::default();
    for item in results {
        c.total += 1;
        match item.status {
            Status::Pass => c.pass += 1,
            Status::Fail => c.fail += 1,
            Status::Skip => c.skip += 1,
        }
    }
    c
}

fn format_progress_line(item: &CaseResult, index: usize) -> String {
    let tag = match item.status {
        Status::Pass => "OK",
        Status::Fail => "FAIL",
        Status::Skip => "SKIP",
    };
    let ty = item.case.types.first().map(|t| t.trim_start_matches(SRLT)).unwrap_or("unknown");
    let mut line = format!("{:03} {} {} {} ({} ms)", index + 1, tag, ty, item.case.name, item.duration_ms);
    if item.status != Status::Pass {
        line.push_str(&format!("\n    {}", item.message));
    }
    line
}

fn print_json_summary(counts: &Counts, duration_ms: u128) {
    println!("{{");
    println!("  \"ok\": {},", counts.fail == 0 && counts.total > 0);
    println!("  \"counts\": {{ \"total\": {}, \"pass\": {}, \"fail\": {}, \"skip\": {} }},", counts.total, counts.pass, counts.fail, counts.skip);
    println!("  \"durationMs\": {}", duration_ms);
    println!("}}");
}

fn to_earl(results: &[CaseResult]) -> String {
    let asserted_by = "<https://github.com/eyereasoner/eyeron>";
    let mut lines = vec![
        "@prefix earl: <http://www.w3.org/ns/earl#> .".to_string(),
        "@prefix doap: <http://usefulinc.com/ns/doap#> .".to_string(),
        String::new(),
        format!("{asserted_by} a earl:Software, doap:Project ;"),
        "  doap:name \"Eyeron\" .".to_string(),
        String::new(),
    ];
    for item in results {
        let outcome = match item.status {
            Status::Pass => "earl:passed",
            Status::Fail => "earl:failed",
            Status::Skip => "earl:untested",
        };
        lines.push("[] a earl:Assertion ;".to_string());
        lines.push(format!("  earl:assertedBy {asserted_by} ;"));
        lines.push(format!("  earl:subject {asserted_by} ;"));
        lines.push(format!("  earl:test <{}> ;", escape_iri(&item.case.ruleset)));
        lines.push("  earl:result [".to_string());
        lines.push("    a earl:TestResult ;".to_string());
        lines.push(format!("    earl:outcome {outcome} ;"));
        lines.push(format!("    earl:info {} ;", turtle_string(&item.message)));
        lines.push("  ] .".to_string());
        lines.push(String::new());
    }
    lines.join("\n")
}

fn escape_iri(iri: &str) -> String {
    iri.replace(['<', '>'], "")
}

fn turtle_string(s: &str) -> String {
    format!("{:?}", s)
}

// ---- Blank-node-aware triple-set isomorphism -----------------------------
//
// SPARQL-RL eval tests are plain triples (no named graphs), so this is a
// deliberately simpler version of `src/bin/w3c_rdf.rs`'s `graphs_isomorphic`
// (no quads, no RDF-star canonicalization beyond what `Term` already gives
// for free via derived `Eq`/`Ord`).

fn graphs_isomorphic(actual: &[Triple], expected: &[Triple]) -> bool {
    let actual = unique_triples(actual);
    let expected = unique_triples(expected);
    if actual.len() != expected.len() {
        return false;
    }
    let actual_blanks = collect_blanks(&actual);
    let expected_blanks = collect_blanks(&expected);
    if actual_blanks.len() != expected_blanks.len() {
        return false;
    }
    let expected_set: BTreeSet<String> = expected.iter().map(|t| render_triple(t, &BTreeMap::new(), false)).collect();
    if actual_blanks.is_empty() {
        return actual.iter().all(|t| expected_set.contains(&render_triple(t, &BTreeMap::new(), false)));
    }
    let mut order: Vec<String> = actual_blanks.into_iter().collect();
    order.sort();
    let candidates: Vec<String> = expected_blanks.into_iter().collect();
    search_blank_mapping(0, &order, &candidates, &mut BTreeMap::new(), &mut BTreeSet::new(), &actual, &expected_set)
}

fn unique_triples(triples: &[Triple]) -> Vec<Triple> {
    let mut seen = BTreeSet::new();
    let mut out = Vec::new();
    for t in triples {
        let key = render_triple(t, &BTreeMap::new(), false);
        if seen.insert(key) {
            out.push(t.clone());
        }
    }
    out
}

fn search_blank_mapping(index: usize, order: &[String], candidates: &[String], mapping: &mut BTreeMap<String, String>, used: &mut BTreeSet<String>, actual: &[Triple], expected_set: &BTreeSet<String>) -> bool {
    if index >= order.len() {
        return actual.iter().all(|t| expected_set.contains(&render_triple(t, mapping, true)));
    }
    let a = &order[index];
    for b in candidates {
        if used.contains(b) {
            continue;
        }
        mapping.insert(a.clone(), b.clone());
        used.insert(b.clone());
        if search_blank_mapping(index + 1, order, candidates, mapping, used, actual, expected_set) {
            return true;
        }
        used.remove(b);
        mapping.remove(a);
    }
    false
}

fn collect_blanks(triples: &[Triple]) -> BTreeSet<String> {
    let mut out = BTreeSet::new();
    for t in triples {
        collect_term_blanks(&t.s, &mut out);
        collect_term_blanks(&t.p, &mut out);
        collect_term_blanks(&t.o, &mut out);
    }
    out
}

fn collect_term_blanks(term: &Term, out: &mut BTreeSet<String>) {
    match term {
        Term::Blank(id) => {
            out.insert(id.clone());
        }
        Term::Formula(triples) => triples.iter().for_each(|t| {
            collect_term_blanks(&t.s, out);
            collect_term_blanks(&t.p, out);
            collect_term_blanks(&t.o, out);
        }),
        Term::List(items) => items.iter().for_each(|t| collect_term_blanks(t, out)),
        _ => {}
    }
}

fn render_triple(t: &Triple, mapping: &BTreeMap<String, String>, require_mapping: bool) -> String {
    format!("{} {} {}", render_term(&t.s, mapping, require_mapping).unwrap_or_default(), render_term(&t.p, mapping, require_mapping).unwrap_or_default(), render_term(&t.o, mapping, require_mapping).unwrap_or_default())
}

fn render_term(term: &Term, mapping: &BTreeMap<String, String>, require_mapping: bool) -> Option<String> {
    match term {
        Term::Iri(iri) => Some(format!("<{iri}>")),
        Term::Blank(id) => match mapping.get(id) {
            Some(mapped) => Some(format!("_:{mapped}")),
            None if require_mapping => None,
            None => Some(format!("_:{id}")),
        },
        Term::Literal(Literal { value, datatype, language }) => match (datatype, language) {
            (_, Some(lang)) => Some(format!("{value:?}@{lang}")),
            (Some(dt), None) => Some(format!("{value:?}^^<{dt}>")),
            (None, None) => Some(format!("{value:?}")),
        },
        Term::List(items) => {
            let mut parts = Vec::with_capacity(items.len());
            for item in items {
                parts.push(render_term(item, mapping, require_mapping)?);
            }
            Some(format!("({})", parts.join(" ")))
        }
        Term::Formula(triples) => {
            let mut parts = Vec::with_capacity(triples.len());
            for t in triples {
                parts.push(render_triple(t, mapping, require_mapping));
            }
            Some(format!("{{{}}}", parts.join(" . ")))
        }
        Term::Var(name) => Some(format!("?{name}")),
    }
}

fn triples_diff(actual: &[Triple], expected: &[Triple]) -> String {
    let actual_set: BTreeSet<_> = actual.iter().map(|t| render_triple(t, &BTreeMap::new(), false)).collect();
    let expected_set: BTreeSet<_> = expected.iter().map(|t| render_triple(t, &BTreeMap::new(), false)).collect();
    let missing: Vec<_> = expected_set.difference(&actual_set).take(5).cloned().collect();
    let extra: Vec<_> = actual_set.difference(&expected_set).take(5).cloned().collect();
    format!("graphs are not isomorphic; missing: [{}] extra: [{}]", missing.join(", "), extra.join(", "))
}
