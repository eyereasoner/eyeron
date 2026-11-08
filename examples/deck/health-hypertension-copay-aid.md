# Checking eligibility for co-pay aid

[health-hypertension-copay-aid.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/health-hypertension-copay-aid.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/health-hypertension-copay-aid.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/health-hypertension-copay-aid.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/health-hypertension-copay-aid.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=health-hypertension-copay-aid)

---

## The question

A sample patient applies for hypertension co-pay support. N3 rules combine
application and eligibility facts to derive the modeled aid decision and
payment information.

**Does the sample application qualify for the modeled co-pay aid?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
ex:Patient a rdfs:Class ;
    rdfs:label "Patient" ;
    rdfs:subClassOf foaf:Person .

# R1: Eligibility — age≥40 AND avg(systolic BP over 3 readings) ≥ 140
# avg = (r1 + r2 + r3) / 3
{
    ?app ex:appliesFor ex:HypertensionCoPayAid .
    ?app ex:hasApplicant ?p .
    ?p ex:hasAge ?age .
    ?p ex:bpS1 ?r1 .
    ?p ex:bpS2 ?r2 .
    ?p ex:bpS3 ?r3 .
    "40"^^xsd:integer math:notGreaterThan ?age .
    (?r1 ?r2) math:sum ?s12 .
    (?s12 ?r3) math:sum ?sum3 .
    (?sum3 "3"^^xsd:integer) math:quotient ?avg .
    ?avg math:notLessThan "140"^^xsd:integer .
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
ex:APP-HYP-01 ex:eligible true .
ex:APP-HYP-01 ex:status ex:Approved .
_:pay_cba340144672eeb9 a ex:HealthcarePayment .
ex:APP-HYP-01 ex:issuedPayment _:pay_cba340144672eeb9 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ex:APP-HYP-01 ex:eligible true . }
  pe:rule 1;
  pe:binding
    [ pe:var "age"; pe:value 52 ],
    [ pe:var "app"; pe:value ex:APP-HYP-01 ],
    [ pe:var "avg"; pe:value 143.33333333333334 ],
    [ pe:var "p"; pe:value ex:Dana ],
    [ pe:var "r1"; pe:value 150 ],
    [ pe:var "r2"; pe:value 142 ],
    [ pe:var "r3"; pe:value 138 ],
    [ pe:var "s12"; pe:value 292 ],
    [ pe:var "sum3"; pe:value 430 ];
  pe:uses
    { ex:APP-HYP-01 ex:appliesFor ex:HypertensionCoPayAid . },
    { ex:APP-HYP-01 ex:hasApplicant ex:Dana . },
    { ex:Dana ex:hasAge 52 . },
    { ex:Dana ex:bpS1 150 . },
    { ex:Dana ex:bpS2 142 . },
    { ex:Dana ex:bpS3 138 . },
    { 40 math:notGreaterThan 52 . },
    { (150 142) math:sum 292 . },
    { (292 138) math:sum 430 . },
    { (430 3) math:quotient 143.33333333333334 . },
    { 143.33333333333334 math:notLessThan 140 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 16 steps, 14 verified, 2 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 11; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 5; pe:failed 0 ];
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
eyeron examples/health-hypertension-copay-aid.n3
eyeron -p examples/health-hypertension-copay-aid.n3
eyeron -c examples/health-hypertension-copay-aid.n3
```

---

## Takeaway

An aid decision is justified against the supplied policy and application
facts.
