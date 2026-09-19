# Eyeron Source Code Guide

This guide explains Eyeron for a computer science student who knows basic Rust but may be new to RDF, Notation3, or rule engines. It focuses on the program's structure and algorithms. For installation and command examples, see [`README.md`](README.md), or [try Eyeron in the browser](https://eyereasoner.github.io/eyeron/playground) while following along.

## 1. What the program does

Eyeron is a **reasoner**: it starts with facts and rules, applies the rules, and produces facts that logically follow.

Here is a small Notation3 (N3) program:

```n3
@prefix : <http://example.org/> .

:Socrates a :Human .

{ ?person a :Human . } => { ?person a :Mortal . } .
```

The first statement is a fact. The second is a rule: if some `?person` is human, conclude that the same person is mortal. Eyeron binds `?person` to `:Socrates` and derives:

```n3
:Socrates a :Mortal .
```

At a high level, the implementation resembles both a compiler and a database query engine:

```text
source text
    │
    ▼
lexer.rs ── tokens ──▶ parser.rs ── Document AST ──▶ reasoner.rs
                                                          │
                                                          ▼
                                                ReasonerResult
                                                          │
                                      ┌───────────────────┴──────────────────┐
                                      ▼                                      ▼
                                 printing.rs                             proof.rs
                                      │                                      │
                                      ▼                                      ▼
                                  N3 / TriG                         proof in N3
```

The command-line program in `main.rs`, the library API in `lib.rs`, and the browser API in `wasm.rs` are different front ends around this same pipeline.

## 2. Essential domain concepts

### RDF triples

Most knowledge is represented as a triple:

```text
(subject, predicate, object)
```

For example, `:Socrates a :Human` says that Socrates has RDF type Human. The subject is `:Socrates`, the predicate is `a` (short for `rdf:type`), and the object is `:Human`.

### Terms

Each position in a triple contains a **term**. Eyeron supports:

- IRIs, which are globally unique names;
- variables such as `?person`;
- blank nodes, which identify unnamed resources;
- literals such as strings and numbers;
- lists;
- quoted formulas, which contain triples used as data.

### Rules and bindings

A rule has a premise (body) and a conclusion (head). A **binding** is a map from variable names to terms:

```text
?person → :Socrates
```

If all premises match under one binding, the reasoner substitutes those values into the conclusion.

### Closure and fixpoint

The **closure** is the set of explicit and derived facts known so far. New facts may enable more rules, so rules are applied repeatedly. The process stops at a **fixpoint**, when one complete pass produces no new facts.

## 3. Repository map

| Path | Responsibility |
| --- | --- |
| `src/ast.rs` | Core data structures: terms, triples, rules, and documents |
| `src/n3/lexer.rs` | Converts input characters into tokens |
| `src/n3/parser.rs` | Builds the AST from N3 and RDF syntax |
| `src/n3/reasoner.rs` | Matching, unification, forward/backward reasoning, indexes, and built-ins |
| `src/n3/printing.rs` | Serializes results as N3, TriG, debug text, or JSON |
| `src/n3/proof.rs` | Builds and renders explanations for derived facts |
| `src/error.rs` | Error type and source-position reporting |
| `src/n3/rdf_compat.rs` | Selects Turtle, N-Triples, N-Quads, or TriG parser profiles |
| `src/lib.rs` | Public Rust library API and module exports |
| `src/main.rs` | Native command-line interface |
| `src/wasm.rs` | WebAssembly/browser interface |
| `src/bin/w3c_rdf.rs` | Helper binary for RDF conformance work |
| `src/srl/` | SPARQL 1.2 RL front end: lexer, parser, expression evaluator, ordered clause evaluator, stratification, forward and backward reasoners (see section 16) |
| `tools/build_playground.rs` | Builds the browser playground package |
| `examples/` | Example inputs, expected outputs, and proof outputs |
| `tests/` | Integration, regression, CLI, N3, and W3C RDF tests |

