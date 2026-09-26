# Proof checking

> This is the normative description of what it means for an eyeron proof
> document to be **valid for a source program**, and of what a conforming
> proof checker must do. `src/proof/` is the reference implementation and
> `eyeron --check-proof` runs it. For how each front end *writes* a proof,
> see [`n3.md`](n3.md) and [`sparql-rl.md`](sparql-rl.md).

## 1. Why this document exists

eyeron's two front ends write proofs in two syntaxes but in one shape:
a list of **steps**, each naming a conclusion, the single reason it holds,
the bindings that reason used, and what it used. Until now that shape was
described as "an inspectable explanation graph, not an independently
verified proof certificate" — a reader could follow it, but nothing checked
that it held together.

This specification closes that gap. It defines checking **once**, over an
abstract proof model, and then binds each of the two syntaxes to that
model. A checker therefore has one set of rules to implement and two
syntax readers.

The keywords **MUST**, **MUST NOT**, **SHOULD** and **MAY** are to be read
as normative requirements.

## 2. What a checker is, and is not

A proof checker takes a **source program** and a **proof document** and
decides whether the document's steps really do establish its claims *given
that program*. It re-performs each recorded inference and compares the
result against what was recorded.

A checker MUST NOT search for a proof of its own. If a step is wrong, the
answer is "this proof is invalid", never "but here is another proof". That
separation is the whole point: a checker is simple enough to trust, and
does not need to contain a reasoner.

Three things a valid proof does **not** establish, and which a checker MUST
NOT be read as asserting:

1. **That the source facts are true.** A proof is an argument from the
   given program, not about it.
2. **Completeness.** That these conclusions follow does not mean no others
   do.
3. **That trusted steps hold.** §6 defines the steps a checker records as
   obligations rather than verifying, and requires it to report them.

## 3. The abstract proof model

A **statement** is whatever the front end concludes: an RDF triple for N3
and SPARQL 1.2 RL.

A **step** is a quadruple:

```text
step = ( conclusion, justification, bindings, uses )
```

- `conclusion` is a statement.
- `justification` is exactly one of the forms in §5 and §6.
- `bindings` maps rule-variable names to terms. It is empty for every
  justification but `rule` and `fact`.
- `uses` is an ordered sequence of statements.

A **proof document** is a set of steps together with a set of **claims** —
the statements the document asserts were derived.

A **source program** supplies, for the checker's purposes, exactly two
things: its **rules**, numbered from 1 in source order, and its **given
statements** (the facts written in the document rather than derived).

## 4. Validity

A proof document is **valid for a source program** when all four conditions
hold. A checker MUST report the first failure precisely enough to locate
it: the offending step's conclusion, the condition, and what was expected.

**(C1) Resolution.** Every entry of every step's `uses` MUST resolve:
it MUST be an **instance** of the conclusion of some step of the document,
or of a given statement of the source program.

A use must match a step conclusion or a given statement under the front end's term-matching rules.

**(C2) Well-foundedness.** The relation "step *a* uses a statement that
resolves to step *b*'s conclusion" MUST be acyclic. Equivalently, every step MUST have
a finite rank, where a step's rank is one more than the greatest rank among
the steps its `uses` resolve to, and a step whose `uses` all resolve to
given statements has rank 1.

This is the condition that makes the document a proof rather than a story.
Without it a step could justify its own conclusion, directly or around a
loop, and every other condition would still hold. Note that (C2) constrains
the *derivation*, not the data: a cyclic graph may still have a well-founded proof if each step uses earlier conclusions.

**(C3) Justification.** Every step MUST satisfy the condition its
justification carries (§5, §6).

**(C4) Coverage.** Every claim of the document MUST be an instance of the
conclusion of some step, or of a given statement, in the sense of (C1).

A document that satisfies (C1), (C2) and (C4), and whose every step is
either checked or trusted, is **valid**. A checker MUST distinguish two
successful verdicts: **checked**, when no step was merely trusted, and
**checked with obligations**, when some were, and it MUST list them.

## 5. Checked justifications

### 5.1 `rule N`

The step claims that rule `N` of the source program, used under the step's
bindings, derives its conclusion from its `uses`.

A checker MUST verify this by re-performing that one inference:

