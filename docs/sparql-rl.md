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

## Importing other rule sets

A rule set can pull in another with `IMPORTS <file-or-url>`, resolved relative to its own base IRI, the same way `--data` resolves relative paths. Every rule set an import brings in is merged in turn (prefixes, `DATA`, and `RULE`s), so imports can chain:

```
PREFIX : <http://example/>
IMPORTS <lib.srl>

DATA {
  :alice :parentOf :bob .
}
```

This is resolved by the CLI (`main.rs`), not inside the library's `parse_sparql_rl`/`reason` calls themselves, so embedding SRL directly (e.g. through the WASM API) must merge imported rule sets manually with `srl::merge_programs`. The WASM API's own `reasonSrlWithImports(mainSource, importedSource, data, proof, query)` takes the caller's already-fetched `importedSource` text rather than fetching it itself (`fetch`/`ureq`/`fs` are not one shared abstraction across native and Wasm); `srlImportTargets(source, base)` resolves `IMPORTS <iri>` against `base` the same way the CLI does, so a caller can discover what to fetch without duplicating SRL's relative-IRI rules. The playground (`playground.html`) uses exactly this pair to wire up `import-main.srl` automatically when it is loaded, and passes its own "Proof explanations" checkbox through as `proof`.

## Two graphs

SPARQL-RL distinguishes two graphs. The rule set's own `DATA { ... }` facts seed the **inference** graph, which grows with rule conclusions. `--data FILE` supplies an immutable **base** graph. Ordinary rule-body clauses match their union; `WHERE DATA { ... }` and `NOT DATA { ... }` restrict matching to the base graph:

```bash
cargo run --release -- --data facts.ttl rules.srl
```

