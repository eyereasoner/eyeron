# Eyeron

**Eyeron** combines **Eye** with the sound of **iron**, reflecting explainable reasoning and its place in the Eyereasoner family.

Eyeron is a Rust reasoner for **Notation3 (N3)** and **SPARQL 1.2 RL**, turning facts and rules into conclusions with verifiable proofs. It can be used as a command-line program, embedded as a Rust library, or run in a browser through WebAssembly.

> [!TIP]
> [Try Eyeron in the browser](https://eyereasoner.github.io/eyeron/playground).

Read [how Eyeron reasons](docs/reasoning.md) for what each language's evaluator actually does, and the
[Eyeron guide](docs/guide.md) for choosing a language, building, embedding, testing, and the code layout.

## Two formats, one tool

| Format | File extension | Documentation |
| --- | --- | --- |
| Notation3 (N3) | `.n3` | [`docs/n3.md`](docs/n3.md) |
| SPARQL 1.2 RL ("SRL") | `.srl` | [`docs/sparql-rl.md`](docs/sparql-rl.md) |

Eyeron dispatches on a file's extension or by content sniffing (`RULE`/`DATA` blocks for SPARQL-RL, otherwise N3). Each doc above covers that format's syntax, semantics, CLI flags, internals, and known limitations in depth.

```bash
cargo build --release
./target/release/eyeron examples/socrates.n3    # N3: forward/backward Horn rules over an RDF graph
./target/release/eyeron examples/family.srl     # SPARQL 1.2 RL: RULE { head } WHERE [DATA] { body }
```

## Documentation

- [`docs/n3.md`](docs/n3.md), [`docs/sparql-rl.md`](docs/sparql-rl.md) — per-format syntax, semantics, CLI flags, internals, and known limitations.
- [`docs/reasoning.md`](docs/reasoning.md) — how each language's evaluator searches, and why the same program gives proofs of different sizes.
- [`docs/guide.md`](docs/guide.md) — choosing a language, building and running, proofs, the Rust library and browser APIs, testing, and the architecture.
- [`docs/proof-checking.md`](docs/proof-checking.md) — what makes a proof document valid for a program, and what `--check-proof` verifies.

## License

MIT. See `LICENSE.md`.
