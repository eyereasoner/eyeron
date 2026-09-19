# Eyeron

**Eyeron** combines **Eye** with the sound of **iron**, reflecting explainable reasoning and its place in the Eyereasoner family.

Eyeron is a Rust reasoner for **Notation3 (N3)**, **SPARQL 1.2 RL**, and **Eyelang**, turning facts and rules into conclusions with verifiable proofs. It can be used as a command-line program, embedded as a Rust library, or run in a browser through WebAssembly.

> [!TIP]
> [Try Eyeron in the browser](https://eyereasoner.github.io/eyeron/playground).

## Three formats, one engine

| Format | File extension | Documentation |
| --- | --- | --- |
| Notation3 (N3) | `.n3` | [`docs/n3.md`](docs/n3.md) |
| SPARQL 1.2 RL ("SRL") | `.srl` | [`docs/sparql-rl.md`](docs/sparql-rl.md) |
| Eyelang ("eye") | `.eye` | [`docs/eyelang.md`](docs/eyelang.md) ([language specification](docs/eyelang-specification.md)) |

Eyeron dispatches on a file's extension, or by content-sniffing (a `RULE`/`DATA` block for SPARQL-RL, an `ask ...`/`identifier(...)` statement for Eyelang, otherwise N3). Each doc above covers that format's syntax, semantics, CLI flags, internals, and known limitations in depth.

```bash
cargo build --release
./target/release/eyeron examples/socrates.n3    # N3: forward/backward Horn rules over an RDF graph
./target/release/eyeron examples/family.srl     # SPARQL 1.2 RL: RULE { head } WHERE [DATA] { body }
./target/release/eyeron examples/ancestor.eye   # Eyelang: Prolog/Datalog-style logic programming
```

## Documentation

- [`docs/n3.md`](docs/n3.md), [`docs/sparql-rl.md`](docs/sparql-rl.md), [`docs/eyelang.md`](docs/eyelang.md) ([specification](docs/eyelang-specification.md)) — per-format syntax, semantics, CLI flags, internals, and known limitations.
- [`docs/development.md`](docs/development.md) — building, the architecture overview, the Rust library API, the browser playground, and testing.

## License

MIT. See `LICENSE.md`.
