# Checking a youth bike-pass discount

[bikepass-youth-discount.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/bikepass-youth-discount.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/bikepass-youth-discount.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/bikepass-youth-discount.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/bikepass-youth-discount.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=bikepass-youth-discount)

---

## The question

A person applies for a discounted bike pass. N3 rules combine the application
and age conditions to derive eligibility and the corresponding pass
information.

**Does the sample application meet the youth bike-pass conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
ex:Person a rdfs:Class ;
    rdfs:label "Person" ;
    rdfs:subClassOf foaf:Person .

# R1: Eligibility — age∈[12,26) and tripsPerWeek ≥ 3
{
    ?app ex:appliesFor ex:YouthDiscount .
    ?app ex:hasApplicant ?p .
    ?p ex:hasAge ?age .
    ?p ex:tripsPerWeek ?t .
    "12"^^xsd:integer math:notGreaterThan ?age .
    ?age math:lessThan "26"^^xsd:integer .
    "3"^^xsd:integer math:notGreaterThan ?t .
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
ex:APP-BP-01 ex:eligible true .
ex:APP-BP-01 ex:status ex:Approved .
_:pass_ce2f55ce9d7b5da6 a ex:BikePass .
ex:APP-BP-01 ex:issuedPass _:pass_ce2f55ce9d7b5da6 .
ex:APP-BP-01 ex:approvedPrice 12 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ex:APP-BP-01 ex:eligible true . }
  pe:rule 1;
  pe:binding
    [ pe:var "age"; pe:value 17 ],
    [ pe:var "app"; pe:value ex:APP-BP-01 ],
    [ pe:var "p"; pe:value ex:Zoe ],
    [ pe:var "t"; pe:value 5 ];
  pe:uses
    { ex:APP-BP-01 ex:appliesFor ex:YouthDiscount . },
    { ex:APP-BP-01 ex:hasApplicant ex:Zoe . },
    { ex:Zoe ex:hasAge 17 . },
    { ex:Zoe ex:tripsPerWeek 5 . },
    { 12 math:notGreaterThan 17 . },
    { 17 math:lessThan 26 . },
    { 3 math:notGreaterThan 5 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 18 steps, 16 verified, 2 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 11; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 7; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ];
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
eyeron examples/bikepass-youth-discount.n3
eyeron -p examples/bikepass-youth-discount.n3
eyeron -c examples/bikepass-youth-discount.n3
```

---

## Takeaway

The pass decision is supported by the supplied application and the example's
eligibility rules.
