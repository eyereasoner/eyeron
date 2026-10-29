# <img src="assets/eye.png" alt="" width="48" height="48" align="absmiddle"> Eyeron

[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.23746168-blue.svg)](https://doi.org/10.5281/zenodo.23746168)
[![crates.io](https://img.shields.io/crates/v/eyeron.svg)](https://crates.io/crates/eyeron)

Eyeron is a Rust reasoner for **Notation3 (N3)**. It derives conclusions from
facts and rules, writes N3 proofs, and checks those proofs. It runs as a
command-line program, a Rust library, and a browser application.

- **[Playground](https://eyereasoner.github.io/eyeron/playground)**: run N3 in
  your browser.
- **[Guide](GUIDE.md)**: build, run, check proofs, use the library, and develop
  Eyeron.
- **[Specification](SPEC.md)**: the language, its evaluation, and the C1–C9
  proof contract.
- **[Examples](examples/)**: runnable programs, with their expected output in
  [`examples/output/`](examples/output/).

```n3
@prefix : <http://example.org/socrates#> .

:Socrates a :Human .
{ ?person a :Human . } => { ?person a :Mortal . } .
```

```sh
cargo run --release -- examples/socrates.n3
cargo run --release -- -c examples/socrates.n3
```

MIT licensed; see [LICENSE.md](LICENSE.md).