The best reading order is `ast.rs`, `lib.rs`, `lexer.rs`, selected parts of `parser.rs`, and then the main loop near `reasoner::reason`. Read individual built-in functions only when you need them.

## 4. The abstract syntax tree (`src/ast.rs`)

The AST is the shared language between parsing, reasoning, and printing.

### `Term`

`Term` is a Rust enum:

```rust
pub enum Term {
    Iri(String),
    Var(String),
    Blank(String),
    Literal(Literal),
    List(Vec<Term>),
    Formula(Vec<Triple>),
}
```

An enum is a good fit because a term is exactly one of these variants. Recursive variants (`List` and `Formula`) allow arbitrarily nested data. `Term::is_ground` recursively checks that a term contains no variables. Groundness matters because a ground fact can be stored as established knowledge, while a variable-containing triple is normally a pattern.

### `Triple`, `Rule`, and `Document`

`Triple` stores subject, predicate, and object terms. `Rule` stores vectors of premise and conclusion triples, plus flags distinguishing forward rules, backward rules, and queries.

`Document` is the parser's final product. It contains:

- prefixes and an optional base IRI;
- explicit facts;
- source locations for proof reporting;
- rules.

`Document::merge` makes multi-file input simple: the CLI parses each input separately and combines the resulting documents.

Many AST types derive `Eq`, `Ord`, and `Hash`. This is important, not cosmetic: the reasoner can place terms and triples in maps and sets for indexing, deterministic output, and duplicate detection.

## 5. Lexing (`src/n3/lexer.rs`)

The lexer performs the first translation:

```text
":Socrates a :Human ."
             ↓
[PName, A, PName, Dot, Eof]
```

`TokenKind` lists the language's vocabulary, including names, variables, literals, punctuation, formula braces, list parentheses, and implication arrows. Every `Token` also stores its byte offset. That offset later becomes a useful line-and-column parse error.

`lex` constructs a private `Lexer` and calls `run`. The loop:

1. skips whitespace and comments;
2. examines the next character(s);
3. chooses a specialized reader for an IRI, string, number, name, and so on;
4. appends a token;
5. finishes with an explicit `Eof` token.

Keeping lexing separate simplifies the parser: the parser asks “is this an arrow token?” instead of repeatedly interpreting characters.

## 6. Parsing (`src/n3/parser.rs` and `src/n3/rdf_compat.rs`)

The public entry points include:

- `parse_n3` for normal N3;
- `parse_n3_with_source` when proof output needs source locations;
- `parse_rdf12` for RDF formats;
- `parse_rdf_message_log` for message logs.

Internally, `Parser` owns the token vector, a current position, the `Document` under construction, counters for generated blank nodes, and a `ParserProfile`. Profiles let one parser enforce different grammar restrictions for N3, Turtle, TriG, N-Triples, and N-Quads.

`parse_document` repeatedly examines the next token and dispatches to a more specific method. Prefix and base declarations update parser state. Ordinary statements become facts. Formula implications such as `{ ... } => { ... }` become `Rule` values.

Some compact syntax expands into multiple triples. For example, a blank-node property list such as `[ :name "Ada" ]` introduces a generated blank node and a triple about it. This is why several parsing functions return both a term and a vector of generated triples.

Parenthesized lists are different: they remain first-class `Term::List` values. The parser does not lower an N3 list into derived `rdf:first` and `rdf:rest` triples. Keeping the native representation avoids polluting rule conclusions and the fact closure with structural bookkeeping. Rules that explicitly use `rdf:first`, `rdf:rest`, or the corresponding `list:` built-ins can still inspect a native list through the reasoner's virtual list matching.

RDF Message Logs are split at message boundaries. Each payload is parsed and represented using message-envelope vocabulary and quoted formulas, allowing rules to inspect a message as one atomic graph.

## 7. Reasoning (`src/n3/reasoner.rs`)

This is the largest module because it contains the core algorithm and the implementations of built-in predicates.

### Result and options

