# Eyelang ("eye")

Eyelang is a small logic programming language, file extension `.eye`, with facts, rules, questions, structured terms, arithmetic, finite search, stratified negation, collection, and inspectable explanations. See [`docs/eyelang-specification.md`](eyelang-specification.md) for the normative grammar and semantics. Unlike N3 and SPARQL 1.2 RL, Eyelang is not an RDF triple language: its programs are relations, not graphs.

## Running Eyelang

```sh
cargo run --release -- examples/ancestor.eye
cargo run --release -- --proof examples/socrates.eye
cargo test --release --test eye
```

Useful CLI forms are:

```sh
cargo run --release -- --query 'ancestor(bob, ?who)' examples/ancestor.eye
cargo run --release -- --check examples/policy.eye
cargo run --release -- --json examples/type-inference.eye
cargo run --release -- --max-steps 100000 examples/shortest-path.eye
cargo run --release -- -
```

`--query` appends a question to questions already in the files. Multiple files are concatenated in argument order. `-` reads standard input. Exit status `0` means completed evaluation, including a question with no answers; `1` means a syntax, validation, or runtime error; `2` means a work limit prevented complete evaluation.

Eyeron recognizes Eyelang input by the `.eye` extension or by content-sniffing an `ask ...`/`identifier(...)` statement, the same way it dispatches on `.n3`/`.srl`.

## Facts, rules, and questions

```eye
parent(alice, bob).
parent(bob, carol).

ancestor(?x, ?y) if parent(?x, ?y).
ancestor(?x, ?z) if parent(?x, ?y), ancestor(?y, ?z).

ask ancestor(alice, ?who).
```

Every statement ends in a period. A rule reads "the head holds if the body holds." Commas form a left-to-right conjunction, and multiple clauses provide alternatives. `#` starts a line comment.

Relations are identified by name and arity. `ready` and `ready()` are both calls to `ready/0`. Clause order does not establish priority, and there are no cuts or procedural database updates.

## Values, terms, and variables

The value domain contains symbols (bare atoms, e.g. `red`, distinct from the zero-arity struct `red()`), strings, arbitrary-size integers, finite binary floating-point numbers, booleans, and compound/constructor terms with a name and zero or more arguments:

```eye
symbol(alice).
text("hello").
numbers(42, -7, 3.5, 2e3).
flags(true, false).
point_value(point(2, 3)).
items([a, b, c]).
open_list([?head | ?tail]).
```

Lists are `cons/2`/`nil/0` sugar, written `[a, b, c]` or `[a, b | Tail]`; those constructor names must not be invoked as relations. Variables begin with `?`. A named variable is shared within one statement; `?_` creates a fresh anonymous variable on every occurrence. Variables in different statements are unrelated. Capitalization has no special variable meaning.

Integers are exact and arbitrary-size (never silently coerced). Floats are finite binary floating-point values. Symbols, strings, booleans, integers, floats, and constructor terms are different kinds — in particular, `1 = 1.0` fails.

Lists support ordinary relational definitions:

```eye
append([], ?ys, ?ys).
append([?x | ?xs], ?ys, [?x | ?zs]) if append(?xs, ?ys, ?zs).

ask append(?left, ?right, [a, b]).
```

## Goals

The available goal forms are:

```eye
pair(?x, ?y)                       # relation call
?x = point(1, 2)                   # unification
?x != ?y                           # ground structural inequality
?age >= 18                         # ground numeric comparison
not blocked(?person)               # ground closed-world test
let ?square = ?number * ?number    # calculation
```

Goals run left to right. `!=`, numeric comparisons, arithmetic, negation, and several built-ins require their inputs to be bound when selected — Eyelang reports a mode error instead of reordering the body.

Unification is structural and uses an occurs check, so `?x = f(?x)` fails. Numeric comparisons may compare integers with floats. Structural `=` never performs numeric conversion.

## Evaluation

