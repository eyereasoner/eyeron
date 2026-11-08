# Checking a need-based student grant

[student-grant-needbased.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/student-grant-needbased.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/student-grant-needbased.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/student-grant-needbased.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/student-grant-needbased.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=student-grant-needbased)

---

## The question

A student applies for financial support under a sample policy. N3 rules
combine the application and eligibility facts to derive the modeled grant
decision and payment information.

**Does this student meet the sample need-based grant conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
ex:Student a rdfs:Class ;
    rdfs:label "Student" ;
    rdfs:subClassOf foaf:Person .

# R1: Eligibility — ECTS ≥ 30, perCapitaIncome ≤ 18000, tuition > 0
# perCapitaIncome = householdIncome / householdSize
{
    ?app ex:appliesFor ex:NeedBasedGrant .
    ?app ex:hasApplicant ?s .
    ?s ex:enrolledECTS ?ects .
    ?s ex:householdIncome ?inc .
    ?s ex:householdSize ?hh .
    ?s ex:tuitionAmount ?fee .
    "30"^^xsd:integer math:notGreaterThan ?ects .
    (?inc ?hh) math:quotient ?pc .
    ?pc math:notGreaterThan "18000"^^xsd:integer .
    ?fee math:greaterThan "0"^^xsd:integer .
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
ex:APP-GR-01 ex:eligible true .
ex:APP-GR-01 ex:status ex:Approved .
_:pay_b34d79284e364c3d a ex:GrantPayment .
ex:APP-GR-01 ex:issuedPayment _:pay_b34d79284e364c3d .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ex:APP-GR-01 ex:eligible true . }
  pe:rule 1;
  pe:binding
    [ pe:var "app"; pe:value ex:APP-GR-01 ],
    [ pe:var "ects"; pe:value 60 ],
    [ pe:var "fee"; pe:value 1200 ],
    [ pe:var "hh"; pe:value 3 ],
    [ pe:var "inc"; pe:value 36000 ],
    [ pe:var "pc"; pe:value 12000 ],
    [ pe:var "s"; pe:value ex:Alice ];
  pe:uses
    { ex:APP-GR-01 ex:appliesFor ex:NeedBasedGrant . },
    { ex:APP-GR-01 ex:hasApplicant ex:Alice . },
    { ex:Alice ex:enrolledECTS 60 . },
    { ex:Alice ex:householdIncome 36000 . },
    { ex:Alice ex:householdSize 3 . },
    { ex:Alice ex:tuitionAmount 1200 . },
    { 30 math:notGreaterThan 60 . },
    { (36000 3) math:quotient 12000 . },
    { 12000 math:notGreaterThan 18000 . },
    { 1200 math:greaterThan 0 . }.
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
eyeron examples/student-grant-needbased.n3
eyeron -p examples/student-grant-needbased.n3
eyeron -c examples/student-grant-needbased.n3
```

---

## Takeaway

The grant and payment conclusions are tied to this policy's stated thresholds.
