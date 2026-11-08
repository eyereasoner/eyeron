# Deciding drought-relief eligibility

[agri-drought-relief.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/agri-drought-relief.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/agri-drought-relief.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/agri-drought-relief.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/agri-drought-relief.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=agri-drought-relief)

---

## The question

A farm applies for drought relief. N3 rules connect the application facts to
eligibility and payment conclusions, keeping the policy conditions and their
consequences explicit. Eyeron finds the application eligible and approves it,
creating a new payment for it. The example shows math built-ins as policy
thresholds and a blank node in a rule's conclusion, which stands for a new
individual: the payment.

The file has four parts: a vocabulary, SHACL shapes describing complete
applications, the policy rules, and the application data. The shapes are kept
as plain data: Eyeron does not validate against them.

**Does this farm qualify, and what payment follows from approval?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
ex:Farm a rdfs:Class ;
    rdfs:label "Farm" .

# R1: Eligibility — area ≥ 5, rainfallLast30d < 20, yield drop ≥ 30
# drop = baselineYield - currentYield
{
    ?app ex:appliesFor ex:DroughtReliefGrant .
    ?app ex:hasApplicant ?farm .
    ?farm ex:totalArea ?area .
    ?farm ex:rainfallLast30d ?rain .
    ?farm ex:baselineYield ?by .
    ?farm ex:currentYield ?cy .
    (?by ?cy) math:difference ?drop .
    "5"^^xsd:integer math:notGreaterThan ?area .
    ?rain math:lessThan "20"^^xsd:integer .
    ?drop math:notLessThan "30"^^xsd:integer .
} => {
    ?app ex:eligible true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
ex:APP-DR-01 ex:eligible true .
ex:APP-DR-01 ex:status ex:Approved .
_:pay_fe97679132096585 a ex:ReliefPayment .
ex:APP-DR-01 ex:issuedPayment _:pay_fe97679132096585 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ex:APP-DR-01 ex:eligible true . }
  pe:rule 1;
  pe:binding
    [ pe:var "app"; pe:value ex:APP-DR-01 ],
    [ pe:var "area"; pe:value 8 ],
    [ pe:var "by"; pe:value 100 ],
    [ pe:var "cy"; pe:value 60 ],
    [ pe:var "drop"; pe:value 40 ],
    [ pe:var "farm"; pe:value ex:FarmAlpha ],
    [ pe:var "rain"; pe:value 12 ];
  pe:uses
    { ex:APP-DR-01 ex:appliesFor ex:DroughtReliefGrant . },
    { ex:APP-DR-01 ex:hasApplicant ex:FarmAlpha . },
    { ex:FarmAlpha ex:totalArea 8 . },
    { ex:FarmAlpha ex:rainfallLast30d 12 . },
    { ex:FarmAlpha ex:baselineYield 100 . },
    { ex:FarmAlpha ex:currentYield 60 . },
    { (100 60) math:difference 40 . },
    { 5 math:notGreaterThan 8 . },
    { 12 math:lessThan 20 . },
    { 40 math:notLessThan 30 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 15 steps, 13 verified, 2 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 11; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `unsatisfied`.

---

## Try it

```sh
eyeron examples/agri-drought-relief.n3
eyeron -p examples/agri-drought-relief.n3
eyeron -c examples/agri-drought-relief.n3
```

---

## Takeaway

Policy thresholds lead to an eligibility decision and an unnamed payment; the
SHACL descriptions are data, not validation performed here.
