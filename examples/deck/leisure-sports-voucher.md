# Checking a sports-voucher application

[leisure-sports-voucher.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/leisure-sports-voucher.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/leisure-sports-voucher.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/leisure-sports-voucher.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/leisure-sports-voucher.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=leisure-sports-voucher)

---

## The question

A person applies for a leisure sports voucher. N3 rules combine the sample
application and policy conditions to derive eligibility and voucher
information.

**Does the application qualify for the sample sports voucher?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
ex:Person a rdfs:Class ;
    rdfs:label "Person" ;
    rdfs:subClassOf foaf:Person .

# R1: Eligibility — age∈[12,30), sessions≥3, weeklyMinutes≥150, income<30000
# weeklyMinutes = sessions * minutesPerSession
{
    ?app ex:appliesFor ex:SportsVoucher .
    ?app ex:hasApplicant ?p .
    ?p ex:hasAge ?age .
    ?p ex:commitsSessionsPerWeek ?s .
    ?p ex:minutesPerSession ?m .
    ?p ex:householdIncome ?inc .
    "12"^^xsd:integer math:notGreaterThan ?age .
    ?age math:lessThan "30"^^xsd:integer .
    "3"^^xsd:integer math:notGreaterThan ?s .
    (?s ?m) math:product ?weekMin .
    ?weekMin math:notLessThan "150"^^xsd:integer .
    ?inc math:lessThan "30000"^^xsd:integer .
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
ex:APP-LEIS-01 ex:eligible true .
ex:APP-LEIS-01 ex:status ex:Approved .
_:v_134e1665e812dc4 a ex:LeisureVoucher .
ex:APP-LEIS-01 ex:issuedVoucher _:v_134e1665e812dc4 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ex:APP-LEIS-01 ex:eligible true . }
  pe:rule 1;
  pe:binding
    [ pe:var "age"; pe:value 19 ],
    [ pe:var "app"; pe:value ex:APP-LEIS-01 ],
    [ pe:var "inc"; pe:value 20000 ],
    [ pe:var "m"; pe:value 45 ],
    [ pe:var "p"; pe:value ex:Liam ],
    [ pe:var "s"; pe:value 4 ],
    [ pe:var "weekMin"; pe:value 180 ];
  pe:uses
    { ex:APP-LEIS-01 ex:appliesFor ex:SportsVoucher . },
    { ex:APP-LEIS-01 ex:hasApplicant ex:Liam . },
    { ex:Liam ex:hasAge 19 . },
    { ex:Liam ex:commitsSessionsPerWeek 4 . },
    { ex:Liam ex:minutesPerSession 45 . },
    { ex:Liam ex:householdIncome 20000 . },
    { 12 math:notGreaterThan 19 . },
    { 19 math:lessThan 30 . },
    { 3 math:notGreaterThan 4 . },
    { (4 45) math:product 180 . },
    { 180 math:notLessThan 150 . },
    { 20000 math:lessThan 30000 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 17 steps, 15 verified, 2 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 11; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
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
eyeron examples/leisure-sports-voucher.n3
eyeron -p examples/leisure-sports-voucher.n3
eyeron -c examples/leisure-sports-voucher.n3
```

---

## Takeaway

The voucher conclusion is tied to explicit eligibility facts and policy
thresholds.
