# Expanding a quartic from its complex roots

[vieta-expand.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/vieta-expand.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/vieta-expand.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/vieta-expand.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/vieta-expand.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=vieta-expand)

---

## The question

Four complex roots are represented as real-imaginary pairs. Backward N3
arithmetic rules apply Vieta's relations to derive the coefficients of their
monic quartic polynomial.

**Which monic quartic coefficients follow from the four complex roots?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Example data (two polynomials)
:poly1 :roots ((1 0) (2 0) (3 0) (4 0)) .

# Verification: computed coeffs match the given coeffs
# (unification does the equality check)
{
    ?P :coeffsGiven ?C .
    ?P :coeffsComputed ?C .
} => {
    ?P :verified true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:poly1 :verified true .
:poly2 :verified true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :poly1 :verified true . }
  pe:rule 5;
  pe:binding
    [ pe:var "C"; pe:value ((1 0) (-10 0) (35 0) (-50 0) (24 0)) ],
    [ pe:var "P"; pe:value :poly1 ];
  pe:uses
    { :poly1 :coeffsGiven ((1 0) (-10 0) (35 0) (-50 0) (24 0)) . },
    { :poly1 :coeffsComputed ((1 0) (-10 0) (35 0) (-50 0) (24 0)) . }.
```

`pe:rule 5` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 153 steps, 153 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 53; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 100; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 49; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/vieta-expand.n3
eyeron -p examples/vieta-expand.n3
eyeron -c examples/vieta-expand.n3
```

---

## Takeaway

Vieta's relations turn a list of roots into explicit coefficient calculations.
