# SPARQL 1.2 RL ("SRL")

SPARQL 1.2 RL is a W3C Working-Draft Datalog-style rule language. It borrows SPARQL's lexical vocabulary — `PREFIX`/`BASE`, `FILTER`, property paths, RDF-star triple terms — but is not the SPARQL `SELECT`/`CONSTRUCT` query language: a rule is `RULE { head } WHERE [DATA] { body }`, structurally much closer to N3's `{ body } => { head }` than to a SPARQL query.

```
PREFIX : <http://example/>

DATA {
  :A :fatherOf :X .
}

RULE { ?x :childOf ?y } WHERE { ?y :fatherOf ?x }
```

## Running a rule set

Run a `.srl` file the same way as an N3 file; Eyeron recognizes SPARQL-RL input by the `.srl` extension or by content-sniffing a `RULE`/`DATA` block:

```bash
cargo run --release -- examples/family.srl
```

## Two graphs

SPARQL-RL distinguishes two graphs. The rule set's own `DATA { ... }` facts seed the **inference** graph, which also grows with rule conclusions and is what ordinary (non-`DATA`) body clauses match against. `--data FILE` supplies an immutable **base** graph that only `WHERE DATA { ... }` and `NOT DATA { ... }` clauses read:

```bash
cargo run --release -- --data facts.ttl rules.srl
```

## Body clauses

A rule body is evaluated strictly left to right (unlike N3's own selectivity-reordering premise matcher), because `FILTER`, `SET`, and `NOT` clauses may only reference variables a *preceding* clause has already bound. Supported clause kinds:

- ordinary triple patterns and **property paths** (`/` sequence, `^` inverse — no Kleene star/plus/alternation yet);
- `FILTER(expr)`;
- `SET(?v := expr)` (SRL's `BIND`) — binds `?v` if unbound, or checks equality if already bound;
- `NOT { ... }` / `NOT DATA { ... }` — negation as failure, with automatic **stratification**: an unstratifiable recursive negation is rejected with a clear error at load time, before any rule runs;
- RDF-star triple terms and reifiers.

Roughly fifty SPARQL built-in functions are implemented: string, numeric, date/time, XSD casts, and RDF-star accessors.

## `run_once` rules

Per SPARQL 1.2 RL §4.4, a rule whose body contains a `SET` clause, or whose head contains a blank node, has its body evaluated **once per fixpoint stratum** rather than re-scanned every pass — but every solution found in that one evaluation is still materialized, including a distinct blank node per solution. This is not "the rule fires on at most one solution"; it governs how many times the body is *scanned*, not how many answers it produces.

## Querying instead of printing every fact

```bash
cargo run --release -- --query '{ ?x :descendedFrom :C }' examples/family.srl
```

`--query-mode forward` (the default) runs the ordinary fixpoint reasoner and matches the pattern against the completed closure. `--query-mode backward` instead proves the pattern directly against the rule set via goal-directed SLD resolution, without materializing a closure first — useful for large data or genuinely recursive rule sets where full materialization would be wasteful.

## Conformance

`cargo test --release --test w3c_sparql_rl` runs the official W3C SPARQL-RL test suite (203/203 passing) against a local mirror (`tests/w3c_sparql_rl/data-shapes/`) and writes an EARL report. `EYERON_W3C_SPARQL_RL_REFRESH=1 cargo test --release --test w3c_sparql_rl` (or `./scripts/sync-test-suites`) refreshes that mirror from the live manifest. `src/bin/w3c_sparql_rl.rs` runs the same suite but always fetches the manifest live, with no local mirror:

```bash
cargo test --release --test w3c_sparql_rl
cargo run --release --bin w3c_sparql_rl
```

## Known limitations

- `--proof` output is not yet implemented for `.srl` input.
- `--query-mode auto` is not implemented (only `forward`/`backward`).