`ReasonerOptions` supplies safety limits and enables tracing or proof capture. Limits prevent recursive or accidentally unbounded programs from running forever.

`ReasonerResult` separates several useful views:

- `explicit`: input facts;
- `derived`: newly inferred output facts;
- `closure`: explicit plus derived facts;
- `proofs`: derivation records;
- `status`, limits, errors, and statistics.

This distinction explains why normal output does not repeat every input fact.

### Fact indexing

A naive matcher would scan every fact for every premise. `FactIndex` instead stores fact positions in three maps:

```text
predicate                 → fact positions
(subject, predicate)      → fact positions
(predicate, object)       → fact positions
```

When some pattern positions are already ground, `candidates` selects a much smaller set. It falls back to a full scan where necessary, preserving correctness. This is the same basic idea as a database index.

### Matching and unification

`Bindings` is a `BTreeMap<String, Term>`. `match_triple` matches three term pairs. In `match_term`:

- an unbound pattern variable is assigned the corresponding value;
- an already bound variable must agree with its earlier value;
- lists match element by element;
- formulas are unified as unordered collections of triples;
- concrete terms must be semantically equal.

Native lists also behave like RDF collections when a rule explicitly asks for `rdf:first` or `rdf:rest`. This behavior is virtual: the matcher computes the first item or remaining list from `Term::List` without materializing extra facts. List built-ins preserve concrete graph blank nodes and implement operations such as membership, append, reverse, and lexicographic sort directly over the native items. Numeric literals sort by numeric value rather than by their lexical spelling.

`unify_term` is more general because either side may contain a variable. It also performs an **occurs check** before creating a binding, avoiding cyclic substitutions such as `?x = (?x)`.

For multiple premises, `match_premise_remaining` is a recursive backtracking search. It does not blindly use source order. It prefers a runnable, selective premise with few candidates. This resembles join ordering in a relational database: applying a selective condition early avoids creating many intermediate bindings.

### The forward-chaining fixpoint

The main `reason` function works approximately as follows:

```text
put explicit facts in the closure and indexes
separate query rules from materialization rules

repeat:
    drive agenda-safe rules from newly added facts
    evaluate other forward rules with general matching
    instantiate conclusions and insert unseen facts
    if a conclusion creates a new rule, register it
    after ordinary closure saturation, evaluate deferred scoped built-ins
until neither ordinary nor deferred evaluation adds an unseen fact

evaluate query rules against the completed closure
return explicit facts, derived facts, closure, proofs, and statistics
```

A `HashSet<Triple>` named `seen` prevents duplicate facts and is also the fixpoint signal. `emit_conclusions` substitutes a successful binding into each rule conclusion. Blank nodes in a conclusion are created deterministically for that firing. `insert_materialized_triple` updates the closure, index, derived output, and optional proof record together.

Scoped built-ins whose answers depend on the completed current graph need an additional phase. Rules containing `log:collectAllIn`, `log:forAllIn`, or `log:notIncludes` are deferred until ordinary forward reasoning reaches closure saturation. If a deferred rule derives new facts, ordinary reasoning resumes before scoped built-ins are evaluated again. This prevents a temporary, incomplete closure from producing an aggregate or negative conclusion that cannot later be retracted.

### Agenda optimization

For suitable forward rules, `AgendaIndex` maps a newly added fact directly to rule premises that it might satisfy. A one-premise transitive chain can therefore process each new fact once instead of rescanning all rules and facts on every iteration.

Rules that need more context—certain multi-premise forms, built-ins, backward dependencies, or blank-node conclusions—use the general matcher. The optimized path is an implementation detail; both paths preserve the same logical behavior.

### Backward rules

Forward reasoning asks, “What can be concluded from all known facts?” Backward reasoning starts with a goal and asks, “Which rule could prove this goal, and what would prove that rule's premises?”

`solve_backward_goal` recursively searches backward rules. Rules are **standardized apart** before use: their variables are renamed so variables from separate rule applications cannot collide. A recursion stack detects cycles, while depth and solution limits bound the search.

