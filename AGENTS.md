# Working on eyeron

eyeron is a Rust reasoner for Notation3 (N3). It derives conclusions from
facts and rules, writes N3 proofs, and checks those proofs; it runs as a
command-line program, a Rust library, and a browser application. It is an N3
reasoner only. Describe what it implements as it currently is, distinguish
demonstrated behavior from design goals, and keep error messages specific and
user-facing text direct.

## Repository map

- `src/`: every source file lives directly here, with no subdirectories.
  - `lexer.rs`, `parser.rs`: N3, Turtle/TriG, N-Triples/N-Quads, and RDF
    Message Log parsing, including quantifier scopes and RDF 1.2 versions.
  - `ast.rs`: terms, graphs with their universal/existential binders, rules,
    and `Document::merge` for separately parsed inputs.
  - `reasoner.rs`: forward agenda, backward rules, built-ins, indexes, and
    proof capture.
  - `proof_writer.rs`, `proof_check.rs`, `proof_check_n3.rs`: N3 proof
    output, the generic validity conditions C1–C9, and the N3 proof reader
    and step checker.
  - `printing.rs`, `rdf_compat.rs`, `error.rs`, `sudoku.rs`, `w3c_rdf.rs`.
  - `main.rs`: CLI. `lib.rs`: library API. `wasm.rs`: browser bindings.
- `tools/build_playground.rs`: builds `pkg/` with wasm-pack (`cargo playground`).
- `playground.html`: hand-written browser playground; `pkg/` holds the
  committed wasm build it loads.
- `_config.yml`, `_layouts/default.html`, `assets/docs.css`: GitHub Pages
  renders the Markdown documents with one masthead (Guide, Playground,
  Specification, Repository), the same nav the playground shows.
- `examples/*.n3`: runnable examples. `examples/output/` holds output goldens
  (`.n3` or `.md`), `examples/input/` companion inputs loaded with the
  example of the same stem (`.n3`, else `.trig`), and `examples/deck/`
  Markdown walkthroughs. Proofs are not stored: the proof-checking suite
  generates each example's proof and checks it.
- `tests/`: integration tests. `examples.rs`, `proof_checking.rs`, and
  `w3c_rdf.rs` are custom harnesses (`harness = false`); `regressions.rs` and
  `quantification.rs` hold focused behavior tests; `proof_validation.rs`
  holds forged proofs the checker must reject; `notation3tests/` and
  `w3c_rdf/rdf-tests/` are vendored conformance suites.
