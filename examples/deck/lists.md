# Appending lists and finding members

*Two small list questions, answered by a recursive rule and a built-in.*

[lists.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/lists.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/lists.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/lists.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/lists.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=lists)

---

## The question

Lists are everywhere: a shopping list, the steps of a recipe, the stops of a
train. Two of the simplest things to do with them are joining two lists end
to end, and asking what is in one.

**What do you get by joining the list (a) to the list (b), and which values
occur in the list (a b a)?**

---

## What we tell Eyeron

In N3 a list is written between round brackets: `(:a :b)` is a list of two
items and `()` is the empty list. Joining is defined by two backward rules,
written with `<=`: *the left side holds if the right side does*.

```n3
{
    (?xs ?ys) :append ?zs
} <= {
    ?xs list:firstRest (?x ?xrest) .
    (?xrest ?ys) :append ?zsrest .
    ?zs list:firstRest (?x ?zsrest) .
} .

{
    (() ?ys) :append ?ys
} <= true .
```

The first rule says: to append `ys` to a non-empty list `xs`, split `xs`
into its first item `x` and the rest, append `ys` to the rest, and put `x`
back in front. `list:firstRest` is a built-in that splits a list or builds
one, depending on which side is known. The second rule ends the recursion:
appending to the empty list gives the other list unchanged.

Two forward rules (`=>`) ask the questions:

```n3
{
    ((:a) (:b)) :append ?result
} => {
    :query :appendResult ?result
} .

{
    (:a :b :a) list:member ?x
} => {
    :query :member ?x
} .
```

`list:member` is a built-in that succeeds once for each value in a list.

---

## What Eyeron concludes

```n3
:query :appendResult (:a :b) .
:query :member :a .
:query :member :b .
```

The joined list is `(:a :b)`. The list `(:a :b :a)` holds `:a` twice, but
a conclusion is a statement, and the same statement is only stated once.

---

## The proof: one recursive step and a base case

The proof of the joined list goes through the first rule once and the second
rule once:

```n3
{ ((:a) (:b)) :append (:a :b) . }
  pe:rule 1;
  …
  pe:uses
    { (:a) list:firstRest (:a ()) . },
    { (() (:b)) :append (:b) . },
    { (:a :b) list:firstRest (:a (:b)) . }.

{ (:a) list:firstRest (:a ()) . }
  pe:builtin list:firstRest.

{ (() (:b)) :append (:b) . }
  pe:rule 2;
  pe:binding [ pe:var "ys"; pe:value (:b) ].
```

Read it as: `(:a)` splits into `:a` and `()`; `()` appended with `(:b)` is
`(:b)` by the base rule; and `(:a :b)` is `:a` in front of `(:b)`. Each
member answer is one rule step resting on one `list:member` step.

---

## Checked: what the report says

```n3
# checked: 9 steps, 9 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 4; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
```

- **C1 resolution**: the 5 rule steps are real instances of the rules they
  cite, with the recorded bindings.
- **C5 re-decision**: the checker recomputes the 4 built-in steps (two
  `list:firstRest`, two `list:member`) instead of believing them.
- **C2, C3, C4, C7**: every step is well-founded, justified, covers what it
  uses, and serves an answer.
- **C10 call fidelity**: each rule premise was checked in the form it was
  called.

Nothing needed to be trusted, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/lists.n3      # the answers
eyeron -p examples/lists.n3   # with the proof
eyeron -c examples/lists.n3   # the proof, checked
```

Change the question to `((:a :b) (:c :d)) :append ?result` and Eyeron
answers `:query :appendResult (:a :b :c :d) .`, now recursing twice before it
reaches the base case.

---

## Takeaway

Two short backward rules are enough to define appending for lists of any
length, and the proof shows each recursive step it took.
