# Scoring risks in a healthcare-data agreement

[odrl-dpv-healthcare-risk-ranked.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/odrl-dpv-healthcare-risk-ranked.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/odrl-dpv-healthcare-risk-ranked.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/odrl-dpv-healthcare-risk-ranked.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/odrl-dpv-healthcare-risk-ranked.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=odrl-dpv-healthcare-risk-ranked)

---

## The question

An agreement grants and restricts uses of healthcare data. N3 rules compare
those clauses with stated needs and derive scored privacy risks, explanations,
and mitigation measures.

**Which clauses cause the modeled healthcare-data risks?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Domain vocabularies used (healthcare/life-sciences)
# See <https://obofoundry.org/ontology/duo.html>
# We use DUO codes as values for odrl:purpose constraints (via odrl:rightOperandReference).
# * duo:0000006 (HMB) health/medical/biomedical research
# * duo:0000042 (GRU) general research use
…
# * hl7ca:use, hl7ca:disclose, hl7ca:collect
:PurposeHMB a skos:Concept ;
    skos:prefLabel "DUO HMB: Health/Medical/Biomedical Research" ;
    skos:exactMatch duo:0000006 .

# 5) Score normalization + DPV-RISK severity/level
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
the conditions match. The ellipsis omits part of the source; the linked file
contains the full program.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
**Agreement:** Example Healthcare & Life-Sciences Data Use Agreement
**Profile:** Example patient profile
**Risk level:** `https://w3id.org/dpv/risk#HighRisk`
**Severity:** `https://w3id.org/dpv/risk#HighSeverity`
Risk: health/genomic data may be used for research without explicit opt-in consent. Clause H1: Hospital may use EHR and genomic data for internal clinical research and publication.
- **Mitigation for clause H1:** Add an explicit consent constraint for secondary research use.
**Risk level:** `https://w3id.org/dpv/risk#HighRisk`
**Severity:** `https://w3id.org/dpv/risk#HighSeverity`
Risk: genomic data may be shared with external pharma partners without a de-identification/pseudonymisation requirement. Clause H2: Hospital may share genomic data with pharmaceutical partners for drug discovery and R&D.
- **Mitigation for clause H2:** Require de-identification/pseudonymisation before external sharing of genomic data.
**Risk level:** `https://w3id.org/dpv/risk#ModerateRisk`
**Severity:** `https://w3id.org/dpv/risk#ModerateSeverity`
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ (:AgreementHC1 :PatientExample 0) log:outputString "# odrl-dpv-healthcare-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-healthcare-risk-ranked.n3)\n\n## Ranked DPV Risk Report (Healthcare & Life Sciences)\n\n**Agreement:** Example Healthcare & Life-Sciences Data Use Agreement\n**Profile:** Example patient profile\n\n" . }
  pe:rule 10;
  pe:binding
    [ pe:var "alabel"; pe:value "Example Healthcare & Life-Sciences Data Use Agreement" ],
    [ pe:var "hdr"; pe:value "# odrl-dpv-healthcare-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-healthcare-risk-ranked.n3)\n\n## Ranked DPV Risk Report (Healthcare & Life Sciences)\n\n**Agreement:** Example Healthcare & Life-Sciences Data Use Agreement\n**Profile:** Example patient profile\n\n" ],
    [ pe:var "plabel"; pe:value "Example patient profile" ];
  pe:uses
    { :AgreementHC1 dct:title "Example Healthcare & Life-Sciences Data Use Agreement" . },
    { :PatientExample dct:title "Example patient profile" . },
    { ("# odrl-dpv-healthcare-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-healthcare-risk-ranked.n3)\n\n## Ranked DPV Risk Report (Healthcare & Life Sciences)\n\n**Agreement:** %s\n**Profile:** %s\n\n" "Example Healthcare & Life-Sciences Data Use Agreement" "Example patient profile") string:format "# odrl-dpv-healthcare-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-healthcare-risk-ranked.n3)\n\n## Ranked DPV Risk Report (Healthcare & Life Sciences)\n\n**Agreement:** Example Healthcare & Life-Sciences Data Use Agreement\n**Profile:** Example patient profile\n\n" . }.
```

`pe:rule 10` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 134 steps, 134 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 98; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 36; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 82; pe:failed 0 ].
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
eyeron examples/odrl-dpv-healthcare-risk-ranked.n3
eyeron -p examples/odrl-dpv-healthcare-risk-ranked.n3
eyeron -c examples/odrl-dpv-healthcare-risk-ranked.n3
```

---

## References

[Source reference 1](https://www.w3.org/TR/odrl-vocab/)

[Source reference 2](https://w3id.org/dpv)

[Source reference 3](https://w3id.org/dpv/pd)

[Source reference 4](https://w3id.org/dpv/risk)

[Source reference 5](https://obofoundry.org/ontology/duo.html)

[Source reference 6](http://terminology.hl7.org/CodeSystem/consentaction)

---

## Takeaway

The result connects each score and mitigation to explicit agreement and need
facts.