### Built-ins

`eval_builtin` dispatches by predicate IRI to functions implementing operations such as arithmetic, string matching, list processing, time extraction, hashing, and logical formula inspection.

A built-in consumes the current binding and returns zero or more bindings:

- zero means the premise failed;
- one means it succeeded once, possibly binding a result variable;
- several means it generated several possible results.

This interface lets ordinary fact matching and built-in computation participate in the same backtracking search.

### Queries

`log:query` rules are deliberately held until the normal rules reach a fixpoint. They select or format results without feeding their output back into reasoning. A conclusion using `log:outputString` is treated specially by the printer and emitted as plain text.

## 8. Proofs (`src/n3/proof.rs`)

When `ReasonerOptions::proof` is enabled, every derived fact can store:

- the fact that was derived;
- the rule that fired;
- the instantiated premises;
- the variable bindings.

`proof_to_n3` groups these `DerivedFact` records, recursively connects derived premises to their own derivations, and distinguishes explicit facts, built-in steps, and unproven steps. Source references recorded during parsing let proofs point back to input files and lines.

Proof collection is optional because retaining derivation history costs memory. Normal reasoning only needs the closure and derived facts.

## 9. Output (`src/n3/printing.rs`)

The printer reverses part of the parsing process: AST values become text again. It handles correct syntax for every `Term` variant, escapes strings, chooses compact prefixes, formats formulas and lists, and can produce N3 or TriG.

Only prefixes actually used in the result are printed. This keeps output smaller and is why the printer first walks the output to collect used namespaces.

`result_to_string` and `rdf_result_to_string` first look for `log:outputString`. If present, literal values are concatenated as program output; otherwise triples are serialized normally.

## 10. Front ends

### Rust library (`src/lib.rs`)

The convenience function `eyeron::reason` parses one string, runs default reasoning, rejects incomplete results, and returns rendered derived facts. Lower-level callers can separately parse, configure `ReasonerOptions`, call `reason_document`, and inspect the structured result.

### Command line (`src/main.rs`)

The CLI performs these steps:

1. parse flags;
2. read local files, standard input, or HTTP(S) resources;
3. infer the RDF format from a file extension when appropriate;
4. parse and merge all documents;
5. either print the AST or run the reasoner;
6. print normal, RDF-compatible, or proof output.

The message-streaming path reads and reasons over one message at a time. Each message gets a fresh reasoning run, so facts are not retained across messages.

### WebAssembly (`src/wasm.rs`)

The Wasm module exposes browser-friendly functions through `wasm-bindgen`. It accepts a program and optional data, selects a parser format, invokes the same core reasoner, and converts errors and reports to JavaScript-friendly strings or JSON. The reasoning algorithm is not duplicated.

## 11. Error handling

`EyeronError` contains a message and optional byte offset. The lexer and parser attach offsets; `with_source_location` converts them into file, line, and column information for users.

Reasoning-time problems are represented separately in `ReasonerResult`. A run may have produced a partial closure while also reaching a search limit. `CompletionStatus` makes this explicit, and high-level APIs reject incomplete results rather than silently presenting them as complete.

## 12. A complete example trace

For the Socrates example, the important state changes are:

1. The lexer recognizes prefix syntax, three terms for the fact, formula delimiters, variables, and the implication arrow.
2. The parser expands `a` to the full `rdf:type` IRI. It stores one explicit `Triple` and one forward `Rule` in a `Document`.
3. `reason` inserts the explicit triple into `closure`, `seen`, and `FactIndex`.
4. The agenda finds that the new fact may satisfy the rule's only premise.
5. `match_triple` binds `?person` to `:Socrates`.
6. `emit_conclusions` resolves `?person` in the rule head and constructs the mortal triple.
7. The new triple is not in `seen`, so it is appended to `closure` and `derived`.
8. No further rule produces an unseen fact, so the fixpoint is reached.
9. `printing.rs` shortens the IRIs using the input prefixes and writes the derived triple.