Goals are solved by a **tabled (memoized)** fixpoint: each distinct call gets a memo table, and a rule fires by matching its head, joining its body left to right, and recording every new answer. This is a genuinely different strategy from N3's premise-matching fixpoint or SPARQL-RL's ordered clause evaluator — it is what makes recursive relations like the `ancestor` example above terminate without special-casing. The declarative meaning of the positive fragment is the least fixed point of the clauses; answers are deduplicated modulo variable renaming, supporting positive left recursion, mutual recursion, and cycles for finite demanded computations.

## Arithmetic

Expressions support unary `-` and `+`, `-`, `*`, `/`, `//`, `%`. Multiplication, division, integer division, and remainder bind more tightly than addition and subtraction; parentheses override precedence.

```eye
hypotenuse(?a, ?b, ?length) if
    let ?a2 = ?a * ?a,
    let ?b2 = ?b * ?b,
    let ?sum = ?a2 + ?b2,
    let ?length = sqrt(?sum).
```

The one-argument expression functions are `abs`, `sqrt`, `round`, `count`, `sum`, `min`, `max`, and `str`. `str` returns the lexical text of a value. `concat(...)` joins the lexical text of any number of values. `/` returns a float; `//` requires integers and truncates toward zero. Division by zero, invalid domains, and non-finite results are errors. Integer and float operands otherwise mix by promoting to float.

## Negation

```eye
person(alice).
person(bob).
blocked(bob).

eligible(?person) if person(?person), not blocked(?person).
ask eligible(?person).
```

The call after `not` must be ground. It succeeds when complete evaluation of that call finds no answer. This is stratified closed-world negation, not classical negation. Because unrestricted recursion through negation has no well-defined meaning, Eyelang statically **stratifies** every program by relation signature (`name/arity`) before running it and rejects an unstratifiable one with a clear error — cycles through negation or collection are rejected before evaluation.

## Collection and braces

```eye
reading(sensor_a, 10).
reading(sensor_b, 15).
reading(sensor_c, 10).

summary(?readings, ?total) if
    collect ?readings = reading(?sensor, ?value) where {
        reading(?sensor, ?value)
    },
    collect ?values = ?value where {
        reading(?sensor, ?value)
    },
    let ?total = sum(?values).
```

Literal `{` and `}` are used only after `collect ... where`. They delimit the nested comma-separated goal body — not a general block, graph literal, set, map, or quoted formula, and there is no period inside them.

`collect Target = Template where { Body }` evaluates `Body` to completion, instantiates `Template` once per answer, deduplicates structurally, sorts into a canonical order, and unifies the resulting closed list with `Target`. It has set semantics, not proof-bag semantics: the two readings of `10` collapse in `?values`, while the tagged readings remain distinct in `?readings` (to preserve identity across sources, tag the template, e.g. `reading(?sensor, ?value)`).

Bindings made before collection are visible inside it. Unbound variables used only inside are local and do not escape; bind a correlation variable before the `collect` goal when separate groups must stay separate. Recursion through a collection is rejected by stratification.

## Built-in relations

- `range(Low, High, Value)` enumerates an inclusive integer range.
- `length(List, Size)` obtains the length of a ground closed list.
- `sort(List, Sorted)` removes duplicates and sorts a ground closed list (numbers precede other kinds and are ordered numerically; remaining order is lexicographic over the canonical structural term encoding).
- `sudoku(Puzzle, Solution)` solves a ground 9×9 Sudoku grid (a constrained backtracking solver), using zero for an empty cell.

These signatures cannot be redefined. `member/2`, `append/3`, and similar list relations are ordinary Eyelang definitions, not implicit built-ins.

## Answers and proofs

Default output is itself an Eyelang program — "Eyelang result format 2":

```eye
query(1, [call(ancestor(alice, ?v0))], [binding("who", ?v0)]).
result(1, complete, 2).
answer(1, [binding("who", bob)]).
answer(1, [binding("who", carol)]).
```

That output can be saved, loaded, and queried. It records a question as data; loading it does not run the question again. `result(..., complete, 0)` means a completed question had no answers. A successful ground question has `answer(Id, [])`.

With `--proof`, additional facts describe the derivation:

```eye
clause(2, mortal(var("who")), [call(human(var("who")))]).
substitution(2, [binding("who", socrates)]).
proof(2, mortal(socrates), rule(2),
      [uses(1, human(socrates))]).
```

