# Auditing the evidence for a research-data decision

[verifiable-decision-audit.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/verifiable-decision-audit.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/verifiable-decision-audit.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/verifiable-decision-audit.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/verifiable-decision-audit.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/verifiable-decision-audit.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=verifiable-decision-audit)

---

## The question

A companion proof records a research-data permission decision. N3 rules follow
its dependencies and compare the identified source documents with a use policy
to derive the audit result.

**Which source documents support the research decision, and may the audit use them?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Audit the fact that the Agreement was derived, rather than the mere existence
# of a requested Permission. ODRL Request policies do not grant privileges.
:audit a dpv:Audit ;
    dpv:hasScope {
        :agreement-42 a odrl:Agreement
    } ;
    dpv:hasPolicy :trust-policy ;
    dpv:hasResponsibleEntity :auditor .

# Follow recorded dependencies to the assertions supporting the scoped claim.
{
    ?claim pe:uses ?premise
} => {
    ?claim prov:wasDerivedFrom ?premise
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The companion input supplies additional facts; load it
together with the rules in the commands below.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:audit dpv:hasJustification doc:intake .
:audit dpv:hasJustification doc:ethics .
:audit dpv:hasJustification doc:consent .
:audit dpv:hasJustification doc:registry .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :audit dpv:hasJustification doc:intake . }
  pe:rule
    {
        {
            :audit dpv:hasDataSource ?doc .
        } => {
            :audit dpv:hasJustification ?doc .
        } .
    };
  pe:binding [ pe:var "doc"; pe:value doc:intake ];
  pe:uses { :audit dpv:hasDataSource doc:intake . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 35 steps, 35 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 35; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 63; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/verifiable-decision-audit.n3 examples/input/verifiable-decision-audit.n3
eyeron -p examples/verifiable-decision-audit.n3 examples/input/verifiable-decision-audit.n3
eyeron -c examples/verifiable-decision-audit.n3 examples/input/verifiable-decision-audit.n3
```

---

## References

[Source reference 1](https://www.w3.org/TR/odrl-model/)

[Source reference 2](https://w3id.org/dpv/2.3)

[Source reference 3](https://www.w3.org/TR/prov-o/)

---

## Takeaway

Inspecting proof dependencies can connect a decision's evidence to the policy
governing its use.