This trace is a useful debugging template: inspect tokens, then the `Document`, bindings, closure changes, and finally rendering.

## 13. Tests and how to explore the code

Run all optimized tests:

```bash
cargo test --release
```

Useful focused commands include:

```bash
# See the parsed representation without reasoning
cargo run --release -- --ast examples/socrates.n3

# Run a small forward-rule example
cargo run --release -- examples/socrates.n3

# Include derivation explanations
cargo run --release -- --proof examples/socrates.n3

# Run one integration-test target
cargo test --release --test regressions
```

Unit tests live beside implementation code, while `tests/` contains black-box and conformance tests. The examples have expected results in `examples/output/` and expected explanations in `examples/proof/`, which makes them especially useful when learning or changing behavior.

For N3 example outputs, the test harness parses both the reasoner output and its golden and requires complete graph isomorphism. Triple order and blank-node labels may differ, but missing or additional triples fail the test. Markdown report goldens use content-line checks because they are presentation text rather than N3 graphs.

The W3C RDF runner likewise compares complete RDF datasets by isomorphism, including named graphs, lists lowered for RDF comparison, RDF-star triple terms, and blank-node renaming. The vendored Notation3tests suite has a different upstream oracle: each N3 program derives standardized pass/fail test facts. Its runner requires the expected outcome, rejects false or missing results, distinguishes expected crash cases, and reports unsupported cases separately; those tests do not ship separate output graphs to compare isomorphically.

## 14. Suggested study exercises

1. Add a fact to `examples/socrates.n3`, run with `--ast`, and identify its `Term` variants.
2. Set a breakpoint in `match_term` and watch `Bindings` change as a rule matches.
3. Compare a one-premise rule with a two-premise rule and observe the agenda and general matching paths.
4. Follow `math:sum` from `eval_builtin` to its implementation, then write a tiny N3 program that uses it.
5. Run with and without `--proof` and compare the `ReasonerResult` data retained.
6. Add a small parser or reasoner regression test before modifying behavior.

## 15. Design lessons

Several broader computer science ideas appear in this project:

- **Separation of concerns:** lexing, parsing, evaluation, proof construction, and serialization are separate modules.
- **Algebraic data types:** `Term` models several forms safely with a Rust enum.
- **Hashing and ordering:** sets provide fast duplicate detection; ordered maps provide stable behavior.
- **Database techniques:** indexes and selective join ordering reduce matching work.
- **Search algorithms:** premise matching uses backtracking, and backward rules use bounded depth-first search.
- **Fixed-point computation:** forward chaining monotonically grows a set until it stops changing.
- **Resource safety:** explicit limits turn nontermination into a structured incomplete result.
- **Reusable core:** the CLI, library, and browser interfaces share one parser and reasoning engine.

## 16. SPARQL 1.2 RL (`src/srl/`)

SPARQL 1.2 RL ("SRL") is a second front end living entirely under `src/srl/`. It reads a different concrete syntax — `RULE { head } WHERE [DATA] { body }` instead of N3's `{ body } => { head }` — but is semantically the same kind of thing as the N3 path above: facts and rules go in, a forward fixpoint runs, derived triples come out. It is worth reading *after* the rest of this guide, both because it borrows several of the same ideas (an AST, a fixpoint loop, deterministic blank-node generation) and because it deliberately does **not** reuse `src/n3/reasoner.rs`'s premise matcher, which is a useful contrast to study.

### Why a second parser and a second body evaluator

