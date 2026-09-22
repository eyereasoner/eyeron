# Prolog

eyeron's third front end reads **Prolog**, file extension `.pl`: the pure,
tabled subset of ISO/IEC 13211-1 described normatively in
[`prolog-specification.md`](prolog-specification.md). Unlike N3 and SPARQL
1.2 RL, it is not an RDF triple language — its programs are predicates, not
graphs.

Two things are worth knowing before anything else. eyeron accepts *less*
than the standard: no cut, no `;`, no `assert/1`, no I/O, no `op/3` (§14 of
the specification lists it all). And it resolves *differently*: goals are
answered by tabled evaluation, so clause order carries no meaning and left
recursion terminates (§6, §15). Inside that fragment, a program means what
the standard says it means, which
[`scripts/prolog-conformance`](../scripts/prolog-conformance) checks by
running every conformance case through SWI-Prolog, GNU Prolog, SICStus and
Scryer as well.

## Running

```sh
cargo run --release -- examples/ancestor.pl
cargo run --release -- --proof examples/socrates.pl
cargo test --release --test prolog
```

Useful CLI forms are:

```sh
cargo run --release -- --query 'ancestor(bob, Who)' examples/ancestor.pl
cargo run --release -- --check examples/policy.pl
cargo run --release -- --json examples/type-inference.pl
cargo run --release -- --max-steps 100000 examples/shortest-path.pl
cargo run --release -- -
```

`--query` appends a `?-` directive to those already in the files. Multiple
files are concatenated in argument order. `-` reads standard input. Exit
status `0` means completed evaluation, including a query with no answers;
`1` means a syntax, validation or runtime error; `2` means a work limit
prevented complete evaluation.

eyeron recognizes Prolog input by the `.pl` extension or by content-
sniffing a `?-` directive or a clause head, the same way it dispatches on
`.n3` and `.srl`.

## Clauses and queries

```prolog
parent(alice, bob).
parent(bob, carol).

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Z) :- parent(X, Y), ancestor(Y, Z).

?- ancestor(alice, Who).
```

Every clause ends in a `.` followed by layout. A rule reads "the head holds
if the body holds". `,` is a left-to-right conjunction, and several clauses
give alternatives. `%` starts a line comment and `/* ... */` a block
comment.

Predicates are identified by name and arity. Clause order establishes no
priority, and there is no cut and no procedural database update.

## Terms and variables

The value domain is atoms, compound terms, arbitrary-size integers, finite
floats, strings, and variables:

```prolog
symbol(alice).
text("hello").
numbers(42, -7, 3.5, 2.0e3).
point_value(point(2, 3)).
items([a, b, c]).
open_list([Head|Tail]).
```

An atom is a compound term of arity zero, so the goal `ready` and the term
`ready` are the same object — which is what lets `clause/2` hand a
zero-argument clause's head back to the program. Lists are `'.'/2` pairs
ending in `[]`; `'.'/2` must not be called as a predicate.

Variables begin with an uppercase letter or `_`. A named variable is shared
within one clause and unrelated in the next; each `_` is a fresh anonymous
variable and never appears in an answer.

Integers are exact at any size. Kinds are distinct — `1`, `1.0`, `"1"` and
`'1'` are four terms, and `1 = 1.0` fails.

Lists support ordinary definitions, because eyeron provides no list library
of its own:

```prolog
append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

?- append(Left, Right, [a, b]).
```

## Goals

```prolog
pair(X, Y)                  % a predicate call
X = point(1, 2)             % unification, with the occurs check
X \== Y                     % term inequality in the standard order
Age >= 18                   % arithmetic comparison
\+ blocked(Person)          % completed closed-world negation
Square is Number * Number   % arithmetic evaluation
```

Goals run left to right. Arithmetic, negation and several library
predicates need their inputs bound when selected — eyeron reports a mode
error rather than reordering the body.

## Evaluation

