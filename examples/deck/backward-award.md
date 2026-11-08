# Comparing by Award

*An award beats a boring rival, even without a score.*

[backward-award.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/backward-award.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/backward-award.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/backward-award.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/backward-award.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=backward-award)

---

## The question

Four candidates, A to D. A scored 8 and B scored 5; D has no score at all,
but D has an award, and B is called boring. A candidate can be more
interesting than another because of a higher score, because of an award
against a boring rival, or through a chain of such comparisons.

**Is D more interesting than B?**

---

## What we tell Eyeron

```n3
:A :score 8 .
:B :score 5 .
:B :moreInterestingThan :C .
:D :hasAward true .
:B :boring true .
```

The facts. (The file also contains `_:b1 log:table :moreInterestingThan`, a
hint some reasoners use to remember answers to recursive questions; no rule
here reads it.)

```n3
{
    ?X :moreInterestingThan ?Y .
} <= {
    ?X :hasAward true .
    ?Y :boring true .
} .
```

This is the second of three **backward rules**. The arrow `<=` points from
the condition (below) to the conclusion (above): *X is more interesting than
Y if X has an award and Y is boring*. The other two compare scores and follow
chains. Backward rules are consulted only when a question is asked.

```n3
{
    :D :moreInterestingThan :B .
} => {
    :D :moreInterestingThan :B .
} .

{
    :D :moreInterestingThan :B .
} log:query {
    :D :moreInterestingThan :B .
} .
```

A forward rule asks the question and records the answer, and a `log:query`
selects what to print: with queries present, Eyeron prints only their answers.

---

## What Eyeron concludes

```n3
:D :moreInterestingThan :B .
```

The score rule cannot help, since D has no score. The award rule can.

---

## The proof, step by step

```n3
{ :D :moreInterestingThan :B . }
  pe:rule 2;
  pe:binding
    [ pe:var "X"; pe:value :D ],
    [ pe:var "Y"; pe:value :B ];
  pe:uses
    { :D :hasAward true . },
    { :B :boring true . }.

{ :D :hasAward true . }
  pe:fact "backward-award.n3".

{ :B :boring true . }
  pe:fact "backward-award.n3".
```

Three steps: the answer by rule 2 (the award rule) with `X` = D and `Y` = B,
and the two facts it used, both from the file.

---

## Checked: what the report says

```n3
# checked: 3 steps, 3 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
```

- **C1 resolution**: the rule step re-performs rule 2 with D and B, and both
  facts are found in the file.
- **C10 call fidelity**: the printed answer is backed by an application of
  the query, not merely shaped like its conclusion.
- C2–C4 and C7 confirm there are no loops, gaps or unneeded steps.

No calculation was involved, so C5 had nothing to recompute. Verdict:
**checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/backward-award.n3      # the answer
eyeron -p examples/backward-award.n3   # the answer with its proof
eyeron -c examples/backward-award.n3   # the proof, checked
```

Delete the line `:B :boring true .` and run again: the award rule no longer
applies, D has no score to compare, and nothing is printed.

---

## Takeaway

A rule can give a reason that has nothing to do with numbers; the proof shows
which reason carried the answer.