`clause/3` reifies the source template, `substitution/2` records its explicit instantiation, `proof/4` records the conclusion and premises, and `why/3` links an answer to its proof. These records can be inspected by ordinary Eyelang rules. Rule numbers and proof links are stable when comments, whitespace, or line wrapping change. Built-ins, calculations, absence, and collection completion remain trusted steps, so the document is an explanation rather than a fully checked proof certificate. The complete record vocabulary is normative in section 12 of [`docs/eyelang-specification.md`](eyelang-specification.md).

`--check` emits `checked/2` and `stratum/2` facts without evaluating questions. `--json` selects a tagged JSON representation instead of `.eye` syntax.

## RDF 1.2 N-Quads bridge

An optional, non-core bridge imports RDF 1.2 N-Quads as ground `rdf(S, P, O, G)` facts and exports the `rdf/4` relation's answers back out:

```sh
cargo run --release -- --rdf-input examples/rdf12-interoperability.nq examples/rdf12-interoperability.eye
cargo run --release -- --rdf-input examples/rdf12-interoperability.nq --rdf-output examples/rdf12-interoperability.eye
```

The first command produces normal `.eye` answers; the second emits RDF 1.2 N-Quads containing imported and inferred `rdf/4` statements. The mapping: IRIs use `iri("u")`, blank nodes use `blank("b")`, literals retain datatype or language and direction, triple terms use `triple(S, P, O)`, and the fourth argument is `default_graph` or a graph IRI/blank node. Blank-node labels from separate `--rdf-input` files are scoped independently. Import does not silently apply an RDF or RDFS entailment regime; any intended entailment is expressed by Eyelang rules. The Rust functions are `eyeron::eye::rdf::{parse_nquads, facts_to_eyelang, format_nquads, answers_to_nquads}`.

## Rust API

```rust
fn main() -> eyeron::Result<()> {
    let result = eyeron::eye::run(r#"
        human(socrates).
        mortal(?x) if human(?x).
        ask mortal(?who).
    "#, eyeron::eye::Limits::default())?;

    print!("{}", eyeron::eye::output::format_result(&result, false));
    Ok(())
}
```

`eyeron::eye::run(source, limits)` returns a `RunResult { queries, proofs, stats }` or an error. `eyeron::eye::check(source)` parses and validates without evaluation. `eyeron::eye::term::format(term)` prints a term. `eyeron::eye::output::format_result(&result, proof)` and `format_check(&result)` produce Eyelang documents; `run_result_json`/`check_result_json` produce the `--json` representation.

`Limits`' fields `max_steps`, `max_tables`, and `max_answers` are positive integers, defaulting to 1,000,000, 100,000, and 100,000. Limits are shared across a run; exhaustion reports incomplete evaluation and never turns partial work into a false or complete answer.

## Examples and practical boundaries

`examples/*.eye` contains 77 examples covering recursion, lists, search, arithmetic, graph-shaped data, policies, scheduling, Sudoku, proof auditing, and large parameterized taxonomies. Expected output and proof documents live under `examples/output/` and `examples/proof/`; `tests/eye.rs` checks every example against its expected output byte for byte, and is the test to re-run (`cargo test --release --test eye`) after any intentional change to the examples or the engine's output format.

Eyelang does not currently provide constraint propagation, Turtle or TriG concrete syntax, quoted executable formulas, generated rules, mutable databases, existential witness generation, or static type and mode inference. Constructor values can represent graph-shaped data but do not acquire RDF semantics automatically; RDF interoperability is explicitly selected through the N-Quads bridge.

General constructor recursion and value-generating arithmetic may not terminate. The engine is a replay-based, demand-driven fixed-point evaluator; it is intended for clarity and conformance rather than production optimization.

## Known limitations

- Proof-record numbering follows the evaluator's own tabled-evaluation order; for `not`/`collect`-heavy programs, a different (but semantically equivalent) evaluation order would number proofs differently. This affects `--proof` output only, never plain results.
- Comparison operators between a `bigint` and a `number` operand use a lossy `f64` conversion for integers outside `f64`'s safe range (rare in practice).
