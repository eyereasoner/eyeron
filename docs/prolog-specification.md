# The Prolog subset eyeron accepts

> This is the normative description of eyeron's Prolog front end (`src/prolog/`). See [`prolog.md`](prolog.md) for a task-oriented overview and running instructions.

## 1. Status and conformance

eyeron reads **Prolog text as defined by ISO/IEC 13211-1**. It accepts the
pure, tabled subset of that standard: the part with no control constructs,
no database modification, and no side effects. The keywords **MUST**, **MUST
NOT**, **SHOULD** and **MAY** are to be read as normative requirements.

eyeron is **not** a conforming Prolog processor, and does not claim to be.
Two things separate it from one:

- **It accepts less.** §14 lists everything in the standard that eyeron
  refuses. A program eyeron accepts is valid Prolog text; the converse does
  not hold.
- **It resolves differently.** A conforming processor resolves goals by
  ordered SLD resolution, where clause order is logical priority and a
  left-recursive predicate loops. eyeron evaluates by *tabling* (§6), where
  clause order carries no meaning and left recursion terminates. §15 states
  every consequence of that choice.

So the relationship eyeron's Prolog front end bears to ISO Prolog is the
same one its `.srl` front end bears to full SPARQL: a named, documented
fragment, evaluated under a stated regime. Inside that fragment, a program
means what the standard says it means. That is checked rather than
asserted: `scripts/prolog-conformance` runs every conformance case through
whichever of SWI-Prolog, GNU Prolog, SICStus and Scryer are installed and
compares answer sets case by case. Where those systems disagree with each
other — and on `/`, `**` and `round/1` they do — eyeron follows the
standard's own text, and the script records each system's deviation by
name.

Answer order is not significant unless this document explicitly defines an
ordering.

## 2. Characters and tokens

Source is Unicode text. Layout text is whitespace, a `%` comment running to
the end of the line, or a `/* ... */` block comment.

```ebnf
name          = identifier | quoted | graphic | solo ;
identifier    = lowercase-letter, { alphanumeric | "_" } ;
quoted        = "'", { quoted-character }, "'" ;
graphic       = graphic-char, { graphic-char } ;
graphic-char  = "#" | "$" | "&" | "*" | "+" | "-" | "." | "/" | ":"
              | "<" | "=" | ">" | "?" | "@" | "^" | "~" | "\" ;
solo          = "!" | ";" | "[]" ;
variable      = "_" | ( uppercase-letter | "_" ),
                { alphanumeric | "_" } ;
integer       = digit, { digit } ;
float         = integer, ".", digit, { digit },
                [ ( "e" | "E" ), [ "+" | "-" ], digit, { digit } ] ;
string        = '"', { quoted-character }, '"' ;
end           = "." ;
```

A graphic token is the **maximal** run of graphic characters, so `=:=` and
`\==` are each one token and `--` is one token (with no meaning, hence a
syntax error). A `.` is the clause terminator `end` when layout text or the
end of input follows it, and an ordinary graphic character otherwise; this
is why `p(1).` terminates but `1.25` does not.

A float MUST have a fractional part, so `1e10` is not a float token. eyeron
accepts decimal integers only: the standard's `0x`, `0o`, `0b` and `0'c`
notations are not in the subset.

Inside a quoted token or a string, a doubled quote character stands for one
literal quote, and these escape sequences are recognised:

| Escape | Meaning |
| --- | --- |
| `\a` `\b` `\f` `\n` `\r` `\t` `\v` | alert, backspace, form feed, newline, return, tab, vertical tab |
| `` \\ `` `\'` `\"` ``\` `` | that character |
| `\xH...\` | the character with that hexadecimal code |
| `\O...\` | the character with that octal code |
| `\` followed by a newline | nothing (line continuation) |

Any other escape is a syntax error.

## 3. Operators

The standard makes the operator table mutable through `op/3` directives.
eyeron fixes it: this is the standard's own initial table, minus the
operators whose predicates are outside the subset. A program MUST NOT add
to it, so every source file reads the same way.

| Priority | Type | Operators |
| --- | --- | --- |
| 1200 | xfx | `:-` |
| 1200 | fx | `:-` `?-` |
| 1000 | xfy | `,` |
| 900 | fy | `\+` |
| 700 | xfx | `=` `\=` `==` `\==` `@<` `@>` `@=<` `@>=` `is` `=:=` `=\=` `<` `>` `=<` `>=` |
| 500 | yfx | `+` `-` |
| 400 | yfx | `*` `/` `//` `mod` `rem` |
| 200 | xfx | `**` |
| 200 | xfy | `^` |
| 200 | fy | `-` `+` |

