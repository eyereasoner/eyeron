# Specializing a pricing calculation

[ershov-mixed-computation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/ershov-mixed-computation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/ershov-mixed-computation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/ershov-mixed-computation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/ershov-mixed-computation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=ershov-mixed-computation)

---

## The question

Known customer and pricing information is used before an order subtotal is
available. N3 rules construct a specialized quoted program and later apply it
to the remaining input.

**What can a pricing program compute before the subtotal is known?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Generic computation, represented as static parameters
:pricingProgram :discountRate "0.90"^^xsd:decimal ;
    :shippingFee "5.00"^^xsd:decimal .

# Phase 1: specialization
#
# Build a residual program for the VIP case by baking the static
# constants into a quoted rule.
{
    :pricingProgram :discountRate ?rate ;
        :shippingFee ?fee .
    :specialization :customerClass :VIP .
} => {
    :specialization :residualProgram {
        {
            ?order :subtotal ?subtotal .
            (?subtotal ?rate) math:product ?discounted .
            (?discounted ?fee) math:sum ?final .
        } => {
            ?order :finalPrice ?final .
        } .
    } .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:specialization :residualProgram {
    {
        ?order :subtotal ?subtotal .
        (?subtotal "0.90"^^xsd:decimal) math:product ?discounted .
        (?discounted "5.00"^^xsd:decimal) math:sum ?final .
    } => {
        ?order :finalPrice ?final .
    } .
} .
:futureOrder :computedByResidualProgram "95"^^xsd:decimal .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :pricingProgram :discountRate 0.90 . }
  pe:fact "ershov-mixed-computation.n3".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 8 steps, 7 verified, 1 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `impure built-in`.

---

## Try it

```sh
eyeron examples/ershov-mixed-computation.n3
eyeron -p examples/ershov-mixed-computation.n3
eyeron -c examples/ershov-mixed-computation.n3
```

---

## Takeaway

Partial evaluation captures known data in a residual program for the remaining
input.
