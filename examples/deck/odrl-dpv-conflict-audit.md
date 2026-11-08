# Auditing conflicting campaign permissions

[odrl-dpv-conflict-audit.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/odrl-dpv-conflict-audit.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/odrl-dpv-conflict-audit.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/odrl-dpv-conflict-audit.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/odrl-dpv-conflict-audit.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=odrl-dpv-conflict-audit)

---

## The question

A quoted campaign policy can support conflicting access conclusions. N3 rules
compute the policy's consequences, detect the modeled conflicts, and derive an
audit using ODRL and DPV terms.

**Which conflicting campaign permissions trigger the audit?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# META-LEVEL POLICY ANALYSIS
# 1) Compute the closure of the quoted ODRL+DPV policy theory.
{
    :case :policyTheory ?PolicyTheory .
    ?PolicyTheory log:conclusion ?PolicyClosure .
} => {
    :case :policyClosure ?PolicyClosure .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:case :decision :ManualReviewRequired .
:case :entails {
    :adVendor a :ExternalRecipient .
    :adVendor :permittedPurpose dpv:Marketing .
    :adVendor :prohibitedPurpose dpv:Marketing .
    :adVendor :permittedReadCategory dpv:PersonalData .
    :adVendor :prohibitedReadCategory dpv:PersonalData .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :case :decision :ManualReviewRequired . }
  pe:rule 3;
  pe:binding
    [ pe:var "PolicyTheory"; pe:value {
        :ticket-314 :request :PublishPartnerCampaignPolicy .
        :adVendor a :ExternalRecipient .
        :analyticsTeam a :InternalRecipient .
        :AudienceList dpv:hasPersonalData pd:EmailAddress .
        :AudienceList dpv:hasPersonalData dpv:PersonalData .
        :ProductCatalog a :NonPersonalDataset .
        :policy-allow-external a odrl:Set .
        :policy-allow-external dpv:hasPurpose dpv:Marketing .
        :policy-allow-external odrl:permission _:b1 .
        _:b1 odrl:assignee :adVendor .
        _:b1 odrl:target :AudienceList .
        _:b1 odrl:action odrl:read .
        :policy-deny-external a odrl:Set .
        :policy-deny-external dpv:hasPurpose dpv:Marketing .
        :policy-deny-external odrl:prohibition _:b2 .
        _:b2 odrl:assignee :adVendor .
        _:b2 odrl:target :AudienceList .
…
            :ticket-314 :request :PublishPartnerCampaignPolicy .
        } .
    },
    { :case :risk :PermissionProhibitionConflictEntailed . }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 8 steps, 7 verified, 1 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 15; pe:failed 0 ];
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
eyeron examples/odrl-dpv-conflict-audit.n3
eyeron -p examples/odrl-dpv-conflict-audit.n3
eyeron -c examples/odrl-dpv-conflict-audit.n3
```

---

## Takeaway

A conflict becomes actionable when explicit audit rules identify it in the
policy closure.
