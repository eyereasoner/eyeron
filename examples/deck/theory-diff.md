# Comparing Two Theories

*Rules as data: spotting which rules a new version drops and which it adds.*

[theory-diff.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/theory-diff.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/theory-diff.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/theory-diff.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/theory-diff.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=theory-diff)

---

## The question

A team keeps a set of rules, the base theory, and someone proposes a revised
one, the candidate. Before accepting it, a reviewer wants a diff: which rules
did the candidate lose, and which did it add?

**Can rules compare two sets of rules, treating them as data?**

---

## What we tell Eyeron

Both theories are written as **quoted graphs**: braces hold a document as a
value, so the rules inside are stored, not run.

```n3
<> :base {
…
    {
        ?P :parentOf ?Q .
    } => {
        ?Q :childOf ?P .
    } .
…
    {
        ?P :worksFor ?Org .
    } <= {
        ?Org :employs ?P .
    } .
} .
```

The base has three rules: a subclass rule, *a parent's child is their child*,
and a backward rule (`<=`) for *works for*. The candidate keeps the subclass
rule, writes *works for* as a forward rule (`=>`) instead, drops the
parent/child rule and adds one for mentors:

```n3
<> :candidate {
…
    {
        ?P :mentors ?Q .
    } => {
        ?Q :menteeOf ?P .
    } .
} .
```

In N3, `{ B } => { H }` is the triple `{ B } log:implies { H }`, and
`{ H } <= { B }` is `{ H } log:impliedBy { B }`. So a rule pattern can look
for rules:

```n3
{
    ?W :base ?Base .
    ?W :candidate ?Cand .
    ?Base log:includes {
        ?B log:implies ?H
    } .
    ?Cand log:notIncludes {
        ?B log:implies ?H
    } .
} => {
    ?B :missingForwardRule ?H .
} .
```

`log:includes` finds each forward rule inside the base; `log:notIncludes`
then checks that the candidate does not contain that same rule. Three more
rules of the same shape report missing backward rules, and extra forward and
backward rules.

---

## What Eyeron concludes

```n3
{
    ?P :parentOf ?Q .
} :missingForwardRule {
    ?Q :childOf ?P .
} .
{
    ?Org :employs ?P .
} :missingBackwardRule {
    ?P :worksFor ?Org .
} .
{
    ?Org :employs ?P .
} :extraForwardRule {
    ?P :worksFor ?Org .
} .
{
    ?P :mentors ?Q .
} :extraForwardRule {
    ?Q :menteeOf ?P .
} .
```

The parent/child rule is missing, the mentor rule is extra, and the *works
for* rule shows up twice: as a missing backward rule and an extra forward
rule. It means the same thing, but it is written differently, and this diff
compares how rules are written, not what they mean. The unchanged subclass
rule is not reported.

---

## The proof: two built-in tests per finding

Each finding is one rule step, using the two stored theories and two built-in
results: the base includes the rule, and the candidate does not.

```n3
{
  {
      ?P :parentOf ?Q .
  } :missingForwardRule {
      ?Q :childOf ?P .
  } .
}
  pe:rule 1;
…
{
  {
…
      {
          ?P :mentors ?Q .
      } => {
          ?Q :menteeOf ?P .
      } .
  } log:notIncludes {
      {
          ?P :parentOf ?Q .
      } => {
          ?Q :childOf ?P .
      } .
  } .
}
  pe:builtin log:notIncludes.
```

---

## Checked: what the report says

```n3
# checked: 14 steps, 14 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 8; pe:failed 0 ];
```

Fourteen steps: 4 rule steps, the 2 stored theories, and 8 built-in tests.
**C1** confirms each rule step matches its rule, **C2–C4** that the argument
is complete and not circular, **C7** that nothing is padding, and **C10**
that the tests were checked as called. **C5 re-decision** re-runs all eight
`log:includes` and `log:notIncludes` tests over the quoted theories. Because
the theories are fixed documents, even the "does not include" answers are
recomputed rather than assumed, and nothing is taken on trust.

---

## Try it

```sh
eyeron examples/theory-diff.n3
eyeron -c examples/theory-diff.n3
```

Copy the parent/child rule into the candidate as well: the
`:missingForwardRule` finding disappears and the other three remain.

---

## Takeaway

In N3 a rule is also a triple, so rules can inspect, compare and report on
other rules, with the same checkable proofs as any other conclusion.
