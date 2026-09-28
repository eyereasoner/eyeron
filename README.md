# Eyeron

**Eyeron** combines **Eye** with the sound of **iron**, reflecting explainable reasoning and its place in the Eyereasoner family.

Eyeron is a Rust reasoner for **Notation3 (N3)**, turning facts and rules into conclusions with verifiable proofs. It can be used as a command-line program, embedded as a Rust library, or run in a browser through WebAssembly.

> [!TIP]
> [Try Eyeron in the browser](https://eyereasoner.github.io/eyeron/playground).

Read [how Eyeron reasons](docs/reasoning.md) for what the evaluator actually does, and the
[Eyeron guide](docs/guide.md) for building, embedding, testing, and the code layout.

## Input syntaxes

| Syntax | File extension |
| --- | --- |
| Notation3 (N3) | `.n3` |
| Turtle, TriG | `.ttl`, `.trig` |
| N-Triples, N-Quads | `.nt`, `.nq` |
| RDF Message Log | any, recognized by its `VERSION "*-messages"` directive |

Rules are written in N3; the RDF syntaxes carry the data those rules reason over, and any mixture of them can be given in one run. Eyeron dispatches on a file's extension or by content sniffing. [`docs/n3.md`](docs/n3.md) covers the syntax, semantics, CLI flags, internals, and known limitations in depth.

```bash
cargo build --release
./target/release/eyeron examples/socrates.n3               # forward/backward Horn rules over an RDF graph
./target/release/eyeron examples/rdf-messages.n3 examples/input/rdf-messages.trig
```

## Documentation

- [`docs/n3.md`](docs/n3.md) — syntax, semantics, resource limits, CLI flags, internals, and known limitations.
- [`docs/reasoning.md`](docs/reasoning.md) — how Eyeron evaluates rules, and what it prints and records in proofs.
- [`docs/guide.md`](docs/guide.md) — building and running, proofs, the Rust library and browser APIs, testing, and the architecture.
- [`docs/proof-checking.md`](docs/proof-checking.md) — what makes a proof document valid for a program, and what `--check-proof` verifies.
- [`docs/verifiable-reasoning.md`](docs/verifiable-reasoning.md) — deriving an answer, proving it, checking the proof, and writing a policy about what the proof rests on.

## License

MIT. See `LICENSE.md`.
