# Turning a process description into a policy view

[dpv-odrl-purpose-mapping.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/dpv-odrl-purpose-mapping.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/dpv-odrl-purpose-mapping.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/dpv-odrl-purpose-mapping.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/dpv-odrl-purpose-mapping.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=dpv-odrl-purpose-mapping)

---

## The question

A data-processing description records parties, data, purpose, and legal basis.
N3 mapping rules derive an ODRL permission and constraints from this DPV
description.

**How does the process description become an ODRL policy view?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# A DPV process describes who uses which data, for what purpose and basis.
:AlphaCareProcess a dpv:Process ;
    dpv:hasDataController :HospitalA ;
    dpv:hasRecipient :ResearchPartner ;
    dpv:hasPersonalData :LabResult ;
    dpv:hasProcessing dpv:Use ;
    dpv:hasPurpose dpv:Healthcare ;
    dpv:hasLegalBasis dpv:Consent .

# Copy the parties, data and processing action into an ODRL permission.
{
    ?policy :representsProcess ?process ;
        :permissionNode ?permission .
    ?process a dpv:Process ;
        dpv:hasDataController ?controller ;
        dpv:hasRecipient ?recipient ;
        dpv:hasPersonalData ?data ;
        dpv:hasProcessing ?processing .
} => {
    ?policy a odrl:Policy ;
        odrl:permission ?permission .
    ?permission a odrl:Permission ;
        odrl:assigner ?controller ;
        odrl:assignee ?recipient ;
        odrl:target ?data ;
        odrl:action ?processing ;
        :derivedFromProcess ?process .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:AlphaPolicy a odrl:Policy .
:AlphaPolicy odrl:permission :AlphaPermission .
:AlphaBasisConstraint odrl:operator odrl:isA .
:AlphaBasisConstraint odrl:rightOperand dpv:Consent .
:AlphaPermission a odrl:Permission .
:AlphaPermission odrl:assigner :HospitalA .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :AlphaPolicy a odrl:Policy . }
  pe:rule 1;
  pe:binding
    [ pe:var "controller"; pe:value :HospitalA ],
    [ pe:var "data"; pe:value :LabResult ],
    [ pe:var "permission"; pe:value :AlphaPermission ],
    [ pe:var "policy"; pe:value :AlphaPolicy ],
    [ pe:var "process"; pe:value :AlphaCareProcess ],
    [ pe:var "processing"; pe:value dpv:Use ],
    [ pe:var "recipient"; pe:value :ResearchPartner ];
  pe:uses
    { :AlphaPolicy :representsProcess :AlphaCareProcess . },
    { :AlphaPolicy :permissionNode :AlphaPermission . },
    { :AlphaCareProcess a dpv:Process . },
    { :AlphaCareProcess dpv:hasDataController :HospitalA . },
    { :AlphaCareProcess dpv:hasRecipient :ResearchPartner . },
    { :AlphaCareProcess dpv:hasPersonalData :LabResult . },
    { :AlphaCareProcess dpv:hasProcessing dpv:Use . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 29 steps, 29 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 29; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 18; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/dpv-odrl-purpose-mapping.n3
eyeron -p examples/dpv-odrl-purpose-mapping.n3
eyeron -c examples/dpv-odrl-purpose-mapping.n3
```

---

## Takeaway

A vocabulary mapping describes a permission and its constraints; it does not
itself decide an access request.
