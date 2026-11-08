# Bounding a quantum T gate's coefficients

[tgate-approx.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/tgate-approx.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/tgate-approx.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/tgate-approx.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/tgate-approx.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=tgate-approx)

---

## The question

The T gate's phase uses coefficients involving the square root of two. N3
rules refine integer-based bounds and derive finite interval coefficients and
checks for the modeled gate.

**Which finite coefficient intervals describe the modeled T gate?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:sqrt2Proc a :DyadicBisection ;
    :maxN 20 .

# midpoint = (l+u)/2^(n+1), compare midpoint^2 < 2 using integers:
# midpoint^2 < 2  <=>  (l+u)^2 < 2^(2n+3)
#
# If true -> new [mid, U]  => (n+1, midNum, 2u)
# Else    -> new [L, mid]  => (n+1, 2l, midNum)
# Case A: midpoint^2 < 2
{
    :sqrt2Proc :state (?n ?l ?u) .
    :sqrt2Proc :maxN ?maxN .
    ?n math:lessThan ?maxN .

    (?n 1) math:sum ?n1 .
    (?l ?u) math:sum ?midNum .
    (?midNum ?midNum) math:product ?midSq .

    (?n 2) math:product ?twoN .
    (?twoN 3) math:sum ?exp .
    # exp = 2n + 3
    (2 ?exp) math:exponentiation ?pow .
…
    (2 ?u) math:product ?uScaled .
} => {
    :sqrt2Proc :state (?n1 ?midNum ?uScaled) .
} .

# 5) Midpoint approximation + certified error bounds for the phase
#
# Let s ∈ [sL,sU], choose m = (sL+sU)/2 and w~ = m + i m.
# Componentwise: |Re(w)-m| <= (sU-sL)/2, same for Im.
# Hence: |w - w~| <= |Re-m| + |Im-m| <= (sU-sL).  (L1 bound)
#
# For the diagonal T gate, operator norm distance to the ideal gate is |w - w~|.
{
    :phasePiOver4 :sBounds (?n ?sL ?sU) .

    (?sU ?sL) math:difference ?sW .
    (?sW 2) math:quotient ?compErr .

…

    :phasePiOver4 :absErrBoundL1 (?n ?sW) .
    :TGate :opNormErrBoundMidpoint (?n ?sW) .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called. The ellipsis omits part of the source; the
linked file contains the full program.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:result :gateOpNormErrBound (0 "0.5"^^xsd:decimal) .
:result :gateOpNormErrBound (1 "0.33333333333333337"^^xsd:decimal) .
:result :gateOpNormErrBound (10 "0.00048804853032569095"^^xsd:decimal) .
:result :gateOpNormErrBound (11 "0.0002441084985992381"^^xsd:decimal) .
:result :TEntry (9 1 0 0.0 0.0 0.0 0.0) .
:result :TEntry (9 1 1 "0.7062068965517241"^^xsd:decimal "0.7071823204419889"^^xsd:decimal "0.7062068965517241"^^xsd:decimal "0.7071823204419889"^^xsd:decimal) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :n 0 . }
  pe:rule
    {
        {
            :sqrt2Proc :dyadic (?n ?l ?u ?denom) .
            :sqrt2Proc :bounds (?n ?L ?U) .
            :phasePiOver4 :sBounds (?n ?sL ?sU) .
            :phasePiOver4 :sWidth (?n ?sW) .
            :phasePiOver4 :componentErrBound (?n ?cE) .
            :phasePiOver4 :phaseMidpoint (?n ?m) .
            :phasePiOver4 :modSqBounds (?n ?mL ?mU) .
            :phasePiOver4 :modSqWidth (?n ?mW) .
            :TGate :opNormErrBoundMidpoint (?n ?opE) .
        } => {
            :result :n ?n .
            :result :sqrt2Dyadic (?n ?l ?u ?denom) .
            :result :sqrt2Bounds (?n ?L ?U) .
            :result :sBounds (?n ?sL ?sU) .
            :result :sWidth (?n ?sW) .
            :result :phaseMid (?n ?m ?m) .
            :result :phaseCompErrBound (?n ?cE) .
…
    { :phasePiOver4 :phaseMidpoint (0 0.75) . },
    { :phasePiOver4 :modSqBounds (0 0.5 2) . },
    { :phasePiOver4 :modSqWidth (0 1.5) . },
    { :TGate :opNormErrBoundMidpoint (0 0.5) . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 1172 steps, 1172 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 652; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 520; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5091; pe:failed 0 ].
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
eyeron examples/tgate-approx.n3
eyeron -p examples/tgate-approx.n3
eyeron -c examples/tgate-approx.n3
```

---

## Takeaway

Integer-based refinement makes the precision of the coefficient bounds
explicit.
