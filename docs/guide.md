# Eyeron guide

Eyeron turns facts and rules into conclusions you can inspect from a command line, a Rust application, or a browser. It supports [Notation3](n3.md) and [SPARQL 1.2 RL](sparql-rl.md). Their syntax, evaluator behavior, and limitations are documented separately.

## Choosing a language

| Need | Start with | Try |
| --- | --- | --- |
| RDF rules, quoted formulas, lists, or rules that generate rules | [N3](n3.md) | `examples/socrates.n3` |
| RDF rules with SPARQL expressions, ordered clauses, or stratified negation | [SRL](sparql-rl.md) | `examples/socrates.srl` |

N3 emits newly derived facts. SRL emits its inference graph, which contains the rule set's own `DATA` facts not present in the base graph and everything derived. See [how Eyeron reasons](reasoning.md) for the evaluation strategies.

## Building and running

```bash
cargo build --release
./target/release/eyeron examples/socrates.n3
./target/release/eyeron examples/socrates.srl
cargo run --release -- --data facts.ttl rules.srl
cargo run --release -- --query '{ ?x :descendedFrom :C }' examples/family.srl
```

The executable chooses a format by file extension or by content sniffing for stdin and URLs. Multiple files merge into one document. Use `-` to read standard input. `eyeron --help` lists the CLI flags.

## Proofs

Both formats support `--proof`. A proof starts with its claims, followed by steps that record the conclusion, why it holds, the bindings used, and its premises. Each proof is a document in the language that produced it.

| One step | N3 | SRL |
| --- | --- | --- |
| Conclusion | `{ s p o }` as subject | `_:stepN rdf:reifies <<(s p o)>>` |
| Reason | `pe:rule N`, `pe:fact`, `pe:builtin`, or `pe:unproven` | the same predicates |
| Bindings | `pe:binding [ pe:var "X"; pe:value V ]` | the same |
| Premises | `pe:uses { s p o }` | `pe:uses _:stepK` |

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

For lower-level integration, use `parse_n3`, `parse_rdf12`, or `parse_rdf_message_log`, then `reason_document`. The `ReasonerResult` reports completion status, limits, statistics, derived facts, and proof data. For SRL, use the `eyeron::srl` parser and reasoner. `PreparedReasoner` parses an N3 program and builds its forward-rule index once for independent data batches.

## Browser playground

The [playground](https://eyereasoner.github.io/eyeron/playground) runs N3 and SRL in WebAssembly and includes the packaged examples. To build and serve it locally:

```bash
cargo playground
python3 -m http.server
```

Open <http://localhost:8000/playground.html>. The `cargo playground` alias rebuilds the committed `pkg/` Wasm package. Browser and native entry points use the same Rust reasoners.

## Testing

```bash
cargo test --release
./scripts/test-all
cargo test --release --test examples
cargo test --release --test sparql_rl_examples
cargo test --release --test playground
cargo test --release --test proof_checking
```

The suite includes unit and CLI tests, example outputs and proofs, the Notation3 conformance suite, the local W3C RDF manifest mirror, and the W3C SPARQL 1.2 RL mirror. `scripts/test-all` prints a grand total across test binaries. N3 and SRL graph output is compared by graph isomorphism so triple order and blank-node labels may differ, while missing or extra triples fail. N3 Markdown reports are checked against their stable expected lines.

The N3 and SRL example suites print separate output and proof passes. Each proof line shows generation and golden-comparison time. Proofs match their saved goldens exactly, except `age.n3`, whose current clock value and derived elapsed duration are normalized before comparison.

## Repository map

| Path | Responsibility |
| --- | --- |
| `src/ast.rs` | Shared terms, triples, rules, and documents |
| `src/n3/` | N3 parser, reasoner, printing, and proofs |
| `src/srl/` | SRL parser, evaluator, stratification, reasoning, printing, and proofs |
| `src/proof/` | Proof checker and a reader for each syntax |
| `src/main.rs` | Native CLI |
| `src/wasm.rs` | Browser interface |
| `examples/` | Inputs with expected outputs and proofs |
| `tests/` | Unit, CLI, example, proof, and conformance tests |

Reasoning can hit resource limits. Library users should inspect completion status before treating a result as exhaustive. Eyeron is not a persistent graph store or general SPARQL query service.