A whole term is read at priority 1200; an argument of a compound term, and
an element of a list, at 999 — which is why a `,` inside `f(a, b)`
separates arguments instead of building a conjunction.

A compound term is written in functional notation only when no layout text
separates its name from the opening bracket: `f(x)` is `f/1`, and `f (x)`
is not. A sign written directly against a numeric literal is part of that
literal, so `-1` is the integer minus one while `- 1` is the compound term
`-(1)`.

## 4. Programs

A program is a sequence of clauses and directives, each ended by `end`.

```ebnf
program   = { clause | directive } ;
clause    = head, [ ":-", body ], end ;
directive = "?-", body, end ;
```

`head` MUST be a callable term — an atom or a compound term — and MUST NOT
be a list pair `'.'/2`. `body` is a goal term; the empty body is the atom
`true`.

`?- Goal.` is a **query**: eyeron evaluates it to completion and reports
its answers (§12). A program MAY contain several. Directives other than
`?-` are not in the subset.

A variable name denotes the same variable everywhere within one clause and
an unrelated variable in the next. Each occurrence of `_` denotes a fresh,
unshared variable; `_` is never reported in an answer. A variable whose
name merely begins with `_` is an ordinary named variable.

## 5. Terms

The value domain is variables, atoms, compound terms, integers of
arbitrary size, finite binary floating-point numbers, and strings. An atom
is a compound term of arity zero, so the goal `ready` and the term `ready`
are one object; there is no separate zero-argument constructor notation and
`ready()` is a syntax error. Lists are `'.'/2` pairs ending in the atom
`[]`; `'.'/2` MUST NOT be called as a predicate.

Kinds are distinct: `1`, `1.0`, `"1"` and `'1'` are four different terms,
and `1 = 1.0` fails.

**Unification** is structural and **always** performs the occurs check.
The standard leaves `=/2`'s result undefined where the occurs check would
be needed, so always performing it is conforming, and it is what makes the
tabled evaluator's memo keys finite.

**The standard order of terms** orders, from least to greatest: variables,
numbers, atoms, strings, compound terms. Variables are ordered by identity;
numbers by value, with a float before an integer of equal value; atoms and
strings alphabetically; compound terms by arity, then name, then arguments
left to right. Strings are eyeron's addition to the standard's order (§14),
placed between atoms and compound terms as SWI-Prolog places them.

## 6. Goal evaluation

Goals in a body are selected **left to right**. A processor MUST report a
mode error when a selected operation requires bound inputs that are not yet
bound; it MUST NOT silently reorder goals.

Evaluation is **tabled**. Each distinct call gets a memo table; evaluating
a table tries every matching clause, joins its body left to right, and
newly found answers re-enqueue the tables that subscribed to it. Answers
are deduplicated modulo variable renaming. For the positive fragment, the
declarative meaning of a program is the least fixed point of its clauses,
and evaluation computes exactly the demanded part of it. Left recursion,
mutual recursion and cycles therefore terminate for finite demanded
computations, and source clause order MUST NOT be used as logical priority.

## 7. Negation

`\+ Goal` requires a ground argument. It succeeds exactly when complete
evaluation of that goal against the immutable program has no answer. This
is stratified closed-world negation, not classical negation. Resource
exhaustion (§11) MUST NOT be interpreted as absence.

## 8. Arithmetic

`X is Expression` evaluates `Expression` once and unifies its value with
`X`. It is not a reversible constraint. `=:=`, `=\=`, `<`, `>`, `=<` and
`>=` evaluate both of their arguments the same way and compare the results
numerically; comparison between an integer and a float is exact, without
widening the integer.

An unbound variable inside an expression, a functor with no arithmetic
meaning, a wrong argument kind, division by zero, or a non-finite result is
an **error**, never a failure.

The evaluable functors are:

