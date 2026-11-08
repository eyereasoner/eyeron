# Auditing a quoted access policy

[odrl-policy-audit.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/odrl-policy-audit.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/odrl-policy-audit.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/odrl-policy-audit.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/odrl-policy-audit.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=odrl-policy-audit)

---

## The question

A quoted ODRL policy grants access to sample assets. N3 rules compute its
consequences, inspect the derived permissions, and flag the policy conditions
selected by the audit.

**Which derived access permissions trigger the quoted-policy audit?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# META-LEVEL POLICY ANALYSIS
# 1) Compute the closure of the quoted ODRL policy theory.
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
    :alice :canAccess :PayrollLedger .
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
        :ticket-42 :request :PublishPolicySnapshot .
        :policy-1 a odrl:Set .
        :policy-1 odrl:permission _:b1 .
        _:b1 odrl:assignee :alice .
        _:b1 odrl:target :EmployeeHandbook .
        _:b1 odrl:action odrl:read .
        :policy-1 odrl:permission _:b2 .
        _:b2 odrl:assignee :alice .
        _:b2 odrl:target :PayrollLedger .
        _:b2 odrl:action odrl:read .
        :PayrollLedger a :SensitiveAsset .
        :PayrollLedger a :PayrollAsset .
        :EmployeeHandbook a :PublicAsset .
        {
            ?Policy odrl:permission _:b3 .
            _:b3 odrl:assignee ?User .
            _:b3 odrl:target ?Asset .
…
            :ticket-42 :request :PublishPolicySnapshot .
        } .
    },
    { :case :risk :SensitiveAccessEntailed . }.
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
eyeron examples/odrl-policy-audit.n3
eyeron -p examples/odrl-policy-audit.n3
eyeron -c examples/odrl-policy-audit.n3
```

---

## Takeaway

Computing a policy's consequences and auditing them are separate rule steps.
