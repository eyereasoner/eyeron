//! Proof checking: `docs/proof-checking.md`'s reference implementation.
//!
//! The four validity conditions are checked *here*, once, over an abstract
//! view of a proof document (`Document`). Each front end supplies a reader
//! that presents its own syntax through that view and re-performs its own
//! inferences. So there is one checker with two readers, one for each syntax.
//!
//! Nothing in this module reasons. It never searches for a derivation, only
//! re-performs the ones the document recorded — which is what keeps a
//! checker small enough to be worth trusting (specification §2).

pub mod n3;
pub mod srl;

use std::collections::BTreeMap;

/// The one reason a step carries. `Kind` is what the generic checker needs;
/// the locator (which rule, which document) stays with the reader.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum Kind {
    Rule,
    Fact,
    Builtin,
    Absent,
    Collected,
    Unproven,
}

impl Kind {
    pub fn label(self) -> &'static str {
        match self {
            Kind::Rule => "rule",
            Kind::Fact => "fact",
            Kind::Builtin => "builtin",
            Kind::Absent => "absent",
            Kind::Collected => "collected",
            Kind::Unproven => "unproven",
        }
    }
}

/// Where one `uses` entry resolves (§4 C1).
pub enum Resolution {
    /// To the conclusion of this step, of which it is an instance.
    Step(usize),
    /// To a statement the source gives outright.
    Given,
    /// Nowhere; the string says what could not be resolved.
    Unresolved(String),
}

/// What checking one step established.
pub enum Checked {
    /// The recorded inference was re-performed and matched (§5).
    Verified,
    /// Recorded as an obligation rather than re-established (§6); the
    /// string says which obligation.
    Trusted(&'static str),
}

#[derive(Debug, Clone)]
pub struct Obligation {
    pub kind: &'static str,
    pub conclusion: String,
}

#[derive(Debug, Clone)]
pub struct Failure {
    /// The validity condition that failed: `"C1"`..`"C4"`.
    pub condition: &'static str,
    pub conclusion: String,
    pub detail: String,
}

#[derive(Debug, Clone, Default)]
pub struct Report {
    pub steps: usize,
    pub verified: usize,
    pub obligations: Vec<Obligation>,
    pub failures: Vec<Failure>,
    pub counts: BTreeMap<&'static str, usize>,
}

impl Report {
    pub fn valid(&self) -> bool {
        self.failures.is_empty()
    }

    /// The verdict line the specification's §9 requires.
    pub fn verdict(&self) -> String {
        if !self.valid() {
            return format!("invalid: {} failure(s)", self.failures.len());
        }
        if self.obligations.is_empty() {
            format!("checked: {} steps", self.steps)
        } else {
            format!("checked with obligations: {} steps, {} trusted", self.steps, self.obligations.len())
        }
    }
}

/// A proof document, seen the way the checker needs to see it. A reader
/// implements this over its own syntax.
///
/// Resolution (§4 C1) belongs to the reader rather than to the checker,
/// because deciding that one statement is an instance of another is a
/// matter of that formalism's terms. Everything else — the four conditions
/// and the bookkeeping — is here and shared.
pub trait Document {
    fn step_count(&self) -> usize;

    fn kind(&self, index: usize) -> Kind;

    /// Step `index`'s conclusion, for reporting.
    fn describe(&self, index: usize) -> String;

    /// Where each entry of step `index`'s `uses` resolves, in order.
    fn dependencies(&self, index: usize) -> Vec<Resolution>;

    /// The statements the document asserts were derived, for reporting.
    fn claims(&self) -> Vec<String>;

    /// Where claim `index` resolves.
    fn claim_resolution(&self, index: usize) -> Resolution;

    /// Re-perform step `index`'s recorded inference (§5), or classify it as
    /// an obligation (§6). `Err` is a failure of (C3).
    fn check_step(&self, index: usize) -> std::result::Result<Checked, String>;
}

/// Check `document` against the source program it was read with, applying
/// the four conditions of specification §4.
pub fn check(document: &dyn Document) -> Report {
    let mut report = Report { steps: document.step_count(), ..Report::default() };

    for index in 0..document.step_count() {
        *report.counts.entry(document.kind(index).label()).or_insert(0) += 1;
    }

    // (C1) every use resolves, and collect the step-to-step edges (C2)
    // needs while we are here.
    let mut edges: Vec<Vec<usize>> = Vec::with_capacity(document.step_count());
    for index in 0..document.step_count() {
        let mut dependencies = Vec::new();
        for resolution in document.dependencies(index) {
            match resolution {
                Resolution::Step(target) => dependencies.push(target),
                Resolution::Given => {}
                Resolution::Unresolved(detail) => report.failures.push(Failure {
                    condition: "C1",
                    conclusion: document.describe(index),
                    detail: format!("uses {}, which is neither an instance of a step's conclusion nor given by the source", detail),
                }),
            }
        }
        edges.push(dependencies);
    }

    // (C2) the step-to-step use relation is well founded.
    check_well_founded(document, &edges, &mut report);

    // (C3) every step's justification holds.
    for index in 0..document.step_count() {
        match document.check_step(index) {
            Ok(Checked::Verified) => report.verified += 1,
            Ok(Checked::Trusted(kind)) => report.obligations.push(Obligation { kind, conclusion: document.describe(index) }),
            Err(detail) => report.failures.push(Failure { condition: "C3", conclusion: document.describe(index), detail }),
        }
    }

    // (C4) every claim is accounted for.
    for (index, claim) in document.claims().into_iter().enumerate() {
        if let Resolution::Unresolved(_) = document.claim_resolution(index) {
            report.failures.push(Failure {
                condition: "C4",
                conclusion: claim,
                detail: "claimed, but no step concludes it and the source does not give it".to_string(),
            });
        }
    }

    report
}

#[derive(Clone, Copy, PartialEq)]
enum Mark {
    Open,
    Done,
}

/// Depth-first search for a cycle in the step-to-step `uses` relation,
/// iterative because a long derivation chain (`deep-taxonomy-100000`) is
/// exactly what this gets pointed at.
fn check_well_founded(document: &dyn Document, edges: &[Vec<usize>], report: &mut Report) {
    let mut marks: Vec<Option<Mark>> = vec![None; edges.len()];
    for root in 0..edges.len() {
        if marks[root].is_some() {
            continue;
        }
        marks[root] = Some(Mark::Open);
        // Each frame is a step and how many of its dependencies have been
        // taken. Iterative, because a long derivation chain
        // (`deep-taxonomy-100000`) is exactly what this gets pointed at.
        let mut stack: Vec<(usize, usize)> = vec![(root, 0)];
        while let Some((index, cursor)) = stack.last_mut() {
            let dependencies = &edges[*index];
            if *cursor == dependencies.len() {
                marks[*index] = Some(Mark::Done);
                stack.pop();
                continue;
            }
            let next = dependencies[*cursor];
            *cursor += 1;
            match marks[next] {
                Some(Mark::Done) => {}
                Some(Mark::Open) => {
                    report.failures.push(Failure {
                        condition: "C2",
                        conclusion: document.describe(next),
                        detail: "is used, directly or indirectly, by its own derivation".to_string(),
                    });
                    marks[next] = Some(Mark::Done);
                }
                None => {
                    marks[next] = Some(Mark::Open);
                    stack.push((next, 0));
                }
            }
        }
    }
}