1. Take rule `N` from the **source program** — not from any copy of the
   rule carried in the proof document — and rename its variables apart. A
   checker MUST fail when the source has no rule `N`.
2. Bind each of the rule's variables named in `bindings` to the recorded
   value.
3. Require the rule's conclusion, so instantiated, to unify with the step's
   conclusion.
4. Require the rule's premises, so instantiated, to be equal in number to
   `uses` and to unify with them pairwise, in order.

Unification in steps 3 and 4 MUST share one environment, so a variable the
bindings did not mention is still forced to take one consistent value
across the conclusion and every premise. A checker MUST NOT accept a step
whose bindings are insufficient to determine the inference but which
happens to unify.

Taking the rule from the source is what ties the proof to the program. A proof document MAY carry its own copy of a rule for readability; a checker MAY compare it with the source but MUST NOT substitute it for the source.

### 5.2 `fact`

The step claims its conclusion is given outright by the source. A checker MUST verify that the source contains a matching fact and that the step has no premises.

### 5.3 `builtin`

The step claims a built-in relation holds of its conclusion. A checker MUST
re-evaluate the named built-in on the conclusion's own arguments and
require it to succeed.

A built-in is checkable exactly when re-evaluating it is a pure function of
the conclusion. A built-in that consults anything else — the clock, the
network, a random source, the rest of the fact set — is not, and MUST be
treated as trusted (§6.1) rather than silently accepted.

## 6. Trusted justifications

A trusted justification is one whose truth a checker cannot re-establish
from the proof document and the source program alone. Trust is not a
loophole: each form below is enumerable, a checker MUST report every
occurrence, and a caller MAY refuse a document that has any.

### 6.1 Impure built-ins

A `builtin` step whose relation is not a pure function of its conclusion
(§5.3).

## 7. Invalid justifications

### 7.1 `unproven`

A step whose justification is `unproven` records that the engine writing
the proof could not justify the premise at all. It is not a trust
obligation, because nothing is being trusted: it is an admission that the
chain is broken.

A checker MUST treat `unproven` as a failure of (C3). A document
containing one is invalid.

## 8. Syntax bindings

### 8.1 Notation3 (`.n3`)

| model | document |
| --- | --- |
| claims | the document's plain triples (no formula subject) |
| step | a top-level triple whose subject is the quoted conclusion |
| `bindings` | `pe:binding [ pe:var "N"; pe:value V ]` |
| `uses` | `pe:uses { s p o }` |
| `rule N` | `pe:rule N` |
| `fact` | `pe:fact "label"`, naming the document |
| `builtin` | `pe:builtin B` |
| `unproven` | `pe:unproven "reason"` |

Given statements are the source document's own triples.

### 8.2 SPARQL 1.2 RL (`.srl`)

| model | document |
| --- | --- |
| claims | the triples asserted in the proof's `DATA` block |
| step | a `_:stepN` node reifying its conclusion |
| `conclusion` | `rdf:reifies <<(s p o)>>` |
| `bindings` | `pe:binding [ pe:var "N"; pe:value V ]` |
| `uses` | `pe:uses`, naming either a `_:stepK` or a triple term |
| `rule N` | `pe:rule N` |

A `pe:uses` naming a triple term rather than a step node resolves under
(C1) against the source's given statements: SPARQL-RL writes no step for a
statement given in `DATA` or in the base graph.

Only the positive body patterns of a rule are reified as premises. A
`FILTER`, `NOT` or `SET` clause is not a premise and has no `uses` entry;
a checker MUST still evaluate every such clause of rule `N` under the
step's bindings as part of (C3), because a step that satisfies the rule's
patterns but violates its `FILTER` has not established anything.

## 9. Reporting

A checker MUST report, per document: the verdict, the number of steps
checked, and every trust obligation with its kind and conclusion. On
failure it MUST report the failing condition and the step.

A checker SHOULD report counts per justification kind, because the ratio of
checked to trusted steps is the honest measure of how much a proof
establishes.

## 10. What eyeron's own proofs establish

`tests/proof_checking.rs` checks every packaged N3 and SRL proof against the program that produced it. It re-performs rule steps, checks premises, and detects cycles. The suite covers examples with derived rules, property paths, built-ins, and shared proof steps.
