# Comparing two matrix multiplication orders

*In quantum mechanics, A times B need not equal B times A.*

[matrix-mechanics.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/matrix-mechanics.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/matrix-mechanics.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/matrix-mechanics.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/matrix-mechanics.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=matrix-mechanics)

---

## The question

In Heisenberg's matrix mechanics, physical quantities are matrices, and the
order of multiplication matters. Take two 2×2 matrices:

- **H** = [[1 0] [0 2]], a toy energy with levels 1 and 2;
- **X** = [[0 1] [1 0]], which swaps the two states.

**Is H·X the same as X·H? If not, how do they differ?**

---

## What we tell Eyeron

```n3
:H :a11 1 ;
    :a12 0 ;
    :a21 0 ;
    :a22 2 .
```

A matrix is written entry by entry: `:a12` is row 1, column 2. X is given the
same way.

Each calculation is a rule with arithmetic built-ins. The trace (sum of the
diagonal) is the smallest:

```n3
# trace(H) = H11 + H22
{
    :H :a11 ?h11 ;
        :a22 ?h22 .
    (?h11 ?h22) math:sum ?tr .
} => {
    :H :trace ?tr .
} .
```

The products H·X, X·H and X·X are spelled out with `math:product` and
`math:sum`, four entries each. The commutator C = H·X − X·H subtracts them:

```n3
# C = [H,X] = HX - XH
…
    (?hx11 ?xh11) math:difference ?c11 .
    (?hx12 ?xh12) math:difference ?c12 .
```

Rules that conclude `false` act as safety checks: if the trace is not 3, the
determinant not 2, X·X not the identity, or C all zeros, the run stops with
an error.

```n3
{
    :H :trace ?tr .
    ?tr math:notEqualTo 3 .
} => false .
```

Finally, `log:query` says which results to print: the trace, the determinant
and the entries of C.

---

## What Eyeron concludes

```n3
:H :trace 3 .
:H :det 2 .
:C :a11 0 .
:C :a12 -1 .
:C :a21 1 .
:C :a22 0 .
:C :nonzero "yes" .
```

C = [[0 −1] [1 0]] is not zero, so H·X and X·H differ: H·X = [[0 1] [2 0]]
while X·H = [[0 2] [1 0]]. None of the safety checks fired. The other derived
facts, such as the products, are computed but not printed, because the query
does not ask for them.

---

## The proof, step by step

The proof has 40 steps: 15 rule steps, 17 calculations and 8 facts. The entry
`:C :a12 -1` comes from rule 6:

```n3
  pe:uses
    { :HX :a11 0 . },
    { :HX :a12 1 . },
    { :HX :a21 2 . },
    { :HX :a22 0 . },
    { :XH :a11 0 . },
    { :XH :a12 2 . },
    { :XH :a21 1 . },
    { :XH :a22 0 . },
    { (0 0) math:difference 0 . },
    { (1 2) math:difference -1 . },
    { (2 1) math:difference 1 . },
    { (0 0) math:difference 0 . }.
```

The entries of H·X and X·H in turn come from rules 3 and 4, and those from
the eight given entries of H and X.

---

## Checked: what the report says

```n3
# checked: 40 steps, 40 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 17; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 7; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 242; pe:failed 0 ].
```

- **C5 re-decision**: all 17 products, sums and differences are recomputed.
- **C6 boundary consistency**: the checker tries each of the 7 safety rules
  against the proof's evidence; none of their conditions is met.
- **C10 call fidelity**: built-ins were checked as the rules called them, and
  the answers are the query's.
- **C1, C2, C3, C4, C7**: each rule step matches its rule, nothing is
  circular, everything is covered and relevant.

All 40 steps are verified; nothing is taken on trust.

---

## Try it

```sh
eyeron examples/matrix-mechanics.n3
eyeron -c examples/matrix-mechanics.n3
```

Change H's last entry from `:a22 2 .` to `:a22 3 .`. The trace becomes 4, the
first safety rule fires, and Eyeron reports `# Inference fuse triggered.` with
the matched instance, exiting with status 65 instead of printing results.

---

## Takeaway

Plain rules and arithmetic reproduce the core fact of matrix mechanics, that
order matters, and every number in that result can be recomputed by a checker.