Goals are answered by a **tabled (memoized)** fixpoint: each distinct call
gets a memo table, and a clause fires by matching its head, joining its
body left to right, and recording every new answer. This is a genuinely
different strategy from N3's premise-matching fixpoint or SPARQL-RL's
ordered clause evaluator, and it is what makes the `ancestor` example above
terminate whichever way round its clauses are written.

The declarative meaning of the positive fragment is the least fixed point
of the clauses. Answers are deduplicated modulo variable renaming, which
supports left recursion, mutual recursion and cycles for finite demanded
computations — and which means `findall/3` collects the *distinct*
solutions rather than a bag, exactly as it does over a tabled predicate in
XSB. Specification §15 lists every observable consequence.

## Arithmetic

`is/2` evaluates an expression once and unifies the result. The evaluable
functors are `+ - * / // mod rem` and unary `- +`, plus `abs`, `sign`,
`min`, `max`, `sqrt`, `float`, `**`, `^`, `floor`, `ceiling`, `truncate`,
`round` and `integer`.

```prolog
hypotenuse(A, B, Length) :-
    Sum is A * A + B * B,
    Length is sqrt(Sum).
```

`//` truncates toward zero, `mod` takes the sign of the divisor and `rem`
the sign of the dividend. `/` gives an integer when both arguments are
integers and the division is exact, and a float otherwise. Division by
zero, an unknown functor, an unbound variable and a non-finite result are
errors, never failures.

Three of these are places where the installed Prolog systems disagree with
each other; eyeron follows the standard's text and
`scripts/prolog-conformance` records who does what. `round(x)` is
ISO's `⌊x + ½⌋`, so `round(-2.5)` is `-2`.

## Negation

```prolog
person(alice).
person(bob).
blocked(bob).

eligible(Person) :- person(Person), \+ blocked(Person).
?- eligible(Person).
```

`\+`'s argument must be ground. It succeeds when complete evaluation of
that goal finds no answer: stratified closed-world negation, not classical
negation. Because unrestricted recursion through negation has no
well-defined meaning, eyeron statically **stratifies** every program by
predicate indicator before running it and rejects an unstratifiable one —
recursion through `\+` or `findall/3` is caught before evaluation.

## Collecting solutions

```prolog
reading(sensor_a, 10).
reading(sensor_b, 15).
reading(sensor_c, 10).

summary(Readings, Total) :-
    findall(reading(Sensor, Value), reading(Sensor, Value), Bag),
    sort(Bag, Readings),
    findall(V, reading(_, V), Values),
    sum_list(Values, Total).
```

`findall(Template, Goal, List)` evaluates `Goal` to completion and unifies
`List` with one instance of `Template` per solution, in the order
evaluation found them; no solutions gives `[]`. `sort/2` puts that list
into the standard order of terms and removes duplicates.

Because answers are already distinct (§15.3), `findall/3` over `V` above
collects `[10, 15]`, not `[10, 15, 10]`. Tagging the template — here with
the sensor that produced each reading — is what keeps equal measurements
from different sources apart.

The template and goal run in a nested evaluation whose bindings do not
escape, so a correlation variable must be bound before the `findall/3` goal
is selected. Recursion through a `findall/3` goal is rejected by
stratification.

## Built-in predicates

Control and comparison: `true/0`, `fail/0`, `false/0`, `\+/1`, `call/1`,
`=/2`, `\=/2`, `==/2`, `\==/2`, `@</2`, `@>/2`, `@=</2`, `@>=/2`.

Arithmetic: `is/2`, `=:=/2`, `=\=/2`, `</2`, `>/2`, `=</2`, `>=/2`.

All solutions and clause inspection: `findall/3`, `clause/2`.

Library predicates, in the forms SWI, SICStus and GNU Prolog share:
`between/3`, `length/2`, `sort/2`, `sum_list/2`, `max_list/2`,
`min_list/2`, `atomics_to_string/2`.

