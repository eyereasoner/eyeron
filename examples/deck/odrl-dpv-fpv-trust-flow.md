# Deciding whether a data flow may proceed

[odrl-dpv-fpv-trust-flow.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/odrl-dpv-fpv-trust-flow.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/odrl-dpv-fpv-trust-flow.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/odrl-dpv-fpv-trust-flow.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/odrl-dpv-fpv-trust-flow.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=odrl-dpv-fpv-trust-flow)

---

## The question

Sample data flows have sources, purposes, trust scores, and policy conditions.
N3 rules combine ODRL and DPV facts with a local Flow/Policy Vocabulary to
derive permission, denial, or review.

**Which data flows are permitted, denied or sent for review?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:HospitalA :trustScore 0.92 .

# Permit if ODRL permission matches and the trust gate is satisfied.
{
    ?flow a fpv:DataFlow ;
        fpv:source ?source ;
        fpv:recipient ?recipient ;
        fpv:data ?data ;
        fpv:processing ?action ;
        fpv:purpose ?purpose .
    ?source :trustScore ?score .
    :TrustPolicy odrl:permission ?permission .
    ?permission odrl:assignee ?recipient ;
        odrl:target ?data ;
        odrl:action ?action ;
        odrl:constraint ?purposeConstraint, ?trustConstraint .
    ?purposeConstraint odrl:leftOperand fpv:purpose ;
        odrl:operator odrl:isA ;
        odrl:rightOperand ?purpose .
    ?trustConstraint odrl:leftOperand fpv:sourceTrust ;
        odrl:operator odrl:gteq ;
…
    ?flow fpv:decision fpv:permit ;
        fpv:confidence ?score ;
        dpv:hasStatus fpv:ExecutableFlow .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The ellipsis omits part of the source; the linked file
contains the full program.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:FlowCare fpv:decision fpv:permit .
:FlowCare fpv:confidence 0.92 .
:FlowClinic fpv:decision fpv:review .
:FlowAds fpv:decision fpv:deny .
:FlowAds dpv:hasRisk risk:UnwantedDisclosureData .
:FlowAds dpv:hasStatus fpv:BlockedFlow .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :FlowCare fpv:decision fpv:permit . }
  pe:rule 1;
  pe:binding
    [ pe:var "action"; pe:value dpv:Use ],
    [ pe:var "data"; pe:value :LabResult ],
    [ pe:var "flow"; pe:value :FlowCare ],
    [ pe:var "minTrust"; pe:value 0.80 ],
    [ pe:var "permission"; pe:value :PermitHealthcareResearch ],
    [ pe:var "purpose"; pe:value dpv:Healthcare ],
    [ pe:var "purposeConstraint"; pe:value :HealthcarePurpose ],
    [ pe:var "recipient"; pe:value :ResearchPartner ],
    [ pe:var "score"; pe:value 0.92 ],
    [ pe:var "source"; pe:value :HospitalA ],
    [ pe:var "trustConstraint"; pe:value :MinTrust ];
  pe:uses
    { :FlowCare a fpv:DataFlow . },
    { :FlowCare fpv:source :HospitalA . },
    { :FlowCare fpv:recipient :ResearchPartner . },
    { :FlowCare fpv:data :LabResult . },
    { :FlowCare fpv:processing dpv:Use . },
    { :FlowCare fpv:purpose dpv:Healthcare . },
…
    { :MinTrust odrl:leftOperand fpv:sourceTrust . },
    { :MinTrust odrl:operator odrl:gteq . },
    { :MinTrust odrl:rightOperand 0.80 . },
    { 0.92 math:notLessThan 0.80 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 50 steps, 50 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 48; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 9; pe:failed 0 ].
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
eyeron examples/odrl-dpv-fpv-trust-flow.n3
eyeron -p examples/odrl-dpv-fpv-trust-flow.n3
eyeron -c examples/odrl-dpv-fpv-trust-flow.n3
```

---

## Takeaway

A flow decision depends on the purpose, policy and trust evidence considered
together.
