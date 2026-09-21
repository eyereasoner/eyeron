# Why Eyeron?

Eyeron is useful when you want to turn explicit facts and rules into conclusions you can inspect, and run that reasoning in a command-line tool, a Rust application, or a browser. Its three languages offer different ways to express a problem; they share entry points, but have distinct evaluators and semantics.

## Choose the language that fits your data

| Need | Start with | Try |
| --- | --- | --- |
| Rules over RDF, quoted formulas, lists, or rules that generate rules | [Notation3](docs/n3.md) | `examples/socrates.n3` |
| RDF rules with SPARQL-style expressions, ordered clauses, and stratified negation | [SPARQL 1.2 RL](docs/sparql-rl.md) | `examples/socrates.srl` |
| Relations, recursive queries, and Prolog/Datalog-style syntax | [Eyelang](docs/eyelang.md) | `examples/socrates.eye` |

The three Socrates examples encode the same small inference: Socrates is human, humans are mortal, therefore Socrates is mortal. Run them and inspect a proof:

```bash
cargo build --release
./target/release/eyeron examples/socrates.n3
./target/release/eyeron examples/socrates.srl
./target/release/eyeron examples/socrates.eye
./target/release/eyeron --proof examples/socrates.srl
```

Output conventions differ: the N3 and SPARQL-RL CLI normally emit newly derived facts, while Eyelang answers the program's `ask` queries. The Rust APIs also expose the completed fact sets. Choosing a format is also choosing its semantics; changing the file extension does not translate a program.

## Inspect how a conclusion was reached

All three formats support `--proof`. N3 and SPARQL-RL retain rule applications, instantiated premises, and bindings when proof collection is enabled. Parsing with source information lets proofs refer to input files and lines. Eyelang provides its own proof format.

These traces help explain unexpected answers and review the rules behind a decision. They do not establish that the input facts are true. Proof coverage also has limits: SPARQL-RL traces record positive premises but do not separately reify every `FILTER`, `NOT`, or `SET` operation. Proof collection costs memory, so enable it when you need the explanation.

## Use the same implementation in different places

The native CLI supports files, standard input, and HTTP/HTTPS sources. The Rust library exposes parsed documents and reasoning results. The [browser playground](https://eyereasoner.github.io/eyeron/playground) runs the reasoning locally through WebAssembly, so it is a convenient place to explore examples without installing the CLI.

For repeated N3 workloads, `PreparedReasoner` in Rust and `EyeronSession` in the browser reuse a parsed program and its rule index across independent batches. Conclusions from one batch are not retained in the next. This fits applications that apply a stable rule set to successive messages; it is not a persistent database.

## Assess correctness and cost for your workload

Eyeron includes regression tests, expected example outputs, proof goldens, and bundled Notation3 and W3C RDF/SPARQL-RL conformance tests. Run `cargo test --release`, or `./scripts/test-all` for combined totals. The [development guide](docs/development.md#testing) explains individual suites and generated reports. Passing these tests is evidence for the covered cases, not a promise of support for every language extension.

N3 uses fact indexes and selective premise matching; SPARQL-RL indexes rule activation and maintains its matching graph incrementally; Eyelang uses a tabled evaluator. Performance still depends on the rule shape, joins, generated facts, and proof volume. Measure your own workload rather than assuming one language is always faster.

Reasoning can reach resource limits. Library integrations should inspect completion status and reported limits before treating a result as exhaustive. The high-level N3 `reason` function returns an error for incomplete evaluation. See each language's documentation for its controls and limitations.

## When to choose something else

Eyeron does not provide a persistent graph store or a general SPARQL query service. SPARQL-RL is a rule language, not a replacement for a full SPARQL query engine. The languages also differ in recursion and negation behavior, and not every extension from related reasoners is implemented.

Use Eyeron when explicit rules, inspectable results, and local execution fit the job. For an existing rule set, first run representative inputs and compare both answers and completion status. The per-language documentation is the place to check compatibility before migrating a larger application.
