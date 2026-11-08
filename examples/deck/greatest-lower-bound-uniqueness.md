# Comparing greatest lower bounds

*A textbook theorem of order theory, replayed as rules on a tiny example.*

[greatest-lower-bound-uniqueness.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/greatest-lower-bound-uniqueness.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/greatest-lower-bound-uniqueness.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/greatest-lower-bound-uniqueness.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/greatest-lower-bound-uniqueness.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=greatest-lower-bound-uniqueness)

---

## The question

In a *partial order* (think "divides" on numbers, or "is a subset of" on
sets) a *greatest lower bound* of a and b is the largest thing below both.
A classic theorem says there can be only one: if g1 and g2 both claim the
title, they are the same element.

**Given two differently named candidates, can Eyeron show they must
coincide, and show how?**

---

## What we tell Eyeron

The order axioms, as rules. Reflexivity and transitivity look like this;
antisymmetry concludes sameness:

```n3
{
    ?x :leq ?y .
    ?y :leq ?x .
} => {
    (?x ?y) :sameTerm true .
} .
```

What it means to be a greatest lower bound: you are below both, and every
lower bound is below you.

```n3
{
    ?m :glbOf (?a ?b) .
} => {
    ?m :lowerBoundOf (?a ?b) .
    ?m :leq ?a .
    ?m :leq ?b .
} .

{
    ?m :glbOf (?a ?b) .
    ?l :lowerBoundOf (?a ?b) .
} => {
    ?l :leq ?m .
} .
```

The theorem packages the result, and the data names two candidates:

```n3
:g1 :glbOf (:a :b) .
:g2 :glbOf (:a :b) .
```

The question is a `log:query`: *show the cases where two greatest lower
bounds of the same pair coincide and have different names.*
`log:notEqualTo` is a built-in test that the two names differ.

```n3
{
    (?a ?b ?m ?n) :sameGlb true .
    ?m log:notEqualTo ?n .
} log:query {
    :result :sameGreatestLowerBound (?a ?b ?m ?n) .
} .
```

Note what this is and is not: g1 and g2 are *declared* greatest lower bounds.
Eyeron does not search the order for them; it shows that two declared ones
are forced to be equal.

---

## What Eyeron concludes

```n3
:result :sameGreatestLowerBound (:a :b :g1 :g2) .
:result :sameGreatestLowerBound (:a :b :g2 :g1) .
```

The same fact in both orders, since the query asks for every pair.

---

## The proof, step by step

The proof follows the textbook argument. Sameness comes from antisymmetry:

```n3
{ (:g1 :g2) :sameTerm true . }
  pe:rule 3;
…
  pe:uses
    { :g1 :leq :g2 . },
    { :g2 :leq :g1 . }.
```

and each direction comes from greatestness: g1 is a lower bound, g2 is the
greatest one, so g1 is below g2.

```n3
{ :g1 :leq :g2 . }
  pe:rule 6;
…
  pe:uses
    { :g2 :glbOf (:a :b) . },
    { :g1 :lowerBoundOf (:a :b) . }.
```

At the bottom are the two declarations, cited as `pe:fact`, and two calls
of `log:notEqualTo`, cited as `pe:builtin`. 14 steps in all.

---

## Checked: what the report says

```n3
# checked: 14 steps, 14 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 12; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
```

- **C1 resolution**: the 10 rule steps and 2 facts match the program.
- **C5 re-decision**: the checker recomputed both `log:notEqualTo` tests.
- **C2–C4, C7, C10**: no circularity, full coverage, no padding, and the
  query was answered as asked.

The verdict is **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/greatest-lower-bound-uniqueness.n3
eyeron -p examples/greatest-lower-bound-uniqueness.n3
```

Add a third candidate, `:g3 :glbOf (:a :b) .`, and run again: you get six
answers, one for every ordered pair of different candidates.

---

## Takeaway

A short mathematical proof maps onto a short machine proof: each line of the
argument is one rule step, and the checker confirms none was skipped.
