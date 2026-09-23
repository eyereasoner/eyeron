# How Eyeron reasons

Eyeron reads three languages, and each has its own evaluator. Which one you
write in decides how the search runs, what ends up derived, and therefore
what a proof contains. The languages share a parser front end and a term
representation, not a semantics: renaming a file does not translate it.

## Forward, to a fixpoint: N3 and SPARQL 1.2 RL

Start from the facts, apply every rule whose body matches, add whatever is
new, and repeat until a pass adds nothing. What remains is the **closure**:
everything the rules can derive, whether or not anyone asked for it.

The passes are driven by an agenda rather than by rescanning. A newly
derived fact wakes only the rule premises that could match it, and a fact
index narrows each premise to a small candidate set instead of a full scan,
so a long single-premise chain costs its length rather than its square.

- **N3** runs one fixpoint over the whole rule set. It also has
  goal-directed pieces inside that run: a backward rule (`<=`) is proved on
  demand when a forward rule needs its conclusion, and `log:query` asks a
  goal against the closure.
- **SPARQL 1.2 RL** first **stratifies**: it builds a dependency graph
  between rule heads and other rules' body patterns and orders the rules in
  layers, so a `NOT` clause never runs before every rule that could produce
  the pattern it negates has finished. Each layer then runs to its own
  fixpoint. `--query-mode backward` skips materialization and proves a query
  pattern directly instead.

## Backward, from the question: Prolog

Start from the question — a `?-` directive — pick the clauses whose head
unifies with the goal, prove the body, and backtrack when a branch fails.
Only what the question needs is ever derived.

Evaluation is **tabled**: the first call to a distinct goal opens a memo
table and computes its answers to a least fixed point; later calls to the
same goal consume answers from the table instead of re-deriving them. That
is why left-recursive definitions terminate, why clause order carries no
meaning, and why each answer is derived once. Negation is stratified, as in
SPARQL-RL and for the same reason.

## One program, three proofs

`examples/deep-taxonomy-100000` is the same benchmark in all three
languages: one individual, 100,000 taxonomy levels, and each level deriving
the next class plus two side labels — 300,000 derivable facts.

```bash
eyeron --check-proof examples/proof/deep-taxonomy-100000.n3 examples/deep-taxonomy-100000.n3
```

| | steps | why |
| --- | --- | --- |
| `.n3` | 300,010 | forward: every one of the 300,000 derived facts is explained, plus the given fact and the report |
| `.srl` | 300,009 | the same 300,009 rule steps; a fact given in `DATA` is named inline as `<<(s p o)>>` rather than getting a step of its own |
| `.pl` | 100,013 | backward: `?- arc(Check, Message).` needs only the spine `n0 → … → n100000 → a2`, plus the four side labels the checks actually name |

The Prolog proof is a third the size not because it proves less soundly but
because it was asked less: the other 199,996 side labels are derivable and
nothing needed them. Replace the question with one that asks for all of
them — `?- a(ind, C).` — and the counts line up. At depth 1,000 that gives
3,002 steps against N3's 3,010, where the packaged `?- arc(Check, Message).`
gives 1,013; the remaining eight are the report and check rules the N3
version also derives.

So the size of a proof tracks the question, not the engine. A forward run
explains its whole closure; a backward run explains its answer.

## What a run reports

The three Socrates examples encode one inference — Socrates is human, humans
are mortal — but each language prints a different part of it.

**N3** prints the facts it newly derived, and not the input it was given:

```
$ eyeron examples/socrates.n3
@prefix : <http://example.org/socrates#> .

:Socrates a :Mortal .
```

**SPARQL 1.2 RL** prints its inference graph. A rule set works over two
graphs: `--data FILE` supplies a **base graph**, which is read but never
added to, while the rule set's own `DATA { ... }` block seeds the
**inference graph**, which grows with every rule conclusion. An ordinary
rule body matches the union of the two; `WHERE DATA { ... }` restricts
matching to the base graph. What a run prints is the inference graph alone —
the rule set's own `DATA` facts that the base graph does not already carry,
plus everything derived. With no `--data`, that is the whole `DATA` block
plus the conclusions:

```
$ eyeron examples/socrates.srl
@prefix : <http://example.org/socrates#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

:Socrates a :Human .              # the rule set's own DATA
:Human rdfs:subClassOf :Mortal .  # the rule set's own DATA
:Socrates a :Mortal .             # derived
```

**Prolog** prints a result document, which is itself an ordinary Prolog
program:

```
$ eyeron examples/ancestor.pl
% Prolog result format 4
query(1, ancestor(alice, _0), ['Who' = _0]).
result(1, complete, 3).
answer(1, ['Who' = bob]).
answer(1, ['Who' = carol]).
answer(1, ['Who' = dana]).
```

- `query(Id, Goal, Variables)` — the question that was asked. `Id` numbers
  the program's `?-` directives from 1, and the other facts refer back to
  it. The goal's variables are renamed `_0`, `_1`, …, and `Variables` says
  which source name stands for which, as `'Name' = Var` pairs; here `'Who'`
  is `_0`, the second argument of the goal.
- `result(Id, Status, Count)` — how the query finished and how many answers
  it had. `complete` means the search finished; `result(1, complete, 0)` is
  a query that completed with no answers.
- `answer(Id, Bindings)` — one answer, as `'Name' = Value` pairs over those
  same variables. A ground query that succeeds binds nothing, so it reports
  `answer(Id, [])`.

Because that document is a program, it can be saved, loaded and queried:
reading it back records the question and its answers as data, rather than
running the query again.

`--proof` adds the derivation to each of the three, in the same shape: a
conclusion, the single term saying why it holds, the bindings that
justification used, and the conclusions it used. See
[the guide's proof section](guide.md#proofs) for the three side by side, and
[`proof-checking.md`](proof-checking.md) for what makes one valid.