| Functor | Result |
| --- | --- |
| `+/2` `-/2` `*/2` | integer when both arguments are integers, otherwise float |
| `//2` | the integer quotient when both arguments are integers and the division is exact, otherwise float |
| `///2` | integer quotient, truncated toward zero; integers only |
| `mod/2` | remainder with the sign of the divisor; integers only |
| `rem/2` | remainder with the sign of the dividend; integers only |
| `-/1` `+/1` `abs/1` | same kind as the argument |
| `sign/1` | `-1`, `0` or `1`, as integer or float following the argument |
| `min/2` `max/2` | whichever argument the numeric comparison selects, unchanged |
| `sqrt/1` `float/1` | float |
| `**/2` | float power |
| `^/2` | integer when both arguments are integers, otherwise float |
| `floor/1` `ceiling/1` `truncate/1` `round/1` `integer/1` | integer; `round(x)` is the standard's `⌊x + ½⌋`, so a tie goes toward positive infinity |

An integer is widened to a float only when the widening is exact;
otherwise the operation is an error rather than a silent loss of precision.

## 9. Built-in predicates

A program MUST NOT define any of these.

**Control.** `true/0` succeeds once. `fail/0` and `false/0` never succeed.
`\+/1` is §7. `call/1` runs a goal term the program itself assembled: its
argument's outermost shape MUST be known when the goal is selected, though
the terms inside it need not be bound, and an unbound or non-callable
argument is an error.

**Unification and term comparison.** `=/2` unifies (§5). `\=/2` succeeds
when its arguments do not unify, binding nothing. `==/2`, `\==/2`, `@</2`,
`@>/2`, `@=</2` and `@>=/2` compare in the standard order of terms without
unifying.

**Arithmetic.** `is/2`, `=:=/2`, `=\=/2`, `</2`, `>/2`, `=</2`, `>=/2`
(§8).

**All solutions.** `findall(Template, Goal, List)` evaluates `Goal` to
completion and unifies `List` with one instance of `Template` per solution,
in the order evaluation found them; no solutions gives `[]`. Because
evaluation is tabled, equal solutions are already one answer, so this is
the list of *distinct* solutions (§15). `sort/2` reorders it into the
standard order.

**Clause inspection.** `clause(Head, Body)` holds for every clause of the
program, with `Head` its head term and `Body` its body goal term — the atom
`true` for a fact, and a `','/2` chain for a conjunction. Each clause is
standardized apart before it is reported, so a program that inspects itself
cannot capture a clause's variables. Unlike the standard's `clause/2`, an
unbound `Head` enumerates the whole program rather than raising an
instantiation error. Answer order is not significant.

`clause/2` is what makes the language homoiconic, and it needs no
supporting notation to do it: a clause body already *is* a term, so the
vanilla meta-interpreter is three ordinary clauses.

```prolog
solve(true).
solve((A, B)) :- solve(A), solve(B).
solve(Head) :- clause(Head, Body), solve(Body).
```

**Lists and atomics.** These are library predicates rather than part of the
standard's core, provided in the forms SWI-Prolog, SICStus and GNU Prolog
all share.

- `between(Low, High, X)`: `Low` and `High` MUST be bound integers;
  enumerates every integer from `Low` through `High` inclusive. Reversed
  bounds have no answers.
- `length(List, N)`: `List` MUST be a bound, closed list; unifies `N` with
  its length.
- `sort(List, Sorted)`: `List` MUST be a bound, closed list; `Sorted` is
  its elements in the standard order of terms, with duplicates removed.
- `sum_list(List, Sum)`, `max_list(List, Max)`, `min_list(List, Min)`:
  `List` MUST be a bound, closed list of numbers. `sum_list([], 0)` holds;
  `max_list` and `min_list` require a nonempty list.
- `atomics_to_string(List, String)`: `List` MUST be a bound, closed list of
  atomic values; `String` is the concatenation of their text. An atom
  contributes its name, a string its contents, a number its lexical form.

**eyeron extension.** `sudoku(Puzzle, Solution)` requires a bound 9 by 9
list of integer rows, zero denoting an empty cell, and enumerates every
grid respecting the givens and the row, column and box constraints.
Malformed input is an error; inconsistent givens have no answers.

Nothing else is implicit: `member/2`, `append/3`, `nth0/3` and the rest of
`library(lists)` MUST be defined by the program.

## 10. Static validation and stratification

Every called predicate MUST be defined by at least one clause or be a
built-in. Defining a built-in is an error.

Let a positive dependency have weight 0, and a dependency beneath `\+` or
inside a `findall/3` goal have weight 1. There MUST be an assignment of
non-negative integer strata such that, for every edge from a clause head
`H` to a dependency `D`:

```text
stratum(H) >= stratum(D) + weight
```

