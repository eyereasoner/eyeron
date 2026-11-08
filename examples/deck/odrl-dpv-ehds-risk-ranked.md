# Assessing modeled health-data reuse risks

[odrl-dpv-ehds-risk-ranked.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/odrl-dpv-ehds-risk-ranked.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/odrl-dpv-ehds-risk-ranked.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/odrl-dpv-ehds-risk-ranked.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/odrl-dpv-ehds-risk-ranked.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=odrl-dpv-ehds-risk-ranked)

---

## The question

A hospital-to-research agreement is described with ODRL and DPV health- data
terms. N3 rules compare its clauses with stated patient needs and derive
scored risks, explanations, and mitigations.

**Which modeled health-data reuse risks receive the highest scores?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 1) A “patient expectations” profile expressed as needs (weights for scoring)
:PatientProfileExample a :PatientProfile, odrl:Party ;
    dct:title "Example patient profile (EHDS rights expectations)" ;
    :hasNeed :Need_RequireDataPermit, :Need_RespectOptOutSecondaryUse, :Need_SecureProcessingEnvironment,
    :Need_StatisticallyAnonymisedSecondaryUse .

# 4) Score normalization + DPV-RISK severity/level
{
    ?r a dpv:Risk ;
        :scoreRaw ?raw .
    ?raw math:greaterThan 100 .
} => {
    ?r :score 100 .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
**Agreement:** EHDS Secondary Use Agreement (example)
**Profile:** Example patient profile (EHDS rights expectations)
**Risk level:** `https://w3id.org/dpv/risk#HighRisk`
**Severity:** `https://w3id.org/dpv/risk#HighSeverity`
Risk: secondary use is permitted without an EHDS Data Permit safeguard. Clause H1: Hospital may provide electronic health data for secondary use based on a bilateral data use agreement with the applicant.
- **Mitigation for clause H1:** Require an EHDS Data Permit (eu-ehds:DataPermit) issued by a Health Data Access Body prior to secondary use.
**Risk level:** `https://w3id.org/dpv/risk#HighRisk`
**Severity:** `https://w3id.org/dpv/risk#HighSeverity`
Risk: secondary use may include patients who opted out (EHDS A71). Clause H2: Secondary use may include all patient records for training and evaluating health-related algorithms.
- **Mitigation for clause H2:** Add an explicit safeguard to exclude records of persons who exercised the EHDS opt-out from secondary use (A71).
**Risk level:** `https://w3id.org/dpv/risk#HighRisk`
**Severity:** `https://w3id.org/dpv/risk#HighSeverity`
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ (:AgreementEHDS1 :PatientProfileExample 0) log:outputString "# odrl-dpv-ehds-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-ehds-risk-ranked.n3)\n\n## Ranked DPV Risk Report (EHDS-aligned)\n\n**Agreement:** EHDS Secondary Use Agreement (example)\n**Profile:** Example patient profile (EHDS rights expectations)\n\n" . }
  pe:rule
    {
        {
            :AgreementEHDS1 dct:title ?alabel .
            :PatientProfileExample dct:title ?plabel .
            ("# odrl-dpv-ehds-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-ehds-risk-ranked.n3)\n\n## Ranked DPV Risk Report (EHDS-aligned)\n\n**Agreement:** %s\n**Profile:** %s\n\n" ?alabel ?plabel) string:format ?hdr .
        } => {
            (:AgreementEHDS1 :PatientProfileExample 0) log:outputString ?hdr .
        } .
    };
  pe:binding
    [ pe:var "alabel"; pe:value "EHDS Secondary Use Agreement (example)" ],
    [ pe:var "hdr"; pe:value "# odrl-dpv-ehds-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-ehds-risk-ranked.n3)\n\n## Ranked DPV Risk Report (EHDS-aligned)\n\n**Agreement:** EHDS Secondary Use Agreement (example)\n**Profile:** Example patient profile (EHDS rights expectations)\n\n" ],
    [ pe:var "plabel"; pe:value "Example patient profile (EHDS rights expectations)" ];
  pe:uses
    { :AgreementEHDS1 dct:title "EHDS Secondary Use Agreement (example)" . },
    { :PatientProfileExample dct:title "Example patient profile (EHDS rights expectations)" . },
    { ("# odrl-dpv-ehds-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-ehds-risk-ranked.n3)\n\n## Ranked DPV Risk Report (EHDS-aligned)\n\n**Agreement:** %s\n**Profile:** %s\n\n" "EHDS Secondary Use Agreement (example)" "Example patient profile (EHDS rights expectations)") string:format "# odrl-dpv-ehds-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-ehds-risk-ranked.n3)\n\n## Ranked DPV Risk Report (EHDS-aligned)\n\n**Agreement:** EHDS Secondary Use Agreement (example)\n**Profile:** Example patient profile (EHDS rights expectations)\n\n" . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 98 steps, 74 verified, 24 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 64; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 34; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 28; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 386; pe:failed 0 ];
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
eyeron examples/odrl-dpv-ehds-risk-ranked.n3
eyeron -p examples/odrl-dpv-ehds-risk-ranked.n3
eyeron -c examples/odrl-dpv-ehds-risk-ranked.n3
```

---

## References

[Source reference 1](http://www.w3.org/ns/odrl/2/)

[Source reference 2](https://w3id.org/dpv#)

[Source reference 3](https://w3id.org/dpv/risk#)

[Source reference 4](https://w3id.org/dpv/legal/eu/ehds#)

[Source reference 5](https://w3id.org/dpv/legal/eu/dga#)

---

## Takeaway

A score explains this rulebook's risk assessment and supplied needs, rather
than establishing legal compliance.