One eyeron extension: `sudoku(Puzzle, Solution)` solves a ground 9×9 grid
with a constrained backtracking solver, zero denoting an empty cell.

None of these may be redefined. `member/2`, `append/3` and the rest of the
list library are ordinary definitions, not implicit built-ins.

## Programs as terms

A clause body *is* a term — `\+ G` is `\+(G)`, `X is E` is `is(X, E)`, and
a conjunction is a `','/2` chain — so `clause/2` hands a clause back in the
very notation the program was written in. That is all homoiconicity needs
here: no reified goal vocabulary, no encoding step, no decoder. The vanilla
meta-interpreter is three ordinary clauses.

```prolog
solve(true).
solve((A, B)) :- solve(A), solve(B).
solve(Head) :- clause(Head, Body), solve(Body).
```

Change `solve/1` and you have changed how proving works — count the clauses
an answer used, trace it, bound its depth, or prove a goal against a
program the running program built. `examples/meta-interpreter.pl` does the
first of those alongside plain `solve/1`.

`call/1` runs a goal the program assembled at run time. It carries a caveat
worth stating: the goal is a value, so static validation cannot see which
predicates it reaches, and those calls take no part in the strata. An
unbound or non-callable goal is a runtime error, not a silent failure.

## Answers and proofs

Default output is itself a Prolog program — "Prolog result format 3":

```prolog
% Prolog result format 3
query(1, ancestor(alice, _0), ['Who' = _0]).
result(1, complete, 2).
answer(1, ['Who' = bob]).
answer(1, ['Who' = carol]).
```

Bindings are written as `'Name' = Value` pairs, the form the standard's
`variable_names` read option uses. That output can be saved, loaded and
queried; loading it records the question as data rather than running it
again. `result(..., complete, 0)` means a completed query had no answers,
and a successful ground query has `answer(Id, [])`.

With `--proof`, additional facts describe the derivation:

```prolog
clause(3, instance_of(var('Individual'), var('Superclass')),
       (instance_of(var('Individual'), var('Class')),
        subclass_of(var('Class'), var('Superclass')))).
substitution(4, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]).
proof(4, instance_of(socrates, mortal), rule(3),
      [uses(1, instance_of(socrates, human)),
       uses(2, subclass_of(human, mortal))]).
```

`clause/3` reifies the source template, `substitution/2` records its
instantiation, `proof/4` records a conclusion and its premises, and `why/3`
links an answer to its proof. Premises are four terms — `uses/2`,
`builtin/1`, `absent/2` and `collected/5` — because a goal already explains
itself: a calculation reads `builtin(3 is 1 + 2)`. These records are
inspectable by ordinary Prolog rules. Clause numbers and proof links are
stable when comments, whitespace or line wrapping change. Built-ins,
absence and collection completion remain trusted steps, so the document is
an explanation rather than a fully checked certificate. The complete
vocabulary is normative in §12 of the specification.

`--check` emits `checked/2` and `stratum/2` facts without evaluating
queries. `--json` selects a tagged JSON representation instead of Prolog
syntax.

## RDF 1.2 N-Quads bridge

An optional, non-core bridge imports RDF 1.2 N-Quads as ground
`rdf(S, P, O, G)` facts and exports the `rdf/4` predicate's answers back
out:

```sh
cargo run --release -- --rdf-input examples/rdf12-interoperability.nq examples/rdf12-interoperability.pl
cargo run --release -- --rdf-input examples/rdf12-interoperability.nq --rdf-output examples/rdf12-interoperability.pl
```

The first command produces normal `.pl` answers; the second emits RDF 1.2
N-Quads containing imported and inferred `rdf/4` statements. IRIs use
`iri("u")`, blank nodes `blank("b")`, literals retain datatype or language
and direction, triple terms use `triple(S, P, O)`, and the fourth argument
is `default_graph` or a graph IRI or blank node. Blank-node labels from
separate `--rdf-input` files are scoped independently. Import applies no
RDF or RDFS entailment regime; any intended entailment is written as
clauses. The Rust functions are
`eyeron::prolog::rdf::{parse_nquads, facts_to_prolog, format_nquads, answers_to_nquads}`.

