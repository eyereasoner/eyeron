# Eyeron guide

Eyeron turns facts and rules into conclusions you can inspect from a command line, a Rust application, or a browser. Rules are written in [Notation3](n3.md); the data they reason over may be N3, Turtle, TriG, N-Triples, N-Quads, or an RDF Message Log. A run emits the newly derived facts. See [how Eyeron reasons](reasoning.md) for the evaluation strategy, and [verifiable reasoning](verifiable-reasoning.md) for handing someone an answer they can check without running the engine.

## Building and running

```bash
cargo build --release
./target/release/eyeron examples/socrates.n3
./target/release/eyeron rules.n3 facts.ttl
```

The executable chooses a syntax by file extension or by content sniffing for stdin and URLs. Multiple files merge into one document. Use `-` to read standard input. `eyeron --help` lists the CLI flags.

## Proofs

`--proof` writes a proof as an N3 document: its claims, followed by steps that record the conclusion, why it holds, the bindings used, and its premises.

| One step | Written as |
| --- | --- |
| Conclusion | `{ s p o }` as subject |
| Reason | `pe:rule N`, `pe:fact`, `pe:builtin`, or `pe:unproven` |
| Bindings | `pe:binding [ pe:var "X"; pe:value V ]` |
| Premises | `pe:uses { s p o }` |

```bash
cargo run --release -- --proof examples/socrates.n3 > socrates.why.n3
cargo run --release -- --check-proof socrates.why.n3 examples/socrates.n3
```

The checker re-performs each recorded inference against the source program, resolves premises, and detects cycles. See [proof checking](proof-checking.md) for its validity rules. A proof explains how a conclusion follows from the given facts; it does not establish that those facts are true. Proof collection costs memory, so enable it when you need the explanation.

## Rust library

The high-level API parses N3, reasons, and returns derived output:

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

For lower-level integration, use `parse_n3`, `parse_rdf12`, or `parse_rdf_message_log`, then `reason_document`. The `ReasonerResult` reports completion status, limits, statistics, derived facts, and proof data. `PreparedReasoner` parses an N3 program and builds its forward-rule index once for independent data batches.

## Browser playground

The [playground](https://eyereasoner.github.io/eyeron/playground) runs Eyeron in WebAssembly and includes the packaged examples. To build and serve it locally:

```bash
cargo playground
python3 -m http.server
```

Open <http://localhost:8000/playground.html>. The `cargo playground` alias rebuilds the committed `pkg/` Wasm package. Browser and native entry points use the same Rust reasoner.

## Testing

```bash
cargo test --release
./scripts/test-all
cargo test --release --test examples
cargo test --release --test playground
cargo test --release --test proof_checking
```

The suite includes unit and CLI tests, example outputs and proofs, the Notation3 conformance suite, and the local W3C RDF manifest mirror. `scripts/test-all` prints a grand total across test binaries. Graph output is compared by graph isomorphism so triple order and blank-node labels may differ, while missing or extra triples fail. Markdown reports are checked against their stable expected lines.

The example suite reasons over each example once and checks that single run against both of its goldens, the derived output and the proof. Proofs match their saved goldens exactly, except `age.n3`, whose current clock value and derived elapsed duration are normalized before comparison.

## Repository map

| Path | Responsibility |
| --- | --- |
| `src/ast.rs` | Shared terms, triples, rules, and documents |
| `src/lexer.rs`, `src/parser.rs`, `src/rdf_compat.rs` | N3, Turtle, TriG and N-Triples/N-Quads front end |
| `src/reasoner.rs` | Forward and backward reasoning |
| `src/printing.rs` | N3, TriG and JSON output |
| `src/proof_writer.rs` | Writes an N3 proof of what was derived |
| `src/proof_check.rs`, `src/proof_check_n3.rs` | Proof checker and its N3 reader |
| `src/main.rs` | Native CLI |
| `src/wasm.rs` | Browser interface |
| `examples/` | Inputs with expected outputs and proofs |
| `tests/` | Unit, CLI, example, proof, and conformance tests |

Reasoning can hit resource limits. Library users should inspect completion status before treating a result as exhaustive. Eyeron is not a persistent graph store or a query service.
