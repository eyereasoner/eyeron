# A Passing Grade

*A rule that builds a small structured value: a list.*

[assignment.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/assignment.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/assignment.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/assignment.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/assignment.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=assignment)

---

## The question

Alice scored 7 and Bob scored 3. A score of at least 5 passes, and a passing
student's grade should record both the verdict and the score.

**Who passes, and what is their grade?**

---

## What we tell Eyeron

```n3
:alice :score 7 .
:bob :score 3 .

{
    ?x :score ?score .
    ?score math:notLessThan 5 .
} => {
    ?x :grade (:pass ?score)
} .
```

Two facts and one rule. The rule reads: *if x has a score that is not less
than 5, x's grade is the list (pass, score)*. `math:notLessThan` is a
**built-in** comparison that Eyeron calculates. `( … )` is an N3 **list**:
here a pair of the label `:pass` and the score itself.

---

## What Eyeron concludes

```n3
:alice :grade (:pass 7) .
```

Bob's 3 is less than 5, so he gets no grade at all: the rule simply does not
fire for him. (A rule for failing grades would need its own condition.)

---

## The proof, step by step

```n3
{ :alice :grade (:pass 7) . }
  pe:rule 1;
  pe:binding
    [ pe:var "score"; pe:value 7 ],
    [ pe:var "x"; pe:value :alice ];
  pe:uses
    { :alice :score 7 . },
    { 7 math:notLessThan 5 . }.

{ :alice :score 7 . }
  pe:fact "assignment.n3".

{ 7 math:notLessThan 5 . }
  pe:builtin math:notLessThan.
```

Three steps: the grade by rule 1 with `x` = Alice and `score` = 7; her score,
a fact from the file; and the comparison, a calculation.

---

## Checked: what the report says

```n3
# checked: 3 steps, 3 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
```

- **C1 resolution**: putting Alice and 7 into rule 1 gives exactly the
  claimed grade, list included, and her score is in the file.
- **C5 re-decision**: the checker compares 7 with 5 again itself.
- C2–C4, C7 and C10 confirm there are no loops, gaps, unneeded steps or
  altered calls.

Verdict: **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/assignment.n3      # the answer
eyeron -p examples/assignment.n3   # the answer with its proof
eyeron -c examples/assignment.n3   # the proof, checked
```

Add `:carol :score 5 .` and run again: 5 is not less than 5, so Carol gets
`(:pass 5)`.

---

## Takeaway

A rule's conclusion can build structured values such as lists, and the proof
shows which inputs went into them.
