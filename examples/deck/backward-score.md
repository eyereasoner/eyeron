# Comparing by Score

*Several ways to be more interesting; Eyeron picks the one that applies.*

[backward-score.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/backward-score.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/backward-score.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/backward-score.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/backward-score.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=backward-score)

---

## The question

Four candidates, A to D. A scored 8 and B scored 5. D has an award, B is
called boring, and we are told outright that B is more interesting than C.
A candidate can be more interesting than another for different reasons: a
higher score, an award against a boring rival, or a chain of such
comparisons.

**Is A more interesting than B?**

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
    ?X :score ?SX .
    ?Y :score ?SY .
    ?SX math:greaterThan ?SY .
} .
```

The first of three **backward rules** (`<=`: conclusion above, condition
below). It says *X beats Y if X's score is greater than Y's*. The other two
cover the award (*an awarded candidate beats a boring one*) and chains (*if X
beats Y and Y beats Z, X beats Z*). Backward rules are only used when a
question is asked.

```n3
{
    :A :moreInterestingThan :B .
} => {
    :A :moreInterestingThan :B .
} .

{
    :A :moreInterestingThan :B .
} log:query {
    :A :moreInterestingThan :B .
} .
```

A forward rule asks the question and records the answer. The `log:query` rule
then selects what to print: when a program has queries, Eyeron outputs only
their answers.

---

## What Eyeron concludes

```n3
:A :moreInterestingThan :B .
```

---

## The proof, step by step

```n3
{ :A :moreInterestingThan :B . }
  pe:rule 1;
  pe:binding
    [ pe:var "SX"; pe:value 8 ],
    [ pe:var "SY"; pe:value 5 ],
    [ pe:var "X"; pe:value :A ],
    [ pe:var "Y"; pe:value :B ];
  pe:uses
    { :A :score 8 . },
    { :B :score 5 . },
    { 8 math:greaterThan 5 . }.
```

The proof names the reason that worked: rule 1, the score rule, with A's 8
against B's 5. The two scores are facts from the file and `8 math:greaterThan
5` is a calculation, giving four steps in all. The award and chain rules were
not needed, so they do not appear.

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
```

- **C1 resolution**: the rule step re-performs rule 1 with the recorded
  values, and the two facts are in the file.
- **C5 re-decision**: the checker compares 8 and 5 itself.
- **C10 call fidelity**: the printed answer is backed by a real application
  of the query, not merely shaped like its conclusion.
- C2–C4 and C7 confirm there are no loops, gaps or unneeded steps.

Verdict: **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/backward-score.n3      # the answer
eyeron -p examples/backward-score.n3   # the answer with its proof
eyeron -c examples/backward-score.n3   # the proof, checked
```

Change A's score from 8 to 4 and run again: A no longer outscores B, has no
award and no chain leads from A to B, so nothing is printed.

---

## Takeaway

When several rules could answer a question, the proof records the one that
did, so you can see not just *that* A beats B but *why*.
