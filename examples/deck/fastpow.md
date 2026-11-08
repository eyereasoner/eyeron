# Fast and slow powers

*Two ways to raise a number to a power, and towers of powers on top.*

[fastpow.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/fastpow.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/fastpow.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/fastpow.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/fastpow.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=fastpow)

---

## The question

2¹⁰ is 1024. You can get it by multiplying ten 2s together, or by asking for
the power directly. 2¹⁰⁰⁰⁰ has over three thousand digits, and a *power
tower* 2^2^2^2^2 has nearly twenty thousand.

**Can rules define powers, both ways, agree with each other, and still give
short answers for enormous numbers?**

---

## What we tell Eyeron

All the relations are *backward* rules, written with `<=`: Eyeron uses them
when a question needs them. The fast power hands the work to the built-in
`math:exponentiation`:

```n3
{
    (?B ?E) :pow ?R .
} <= {
    (?B ?E) math:exponentiation ?R .
} .
```

The slow power multiplies: anything to the power 0 is 1, and otherwise
B^E = B^(E−1) × B, which the rule finds by calling itself:

```n3
{
    (?B ?E) :powSlow ?R .
} <= {
    ?E math:greaterThan 0 .
    (?E 1) math:difference ?E1 .
    (?B ?E1) :powSlow ?Prev .
    (?Prev ?B) math:product ?R .
} .
```

A tower of height H is B raised to a tower of height H − 1, defined the same
way. Two helpers keep only the last six digits of a result, using
`math:remainder`:

```n3
{
    (?B ?E) :powMod1e6 ?M .
} <= {
    (?B ?E) :pow ?R .
    (?R 1000000) math:remainder ?M .
} .
```

The test rule asks six questions and gathers the answers into one quoted
graph, in braces:

```n3
(2 10) :pow ?P10 .
(2 10) :powSlow ?S10 .
…
(2 10000) :powMod1e6 ?M1 .
(3 10000) :powMod1e6 ?M2 .
…
(2 4) :tower ?T4 .
(2 5) :towerMod1e6 ?TM5 .
```

---

## What Eyeron concludes

```n3
:test :is {
    (2 10) :pow 1024 .
    (2 10) :powSlow 1024 .
    (2 10000) :powMod1e6 709376 .
    (3 10000) :powMod1e6 200001 .
    (2 4) :tower 65536 .
    (2 5) :towerMod1e6 156736 .
} .
```

The fast and slow powers agree on 1024. 2¹⁰⁰⁰⁰ ends in 709376 and 3¹⁰⁰⁰⁰ in
200001. The tower 2^2^2^2 is 65536, and 2^65536 ends in 156736. Integers are
exact, so these huge numbers are computed in full before their last digits
are taken.

---

## The proof, step by step

```n3
{ (2 4) :tower 65536 . }
  pe:rule 5;
  pe:binding
    [ pe:var "B"; pe:value 2 ],
    [ pe:var "H"; pe:value 4 ],
    [ pe:var "H1"; pe:value 3 ],
    [ pe:var "Prev"; pe:value 16 ],
    [ pe:var "R"; pe:value 65536 ];
  pe:uses
    { 4 math:greaterThan 0 . },
    { (4 1) math:difference 3 . },
    { (2 3) :tower 16 . },
    { (2 16) math:exponentiation 65536 . }.
```

A tower of height 4 is 2 to the tower of height 3, which is 16. The proof
has 66 steps: 24 rule applications and 42 calculations.

---

## Checked: what the report says

```n3
# checked: 66 steps, 66 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 42; pe:failed 0 ];
```

- **C5 re-decision**: the checker redid all 42 calculations itself,
  including raising 2 to the power 65536.
- **C1 resolution**: the 24 rule steps match their rules.
- **C2 well-foundedness**: the recursions all reach their base case.
- **C3**, **C4**, **C7** and **C10**: each step is backed, everything used is
  accounted for and relevant, and conditions were checked as written.

The verdict is **checked**.

---

## Try it

```sh
eyeron examples/fastpow.n3
eyeron -c examples/fastpow.n3
```

Replace each `(2 10)` with `(3 7)`, in the test rule's conditions and in its
conclusion, and run again: both powers give 2187.

---

## Takeaway

A relation defined two ways is a built-in test of itself, and exact integers
let rules work with numbers far too large to print.
