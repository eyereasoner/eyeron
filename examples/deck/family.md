# Family descent

*From who is whose parent to who descends from whom, however far back.*

[family.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/family.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/family.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/family.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/family.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=family)

---

## The question

Three facts describe a small family: A is X's father, B is X's mother, and C
is A's mother. So C is X's grandmother, though nobody said so.

**From parent facts alone, can Eyeron work out every line of descent?**

---

## What we tell Eyeron

```n3
:A :fatherOf :X .
:B :motherOf :X .
:C :motherOf :A .
```

Two rules turn fathers and mothers into children; here is the first:

```n3
{
    ?y :fatherOf ?x
} => {
    ?x :childOf ?y
} .
```

Then two rules define descent. A child descends from its parent; and if `x`
is a child of `z`, and `z` descends from `y`, then `x` descends from `y` too:

```n3
{
    ?x :childOf ?y
} => {
    ?x :descendedFrom ?y
} .

{
    ?x :childOf ?z .
    ?z :descendedFrom ?y
} => {
    ?x :descendedFrom ?y
} .
```

The last rule uses its own conclusions as conditions. That is what lets
descent reach back any number of generations: Eyeron keeps applying the rules
until nothing new follows.

---

## What Eyeron concludes

```n3
:X :childOf :A .
:X :childOf :B .
:A :childOf :C .
:X :descendedFrom :A .
:X :descendedFrom :B .
:A :descendedFrom :C .
:X :descendedFrom :C .
```

The last line is the one nobody stated: X descends from its grandmother C.

---

## The proof, step by step

```n3
{ :X :descendedFrom :C . }
  pe:rule 4;
  pe:binding
    [ pe:var "x"; pe:value :X ],
    [ pe:var "y"; pe:value :C ],
    [ pe:var "z"; pe:value :A ];
  pe:uses
    { :X :childOf :A . },
    { :A :descendedFrom :C . }.
```

X descends from C by rule 4, through A: X is a child of A, and A descends
from C. Each of those has its own step, going back to the three facts of the
file. The proof has 10 steps: 3 facts and 7 rule applications.

---

## Checked: what the report says

```n3
# checked: 10 steps, 10 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 10; pe:failed 0 ];
pe:condition [ pe:id "C2"; pe:name "well-foundedness"; pe:checked 10; pe:failed 0 ];
```

- **C1 resolution**: every step is exactly what its rule or fact gives.
- **C2 well-foundedness**: although rule 4 is recursive, no step depends on
  itself: the chain always bottoms out in facts.
- **C3**, **C4**, **C7** and **C10**: each step is backed, everything used is
  accounted for, nothing is padding, and the conditions were checked as
  written.

All 10 steps were verified, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/family.n3
eyeron -p examples/family.n3
eyeron -c examples/family.n3
```

Add `:D :fatherOf :C .` and run again: C, A and X all descend from D now, a
generation further back.

---

## Takeaway

A rule that builds on its own conclusions turns a handful of parent facts
into the whole family line, and each link of it can be checked.