§6.5 evaluates a rule set over the union `GE = G0 ∪ D` (base graph plus the rule set's own `DATA` facts) and keeps only `Y = { t ∈ X | t ∉ GE }` from each rule firing, so a conclusion that merely restates a fact either graph already holds contributes nothing — §6.4 notes that a rule's own output "may contain triples that are also in the data graph", and this is where those are filtered out. Repeated triples and overlap between the graphs likewise count as one fact when matching a rule body, including before a volatile expression such as `UUID()`.

The result is §6.5's inference graph `GI`, seeded with `{ t ∈ D | t ∉ G0 }` and grown by each `Y`: the rule set's own `DATA` facts that the base graph does not already carry, plus everything derived. That is what the CLI prints and what `ReasonerResult::closure` holds; `ReasonerResult::derived` narrows it to just the rule conclusions, excluding the `DATA` facts.

## Body clauses

A rule body is evaluated strictly left to right (unlike N3's own selectivity-reordering premise matcher), because `FILTER`, `SET`, and `NOT` clauses may only reference variables a *preceding* clause has already bound. Supported clause kinds:

- ordinary triple patterns and **property paths**: sequence `/`, inverse `^`, and `(...)` grouping. That is the whole path grammar SPARQL 1.2 RL has (§7.6, `Path ::= PathSequence`, productions [85]–[88]): alternation `|` and the length modifiers `?`/`+`/`*` are SPARQL syntax SRL leaves out, so every path expands into plain triple patterns and a rule body stays statically analysable. Write an arbitrary-length path as a recursive rule instead, which the draft calls out as the more general approach — `RULE { ?x :r ?z } WHERE { ?x :p ?y . ?y :r ?z }` for `:p+`. Each of `|`/`?`/`+`/`*` is a syntax error;
- `FILTER(expr)`;
- `SET(?v := expr)` (SRL's `BIND`) — binds `?v` if unbound, or checks equality if already bound;
- `NOT { ... }` / `NOT DATA { ... }` — negation as failure, with automatic **stratification**: an unstratifiable recursive negation is rejected with a clear error at load time, before any rule runs;
- RDF-star triple terms and reifiers.

Roughly fifty SPARQL built-in functions are implemented: string, numeric, date/time, XSD casts, and RDF-star accessors. One non-standard extension is also recognized, matching eyeleng's own reference implementation: a call whose IRI's local name is `sudoku` (any namespace, e.g. `:sudoku(?puzzle)`) takes an 81-character puzzle string (`.` or `0` for a blank cell) and returns the solved 81-character string, or `""` if unsolvable.

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

## Implementation notes

`src/srl/` deliberately does **not** reuse `src/n3/reasoner.rs`'s premise matcher, which is worth understanding if you are modifying either front end. N3's `match_premise_remaining` reorders premises to try the most selective one first — sound because ordinary N3 premises are just triple patterns with no notion of "before" and "after." SPARQL-RL's `FILTER`, `SET`, and `NOT` clauses break that assumption, since each may only reference variables a *preceding* clause in source order has already bound; reordering them would be unsound. `src/srl/eval.rs` therefore implements its own small, strictly left-to-right backtracking search (`solve_body`/`solve_from`, written as continuation-passing recursion since Rust has no generators), but still calls straight into `crate::n3::reasoner::{FactIndex, match_triple, resolve_pattern}` for the actual triple lookups — the indexing and unification machinery is fully reused, only the *order* clauses are tried in differs. `src/srl/lexer.rs`/`parser.rs` are separate, small, hand-written modules rather than extensions of N3's own (SPARQL's vocabulary — `FILTER`, property paths, RDF-star triple terms — is different enough, and N3's word-reading does not stop at `/` or `^`, which SRL needs as property-path operators), though the parser still reuses `crate::ast::{Term, Triple, Literal}` and N3's numeric/boolean-literal and RDF-star conventions.

The pieces, in reading order:

1. **`ast.rs`** — `Expr` (the `FILTER`/`SET` expression tree), `PathExpr` (sequence/inverse paths only — no Kleene star/plus/alternation), `Clause` (`Triple`/`Path`/`Filter`/`Set`/`Not`), and `SparqlRlRule`/`SparqlRlProgram` — a separate type family from `crate::ast::Rule`/`Document`, precisely because of the ordering constraint above.
2. **`expr.rs`** — a tree-walking evaluator for `Expr` covering roughly fifty SPARQL built-in functions (string, numeric, date/time, XSD casts, RDF-star accessors), with every result uniformly represented as a `Term` (booleans and numbers become `Literal`s). The non-standard `sudoku` extension (any call IRI whose local name is `sudoku`, matching eyeleng's own `localName(name) === 'sudoku'` convention) is dispatched here.
3. **`eval.rs`** — the ordered clause evaluator described above. `Clause::Not` succeeds iff a recursive `solve_body` call over the negated sub-body finds zero solutions (classic negation as failure); `Clause::Path` is expanded into an ordinary chain of triple clauses with fresh join variables *at evaluation time*, so path matching needs no new machinery beyond triple matching.
4. **`stratify.rs`** — a pure static analysis that decides a safe rule execution order: it builds a dependency graph between rule heads and other rules' body patterns, computes strongly-connected components, and rejects an unstratifiable rule set (negation participating in a recursive cycle, which has no single well-defined meaning). This exists because `NOT`'s soundness depends on the graph it searches being *finished* — a `NOT` clause must never run before every rule that could produce the pattern it negates has already reached a fixpoint.
5. **`forward.rs`** — ties `stratify.rs`, `eval.rs`, `wellformed.rs`, and `expr.rs` together: check well-formedness, run `stratify`'s layers in order, and within each layer run every rule's body to a local fixpoint, reusing `crate::n3::reasoner::instantiate_triple` to materialize each head (so head blank nodes get the same deterministic-per-firing identity N3 conclusions use). Ordinary (non-`WHERE DATA`) clauses match against the *union* of the base graph and the inference graph — `--data` input is meant to be reasoned *over*, not merely alongside a rule set's own `DATA` facts, so a rule set with no `DATA { ... }` block of its own would otherwise never see its `--data` input at all. `ReasonerResult::closure` is the inference graph alone (`program.data` plus everything derived, never the base graph) — this, not `::derived`, is what the W3C eval tests' `mf:result` corresponds to.
6. **`wellformed.rs`** — static, per-rule checks independent of other rules (contrast with `stratify.rs`'s inter-rule dependencies): an unbound head variable, a non-IRI/non-variable head predicate, or a `FILTER`/`SET` referencing a variable before a preceding body clause has bound it.
7. **`backward.rs`** — goal-directed query evaluation (`--query-mode backward`), the SRL counterpart to `crate::n3::reasoner::solve_backward_goal`: a separate implementation (for the same reason `eval.rs` is separate from `match_premise_remaining`) that borrows the same core ideas — standardizing a candidate rule apart, a depth-bounded recursive search, a stack-based cycle guard — but works over `SparqlRlRule`'s ordered `Vec<Clause>` body, extending `eval.rs`'s clause dispatch with head-unification-then-recurse for rule heads that could produce the goal. A returned solution's bindings must be filtered down to the query text's own variable set (`query_body_variables`) before returning, since standardizing rules apart introduces internal renamed variables that should not leak into the caller's result.

A rule set's `IMPORTS` directive is parsed into `SparqlRlProgram::imports` by `parser.rs`, but resolving it (fetching, parsing, folding in with `merge_programs`) is deliberately **not** done inside `parse_sparql_rl`/`reason` — it lives in `main.rs`'s `resolve_sparql_rl_imports`, mirroring how `--data` resolution is a CLI-level concern, not a library one (see "Importing other rule sets" above).

`--proof` output is a genuine `.srl` document, produced by `srl::proof::proof_to_srl` rather than N3's own `proof_to_n3`: N3 represents a proof step as a quoted-formula subject (`{ s p o } pe:why { ... }`), which SRL's grammar has no term for (its only quoted-graph-shaped term is the single-triple RDF-star triple term `<<( s p o )>>`). So each step here is instead a small blank node reifying its own conclusion — `_:stepN rdf:reifies <<( s p o )>>` — the idiom `examples/proof-audit.srl` demonstrates by hand, with `pe:uses` linking straight to the blank nodes of the steps it depended on rather than repeating their triples, all inside one `DATA { ... }` block (SRL has no bare top-level triples). The *analysis* that walks a derivation into a flat list of steps is shared verbatim with `n3::proof` (exposed to `srl::proof` as `pub(crate)`); only the SRL-syntax rendering is separate. Underneath, `forward.rs` builds an N3-shaped `Rule` from each `SparqlRlRule` (`premise` = the rule's own positive body patterns, from the same `rule_positive_patterns` the stratifier's activation index already computes; `conclusion` = its head), records one `DerivedFact` per genuinely new fact (not per solution — matching "alternative derivations of an already known answer need not be retained"), and `parser.rs`'s `parse_sparql_rl_with_source` stamps each rule and `DATA {...}` fact with a `SourceRef` (file label + line) the same way `n3::parser`'s own `with_source` does, so a step's `pe:rule "file.srl"; pe:line N`/`pe:fact "file.srl"; pe:line N` point at real source locations rather than `"<unknown>"`. A `FILTER`/`NOT`/`SET` clause is not itself reified as a premise (there is no natural `Triple` shape for one) — the trace shows the positive facts that fed the rule and the bindings used, but not, say, a `FILTER` condition's own text; a step's own source line is always one click away from the full rule for that.

## Known limitations

- `--query-mode auto` is not implemented (only `forward`/`backward`).
- The forward reasoner is not as fast as N3's own agenda-based fixpoint or Eyelang's tabled evaluator for the same shape of problem, though a long single-premise rule chain — the case eyeleng's `deep-taxonomy-10000.srl`/`deep-taxonomy-100000.srl` stress-test — is no longer quadratic: `stratify`'s dependency-edge computation and the forward fixpoint's per-pass rule scan and match-graph reindexing are now all indexed rather than all-pairs, so both examples are packaged in `examples/` and run in a few seconds.
- SPARQL-RL has no backward chaining, and stratification rejects recursion through negation, so a rule set cannot express "a simple path of any length that never revisits a node" (needed for cycle-safe path search over a graph with cycles) the way N3/Eyelang's backward, visited-list-guarded recursion can. `path-discovery.srl` works around this by structurally unrolling one join rule per stopover count up to a fixed bound, each gated by `FILTER(<count> <= ?maxStopovers)`; the source/destination/stopover-count query itself stays fully general, only the *maximum* supported stopover count is fixed at rule-set-authoring time.
- `--proof`'s dependency-tree walk (shared with N3's own `--proof`) explains each derived fact independently of every other one, so its cost grows with the *square* of the derivation's size; a long single-premise chain like `deep-taxonomy-1000.srl` does not finish in a reasonable time under `--proof`, even though ordinary reasoning over it is fast (see the limitation above). `examples/proof/` therefore only packages a `deep-taxonomy-10.srl` proof, not the larger stress-test sizes.
