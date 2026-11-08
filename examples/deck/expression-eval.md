# Evaluating an expression tree

*A calculation stored as data, worked out by rules that call each other.*

[expression-eval.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/expression-eval.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/expression-eval.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/expression-eval.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/expression-eval.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=expression-eval)

---

## The question

A calculator turns `(2 * 3) + (10 - 4)` into a tree: the `+` at the top, a
`*` and a `-` below it, and four numbers at the leaves. Here that tree is
written down as plain statements.

**What is the value at the root, and can every step of the arithmetic be
shown?**

---

## What we tell Eyeron

Each number is a node with its value, and each operation is a node with an
operator and a left and right child:

```n3
:n2 :n 2 .
:n3 :n 3 .
…
:eMul a :Expr ;
    :op :mul ;
    :left :n2 ;
    :right :n3 .
…
:eAdd a :Expr ;
    :op :add ;
    :left :eMul ;
    :right :eSub .

:Root :expr :eAdd .
```

The value of a node is defined by *backward* rules, written with `<=`: the
conclusion comes first, and the conditions after it. Eyeron uses them only
when it needs a `:value`. A number node's value is its number; an addition
node's value is the sum of its children's values:

```n3
{
    ?N :value ?V .
} <= {
    ?N :n ?V .
} .

{
    ?E :value ?V .
} <= {
    ?E :op :add .
    ?E :left ?L .
    ?E :right ?R .
    ?L :value ?LV .
    ?R :value ?RV .
    (?LV ?RV) math:sum ?V .
} .
```

The rule asks for `:value` again on the children, so it calls itself down
the tree until it reaches the numbers. `math:sum` is a built-in: Eyeron
computes it rather than looking it up. Subtraction and multiplication work
the same way with `math:difference` and `math:product`.

Finally a forward rule (`=>`) asks for the root's value and records it:

```n3
{
    :Root :expr ?E .
    ?E :value ?V .
} => {
    :Root :result ?V .
} .
```

---

## What Eyeron concludes

```n3
:Root :result 12 .
```

2 × 3 is 6, 10 − 4 is 6, and 6 + 6 is 12. The intermediate values are not
printed: they were only worked out to answer the question.

---

## The proof, step by step

The proof follows the tree. The result comes from rule 5, using the root's
value, which comes from rule 2, the addition:

```n3
{ :eAdd :value 12 . }
  pe:rule 2;
  pe:binding
    [ pe:var "E"; pe:value :eAdd ],
    [ pe:var "L"; pe:value :eMul ],
    [ pe:var "LV"; pe:value 6 ],
    [ pe:var "R"; pe:value :eSub ],
    [ pe:var "RV"; pe:value 6 ],
    [ pe:var "V"; pe:value 12 ];
  pe:uses
    { :eAdd :op :add . },
    { :eAdd :left :eMul . },
    { :eAdd :right :eSub . },
    { :eMul :value 6 . },
    { :eSub :value 6 . },
    { (6 6) math:sum 12 . }.
```

Its two children each have a step of their own, down to the number nodes,
and every calculation is a step that names the built-in that decides it:

```n3
{ (6 6) math:sum 12 . }
  pe:builtin math:sum.
```

---

## Checked: what the report says

```n3
# checked: 25 steps, 25 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 22; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
```

- **C1 resolution**: the 8 rule steps and 14 fact steps are exactly what they
  cite.
- **C5 re-decision**: the checker did the 3 calculations again itself (the
  product, the difference and the sum) and got the same numbers.
- **C2**, **C3**, **C4** and **C7**: no step depends on itself, each is
  backed, everything used is accounted for, and nothing is padding.
- **C10 call fidelity**: the 8 rule conditions were checked as written.

All 25 steps were verified, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/expression-eval.n3
eyeron -p examples/expression-eval.n3
eyeron -c examples/expression-eval.n3
```

Change `:n10 :n 10 .` into `:n10 :n 100 .` and run again: the result becomes
102, since (2 × 3) + (100 − 4) = 102.

---

## Takeaway

Backward rules compute only what a question needs, and the proof records the
calculation step by step, so that a checker can redo every sum.
