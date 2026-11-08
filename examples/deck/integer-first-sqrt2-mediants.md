# Bracketing the square root of two with fractions

[integer-first-sqrt2-mediants.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/integer-first-sqrt2-mediants.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/integer-first-sqrt2-mediants.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/integer-first-sqrt2-mediants.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/integer-first-sqrt2-mediants.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=integer-first-sqrt2-mediants)

---

## The question

Integer numerator-denominator pairs describe lower and upper bounds. N3 rules
refine them using mediants and integer square comparisons, deriving a finite
sequence of rational brackets.

**Which rational brackets follow from successive mediant refinements?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:sqrt2 a :Target ;
    :computedBy :mediantRefiner .

# Refinement: replace one endpoint by the mediant according to the sign of
# p^2 - 2 q^2, checked with integer arithmetic only.
# If mediant^2 < 2 then it becomes the new lower bound.
{
    :mediantRefiner :bounds (?n ?pL ?qL ?pU ?qU) .
    :mediantRefiner :maxStep ?max .
    ?n math:lessThan ?max .

    (?n ?max) :successor ?n1 .
    (?pL ?pU) math:sum ?pM .
    (?qL ?qU) math:sum ?qM .
    (?pM ?pM) math:product ?pM2 .
    (?qM ?qM) math:product ?qM2 .
    (2 ?qM2) math:product ?twoQM2 .
    ?pM2 math:lessThan ?twoQM2 .
} => {
    :mediantRefiner :bounds (?n1 ?pM ?qM ?pU ?qU) .
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
:result :boundsQ (0 1 1 2 1) .
:result :boundsQ (1 1 1 3 2) .
:result :boundsQ (2 4 3 3 2) .
:result :boundsQ (3 7 5 3 2) .
:result :widthQ (7 1 348) .
:result :widthQ (8 1 1189) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :boundsQ (0 1 1 2 1) . }
  pe:rule
    {
        {
            :mediantRefiner :bounds (?n ?pL ?qL ?pU ?qU) .
            :sqrt2 :integerCertificate (?n ?lowerGap ?upperGap) .
            :sqrt2 :widthExact (?n ?widthNum ?widthDen) .
            :sqrt2 :fareyAdjacent (?n true) .
        } => {
            :result :boundsQ (?n ?pL ?qL ?pU ?qU) .
            :result :gapTo2 (?n ?lowerGap ?upperGap) .
            :result :widthQ (?n ?widthNum ?widthDen) .
            :result :fareyAdjacent (?n true) .
        } .
    };
  pe:binding
    [ pe:var "lowerGap"; pe:value 1 ],
    [ pe:var "n"; pe:value 0 ],
    [ pe:var "pL"; pe:value 1 ],
    [ pe:var "pU"; pe:value 2 ],
    [ pe:var "qL"; pe:value 1 ],
…
    { :mediantRefiner :bounds (0 1 1 2 1) . },
    { :sqrt2 :integerCertificate (0 1 2) . },
    { :sqrt2 :widthExact (0 1 1) . },
    { :sqrt2 :fareyAdjacent (0 true) . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 230 steps, 230 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 108; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 122; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 724; pe:failed 0 ].
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
eyeron examples/integer-first-sqrt2-mediants.n3
eyeron -p examples/integer-first-sqrt2-mediants.n3
eyeron -c examples/integer-first-sqrt2-mediants.n3
```

---

## Takeaway

Integer square comparisons can refine bounds without a floating-point square
root.