- `reports/w3c-rdf-earl.ttl`: EARL report, rewritten by the W3C RDF suite.
- `README.md` (short entry point), `GUIDE.md` (CLI, formats, playground,
  APIs, development), `SPEC.md` (RFC-style specification: language,
  evaluation, built-ins, and the C1–C9 proof contract), and `docs/images/`
  (the guide's illustrations).
- `scripts/test-all`, `release`, `deny.toml`, `.github/workflows/`: full test
  run, releases, dependency policy, CI, Pages, and GitHub releases.

## Commands

```sh
cargo build --release
./target/release/eyeron examples/socrates.n3
./target/release/eyeron -p examples/socrates.n3      # proof
./target/release/eyeron -c examples/dog-license.n3   # prove and check
./target/release/eyeron --check-proof proof.n3 program.n3
./target/release/eyeron -a examples/socrates.n3      # parsed AST
cargo test --release --test regressions
cargo test --release --test examples
./scripts/test-all
cargo clippy --release --all-targets
cargo playground
git diff --check
```

`./scripts/test-all` uses the optimized `test-fast` profile, enables incremental
builds, and checks two example proofs concurrently (`EYERON_TEST_JOBS` overrides
the worker count). It runs every suite with `--no-fail-fast` and ends with one
line, `Tests: N run; P% OK; Ts total`, naming any suite that ended without a
result. `cargo playground` needs wasm-pack. `cargo deny check` needs a
one-time `cargo install --locked cargo-deny`; CI runs it on every push.
`EYERON_W3C_RDF_REFRESH=1` refreshes the local W3C mirror; the suite is
local-only otherwise.

Large examples such as `deep-taxonomy-100000` and `kaprekar-6174` produce very
large proofs. Redirect full output to a temporary file and inspect focused
parts rather than flooding the terminal.

## Language and examples

- Read the relevant section of `SPEC.md` before changing language behavior,
  and its Section 9 before changing proofs. Keep the
  implementation, docs, examples, and tests consistent.
- Graph terms are opaque and keep literal lexical identity: inside a quoted
  graph `"01"^^xsd:integer` is not `1`, while `()` is `rdf:nil`. Numeric
  matching outside graph terms compares values.
- Files given together are parsed separately and merged with their blank-node
  and quantifier scopes kept apart. Rule-only variables keep their names, so
  proofs show the names the source used.
- RDF syntaxes follow their grammars strictly: undeclared prefixes, prefixed
  names in N-Triples/N-Quads, and misplaced dots after `@version`/`VERSION`
  are errors. N3 keeps its conventional prefixes.
- Every example starts with a header comment for a wide audience: a short
  title line, a blank `#` line, then a few lines saying what situation it
  models, what eyeron derives, and which N3 feature it shows. Describe the
  example as it is; do not mention where it came from or sibling projects.
  External references that help the reader go on a `# See <url>` line.
- Examples use the layout eyeron's N3 printer writes: `@prefix p: <iri> .`,
  statements ending in ` .`, rules as `{ ... } => { ... } .` with four-space
  indentation inside `{ }`, `[ ]` and wrapped lists, plain `# Section`
  comments without banners, and no trailing whitespace. `examples/socrates.n3`
  is the reference. Reformatting is whitespace and comments only, so every
  golden must stay unchanged.
- Every example has an output golden, and `tests/proof_checking.rs`
  generates the proof of every example that derives anything and checks it
  under C1–C9. When adding an example, add it to `bundledExamplesN3` in
  `playground.html`; a companion input goes in `examples/input/` and in
  `bundledCompanionInputs`. `tests/playground.rs` checks both lists.
- Ordinary test runs only read goldens. After an intentional output change,
  `EYERON_UPDATE_GOLDENS=1 cargo test --release --test examples` rewrites the
  output (`.n3`) goldens that no longer match, exactly as the harness
  produces them (with no base IRI). Review the diff: no output golden should
  change unless intended, and `cargo test --release --test proof_checking`
  must still pass.

- Query examples return their answers directly. `-p` explains them and `-c`
  verifies that explanation under C1–C9, so an example never prints a
  hand-written Answer/Reason/Check report.

## Implementation and verification

Match the surrounding Rust: its naming, comment density, and doc comments
that say why. Prefer small, direct changes over new machinery, and fix the
code that produces a wrong result rather than patching its output.

Proof checking must stay sound: a forged proof must never report `checked`.
The conditions C1–C9 are defined in `SPEC.md` Section 9; proof checking
does not require compatibility with sibling engines. Matching
against a recorded step is one-way, so only the rule's variables bind. An
existential witness must be a fresh blank node tied to one firing, and its
introduction assumes no fact already satisfied its piece: an `unsatisfied`
obligation that evidence independent of the firing contradicts (C6). Built-ins
are re-decided with closed arguments, including tests on quoted graphs; only
those that read outside the proof, and tests over the current graph, are
obligations, and the latter must not be contradicted by the proof's own
evidence (C6). Query answers are output, never premises, and a proof claims
exactly what the run outputs. For every new check, add a forged proof to
`tests/proof_validation.rs` and confirm that all packaged proofs still check.

eyeron is expected to run about as fast as its JavaScript sibling eyeling; a
gap of several times is a defect. After engine changes, run
`EYERON_TEST_JOBS=1 ./scripts/test-all --release` once on a quiet machine, and
look per example as well as at the total: one slow example can
hide behind an otherwise faster suite. Do not time anything while other
builds or agents share the machine. Profile before optimizing; valgrind's
callgrind works where perf is unavailable. Hand-rolled hashers need final
mixing, because hash tables pick buckets from the low bits.

eyeron, eyeling, eyeleng, and eyeprolog are one family; a behavior fixed in
one usually belongs in the others. When eyeron and eyeling disagree, find out
which one is right before changing either.

Run focused tests while working, then `./scripts/test-all` and clippy before
finishing code changes. Add a regression test for each behavior change, in the
style of the file it joins. Documentation describes the current behavior, not
how it came to be; documentation-only edits need a review and
`git diff --check`.

## Versions and releases

Commit directly to `main`. Do not use closing keywords such as `Fixes #N` in
commit messages; issues are closed by hand. Follow the user's instructions
about committing, pushing, and releasing.

`Cargo.toml` is the version source; never bump it by hand. Releases are cut
with the release script after the suite has passed:

```sh
./release patch "<release message>"
./release minor "<release message>"
./release major "<release message>"
```

The script switches to `main`, pulls with `--ff-only`, bumps the version with
`cargo set-version` (cargo-edit), rebuilds `pkg/` with `cargo playground` so
the wasm build reports the new version, stages every change, commits, creates
an annotated `v*` tag, and pushes the branch and tag. Review the working tree
first because it stages everything. A push to `main` deploys GitHub Pages and
runs CI; a `v*` tag creates the GitHub release from the tag's message and
publishes the crate through `.github/workflows/publish-crates.yml`, only
through crates.io trusted publishing. See the guide for existing-tag dispatch.
