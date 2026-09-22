# Eyeron guide

Eyeron turns explicit facts and rules into conclusions you can inspect, from a command line, a Rust application, or a browser. This page covers choosing between its three languages, running and embedding it, testing, and finding your way around the code. Each language's own syntax, semantics, CLI flags, and internals live in [`n3.md`](n3.md), [`sparql-rl.md`](sparql-rl.md), and [`prolog.md`](prolog.md).

## Choosing a language

| Need | Start with | Try |
| --- | --- | --- |
| Rules over RDF, quoted formulas, lists, or rules that generate rules | [Notation3](n3.md) | `examples/socrates.n3` |
| RDF rules with SPARQL-style expressions, ordered clauses, and stratified negation | [SPARQL 1.2 RL](sparql-rl.md) | `examples/socrates.srl` |
| Predicates, recursive queries, logic programming, or a program that reasons about its own clauses | [Prolog](prolog.md) | `examples/socrates.pl` |

The three Socrates examples encode the same inference — Socrates is human, humans are mortal, therefore Socrates is mortal:

```bash
cargo build --release
./target/release/eyeron examples/socrates.n3
./target/release/eyeron examples/socrates.srl
./target/release/eyeron examples/socrates.pl
```

The languages share entry points but not evaluators or semantics, so changing a file extension does not translate a program. Output conventions differ too: N3 emits newly derived facts, SPARQL-RL emits its inference graph (the rule set's own `DATA` facts the base graph does not already carry, plus everything derived), and Prolog answers the program's `?-` directives. The Rust and browser APIs also expose the completed fact sets.

## Building and running

```bash
cargo build --release
```

The executable lands in `target/release/eyeron`. Input format follows the file extension, or content sniffing for stdin and URLs. Several files (and `http(s)` URLs) merge into one document, and `-` reads standard input:

```bash
cargo run --release -- examples/socrates.n3
cargo run --release -- --proof examples/backward.n3
cargo run --release -- examples/family.srl
cargo run --release -- --data facts.ttl rules.srl
cargo run --release -- --query '{ ?x :descendedFrom :C }' examples/family.srl
printf '@prefix : <http://example.org/> . :Socrates a :Man . { ?x a :Man . } => { ?x a :Mortal . } .' \
  | cargo run --release -- -
```

`eyeron`, `eyeron -h`, or no arguments at all prints the help, which lists every flag.

## Proofs

All three formats support `--proof`. N3 and SPARQL-RL retain rule applications, instantiated premises, and bindings when proof collection is enabled; Prolog has its own proof format. An N3 proof is an N3 document, a SPARQL-RL proof is an `.srl` rule set whose `DATA` block reifies one step per derived fact, and a Prolog proof is a Prolog result document — so each can be read back by the engine that produced it.

```bash
cargo run --release -- --proof examples/socrates.srl
cargo run --release -- --proof examples/socrates.pl
```

A trace explains how an answer followed from the input; it does not establish that the input facts are true. Coverage has limits: SPARQL-RL records the positive premises that fed a rule, not a separate reification of every `FILTER`, `NOT`, or `SET`. Proof collection costs memory and, for a derivation with many interdependent facts, time — enable it when you want the explanation.

## Rust library

The high-level API parses N3, reasons, and returns the derived output:

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

For lower-level integration, use `parse_n3`, `parse_rdf12`, or `parse_rdf_message_log`, then `reason_document`. The returned `ReasonerResult` reports completion status, reached safety limits, semantic errors, statistics, derived facts, and proof data. `eyeron::srl` and `eyeron::prolog` expose the corresponding entry points for the other two formats — see [`prolog.md`'s Rust API section](prolog.md#rust-api) for Prolog's.

For repeated N3 workloads, `PreparedReasoner` parses the program and builds its forward-rule index once, then reasons over independent data batches. Conclusions from one batch are not carried into the next: this suits applying a stable rule set to successive messages, and is not a persistent store.

## Browser playground

The hosted playground is at <https://eyereasoner.github.io/eyeron/playground>. It runs all three formats client-side through WebAssembly, with the packaged examples available to load. To build and serve it locally, install `wasm-pack`, then:

```bash
cargo playground
python3 -m http.server
```

Open <http://localhost:8000/playground.html>. The `cargo playground` alias runs the `eyeron-playground-build` helper, which rebuilds the `pkg/` WebAssembly package and drops generated files the playground does not need.

`EyeronSession` is the browser counterpart of `PreparedReasoner`:

```js
const session = new EyeronSession(runtimeN3, false);
const output = session.reason(messageNQuads, true, "nquads");
const report = JSON.parse(session.reasonReport(nextMessageNQuads, true, "nquads"));
session.free();
```

The constructor's second argument enables proof output. The two run arguments select RDF output and the input RDF syntax, matching `reasonWithData`. `reasonReport` adds iteration, matching, fact, and rule counts. The reasoning algorithm is not duplicated for Wasm; `src/wasm.rs` calls the same core reasoner as the CLI and library.

## Testing

```bash
cargo test --release          # everything
./scripts/test-all            # everything, plus one grand total
```

The suite covers parser and built-in unit tests, CLI behavior, regressions, example outputs, proof goldens, the Prolog conformance cases, the bundled Notation3 conformance suite, the local W3C RDF 1.1/1.2 manifest mirror, and the local W3C SPARQL 1.2 RL mirror (203/203).

`cargo test` runs each target as its own process and prints a separate total, with no way to sum them. `./scripts/test-all` forwards any extra arguments to `cargo test --release`, forces color through the pipe, and appends a `Grand total: ok. N passed; ...` line — plus a second line with the larger underlying case count, since a few of those checks each roll up hundreds of conformance cases.

Focused runs:

```bash
cargo test --release --test regressions
cargo test --release --test examples            # .n3 examples
cargo test --release --test sparql_rl_examples  # .srl examples
cargo test --release --test prolog             # .pl examples
cargo test --release --test sparql_rl           # SRL CLI flags and rule-set behavior
cargo test --release --test prolog_conformance # Prolog, case by case against the accepted subset
cargo test --release --test playground
```

`tests/prolog_conformance.rs` holds the Prolog front end to [`prolog-specification.md`](prolog-specification.md). Its cases live in `tests/prolog_conformance/cases.txt`, one per normative statement: a small program, the statement it pins, and either the result document it must produce or a substring of the error it must raise. Because the language is ISO/IEC 13211-1 Prolog rather than a local invention, most of those cases can be held against an external authority too — `scripts/prolog-conformance` runs every case that stays inside the pure subset through whichever of SWI-Prolog, GNU Prolog, SICStus and Scryer are installed and compares answer sets, while `--update` refills the expectations:

```bash
scripts/prolog-conformance            # report agreement with real Prolog systems
scripts/prolog-conformance --update   # refill the expectations
```

`tests/examples.rs`, `tests/sparql_rl_examples.rs`, and `tests/eye.rs` each account for every one of the 133 packaged examples in their format — by golden match, by an expected-error assertion, or, where output is inherently non-reproducible, by running without comparing it. Their summary lines (`n3 result: ...`, `srl result: ...`, `eye result: ...`) report that full count with a breakdown. To see all three adjacently under one total:

```bash
./scripts/test-all --test examples --test eye --test sparql_rl_examples
```

Golden comparison differs per format. N3 and SPARQL-RL outputs are compared by full graph isomorphism — triple order and blank-node labels may differ, missing or extra triples fail — over derived output for N3 and over the inference graph for SPARQL-RL. Prolog goldens are compared byte for byte, since that result format is deterministic and order-independent by construction.

The two W3C sweeps can run alone, and each writes an EARL report under `reports/`:

```bash
cargo test --release --test w3c_rdf          # reports/w3c-rdf-earl.ttl
cargo test --release --test w3c_sparql_rl    # reports/w3c-sparql-rl-earl.ttl
```

`tests/w3c_rdf/README.md` documents filtering, refresh, cache, verbosity, and EARL options; `EYERON_W3C_SPARQL_RL_REFRESH`, `_FILTER`, `_VERBOSE`, `_EARL`, and `_CACHE_DIR` mirror them for the SPARQL-RL runner, whose `cargo run --release --bin w3c_sparql_rl` variant always fetches the manifest live. Refresh both vendored suites with `./scripts/sync-test-suites`.

## Architecture

The implementation resembles both a compiler and a database query engine. Each format has its own front end; all three share the CLI, library, and Wasm entry points:

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
                                ▼                          ▼
                             printing                    proof
```

`src/error.rs`'s `EyeronError` carries a message and an optional byte offset; the lexer and parser attach offsets, and `with_source_location` turns them into file/line/column information.

### Shared N3/RDF core (`src/ast.rs`)

N3 and, partly, SPARQL 1.2 RL share one term/triple/document model:

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

An enum fits because a term is exactly one of these; the recursive `List` and `Formula` variants allow arbitrarily nested data. `Term::is_ground` checks recursively for variables — groundness matters because a ground fact is established knowledge while a variable-carrying triple is a pattern. `Triple` holds subject, predicate, and object; `Rule` holds premise and conclusion triples plus flags for forward rules, backward rules, and queries; `Document` is the parser's product (prefixes, base IRI, explicit facts, source locations, rules), and `Document::merge` makes multi-file input simple. Many of these types derive `Eq`, `Ord`, and `Hash`, so the reasoner can index terms and triples for deterministic output and duplicate detection.

The Prolog front end (`src/prolog/`) does not use this model — see [`prolog.md`'s implementation notes](prolog.md#implementation-notes) for why it has its own term type.

### Repository map

| Path | Responsibility |
| --- | --- |
| `src/ast.rs` | Terms, triples, rules, documents |
| `src/error.rs` | Error type and source-position reporting |
| `src/lib.rs` | Public Rust library API and module exports |
| `src/main.rs` | Native command-line interface |
| `src/wasm.rs` | WebAssembly/browser interface |
| `src/n3/` | N3 front end: lexer, parser, reasoner, printing, proof ([`n3.md`](n3.md)) |
| `src/srl/` | SPARQL 1.2 RL front end: lexer, parser, expression evaluator, stratification, forward/backward reasoners, printing, proof ([`sparql-rl.md`](sparql-rl.md)) |
| `src/prolog/` | Prolog front end: lexer, operator table, reader, term model, tabled evaluator, built-ins, proof/result output, RDF bridge ([`prolog.md`](prolog.md)) |
| `src/bin/` | Conformance-runner binaries |
| `examples/` | Example inputs, with `examples/output/` and `examples/proof/` holding expected results and proofs |
| `tests/` | Unit, CLI, regression, example, Prolog conformance, and W3C conformance tests |
| `tools/` | Playground build helper |
| `scripts/` | `test-all`, `sync-test-suites`, and `prolog-conformance` |
| `reports/` | Generated, checked-in EARL reports |

## Performance, limits, and correctness

N3 uses fact indexes and selective premise matching, SPARQL-RL indexes rule activation and maintains its matching graph incrementally, and the Prolog front end uses a tabled evaluator. Which is fastest depends on rule shape, joins, generated facts, and proof volume, so measure your own workload rather than assuming.

Reasoning can reach resource limits. A library integration should inspect completion status and reported limits before treating a result as exhaustive; the high-level N3 `reason` function turns incomplete evaluation into an error. Passing the packaged tests is evidence for the cases they cover, not a guarantee for every extension of a language.

Across all three formats:

- Persistent stores and custom external built-in modules are not implemented.
- Proof traces do not include every explanation detail.
- Each format implements what its own doc documents, not every extension of every related implementation.

Each format's doc lists its own further limitations: [N3](n3.md#known-limitations), [SPARQL 1.2 RL](sparql-rl.md#known-limitations), [Prolog](prolog.md#known-limitations).

Eyeron is not a persistent graph store or a general SPARQL query service, and SPARQL-RL is a rule language rather than a replacement for a SPARQL query engine. For an existing rule set, run representative inputs and compare both the answers and the completion status before migrating.

## Study exercises

1. Add a fact to `examples/socrates.n3`, run with `--ast`, and identify its `Term` variants.
2. Break in `src/n3/reasoner.rs`'s `match_term` and watch `Bindings` change as a rule matches.
3. Compare a one-premise rule with a two-premise rule, and follow the agenda-index and general-matching paths in [`n3.md`'s implementation notes](n3.md#implementation-notes).
4. Follow `math:sum` from `eval_builtin` to its implementation, then write a small N3 program that uses it.
5. Run with and without `--proof` and compare the `ReasonerResult` data retained.
6. Add a parser or reasoner regression test before changing behavior.
