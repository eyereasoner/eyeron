//! Manifest-fetching/case-running logic for the `cargo test` W3C SPARQL-RL
//! harness (`tests/w3c_sparql_rl.rs`).
//!
//! This deliberately duplicates `src/bin/w3c_sparql_rl.rs` rather than
//! sharing code with it, matching the existing project convention for the
//! RDF harness (`src/bin/w3c_rdf.rs` vs. `tests/w3c_rdf/runner.rs`): the
//! binary is a CLI tool with its own argument parsing and `fn main`, while
//! this module exposes a `Result`-returning entry point
//! (`run_default_suite`) the `harness = false` test driver in
//! `tests/w3c_sparql_rl.rs` calls and turns into libtest-style output.

use eyeron::ast::{Literal, Term, Triple};
use eyeron::srl::{self, SparqlRlProgram};
use eyeron::{parse_rdf12, Document, RdfFormat};
use std::collections::{BTreeMap, BTreeSet, HashMap};
use std::fs;
use std::path::{Path, PathBuf};

const MF_ENTRIES: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#entries";
const MF_INCLUDE: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#include";
const MF_NAME: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#name";
const MF_ACTION: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#action";
const MF_RESULT: &str = "http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#result";
const RDF_TYPE: &str = "http://www.w3.org/1999/02/22-rdf-syntax-ns#type";
const SRLT: &str = "http://www.w3.org/ns/sparql-rl-tests#";
const SRLT_RULESET: &str = "http://www.w3.org/ns/sparql-rl-tests#ruleset";
const SRLT_DATA: &str = "http://www.w3.org/ns/sparql-rl-tests#data";

pub const DEFAULT_MANIFEST: &str = "https://w3c.github.io/data-shapes/shacl12-test-suite/tests/sparql-rl/manifest-sparql-rl.ttl";

const DEFAULT_W3C_SPARQL_RL_CACHE_DIR: &str = "tests/w3c_sparql_rl/data-shapes";

#[derive(Debug, Clone)]
struct ManifestCase {
    name: String,
    types: Vec<String>,
    /// The rule set to load: either `mf:action`'s IRI directly (syntax /
    /// well-formedness / stratification tests) or `srlt:ruleset` from the
    /// `mf:action` blank node (eval tests).
    ruleset: String,
    /// `srlt:data` from an eval test's `mf:action` blank node.
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
}

#[derive(Debug, Default, Clone, Copy)]
pub struct Counts {
    pub total: usize,
    pub pass: usize,
    pub fail: usize,
    pub skip: usize,
}

struct Runner {
    cache: HashMap<String, String>,
    disk_cache_dir: PathBuf,
    offline: bool,
    refresh_cache: bool,
}

pub fn has_filter() -> bool {
    std::env::var("EYERON_W3C_SPARQL_RL_FILTER").map(|v| !v.trim().is_empty()).unwrap_or(false)
}

fn is_quiet() -> bool {
    std::env::var("EYERON_W3C_SPARQL_RL_QUIET").map(|v| v == "1").unwrap_or(false)
}

pub fn refresh_requested() -> bool {
    env_flag("EYERON_W3C_SPARQL_RL_REFRESH")
}

fn env_flag(name: &str) -> bool {
    std::env::var(name).map(|value| matches!(value.as_str(), "1" | "true" | "TRUE" | "yes" | "YES" | "on" | "ON")).unwrap_or(false)
}

/// Run every case from the W3C SPARQL-RL manifest, write the EARL report,
/// and return the pass/fail/skip counts. Like the W3C RDF harness, this is
/// local-only by default: it reads `tests/w3c_sparql_rl/data-shapes/` and
/// fails fast on a cache miss, so repeat runs stay fast. Set
/// `EYERON_W3C_SPARQL_RL_REFRESH=1` to bootstrap or refresh that mirror
/// from the live manifest. Errors here are hard failures (network/parse
/// problems), distinct from an individual test case failing (which is
/// reflected in `Counts::fail`).
pub fn run_default_suite() -> Result<Counts, String> {
    let filter = std::env::var("EYERON_W3C_SPARQL_RL_FILTER").ok().filter(|v| !v.trim().is_empty());
    let output = std::env::var("EYERON_W3C_SPARQL_RL_EARL").unwrap_or_else(|_| "reports/w3c-sparql-rl-earl.ttl".to_string());
    let quiet = is_quiet();

    let mut runner = Runner::from_env();
    if !quiet {
        eprintln!("== W3C SPARQL-RL manifest: {DEFAULT_MANIFEST}");
    }
    let mut seen = BTreeSet::new();
    let cases = runner.load_manifest_recursive(DEFAULT_MANIFEST, &mut seen)?;

    let mut results = Vec::new();
    for case in cases {
        if let Some(filter) = &filter {
            let hay = format!("{} {} {}", case.name, case.types.join(" "), case.ruleset);
            if !hay.contains(filter) {
                continue;
            }
        }
        let item = runner.run_case(case);
        if !quiet {
            eprintln!("{}", format_progress_line(&item));
        }
        results.push(item);
    }

    let counts = total_counts(&results);
    let earl = to_earl(&results);
    let output_path = PathBuf::from(&output);
    if let Some(parent) = output_path.parent() {
        fs::create_dir_all(parent).map_err(|e| e.to_string())?;
    }
    fs::write(&output_path, format!("{earl}\n")).map_err(|e| format!("failed to write {}: {e}", output_path.display()))?;
    if !quiet {
        eprintln!("EARL report: {}", output_path.display());
    }

    Ok(counts)
}