## Rust API

```rust
fn main() -> eyeron::Result<()> {
    let result = eyeron::prolog::run(r#"
        human(socrates).
        mortal(X) :- human(X).
        ?- mortal(Who).
    "#, eyeron::prolog::Limits::default())?;

    print!("{}", eyeron::prolog::output::format_result(&result, false));
    Ok(())
}
```

`eyeron::prolog::run(source, limits)` returns a
`RunResult { queries, proofs, stats }` or an error.
`eyeron::prolog::check(source)` parses and validates without evaluating.
`eyeron::prolog::term::format(term)` writes a term the way `writeq/1` does.
`output::format_result(&result, proof)` and `format_check(&result)` produce
result documents; `run_result_json` and `check_result_json` produce the
`--json` representation.

`Limits`' fields `max_steps`, `max_tables` and `max_answers` default to
5,000,000, 1,000,000 and 1,000,000. Limits are shared across a run;
exhaustion reports incomplete evaluation and never turns partial work into
a false or complete answer.

## Examples and practical boundaries

`examples/*.pl` contains 134 programs covering recursion, lists, search,
arithmetic, graph-shaped data, policies, scheduling, Sudoku, proof auditing
and large parameterized taxonomies. Expected output and proof documents
live under `examples/output/` and `examples/proof/`; `tests/prolog.rs`
checks every example against both byte for byte, and is the test to re-run
(`cargo test --release --test prolog`) after any intentional change to the
examples or to the output format.

Beyond §14's list of what the subset excludes, eyeron provides no
constraint propagation, no existential witness generation, and no static
type or mode inference. Compound terms can represent graph-shaped data but
acquire no RDF semantics automatically; RDF interoperability is explicitly
selected through the N-Quads bridge.

General term recursion and value-generating arithmetic may not terminate.
The engine is a demand-driven fixed-point evaluator intended for clarity
and conformance rather than production optimization.

## Implementation notes

`src/prolog/` shares essentially nothing with `crate::ast`/`crate::n3`/
`crate::srl` except at one explicit boundary (`rdf.rs`), for the reason
given above: this is a logic programming language, not an RDF triple
language. `term.rs`'s `Term` enum (`Var`/`Struct`/`Str`/`Int`/`Float`) has
no relationship to `crate::ast::Term` — an atom is not an IRI and a
compound term is not a triple, so bending `crate::ast::Term` to fit would
mean stretching an RDF-shaped type outside the domain it was designed for.
`src/prolog/` is therefore self-contained: its own `Bindings` (a
`BTreeMap<u64, Term>`, cloned per backtracking attempt), its own
`unify`/`deref`/`instantiate`/`fresh`, and its own arbitrary-precision
integers via `num-bigint`.

One subtlety worth knowing before touching `--proof` output: a variable's
numeric id reflects *when it was minted*, not its position in whatever term
it currently appears in, so `term::variables_in` must return a genuinely
insertion-ordered `Vec<(u64, Term)>`, never an id-sorted map.

The pieces, in reading order:

1. **`term.rs`** — the value domain, unification with the occurs check, the
   standard order of terms, and the writer. `format` writes what `writeq/1`
   writes: quoted atoms where needed, operators in operator position, list
   notation, and brackets wherever a subterm's priority would otherwise
   misread. `key`/`term_key` produce a canonical, variable-identity-
   independent shape used to dedupe table answers.
2. **`ops.rs`** — the operator table, which is the standard's own initial
   table minus the operators whose predicates are outside the subset. Both
   directions use it: the parser to read a term and `term::format` to write
   one, which is what keeps a result document re-readable.
