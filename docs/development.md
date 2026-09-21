# Development

This page covers building Eyeron, embedding it as a Rust library, running the browser playground, testing, and the overall project layout. For each format's own syntax, semantics, CLI flags, and internals, see [`docs/n3.md`](n3.md), [`docs/sparql-rl.md`](sparql-rl.md), and [`docs/eyelang.md`](eyelang.md).

## Building

```bash
cargo build --release
```

The executable is written to `target/release/eyeron`. Run a file the same way regardless of format; multiple files (and HTTP/HTTPS URLs) are merged into one document, and `-` reads standard input:

```bash
cargo run --release -- examples/socrates.n3
cargo run --release -- --proof examples/socrates.n3
printf '@prefix : <http://example.org/> . :Socrates a :Man . { ?x a :Man . } => { ?x a :Mortal . } .' \
  | cargo run --release -- -
```

Run `eyeron`, `eyeron -h`, or `eyeron --help` to display help. Running without arguments is equivalent to `-h`.

## Architecture overview

At a high level, the implementation resembles both a compiler and a database query engine. Each format has its own front end, but they share the command-line, library, and Wasm entry points:

```text
source text
    │
    ▼
lexer ── tokens ──▶ parser ── AST ──▶ reasoner / evaluator
                                              │
                                              ▼
                                          result
                                              │
                                ┌─────────────┴────────────┐
                                ▼                           ▼
                             printing                     proof
```

`src/main.rs` (native CLI), `src/lib.rs` (Rust library API), and `src/wasm.rs` (browser API) are different front ends around the same three reasoning pipelines. `src/error.rs`'s `EyeronError` carries a message and an optional byte offset; the lexer and parser attach offsets, and `with_source_location` converts them into file/line/column information for users.

### Shared N3/RDF core (`src/ast.rs`)

N3 and (partially) SPARQL 1.2 RL share one term/triple/document model. `Term` is a Rust enum:

```rust
pub enum Term {
    Iri(String),
    Var(String),
    Blank(String),
    Literal(Literal),
    List(Vec<Term>),
    Formula(Vec<Triple>),
}
```

An enum is a good fit because a term is exactly one of these variants; the recursive `List` and `Formula` variants allow arbitrarily nested data. `Term::is_ground` recursively checks that a term contains no variables — groundness matters because a ground fact can be stored as established knowledge, while a variable-containing triple is normally a pattern. `Triple` stores subject/predicate/object terms; `Rule` stores premise and conclusion triple vectors plus flags for forward rules, backward rules, and queries; `Document` is the parser's final product (prefixes, base IRI, explicit facts, source locations, rules), and `Document::merge` makes multi-file input simple. Many AST types derive `Eq`, `Ord`, and `Hash` so the reasoner can place terms and triples in maps and sets for indexing, deterministic output, and duplicate detection.

