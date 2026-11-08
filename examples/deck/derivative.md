# Differentiating symbolic expressions

*School calculus as a handful of rules: the derivative of x times x, worked out symbolically.*

[derivative.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/derivative.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/derivative.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/derivative.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/derivative.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=derivative)

---

## The question

In school you learn that the derivative of a constant is 0, of x is 1, and
that sums and products have their own rules. Those rules work on the *shape*
of a formula, not on numbers, so a reasoner that matches shapes can apply
them.

**What is the derivative of x · x with respect to x, worked out rule by
rule?**

---

## What we tell Eyeron

A formula is written as a nested list: `(:var :x)` is the variable x,
`(:const 3)` the number 3, and `(:mul (:var :x) (:var :x))` is x · x.
The statement `(F X) :derivative D` says *"the derivative of F with respect
to X is D"*.

```n3
{
    ((:const ?n) ?x) :derivative (:const 0)
} <= true .
…
{
    ((:var ?x) ?x) :derivative (:const 1)
} <= true .
…
{
    ((:var ?y) ?x) :derivative (:const 0)
} <= {
    ?y log:notEqualTo ?x
} .
```

These are *backward* rules, written `{ conclusion } <= { conditions }`.
Eyeron uses them on demand: when it needs a derivative, it looks for a rule
whose conclusion has the right shape. `<= true` means the conclusion holds
with no conditions. A variable other than x counts as a constant, which
`log:notEqualTo` (a built-in test) checks.

The product rule says that the derivative of u · v is du · v + u · dv:

```n3
{
    ((:mul ?u ?v) ?x) :derivative (:add (:mul ?du ?v) (:mul ?u ?dv))
} <= {
    (?u ?x) :derivative ?du .
    (?v ?x) :derivative ?dv .
} .
```

The rule calls itself on the parts u and v, so it works for formulas of any
depth. A sum rule of the same form handles `:add`. Finally, one forward rule
(`=>`) asks the question and records the answer:

```n3
{
    ((:mul (:var :x) (:var :x)) :x) :derivative ?d
} => {
    :query :derivative ?d
} .
```

---

## What Eyeron concludes

```n3
:query :derivative (:add (:mul (:const 1) (:var :x)) (:mul (:var :x) (:const 1))) .
```

Read back as ordinary maths: 1 · x + x · 1. That is 2x, as expected, but
the rules only differentiate; they do not simplify. Simplification would
need more rules.

---

## The proof, step by step

The proof has three steps. The answer comes from rule 6, the question rule;
it uses the derivative of x · x, which comes from rule 5, the product rule:

```n3
{ ((:mul (:var :x) (:var :x)) :x) :derivative (:add (:mul (:const 1) (:var :x)) (:mul (:var :x) (:const 1))) . }
  pe:rule 5;
  pe:binding
    [ pe:var "du"; pe:value (:const 1) ],
    [ pe:var "dv"; pe:value (:const 1) ],
    [ pe:var "u"; pe:value (:var :x) ],
    [ pe:var "v"; pe:value (:var :x) ],
    [ pe:var "x"; pe:value :x ];
  pe:uses
    { ((:var :x) :x) :derivative (:const 1) . },
    { ((:var :x) :x) :derivative (:const 1) . }.

{ ((:var :x) :x) :derivative (:const 1) . }
  pe:rule 2;
  pe:binding [ pe:var "x"; pe:value :x ].
```

Both factors are x, so the product rule uses the same fact twice: *the
derivative of x is 1*, from rule 2, which needs nothing further. Rules are
numbered in the order they appear in the program, backward and forward
alike.

---

## Checked: what the report says

```n3
# checked: 3 steps, 3 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C2"; pe:name "well-foundedness"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ].
```

- **C1 resolution**: each step really is its rule with the recorded values
  filled in.
- **C2 well-foundedness**: no step depends on itself.
- **C3 justification** and **C4 coverage**: every premise a step uses is
  itself proved, and the steps cover the answer.
- **C7 relevance**: every step serves the answer.
- **C10 call fidelity**: the backward rules were called with the shapes the
  steps claim.

The test `log:notEqualTo` was never needed (x · x has no other variable), so
there was nothing for C5 to recompute. The verdict is **checked**, with
nothing taken on trust.

---

## Try it

```sh
eyeron examples/derivative.n3      # the answer
eyeron -p examples/derivative.n3   # the answer with its proof
eyeron -c examples/derivative.n3   # the proof, checked
```

Change the question to `((:add (:var :x) (:const 3)) :x)`: the sum rule now
answers with `(:add (:const 1) (:const 0))`.

---

## Takeaway

Calculus rules are rules about the shape of formulas, and a few backward
rules apply them to any expression, with a checked record of every rule used.
