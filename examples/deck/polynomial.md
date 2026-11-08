# Finding roots of low-degree polynomials

[polynomial.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/polynomial.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/polynomial.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/polynomial.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/polynomial.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=polynomial)

---

## The question

Coefficient lists describe polynomials of degree one through four. Backward N3
arithmetic rules work with real-imaginary pairs to derive the sample roots and
supporting calculations.

**Which roots follow from the sample coefficient lists?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Roots of unity
:SquareUnity :vals ((1 0) (-1 0)) .

# Polynomial roots: return ALL roots as a list (degree 1..4)
# Degree 1: A x + B = 0  => x = -B/A
{
    (?A ?B) :roots (?Z) .
} <= {
    (?B ?A) complex:quotient ?BA .
    ?BA complex:negation ?Z .
} .

{
    ?Poly :roots ?Roots .
    ?Roots :polynome ?Coeffs .
} => {
    ?Poly :coeffsFromRoots ?Coeffs .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:poly1 :hasRoot ("4.000000007450581"^^xsd:decimal "0"^^xsd:decimal) .
:poly1 :hasRoot ("2.9999999925494194"^^xsd:decimal "0"^^xsd:decimal) .
:poly2 :hasRoot ("-3.1086244689504383e-15"^^xsd:double "1.0000000000000064"^^xsd:decimal) .
:poly2 :hasRoot ("1"^^xsd:decimal "1.0000000000000049"^^xsd:decimal) .
:poly1 :hasRoot ("1.9999999925494194"^^xsd:decimal "0"^^xsd:decimal) .
:poly1 :hasRoot ("1.0000000074505808"^^xsd:decimal "0"^^xsd:decimal) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :poly1 :hasRoot (4.000000007450581 "0"^^xsd:decimal) . }
  pe:rule 41;
  pe:binding
    [ pe:var "Coeffs"; pe:value ((1 0) (-10 0) (35 0) (-50 0) (24 0)) ],
    [ pe:var "L"; pe:value ((4.000000007450581 "0"^^xsd:decimal) (2.9999999925494194 "0"^^xsd:decimal) (1.9999999925494194 "0"^^xsd:decimal) (1.0000000074505808 "0"^^xsd:decimal)) ],
    [ pe:var "Poly"; pe:value :poly1 ],
    [ pe:var "Z"; pe:value (4.000000007450581 "0"^^xsd:decimal) ];
  pe:uses
    { :poly1 :coeffs ((1 0) (-10 0) (35 0) (-50 0) (24 0)) . },
    { ((1 0) (-10 0) (35 0) (-50 0) (24 0)) :roots ((4.000000007450581 "0"^^xsd:decimal) (2.9999999925494194 "0"^^xsd:decimal) (1.9999999925494194 "0"^^xsd:decimal) (1.0000000074505808 "0"^^xsd:decimal)) . },
    { ((4.000000007450581 "0"^^xsd:decimal) (2.9999999925494194 "0"^^xsd:decimal) (1.9999999925494194 "0"^^xsd:decimal) (1.0000000074505808 "0"^^xsd:decimal)) list:member (4.000000007450581 "0"^^xsd:decimal) . }.
```

`pe:rule 41` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 1177 steps, 1177 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 310; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 867; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 307; pe:failed 0 ].
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
eyeron examples/polynomial.n3
eyeron -p examples/polynomial.n3
eyeron -c examples/polynomial.n3
```

---

## Takeaway

Degree-specific formulas work over complex pairs and leave an explicit
arithmetic derivation.
