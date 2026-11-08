# Chaining Comparisons

*If A beats B and B beats C, then A beats C.*

[backward-transitivity.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/backward-transitivity.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/backward-transitivity.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/backward-transitivity.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/backward-transitivity.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=backward-transitivity)

---

## The question

Four candidates, A to D. A scored 8 and B scored 5. D has an award and B is
called boring. We are also told outright that B is more interesting than C.
C has no score, so nothing compares A with C directly.

**Is A more interesting than C?**

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

A **backward rule** (`<=`: conclusion above, condition below), consulted only
when a question is asked: *X beats Y if X has the higher score.* A second one
lets an awarded candidate beat a boring one.

```n3
{
    ?X :moreInterestingThan ?Z .
} <= {
    ?X :moreInterestingThan ?Y .
    ?Y :moreInterestingThan ?Z .
} .
```

The third is **recursive**: its condition asks the same kind of question
again. *X beats Z if X beats some Y, and that Y beats Z.* Each of those two
smaller questions can be answered by a score, an award, a stated fact, or
another chain.

```n3
{
    :A :moreInterestingThan :C .
} log:query {
    :A :moreInterestingThan :C .
} .
```

A forward rule (not shown) asks the question and records the answer; this
`log:query` selects it for printing.

---

## What Eyeron concludes

```n3
:A :moreInterestingThan :C .
```

---

## The proof, step by step

```n3
{ :A :moreInterestingThan :C . }
  pe:rule 3;
  pe:binding
    [ pe:var "X"; pe:value :A ],
    [ pe:var "Y"; pe:value :B ],
    [ pe:var "Z"; pe:value :C ];
  pe:uses
    { :A :moreInterestingThan :B . },
    { :B :moreInterestingThan :C . }.

{ :A :moreInterestingThan :B . }
  pe:rule 1;
…
{ :B :moreInterestingThan :C . }
  pe:fact "backward-transitivity.n3".
```

The proof has six steps. The answer comes from rule 3, the chain rule, with B
as the stepping stone. Its first link, *A beats B*, comes from rule 1: A's
score 8 against B's 5, both facts from the file, with `8 math:greaterThan 5`
computed. Its second link, *B beats C*, is simply a fact we stated.

---

## Checked: what the report says

```n3
# checked: 6 steps, 6 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 8; pe:failed 0 ].
```

- **C1 resolution**: both rule steps re-perform their rules with the recorded
  values, and the three facts are in the file.
- **C5 re-decision**: the checker compares 8 and 5 itself.
- **C10 call fidelity**: the calls each rule step uses are the ones its rule
  makes, and the printed answer is backed by an application of the query.
- **C2 well-foundedness** matters more here than usual: a recursive rule
  could in principle be used to justify a statement by itself, and the
  checker makes sure no step depends on itself.

Verdict: **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/backward-transitivity.n3      # the answer
eyeron -p examples/backward-transitivity.n3   # the answer with its proof
eyeron -c examples/backward-transitivity.n3   # the proof, checked
```

Replace every `:A :moreInterestingThan :C` with `:D :moreInterestingThan :C`
and run again. Eyeron again concludes yes, now by a different chain: D beats B
by the award rule, and B beats C as stated.

---

## Takeaway

A recursive rule turns a few direct comparisons into conclusions about pairs
nobody compared, and the proof spells out the chain it followed.
