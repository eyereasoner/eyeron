# Eyeron

**Eyeron** combines **Eye** with the sound of **iron**, reflecting explainable reasoning and its place in the Eyereasoner family.

Eyeron is a Rust reasoner for **Notation3 (N3)**, **SPARQL 1.2 RL**, and **Eyelang**, turning facts and rules into conclusions with verifiable proofs. It can be used as a command-line program, embedded as a Rust library, or run in a browser through WebAssembly.

> [!TIP]
> **Start here:** [Learn how Eyeron's source code works](SOURCE_CODE_GUIDE.md), or [try Eyeron now in the browser](https://eyereasoner.github.io/eyeron/playground).

## Three formats, one engine

| Format | File extension | Documentation |
| --- | --- | --- |
| Notation3 (N3) | `.n3` | [`docs/n3.md`](docs/n3.md) |
| SPARQL 1.2 RL ("SRL") | `.srl` | [`docs/sparql-rl.md`](docs/sparql-rl.md) |
| Eyelang ("eye") | `.eye` | [`docs/eyelang.md`](docs/eyelang.md) ([language specification](docs/eyelang-specification.md)) |

Eyeron dispatches on a file's extension, or by content-sniffing (an `RULE`/`DATA` block for SPARQL-RL, an `ask ...`/`identifier(...)` statement for Eyelang, otherwise N3). Each doc above covers that format's syntax, semantics, CLI flags, and known limitations in depth; this README stays high level.

```bash
cargo run --release -- examples/socrates.n3    # N3: forward/backward Horn rules over an RDF graph
cargo run --release -- examples/family.srl     # SPARQL 1.2 RL: RULE { head } WHERE [DATA] { body }
cargo run --release -- examples/ancestor.eye   # Eyelang: Prolog/Datalog-style logic programming
```

## Build

```bash
cargo build --release
```

The executable is written to `target/release/eyeron`.

## Command-line use

Run a file the same way regardless of format; multiple files (and HTTP/HTTPS URLs) are merged into one document, and `-` reads standard input:

```bash
cargo run --release -- examples/socrates.n3
cargo run --release -- --proof examples/socrates.n3
printf '@prefix : <http://example.org/> . :Socrates a :Man . { ?x a :Man . } => { ?x a :Mortal . } .' \
  | cargo run --release -- -
```

Run `eyeron`, `eyeron -h`, or `eyeron --help` to display help. Running without arguments is equivalent to `-h`. See each format's doc (above) for its own flags — `--rdf`/`--stream-messages` for N3, `--data`/`--query`/`--query-mode` for SPARQL-RL, `--check`/`--json`/`--rdf-input`/`--rdf-output`/`--max-steps` for Eyelang.

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

For lower-level integration, use `parse_n3`, `parse_rdf12`, or `parse_rdf_message_log`, followed by `reason_document`. The returned `ReasonerResult` reports completion status, reached safety limits, semantic errors, statistics, derived facts, and proof data. `eyeron::srl` and `eyeron::eye` expose the corresponding APIs for the other two formats.

## Browser playground

Try the hosted playground at <https://eyereasoner.github.io/eyeron/playground>. It runs all three formats — N3, SPARQL 1.2 RL, and Eyelang — entirely client-side via WebAssembly, with the packaged examples for each available to load.

To build and serve it locally, install `wasm-pack`, then run:

```bash
cargo playground
python3 -m http.server
```

Open <http://localhost:8000/playground.html>. The `cargo playground` alias runs the `eyeron-playground-build` helper, which rebuilds the `pkg/` WebAssembly package and removes generated files that are not needed by the playground.

For repeated browser or RDF-JS inference, construct one `EyeronSession`. Its
N3 program is parsed and its forward-rule index is built once; each `reason`
call uses an independent data batch:

```js
const session = new EyeronSession(runtimeN3, false);
const output = session.reason(messageNQuads, true, "nquads");
const report = JSON.parse(session.reasonReport(nextMessageNQuads, true, "nquads"));
session.free();
```

The constructor's second argument enables proof output. The two run arguments
select RDF output and the input RDF syntax, matching `reasonWithData`.
`reasonReport` includes iteration, matching, fact, and rule counts.

## Testing

Run the complete optimized test suite with:

```bash
cargo test --release
```

The suite covers parser and built-in unit tests, CLI behavior, regressions, example outputs, proof goldens, the bundled Notation3 conformance suite, the local W3C RDF 1.1/1.2 manifest mirror, the live W3C SPARQL 1.2 RL manifest (203/203; this one needs network access, unlike the other suites here), and every packaged Eyelang example (`tests/eye.rs`) against its expected output and proof documents.

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
cargo test --release --test eye
```

Refresh both vendored upstream test suites with:

```bash
./scripts/sync-test-suites
```

This synchronizes `notation3tests` from Codeberg, refreshes the W3C RDF 1.x manifests from GitHub, and runs the RDF manifest checks with `--release`.

Run only the W3C RDF sweep with:

```bash
cargo test --release --test w3c_rdf
```

The W3C runner writes `reports/w3c-rdf-earl.ttl`. See `tests/w3c_rdf/README.md` for filtering, refresh, cache, verbosity, and EARL options.

Run only the W3C SPARQL-RL sweep with:

```bash
cargo test --release --test w3c_sparql_rl
```

This always fetches the live manifest (no local mirror yet) and writes `reports/w3c-sparql-rl-earl.ttl`. `EYERON_W3C_SPARQL_RL_FILTER`, `EYERON_W3C_SPARQL_RL_VERBOSE`, and `EYERON_W3C_SPARQL_RL_EARL` mirror the RDF runner's corresponding options.

## Examples

A small representative set — see [`docs/n3.md`](docs/n3.md), [`docs/sparql-rl.md`](docs/sparql-rl.md), and [`docs/eyelang.md`](docs/eyelang.md) for more:

```bash
cargo run --release -- examples/socrates.n3
cargo run --release -- --proof examples/backward.n3
cargo run --release -- examples/family.srl
cargo run --release -- --proof examples/socrates.eye
```

More inputs are available under `examples/`, with expected results in `examples/output/` and proof goldens in `examples/proof/`.

## Current limitations

- Persistent stores and custom external built-in modules are not implemented.
- Proof output does not yet include every possible trace comment or explanation detail, and is not yet implemented at all for `.srl` input.
- Eyeron implements the features and built-ins documented for each format, not every extension in every historical implementation of that format.

Each format's own doc ([N3](docs/n3.md#known-limitations), [SPARQL 1.2 RL](docs/sparql-rl.md#known-limitations), [Eyelang](docs/eyelang.md#known-limitations)) lists further limitations specific to it.

## Project layout

```text
src/                  Shared core (ast, error), CLI, and Wasm API
src/n3/               N3 front end: lexer, parser, reasoner, printing, proof
src/srl/              SPARQL 1.2 RL front end: lexer, parser, expression evaluator, forward/backward reasoner
src/eye/              Eyelang front end: lexer, parser, tabled evaluator, built-ins, proof/result output, RDF bridge
docs/                 Per-format documentation (N3, SPARQL 1.2 RL, Eyelang)
examples/             N3, RDF Message, SPARQL-RL, and Eyelang examples
examples/output/      Expected derived output
examples/proof/       Expected proof output
tests/                CLI, regression, conformance, W3C RDF, SPARQL-RL, and Eyelang tests
tools/                Playground build helper
reports/              Generated and checked-in reports
```

## License

MIT. See `LICENSE.md`.
