# Bounding a Hadamard gate's coefficients

*Pinning down 1/√2 between two fractions, twenty times tighter.*

[hadamard-approx.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/hadamard-approx.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/hadamard-approx.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/hadamard-approx.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/hadamard-approx.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=hadamard-approx)

---

## The question

The Hadamard gate is one of the basic operations of a quantum computer. As a
matrix it is

    H = 1/√2 · [ 1   1 ]
               [ 1  -1 ]

But √2 has no exact decimal or fractional value. A program that wants to be
honest about it can work with *intervals*: two numbers that certainly
enclose the true value.

**How tightly can rules enclose √2, and the gate's entries, and does each
row of the gate still have length one inside those bounds?**

---

## What we tell Eyeron

The process starts with √2 between 1 and 2, written as `(n l u)`: the
interval from l/2ⁿ to u/2ⁿ.

```n3
:sqrt2Proc :state (0 1 2) .
```

Each step halves the interval. Whether the midpoint is below √2 is decided
with whole numbers only: (l+u)² < 2^(2n+3) says the same as
"midpoint² < 2", without ever dividing.

```n3
{
    :sqrt2Proc :state (?n ?l ?u) .
    :sqrt2Proc :maxN ?maxN .
    ?n math:lessThan ?maxN .
…
    ?midSq math:lessThan ?pow .
    (2 ?u) math:product ?uScaled .
} => {
    :sqrt2Proc :state (?n1 ?midNum ?uScaled) .
} .
```

`math:sum`, `math:product`, `math:exponentiation` and the comparisons are
built-ins: Eyeron computes them. A twin rule handles the other half, and
`:maxN 20` stops after twenty steps.

Further rules turn each interval into decimal bounds for √2 and for 1/√2,
build the four gate entries (the bottom-right one negated), and compute
midpoints and error bounds. The length check stays in integers:

```n3
    ?normNum math:notGreaterThan ?u2 .
    ?normNum math:notLessThan ?l2 .
```

that is, l² ≤ 2·4ⁿ ≤ u². A row's squared length is 2s², with s the entry
1/√2; the test says that for s within its bounds, 2s² can be exactly 1.

---

## What Eyeron concludes

Every step from 0 to 20 gets a full set of results. After three steps:

```n3
:result :sqrt2Dyadic (3 11 12 8) .
:result :sqrt2Bounds (3 "1.375"^^xsd:decimal "1.5"^^xsd:decimal) .
```

After twenty, √2 lies between 1482910/1048576 and 1482911/1048576:

```n3
:result :sqrt2Dyadic (20 1482910 1482911 1048576) .
:result :invSqrt2Bounds (20 "0.7071064952650563"^^xsd:decimal "0.7071069721021505"^^xsd:decimal) .
:result :HEntry (20 1 1 "-0.7071069721021505"^^xsd:decimal "-0.7071064952650563"^^xsd:decimal 0 0) .
:result :rowNormSqBounds (20 "0.9999991912920624"^^xsd:decimal "1.0000005399909428"^^xsd:decimal) .
:result :rowNormSqContains1 (20 true) .
:result :midpointRowsOrthogonal (20 true) .
```

An `:HEntry` lists step, row, column, then the lower and upper bounds of the
real part and of the imaginary part (zero here).

Two honest remarks. The bisection and the length check use exact integers;
the decimal bounds come from ordinary division and are readable
approximations of those exact fractions. And `:midpointRowsOrthogonal` is
true by construction: m·m + m·(−m) is zero for any m.

---

## The proof, step by step

The proof is large: 1573 steps, over 31 000 lines. A typical bisection
step, from `(2 5 6)` (√2 between 5/4 and 6/4) to `(3 11 12)`:

```n3
{ :sqrt2Proc :state (3 11 12) . }
  pe:rule 1;
…
  pe:uses
    { :sqrt2Proc :state (2 5 6) . },
    { :sqrt2Proc :maxN 20 . },
    { 2 math:lessThan 20 . },
    { (2 1) math:sum 3 . },
    { (5 6) math:sum 11 . },
    { (11 11) math:product 121 . },
    { (2 2) math:product 4 . },
    { (4 3) math:sum 7 . },
    { (2 7) math:exponentiation 128 . },
    { 121 math:lessThan 128 . },
    { (2 6) math:product 12 . }.
```

121 < 128, so the midpoint 11/8 is below √2 and becomes the new lower end.
The length check at step 20 compares big integers:

```n3
    { 2199023255552 math:notGreaterThan 2199025033921 . },
    { 2199023255552 math:notLessThan 2199022068100 . },
```

---

## Checked: what the report says

```n3
# checked: 1573 steps, 1573 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 925; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 648; pe:failed 0 ];
```

- **C1 resolution**: 923 rule steps and the 2 facts they rest on match the
  program.
- **C5 re-decision**: all 648 arithmetic results were recomputed by the
  checker, every sum, product, power, quotient and comparison.
- **C2–C4, C7, C10**: no circular steps, every premise covered, nothing
  irrelevant, and every query answered as asked.

Nothing is trusted: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/hadamard-approx.n3
eyeron -c examples/hadamard-approx.n3 | head -1
```

Change `:maxN 20` to `:maxN 5` for a short run that is easy to read.

---

## Takeaway

Irrational numbers can be handled honestly with whole-number interval
arithmetic, and every one of the 648 calculations behind the bounds is
recomputed when the proof is checked.