Eyelang (`src/eye/`) does not use this model at all — see [`docs/eyelang.md`'s implementation notes](eyelang.md#implementation-notes) for why it has its own, wholly separate term type.

### Repository map

| Path | Responsibility |
| --- | --- |
| `src/ast.rs` | Core data structures: terms, triples, rules, and documents |
| `src/error.rs` | Error type and source-position reporting |
| `src/lib.rs` | Public Rust library API and module exports |
| `src/main.rs` | Native command-line interface |
| `src/wasm.rs` | WebAssembly/browser interface |
| `src/bin/w3c_rdf.rs`, `src/bin/w3c_sparql_rl.rs` | Conformance-runner binaries |
| `src/n3/` | N3 front end: lexer, parser, reasoner, printing, proof (see [`docs/n3.md`](n3.md)) |
| `src/srl/` | SPARQL 1.2 RL front end: lexer, parser, expression evaluator, stratification, forward/backward reasoners (see [`docs/sparql-rl.md`](sparql-rl.md)) |
| `src/eye/` | Eyelang front end: lexer, parser, term model, tabled evaluator, built-ins, proof/result output, RDF bridge (see [`docs/eyelang.md`](eyelang.md)) |
| `tools/build_playground.rs` | Builds the browser playground package |
| `examples/` | Example inputs, expected outputs, and proof outputs |
| `tests/` | Integration, regression, CLI, N3, and W3C RDF/SPARQL-RL tests |

## Rust library

The high-level API parses N3, runs the reasoner, and returns newly derived output:

```rust
fn main() -> eyeron::Result<()> {
    let output = eyeron::reason(r#"
        @prefix : <http://example.org/> .

        :Socrates a :Man .
        { ?x a :Man . } => { ?x a :Mortal . } .
    "#)?;

    assert!(output.contains(":Socrates a :Mortal"));
    Ok(())
}
```

For lower-level integration, use `parse_n3`, `parse_rdf12`, or `parse_rdf_message_log`, followed by `reason_document`. The returned `ReasonerResult` reports completion status, reached safety limits, semantic errors, statistics, derived facts, and proof data. `eyeron::srl` and `eyeron::eye` expose the corresponding APIs for the other two formats — see [`docs/eyelang.md`'s Rust API section](eyelang.md#rust-api) for Eyelang's own entry points.

## Browser playground

Try the hosted playground at <https://eyereasoner.github.io/eyeron/playground>. It runs all three formats — N3, SPARQL 1.2 RL, and Eyelang — entirely client-side via WebAssembly, with the packaged examples for each available to load.

To build and serve it locally, install `wasm-pack`, then run:

```bash
cargo playground
python3 -m http.server
```

Open <http://localhost:8000/playground.html>. The `cargo playground` alias runs the `eyeron-playground-build` helper, which rebuilds the `pkg/` WebAssembly package and removes generated files that are not needed by the playground.

For repeated browser or RDF-JS inference, construct one `EyeronSession`. Its N3 program is parsed and its forward-rule index is built once; each `reason` call uses an independent data batch:

```js
const session = new EyeronSession(runtimeN3, false);
const output = session.reason(messageNQuads, true, "nquads");
const report = JSON.parse(session.reasonReport(nextMessageNQuads, true, "nquads"));
session.free();
```

The constructor's second argument enables proof output. The two run arguments select RDF output and the input RDF syntax, matching `reasonWithData`. `reasonReport` includes iteration, matching, fact, and rule counts. The reasoning algorithm itself is not duplicated for Wasm; `src/wasm.rs` calls straight into the same core reasoner as the CLI and library.

## Testing

Run the complete optimized test suite with:

```bash
cargo test --release
```

The suite covers parser and built-in unit tests, CLI behavior, regressions, example outputs, proof goldens, the bundled Notation3 conformance suite, the local W3C RDF 1.1/1.2 manifest mirror, the local W3C SPARQL 1.2 RL manifest mirror (203/203), every packaged SPARQL-RL example (`tests/sparql_rl_examples.rs`, ~50 of them ported from eyeleng's own suite), and every packaged Eyelang example (`tests/eye.rs`) against its expected output and proof documents.

`cargo test` runs each test target as a separate process and prints each one's own pass/fail total, with no built-in way to sum them. For one grand total and elapsed time across every binary, run:

```bash
./scripts/test-all
```

This runs the same `cargo test --release` (forwarding any extra arguments, e.g. `./scripts/test-all --test examples`), forces color through the pipe, and appends a `Grand total: ok. N passed; ...` line at the end plus, since a handful of those "passed" checks each roll up hundreds of individual conformance cases (the W3C RDF and W3C SPARQL-RL harnesses, and the vendored notation3tests suite), a second line with that larger underlying case count.

Run the focused regression, packaged-example, or playground checks independently with:

```bash
cargo test --release --test regressions
cargo test --release --test examples
cargo test --release --test playground
cargo test --release --test sparql_rl
cargo test --release --test sparql_rl_examples
cargo test --release --test eye
```

`tests/examples.rs`, `tests/eye.rs`, and `tests/sparql_rl_examples.rs` each check every one of the 133 packaged examples in their format (`.n3`, `.eye`, `.srl`) — by golden match, by an expected-error assertion, or (for `.srl` alone) by running without checking exact output when it is inherently non-reproducible — and their summary lines (`n3 result: ...`, `eye result: ...`, `srl result: ...`) report that full count with a breakdown, not just the golden-matched subset. `cargo test` does not run specific test targets adjacently; to see all three summary lines back to back (with a combined grand total), pass all three explicitly:

```bash
./scripts/test-all --test examples --test eye --test sparql_rl_examples
```

Refresh both vendored upstream test suites with:

```bash
./scripts/sync-test-suites
```

This synchronizes `notation3tests` from Codeberg and refreshes the W3C RDF 1.x and W3C SPARQL 1.2 RL manifests from GitHub, running each manifest's checks with `--release`.

Run only the W3C RDF sweep with:

```bash
cargo test --release --test w3c_rdf
```

The W3C runner writes `reports/w3c-rdf-earl.ttl`. See `tests/w3c_rdf/README.md` for filtering, refresh, cache, verbosity, and EARL options.

Run only the W3C SPARQL-RL sweep with:

```bash
cargo test --release --test w3c_sparql_rl
```

This runs against the local mirror under `tests/w3c_sparql_rl/data-shapes/` and writes `reports/w3c-sparql-rl-earl.ttl`. `EYERON_W3C_SPARQL_RL_REFRESH`, `EYERON_W3C_SPARQL_RL_FILTER`, `EYERON_W3C_SPARQL_RL_VERBOSE`, `EYERON_W3C_SPARQL_RL_EARL`, and `EYERON_W3C_SPARQL_RL_CACHE_DIR` mirror the RDF runner's corresponding options. `cargo run --release --bin w3c_sparql_rl` runs the same suite but always fetches the manifest live.

For N3 example outputs, the test harness parses both the reasoner output and its golden and requires complete graph isomorphism: triple order and blank-node labels may differ, but missing or additional triples fail the test. SPARQL-RL example goldens are compared the same way, over the reasoner's `closure` (its `DATA` facts plus everything derived). Eyelang example goldens are compared byte for byte instead, since "Eyelang result format 2" output is fully deterministic and order-independent by construction.

## Examples

A small representative set — see [`docs/n3.md`](n3.md), [`docs/sparql-rl.md`](sparql-rl.md), and [`docs/eyelang.md`](eyelang.md) for more:

```bash
cargo run --release -- examples/socrates.n3
cargo run --release -- --proof examples/backward.n3
cargo run --release -- examples/family.srl
cargo run --release -- --proof examples/socrates.srl
cargo run --release -- --proof examples/socrates.eye
```

More inputs are available under `examples/`, with expected results in `examples/output/` and proof goldens in `examples/proof/`.

## Project layout

```text
src/                  Shared core (ast, error), CLI, and Wasm API
src/n3/               N3 front end: lexer, parser, reasoner, printing, proof
src/srl/              SPARQL 1.2 RL front end: lexer, parser, expression evaluator, forward/backward reasoner
src/eye/              Eyelang front end: lexer, parser, tabled evaluator, built-ins, proof/result output, RDF bridge
docs/                 Per-format documentation (N3, SPARQL 1.2 RL, Eyelang) and this development guide
examples/             N3, RDF Message, SPARQL-RL, and Eyelang examples
examples/output/      Expected derived output
examples/proof/       Expected proof output
tests/                CLI, regression, conformance, W3C RDF, SPARQL-RL, and Eyelang tests
tools/                Playground build helper
reports/              Generated and checked-in reports
```

## Suggested study exercises

1. Add a fact to `examples/socrates.n3`, run with `--ast`, and identify its `Term` variants.
2. Set a breakpoint in `src/n3/reasoner.rs`'s `match_term` and watch `Bindings` change as a rule matches.
3. Compare a one-premise rule with a two-premise rule and observe the agenda-index and general-matching paths described in [`docs/n3.md`'s implementation notes](n3.md#implementation-notes).
4. Follow `math:sum` from `eval_builtin` to its implementation, then write a tiny N3 program that uses it.
5. Run with and without `--proof` and compare the `ReasonerResult` data retained.
6. Add a small parser or reasoner regression test before modifying behavior.

## Current limitations

- Persistent stores and custom external built-in modules are not implemented.
- All three formats support proof output. Traces do not include every explanation detail; SPARQL-RL proofs record positive premises but do not separately reify `FILTER`, `NOT`, or `SET` clauses.
- Eyeron implements the features and built-ins documented for each format, not every extension in every historical implementation of that format.

Each format's own doc lists further limitations specific to it: [N3](n3.md#known-limitations), [SPARQL 1.2 RL](sparql-rl.md#known-limitations), [Eyelang](eyelang.md#known-limitations).
