# Eyeron

**Eyeron** combines **Eye** with the sound of **iron**, reflecting explainable reasoning and its place in the Eyereasoner family.

Eyeron is a Rust reasoner for **Notation3 (N3)**, **SPARQL 1.2 RL**, and **Prolog**, turning facts and rules into conclusions with verifiable proofs. It can be used as a command-line program, embedded as a Rust library, or run in a browser through WebAssembly.

> [!TIP]
> [Try Eyeron in the browser](https://eyereasoner.github.io/eyeron/playground).

Read the [Eyeron guide](docs/guide.md) for choosing a language, building, embedding, testing, and the code layout.

## Three formats, one tool

| Format | File extension | Documentation |
| --- | --- | --- |
| Notation3 (N3) | `.n3` | [`docs/n3.md`](docs/n3.md) |
| SPARQL 1.2 RL ("SRL") | `.srl` | [`docs/sparql-rl.md`](docs/sparql-rl.md) |
| Prolog | `.pl` | [`docs/prolog.md`](docs/prolog.md) ([accepted subset](docs/prolog-specification.md)) |

Eyeron dispatches on a file's extension, or by content-sniffing (a `RULE`/`DATA` block for SPARQL-RL, a `?-` directive or a clause head for Prolog, otherwise N3). Each doc above covers that format's syntax, semantics, CLI flags, internals, and known limitations in depth.

```bash
cargo build --release
./target/release/eyeron examples/socrates.n3    # N3: forward/backward Horn rules over an RDF graph
./target/release/eyeron examples/family.srl     # SPARQL 1.2 RL: RULE { head } WHERE [DATA] { body }
./target/release/eyeron examples/ancestor.pl    # Prolog: the pure, tabled subset of ISO/IEC 13211-1
```

## Documentation

- [`docs/n3.md`](docs/n3.md), [`docs/sparql-rl.md`](docs/sparql-rl.md), [`docs/prolog.md`](docs/prolog.md) ([accepted subset](docs/prolog-specification.md)) — per-format syntax, semantics, CLI flags, internals, and known limitations.
- [`docs/guide.md`](docs/guide.md) — choosing a language, building and running, proofs, the Rust library and browser APIs, testing, and the architecture.

## License

MIT. See `LICENSE.md`.