Programs with recursion through `\+` or `findall/3` therefore fail
validation. The analysis is conservative, by predicate indicator, and does
not inspect argument values. Input modes, value kinds and groundness are
checked at evaluation time rather than by the static validator.

A goal reached through `call/1` is beyond the analysis: the goal is a
value, so the predicates it reaches are not known until evaluation and take
no part in the strata.

## 11. Completion, limits and errors

Compound terms and arithmetic can create unboundedly many calls or answers.
The language does not require every valid program to terminate. eyeron
exposes positive limits for steps, tables and answers; reaching one
produces an explicit incomplete-evaluation error, and partial answers MUST
NOT be presented as a complete result.

Syntax errors carry a source line and column. Validation, mode, arithmetic,
malformed-built-in-input and incomplete-evaluation errors are distinct from
a completed query with no answers. Errors are reported and stop the run;
they are not thrown as terms a program can catch (§14).

## 12. Result documents and proofs

A completed evaluation serializes as a Prolog program. It opens with the
comment `% Prolog result format 3`, and every other line is an ordinary
fact that another eyeron run can load and query. Loading a result document
asserts records; it does not re-run the recorded questions or recreate the
source program.

The answer vocabulary is:

- `query(Id, Goal, Projection)` records a question. `Projection` is a list
  of `'Name' = Variable` pairs, the form the standard's `variable_names`
  read option uses.
- `result(Id, complete, Count)` states that evaluation completed and gives
  the number of distinct answers. Count zero is logical failure, not an
  error.
- `answer(Id, Bindings)` records one solution as a list of
  `'Name' = Value` pairs. A successful ground query uses `answer(Id, [])`.
- `why(QueryId, Bindings, ProofId)` links an answer to its proof, and is
  present only when proofs are requested.

Query ids start at one and are local to the document. Integers, floats,
strings, atoms and compound terms keep their kinds. A residual variable
remains a live variable in the output fact; variable identity is preserved
within one fact and independent between facts.

With proofs requested, the document additionally contains:

- `clause(Number, HeadTemplate, BodyTemplate)` once per used source clause;
- `substitution(ProofId, Bindings)` for every proof step; and
- `proof(Id, Conclusion, Source, Premises)` for every recorded derivation.

`Source` is `rule(ClauseNumber)` for a clause step and `query` for a
query-projection step, whose conclusion is `solution(Values)`. Clause
numbers identify the corresponding `clause/3` record and are independent of
whitespace and physical position. Positive proof references MUST point to
earlier proof records, so the recorded derivation graph is acyclic even
when the program is recursive.

A clause template's variables are reified as `var('Name')` and
`anonymous(N)` so their identity survives being split across separate
facts, where ordinary variables would each read back as a fresh one.
`anonymous(N)` terms MUST NOT occur as substitution keys.

The premise vocabulary is four terms, because a goal is already a term and
explains itself:

- `uses(ProofId, Goal)` for a derived answer of a user predicate;
- `builtin(Goal)` for a built-in goal that succeeded, instantiated — so a
  calculation reads `builtin(3 is 1 + 2)` and a comparison `builtin(1 < 2)`;
- `absent(Goal, complete)` for a `\+` whose argument completed with no
  answer; and
- `collected(Values, Template, Goal, ProofIds, complete)` for a completed
  `findall/3`.

Built-ins, absence and collection completion are trusted records. The
format is an inspectable explanation graph, not an independently verified
proof certificate.

`--check` output instead consists of `checked(rules(N), queries(M))` and
one `stratum(Name/Arity, Level)` fact per predicate. JSON is an explicitly
selected API and CLI representation rather than Prolog syntax; integers use
tagged decimal strings there, because JSON has no arbitrary-size integer
kind.

## 13. RDF 1.2 N-Quads adapter

eyeron provides a lossless boundary mapping between an RDF 1.2 dataset in
N-Quads syntax and ground `rdf/4` terms. This adapter is not part of goal
evaluation and does not imply an entailment regime.

An RDF quad `(S, P, O, G)` maps to `rdf(S, P, O, G)`. Terms map as follows:

| RDF value | Prolog term |
| --- | --- |
| IRI `u` | `iri("u")` |
| blank node with document-local label `b` | `blank("b")` |
| simple or typed literal `(lexical, datatype)` | `literal("lexical", datatype(iri("datatype")))` |
| language-tagged literal `(lexical, language)` | `literal("lexical", language("language"))` |
| directional literal `(lexical, language, direction)` | `literal("lexical", language("language", direction))` |
| triple term `(S, P, O)` | `triple(S, P, O)` |
| default graph | `default_graph` |
| named graph | its mapped IRI or blank node |