3. **`lexer.rs`/`ast.rs`/`parser.rs`** — a hand-written tokenizer and an
   operator-precedence reader. The tokenizer settles the two details the
   parser depends on: a graphic token is a maximal run, and every token
   records whether layout preceded it (which is how `f(x)` is told from
   `f (x)`, and `-1` from `- 1`). `ast.rs` holds only `Rule`, `Query` and
   the two functions that convert between a body's flat goal sequence and
   its `','/2` chain — there is no goal or expression syntax tree, because
   a goal is a term.
4. **`analyze.rs`** — static stratification per predicate indicator, not
   per clause. A `\+` or `findall/3` argument always contributes a "closed"
   (level-raising) edge; an ordinary call only does when it is already
   inside one. Also validates that every called predicate is defined or
   built in, and that no clause redefines a built-in.
5. **`builtins.rs`** — arithmetic evaluation over terms and every built-in
   that needs neither the program nor the evaluator. `call_builtin` returns
   every resulting binding environment eagerly as a `Vec`. The four that do
   need the program — `\+/1`, `call/1`, `findall/3`, `clause/2` — are
   listed here so validation accepts them but dispatched in `engine.rs`.
6. **`engine.rs`** — the tabled evaluator, described below.
7. **`output.rs`** — result serialization, including anonymous-variable
   numbering and a hand-built `--json` rendering (`serde_json` is
   unavailable on the `wasm32` target).
8. **`rdf.rs`** — the RDF bridge, reusing eyeron's existing N-Quads reader
   (`crate::n3::rdf_compat::parse_rdf12`) and writing one small new N-Quads
   serializer for `--rdf-output`.

### Tabled evaluation

`engine.rs`'s evaluator is not backward SLD search: each distinct call gets
a memo *table*; evaluating a table tries each matching clause, joins its
body left to right, and a newly found answer wakes up (re-enqueues) every
table that subscribed to it. `\+` and `findall/3` each spawn a fresh,
independent, nested tabled evaluation over the whole program for that one
sub-query.

Two design choices make this tractable in Rust without generators:

- **Eager solution collection wherever laziness would not change
  behavior.** Nothing here depends on early termination (unlike SPARQL-RL's
  negation check, which stops at the first solution as a genuine
  optimization) — `\+` always runs its nested query to *completion*. So
  `join` and `step` just return a `Vec` of every solution or branch found.
- **A `Copy` `Ctx` handle, not `&mut Engine`, threaded through every
  recursive call.** Cross-call mutable state — step/table/answer counters,
  the growing proof list, the negation-completion cache, the variable
  counter, and one evaluation's own table arena — is reached through
  `Ctx { shared: &RefCell<Shared>, arena: &RefCell<Arena> }`. Because `Ctx`
  is `Copy`, it can be captured by any number of closures with no
  borrow-checker aliasing fight; an `&mut Engine` reborrowed through the
  search runs straight into "two sibling closures each want to mutably
  borrow the same engine" the moment a callback needs to both tick a step
  counter and recurse. Every mutation is a short `.borrow_mut()` scope that
  never spans a further recursive call.

One correctness-affecting detail: **when an answer is recorded matters, not
just what the final set of answers is.** Collecting every solution of a
clause body into a `Vec` first and only then recording answers is
semantically equivalent for the final table contents, but not for proof-id
*order*: for a body like `person(X), \+ blocked(X)`, the `\+` sub-check for
one binding of `X` — and everything it derives while resolving
`blocked(X)` — happens, and gets its own proof ids, strictly before the
search moves on to the next binding. `join` takes an `on_solution` callback
invoked at its base case specifically to keep that ordering; it is the
reason `join` takes a callback at all while every other search function in
this module returns a plain `Vec`.

## Known limitations

- Proof-record numbering follows the evaluator's own tabled-evaluation
  order; for `\+`/`findall`-heavy programs, a different but semantically
  equivalent evaluation order would number proofs differently. This affects
  `--proof` output only, never plain results.
- Widening an integer to a float is refused rather than approximated, so an
  expression mixing a very large integer with a float reports an error
  where a system with silent conversion would answer.