pub fn assert_clean_counts(label: &str, counts: &Counts, expected_total: Option<usize>) -> Result<(), String> {
    if counts.fail > 0 || counts.skip > 0 || counts.pass != counts.total {
        return Err(format!("{label} did not reach 100%: ok={} count={} failed={} skipped={}", counts.pass, counts.total, counts.fail, counts.skip));
    }
    if let Some(expected_total) = expected_total {
        if counts.total != expected_total {
            return Err(format!("{label} ran an unexpected number of SPARQL-RL tests: ok={} count={} expected={}", counts.pass, counts.total, expected_total));
        }
    }
    Ok(())
}

impl Runner {
    fn from_env() -> Self {
        let disk_cache_dir = std::env::var("EYERON_W3C_SPARQL_RL_CACHE_DIR").map(PathBuf::from).unwrap_or_else(|_| PathBuf::from(DEFAULT_W3C_SPARQL_RL_CACHE_DIR));
        let refresh_cache = refresh_requested();
        let online = refresh_cache || env_flag("EYERON_W3C_SPARQL_RL_ONLINE");
        let offline = env_flag("EYERON_W3C_SPARQL_RL_OFFLINE") || !online;
        Runner { cache: HashMap::new(), disk_cache_dir, offline, refresh_cache }
    }

    fn load_manifest_recursive(&mut self, resource: &str, seen: &mut BTreeSet<String>) -> Result<Vec<ManifestCase>, String> {
        if !seen.insert(resource.to_string()) {
            return Ok(Vec::new());
        }
        let text = self.read_resource(resource)?;
        let doc = parse_rdf12(&text, Some(resource), RdfFormat::Turtle).map_err(|err| format!("failed to parse manifest {resource}: {err}"))?;
        let mut cases = manifest_cases(&doc, resource)?;
        for include in manifest_includes(&doc, resource) {
            cases.extend(self.load_manifest_recursive(&include, seen)?);
        }
        Ok(cases)
    }

    fn read_resource(&mut self, resource: &str) -> Result<String, String> {
        if let Some(cached) = self.cache.get(resource) {
            return Ok(cached.clone());
        }
        let text = if is_url(resource) {
            self.read_url_resource(resource)?
        } else {
            fs::read_to_string(resource).map_err(|err| format!("failed to read {resource}: {err}"))?
        };
        self.cache.insert(resource.to_string(), text.clone());
        Ok(text)
    }

    fn read_url_resource(&mut self, resource: &str) -> Result<String, String> {
        if !self.refresh_cache {
            if let Some(path) = self.cache_path_for_url(resource) {
                if path.exists() {
                    return fs::read_to_string(&path).map_err(|err| format!("failed to read cached {} for {resource}: {err}", path.display()));
                }
            }
        }
        if self.offline {
            let expected = self.cache_path_for_url(resource).map(|p| p.display().to_string()).unwrap_or_else(|| self.disk_cache_dir.display().to_string());
            return Err(format!(
                "local W3C SPARQL-RL mirror miss for {resource}; expected {expected}. \
                 The W3C SPARQL-RL conformance test is intentionally local-only so `cargo test` stays fast. \
                 Run once with EYERON_W3C_SPARQL_RL_REFRESH=1 to populate the mirror, then commit tests/w3c_sparql_rl/data-shapes/."
            ));
        }
        let text = match fetch_url(resource) {
            Ok(text) => text,
            Err(primary) => {
                if let Some(fallback) = github_raw_fallback(resource) {
                    fetch_url(&fallback).map_err(|secondary| format!("failed to fetch {resource}: {primary}; fallback {fallback}: {secondary}"))?
                } else {
                    return Err(format!("failed to fetch {resource}: {primary}"));
                }
            }
        };
        if let Some(path) = self.cache_path_for_url(resource) {
            if let Some(parent) = path.parent() {
                fs::create_dir_all(parent).map_err(|err| format!("failed to create W3C SPARQL-RL cache directory {}: {err}", parent.display()))?;
            }
            fs::write(&path, &text).map_err(|err| format!("failed to write W3C SPARQL-RL cache file {}: {err}", path.display()))?;
        }
        Ok(text)
    }

    fn cache_path_for_url(&self, resource: &str) -> Option<PathBuf> {
        w3c_sparql_rl_relative_path(resource).map(|relative| self.disk_cache_dir.join(relative))
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
        match self.run_case_inner(&case) {
            Ok((status, message)) => CaseResult { case, status, message },
            Err(message) => CaseResult { case, status: Status::Fail, message },
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

fn is_url(value: &str) -> bool {
    value.starts_with("http://") || value.starts_with("https://")
}

fn fetch_url(resource: &str) -> Result<String, String> {
    ureq::get(resource).call().map_err(|err| err.to_string())?.into_string().map_err(|err| err.to_string())
}

fn github_raw_fallback(resource: &str) -> Option<String> {
    let prefix = "https://w3c.github.io/data-shapes/";
    resource.strip_prefix(prefix).map(|rest| format!("https://raw.githubusercontent.com/w3c/data-shapes/main/{rest}"))
}

fn w3c_sparql_rl_relative_path(resource: &str) -> Option<PathBuf> {
    let github_pages = "https://w3c.github.io/data-shapes/";
    let raw_github = "https://raw.githubusercontent.com/w3c/data-shapes/main/";
    resource.strip_prefix(github_pages).or_else(|| resource.strip_prefix(raw_github)).map(|rest| PathBuf::from(rest.trim_start_matches('/')))
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

fn format_progress_line(item: &CaseResult) -> String {
    let tag = match item.status {
        Status::Pass => "OK",
        Status::Fail => "FAIL",
        Status::Skip => "SKIP",
    };
    let ty = item.case.types.first().map(|t| t.trim_start_matches(SRLT)).unwrap_or("unknown");
    let mut line = format!("{} {} {}", tag, ty, item.case.name);
    if item.status != Status::Pass {
        line.push_str(&format!("\n    {}", item.message));
    }
    line
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