SRL borrows SPARQL's lexical vocabulary — `FILTER`, property paths, RDF-star triple terms — so its tokenizer and grammar are different enough from N3's that `src/srl/lexer.rs` and `src/srl/parser.rs` are separate, small, hand-written modules rather than extensions of `src/n3/lexer.rs`/`src/n3/parser.rs`. (One concrete reason: N3's word-reading does not stop at `/` or `^`, which SRL needs as standalone property-path operators.) The parser still reuses `crate::ast::{Term, Triple, Literal}` and the numeric/boolean-literal and RDF-star triple-term conventions from `crate::n3::parser` wherever the shapes coincide, so the rest of the pipeline — printing, proofs — needs no SRL-specific cases.

A more interesting divergence is the rule body itself. `crate::n3::reasoner::match_premise_remaining` deliberately **reorders** an N3 rule's premises to try the most selective one first — a database-style query-planning optimization that is sound because ordinary N3 premises are just triple patterns with no notion of "before" and "after." SPARQL-RL's `FILTER`, `SET`, and `NOT` clauses break that assumption: each one may only reference variables that a *preceding* clause in source order has already bound. Reordering them would be unsound. `src/srl/eval.rs` therefore implements its own small, strictly left-to-right backtracking search (`solve_body`/`solve_from`), written as continuation-passing recursion since Rust has no generators. It still calls straight into `crate::n3::reasoner::{FactIndex, match_triple, resolve_pattern}` for the actual triple lookups — the indexing and unification machinery is fully reused, only the *order* in which clauses are tried is different.

### The pieces, in reading order

1. **`ast.rs`** — `Expr` (the `FILTER`/`SET` expression tree), `PathExpr` (property paths: sequence and inverse only — SRL's grammar has no `*`/`+`/`?`/alternation), `Clause` (one body element: `Triple`, `Path`, `Filter`, `Set`, or `Not`), and `SparqlRlRule`/`SparqlRlProgram`. These are a separate type family from `crate::ast::Rule`/`Document`, precisely because of the ordering constraint above.
2. **`expr.rs`** — a tree-walking evaluator for `Expr`, covering roughly fifty SPARQL built-in functions (string, numeric, date/time, XSD casts, RDF-star accessors) plus the usual operators. Every result is represented uniformly as a `Term` (booleans and numbers become `Literal`s), which is simpler than the reference JavaScript implementation this was ported from, where evaluation mixes raw primitives and term objects.
3. **`eval.rs`** — the ordered clause evaluator described above. `Clause::Not`/`Clause::Path` are the two interesting cases: negation succeeds iff a recursive `solve_body` call over the negated sub-body finds zero solutions (classic negation as failure), and a property path is expanded into an ordinary chain of triple clauses with fresh join variables *at evaluation time*, so path matching needs no new machinery beyond what triple matching already provides.
4. **`stratify.rs`** — a pure static analysis, unrelated to evaluation, that decides a safe rule execution order. It builds a dependency graph between rule heads and other rules' body patterns, computes strongly-connected components, and rejects a rule set where negation participates in a recursive cycle (an "unstratifiable" program, which has no single well-defined meaning). This exists because `NOT`'s soundness depends on the graph it searches being *finished*: a `NOT` clause must never run before every rule that could produce the pattern it negates has already reached a fixpoint.
5. **`forward.rs`** — ties `stratify.rs`, `eval.rs`, `wellformed.rs`, and `expr.rs` together: check every rule's well-formedness, run `stratify`'s layers in order, and within each layer, run every rule's body to a local fixpoint (repeated passes until nothing new is added), reusing `crate::n3::reasoner::instantiate_triple` to materialize each rule's head — the same helper N3 conclusions use, so head blank nodes get the same deterministic-per-firing identity already described in section 7. Ordinary (non-`WHERE DATA`) clauses match against the *union* of the base graph and the inference graph — a real bug caught during development: it is tempting to read "`WHERE DATA`/`NOT DATA` clauses read the base graph" as "ordinary clauses only read the inference graph," but `--data` input is meant to be reasoned *over*, not merely alongside; rules with no `DATA { ... }` block of their own would otherwise never see their `--data` input at all. `ReasonerResult::closure` is the inference graph alone (`program.data` plus everything derived, never the base graph) — this, not `::derived`, is what the W3C eval tests' `mf:result` corresponds to (`derived` additionally excludes `program.data` itself, which `mf:result` does not).
6. **`wellformed.rs`** — static, per-rule checks independent of any other rule (contrast with `stratify.rs`, which is about *inter*-rule dependencies): an unbound head variable, a non-IRI/non-variable head predicate, or a `FILTER`/`SET` referencing a variable before a preceding body clause has bound it. Ported from eyeleng's `sequentialWellFormednessDiagnostics`.
7. **`backward.rs`** — goal-directed query evaluation (`--query-mode backward`), the SRL counterpart to `crate::n3::reasoner::solve_backward_goal`. It is a separate implementation rather than a reuse of that function, for the same reason `eval.rs` is separate from `match_premise_remaining`: it borrows the same core ideas (standardizing a candidate rule apart by renaming its variables uniquely per application, a depth-bounded recursive search, a stack-based cycle guard) but works over `SparqlRlRule`'s ordered `Vec<Clause>` body. It extends `eval.rs`'s own clause dispatch: proving a `Triple` subgoal tries known facts first, exactly as forward evaluation does, then — new here — unifies the goal against every rule head that could produce it and recurses into that rule's body. A real bug surfaced while writing this module's tests: a returned solution's bindings included internal renamed rule variables alongside the caller's own query variables, fixed by filtering each solution down to the query text's own variable set (`query_body_variables`) before returning it — worth reading as a concrete example of the kind of bug this style of variable renaming invites.

A note on `run_once` (SPARQL 1.2 RL §4.4) worth internalizing precisely, since it is easy to misread: it does **not** mean "this rule fires on at most one solution." An earlier implementation made exactly that mistake — it stopped `fire_rule` after the first successful body match — and the W3C suite's `eval-bnodes-03` test (two data triples, two `run_once` rules, expects *four* distinct blank nodes, i.e. every solution of every rule still gets its own fresh blank) caught it. What `run_once` actually governs is how many times the rule's *body* is scanned across the fixpoint — once, rather than re-evaluated on every pass — which is safe precisely because each solution's blank node is already a deterministic function of its bindings (`instantiate_triple`'s `stable_binding_suffix`), so a later pass could not discover any solution the one scan missed.

### W3C SPARQL-RL conformance harness

`src/bin/w3c_sparql_rl.rs`, modeled on `src/bin/w3c_rdf.rs` but much smaller (no quads, no entailment regimes, no RDFS closure — SPARQL-RL's manifest vocabulary has seven simple test categories: positive/negative syntax, well-formedness, and stratification, plus one eval-test kind), fetches the live W3C manifest, runs all of it, and writes an EARL report. It currently passes 203/203, matching eyeleng's own reported total. Run it with `cargo run --release --bin w3c_sparql_rl`; it always needs network access (there is no local vendored mirror of this suite yet, unlike `tests/w3c_rdf/rdf-tests/` for the RDF harness — a natural next step were this suite to grow).

The same suite is also wired into `cargo test --release` as `tests/w3c_sparql_rl.rs` (`[[test]] harness = false`, matching `tests/w3c_rdf.rs`'s pattern) with its logic duplicated into `tests/w3c_sparql_rl/runner.rs` rather than shared with the binary — that duplication mirrors the existing `src/bin/w3c_rdf.rs`/`tests/w3c_rdf/runner.rs` split, not a new convention. It prints one libtest-style aggregate line (`w3c_sparql_rl_01_all_manifests_203_earl_report ... ok (203/203 tests + EARL report)`), so a plain `cargo test --release` run's final per-binary totals include it alongside the RDF and N3 suites.

### What is not implemented yet

`--proof` output for `.srl` input, and `--query-mode auto` (only `forward`/`backward` are implemented — `auto` would need eyeleng's backward-eligibility precheck, `ruleSupported`/`bodySupported` in its `src/backward.js`, ported too). `tests/sparql_rl.rs` is the day-to-day test entry point; run it with `cargo test --release --test sparql_rl`.

The central idea to keep in mind is simple: Eyeron converts syntax into structured triples and rules, searches for consistent variable bindings, materializes new ground triples, and repeats until knowledge stops growing.
