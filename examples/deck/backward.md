# A Backward Rule

*Asking a question on demand instead of filling in every answer up front.*

[backward.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/backward.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/backward.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/backward.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/backward.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=backward)

---

## The question

We call one number "more interesting" than another when it is bigger. There
are endlessly many pairs of numbers, so writing down every such pair is out of
the question. Instead we want a definition that is only used when someone
actually asks.

**Is five more interesting than three?**

---

## What we tell Eyeron

```n3
{
    ?X :moreInterestingThan ?Y .
} <= {
    ?X math:greaterThan ?Y .
} .
```

This is a **backward rule**: the arrow `<=` points from the condition (below)
to the conclusion (above). It reads *"X is more interesting than Y if X is
greater than Y"*. Eyeron does not run it by itself; it waits until something
asks a `:moreInterestingThan` question, and then answers it by checking the
condition. `math:greaterThan` is a **built-in**: Eyeron computes it rather
than looking it up.

```n3
{
    5 :moreInterestingThan 3 .
} => {
    5 :isIndeedMoreInterestingThan 3 .
} .
```

This is an ordinary **forward rule** (`=>`). Its condition asks the question,
which hands it to the backward rule; if the answer is yes, it records a new
statement.

---

## What Eyeron concludes

```n3
5 :isIndeedMoreInterestingThan 3 .
```

The forward rule asked, the backward rule answered by comparing 5 with 3, and
the answer was recorded. No `:moreInterestingThan` statement is printed: the
backward rule answers questions but adds nothing to the output by itself.

---

## The proof, step by step

```n3
{ 5 :isIndeedMoreInterestingThan 3 . }
  pe:rule 2;
  pe:uses { 5 :moreInterestingThan 3 . }.

{ 5 :moreInterestingThan 3 . }
  pe:rule 1;
  pe:binding
    [ pe:var "X"; pe:value 5 ],
    [ pe:var "Y"; pe:value 3 ];
  pe:uses { 5 math:greaterThan 3 . }.

{ 5 math:greaterThan 3 . }
  pe:builtin math:greaterThan.
```

Three steps, read from the answer down:

1. The answer comes from rule 2 (the forward rule), using *5 is more
   interesting than 3*.
2. That comes from rule 1 (the backward rule), with `X` = 5 and `Y` = 3,
   using *5 is greater than 3*.
3. And that is a calculation by the built-in `math:greaterThan`.

In a proof, a backward rule looks just like a forward one: a rule, its
bindings and what it used.

---

## Checked: what the report says

```n3
# checked: 3 steps, 3 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

- **C1 resolution**: the two rule steps really are applications of rules 1
  and 2 with the recorded values.
- **C5 re-decision**: the checker compares 5 and 3 again itself rather than
  trusting the proof's word for it.
- **C10 call fidelity**: each rule step uses the calls its rule makes.
- C2–C4 and C7 confirm the steps form a well-shaped chain with no gaps, loops
  or padding.

All three steps were verified and none taken on trust, so the verdict is
**checked**.

---

## Try it

```sh
eyeron examples/backward.n3      # the answer
eyeron -p examples/backward.n3   # the answer with its proof
eyeron -c examples/backward.n3   # the proof, checked
```

Change both `3`s in the forward rule into `7`s and run again: 5 is not
greater than 7, the backward rule says no, and Eyeron derives nothing.

---

## Takeaway

A backward rule is a definition consulted only when asked, so it can cover
endlessly many cases; its answers are proved and checked like any other.
