# Stratified Negation

*Finish working out who is blocked before asking who is not.*

[stratified-negation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/stratified-negation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/stratified-negation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/stratified-negation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/stratified-negation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=stratified-negation)

---

## The question

Alice, Bob and Carol apply for something. Alice is directly blocked; Carol is
flagged, and being flagged also blocks you. Anyone who is not blocked is
eligible.

The catch: "not blocked" is only meaningful once every block is known. If a
reasoner checked Carol before it derived that she is blocked, it would wrongly
call her eligible.

**Who is eligible?**

---

## What we tell Eyeron

```n3
:alice a :Person .
:bob a :Person .
:carol a :Person .
:alice a :DirectlyBlocked .
:carol a :Flagged .
```

Two rules say who is blocked:

```n3
{
    ?x a :DirectlyBlocked
} => {
    ?x a :Blocked
} .

{
    ?x a :Flagged
} => {
    ?x a :Blocked
} .
```

and one says who is eligible:

```n3
{
    ?x a :Person .
    ?SCOPE log:notIncludes {
        ?x a :Blocked
    } .
} => {
    ?x a :Eligible
} .
```

`log:notIncludes` succeeds when the graph does not contain the quoted
statement; with an open `?SCOPE`, that graph is everything Eyeron knows.

---

## How Eyeron orders the work

Eyeron sees that the eligibility rule tests the absence of `:Blocked`, and
that two other rules produce `:Blocked`. So it runs those first, to the end,
and only then the negation. This layering is called *stratification*. It
does not depend on where the rules appear in the file: put the eligibility
rule first and the answer is the same.

---

## What Eyeron concludes

```n3
:alice a :Blocked .
:carol a :Blocked .
:bob a :Eligible .
```

---

## The proof, step by step

The two blocks come from rules 1 and 2, each from a fact. Bob's eligibility
uses rule 3 and the absence test:

```n3
{ :bob a :Eligible . }
  pe:rule 3;
…
    [ pe:var "x"; pe:value :bob ];
  pe:uses
    { :bob a :Person . },
…
rdf:type pe:derived
    { :alice a :Blocked . },
    { :carol a :Blocked . },
    { :bob a :Eligible . }.
```

The open scope is recorded as a fixed stand-in graph meaning "the current
graph". The last statement is the *search certificate*: every `rdf:type`
statement (`a`) the run derived. It lets the checker see the whole relevant
part of the final graph.

---

## Checked: what the report says

```n3
# checked: 7 steps, 7 verified, 0 trusted
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
```

- **C1 resolution**: the three rule steps match rules 1, 2 and 3, and the
  three fact steps are facts of the program.
- **C5 re-decision** re-decides the absence test, and **C6 boundary
  consistency** finds nothing in the proof saying Bob is blocked.
- **C9 search closure** checks the certificate: each listed statement has a
  supporting step, the list is closed (no rule could derive another `a`
  statement from it), and over it Bob is indeed not blocked. So Bob's
  eligibility is settled rather than assumed.
- **C2**, **C3**, **C4**, **C7** and **C10**: a proper, covered tree with
  nothing extra, and the answers are what was derived.

All 7 steps are verified; the verdict is **checked**.

---

## Try it

```sh
eyeron examples/stratified-negation.n3      # the answer
eyeron -p examples/stratified-negation.n3   # the answer with its proof
eyeron -c examples/stratified-negation.n3   # the proof, checked
```

Add `:bob a :Flagged .`: Bob becomes blocked too, and nobody is eligible.
Or move the eligibility rule to the top of the file: nothing changes.

---

## Takeaway

Negation is safe when everything it depends on is settled first; Eyeron
orders the rules that way itself, and the proof's certificate lets the
checker confirm the absence.
