# Scoring risks in a consumer-data agreement

[odrl-dpv-risk-ranked.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/odrl-dpv-risk-ranked.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/odrl-dpv-risk-ranked.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/odrl-dpv-risk-ranked.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/odrl-dpv-risk-ranked.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=odrl-dpv-risk-ranked)

---

## The question

A consumer profile states needs that an agreement may fail to meet. N3 rules
inspect ODRL clauses and derive DPV risk descriptions, numeric scores, and
possible mitigations.

**Which agreement clauses fail to meet the sample consumer's needs?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 1) Consumer profile (needs)
:ConsumerExample a :ConsumerProfile, odrl:Party ;
    dct:title "Example consumer profile" ;
    :hasNeed :Need_DataCannotBeRemoved, :Need_ChangeOnlyWithPriorNotice, :Need_NoSharingWithoutConsent,
    :Need_DataPortability .

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
**Agreement:** Example Agreement
**Profile:** Example consumer profile
**Risk level:** `https://w3id.org/dpv/risk#HighRisk`
**Severity:** `https://w3id.org/dpv/risk#HighSeverity`
Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance.
**Risk level:** `https://w3id.org/dpv/risk#ModerateRisk`
**Severity:** `https://w3id.org/dpv/risk#ModerateSeverity`
Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data.
**Risk level:** `https://w3id.org/dpv/risk#HighRisk`
**Severity:** `https://w3id.org/dpv/risk#HighSeverity`
Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account (and associated data) at its discretion.
**Risk level:** `https://w3id.org/dpv/risk#HighRisk`
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ (:Agreement1 :ConsumerExample 0) log:outputString "# odrl-dpv-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-risk-ranked.n3)\n\n## Ranked DPV Risk Report\n\n**Agreement:** Example Agreement\n**Profile:** Example consumer profile\n\n" . }
  pe:rule
    {
        {
            :Agreement1 dct:title ?alabel .
            :ConsumerExample dct:title ?plabel .
            ("# odrl-dpv-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-risk-ranked.n3)\n\n## Ranked DPV Risk Report\n\n**Agreement:** %s\n**Profile:** %s\n\n" ?alabel ?plabel) string:format ?hdr .
        } => {
            (:Agreement1 :ConsumerExample 0) log:outputString ?hdr .
        } .
    };
  pe:binding
    [ pe:var "alabel"; pe:value "Example Agreement" ],
    [ pe:var "hdr"; pe:value "# odrl-dpv-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-risk-ranked.n3)\n\n## Ranked DPV Risk Report\n\n**Agreement:** Example Agreement\n**Profile:** Example consumer profile\n\n" ],
    [ pe:var "plabel"; pe:value "Example consumer profile" ];
  pe:uses
    { :Agreement1 dct:title "Example Agreement" . },
    { :ConsumerExample dct:title "Example consumer profile" . },
    { ("# odrl-dpv-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-risk-ranked.n3)\n\n## Ranked DPV Risk Report\n\n**Agreement:** %s\n**Profile:** %s\n\n" "Example Agreement" "Example consumer profile") string:format "# odrl-dpv-risk-ranked\n\n## Source files\n\n- [N3 rules](../odrl-dpv-risk-ranked.n3)\n\n## Ranked DPV Risk Report\n\n**Agreement:** Example Agreement\n**Profile:** Example consumer profile\n\n" . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 107 steps, 81 verified, 26 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 68; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 39; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 31; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 427; pe:failed 0 ];
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
eyeron examples/odrl-dpv-risk-ranked.n3
eyeron -p examples/odrl-dpv-risk-ranked.n3
eyeron -c examples/odrl-dpv-risk-ranked.n3
```

---

## References

[Source reference 1](https://w3c.github.io/N3/spec/)

[Source reference 2](https://www.w3.org/TR/odrl-vocab/)

[Source reference 3](https://dev.dpvcg.org/dpv/modules/risk)

[Source reference 4](https://w3id.org/dpv/risk)

---

## Takeaway

Rule-based scoring exposes the assumptions behind a ranked risk list.