Language tags MUST be normalized to lowercase. A simple literal MUST map to
the `http://www.w3.org/2001/XMLSchema#string` datatype. Lexical forms MUST
otherwise be preserved. Blank-node identity MUST be preserved within one
input document and kept distinct between documents loaded by one CLI
invocation.

`--rdf-input FILE` MUST parse RDF 1.2 N-Quads and prepend the resulting
ground facts to the program. It may be repeated. `--rdf-output` MUST query
the complete `rdf/4` predicate after evaluation and serialize its distinct
ground answers as deterministic N-Quads with a `VERSION "1.2"`
announcement. Invalid RDF positions, malformed terms, non-ground output and
unsupported version announcements MUST be errors. The adapter follows [RDF
1.2 Concepts and Abstract Data Model](https://www.w3.org/TR/rdf12-concepts/)
and [RDF 1.2 N-Quads](https://www.w3.org/TR/rdf12-n-quads/).

## 14. What is not in the subset

eyeron refuses these at parse time or at validation time rather than
accepting them with an approximate meaning:

- **Control constructs**: the cut `!`, disjunction `;/2`, if-then `->/2`,
  `catch/3` and `throw/1`. A program expresses a choice as two clauses.
- **Database modification**: `assert/1`, `asserta/1`, `assertz/1`,
  `retract/1`, `abolish/1`. The program is immutable, which is what lets
  `\+` and `findall/3` report *completed* absence and collection.
- **Directives**: everything but `?-`, including `op/3` (§3),
  `dynamic/1`, `discontiguous/1`, `initialization/1`, `set_prolog_flag/2`
  and `ensure_loaded/1`.
- **Term construction and inspection**: `=../2`, `functor/3`, `arg/3`,
  `copy_term/2`, and the type tests `var/1`, `nonvar/1`, `atom/1`,
  `number/1`, `atomic/1`, `compound/1`, `callable/1`, `is_list/1`.
- **Other all-solutions predicates**: `bagof/3` and `setof/3`, whose free
  variable and `^/2` semantics need backtracking over witnesses that a
  tabled evaluator does not offer. `findall/3` plus `sort/2` covers what
  they are usually used for.
- **Input and output**: every stream predicate, `write/1`, `read/1`,
  `format/2` and friends. A program's output is its answers.
- **Character escapes and notations** listed as excluded in §2, and
  curly-bracketed `{}/1` terms.
- **Modules** (ISO/IEC 13211-2) and DCG notation.

One thing eyeron *adds*: `"..."` denotes a string object rather than the
code list the standard's `double_quotes` flag defaults to. This is
SWI-Prolog's convention, and the RDF adapter (§13) depends on it to carry
lexical forms. Nothing else outside the standard is accepted, and the two
remaining additions — `atomics_to_string/2` and `sudoku/2` — are ordinary
predicates, not syntax.

## 15. Differences from a resolution-order processor

Where eyeron accepts a program, its answers are the program's declarative
answers, and a conforming processor that terminates on it agrees. These are
the places where the tabled regime is observable:

1. **Clause order is not priority.** Reordering a predicate's clauses never
   changes an answer. A program that depends on a fact being tried before a
   rule has no such dependency here.
2. **Left recursion terminates.** `ancestor(X, Z) :- ancestor(X, Y),
   parent(Y, Z).` is an ordinary definition for eyeron and a loop for a
   resolution-order processor.
3. **Answers are distinct.** Two derivations of the same answer are one
   answer, so `findall/3` collects the distinct solutions rather than a
   true bag (§9). Where multiplicity matters, the template can carry what
   distinguishes the sources, as `reading(Sensor, Value)` does in
   `examples/aggregation.pl`.
4. **Answer order is unspecified.** It is deterministic for a given
   program, but neither the standard's resolution order nor any other
   stated order.
5. **Errors stop the run.** With no `catch/3` in the subset, an error is
   reported against the whole evaluation rather than caught by a goal.
6. **`clause/2` sees only the program.** A call whose head names a built-in
   simply has no answers, where the standard raises a permission error.
   This is what lets the vanilla meta-interpreter of §9 fall through to its
   third clause instead of stopping on `solve(true)`.
