# Checking a sample data-processing policy

[gdpr-compliance.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/gdpr-compliance.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/gdpr-compliance.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/gdpr-compliance.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/gdpr-compliance.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=gdpr-compliance)

---

## The question

People have personal data, processing purposes, and consent information. N3
rules evaluate the example's explicit compliance conditions and return
supported policy judgments.

**Which people meet this small rulebook's compliance conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The dataset records purposes, stated bases, retention and processor evidence.
:jane_smith a :DataSubject .

# A purpose is labelled lawful when a basis node names that purpose.
# This rule does not validate the basis against external law.
{
    ?S :hasProcessingPurpose ?P .
    ?S :hasLawfulBasis ?Premise0_b7 .
    ?Premise0_b7 :purpose ?P .
    ?Premise0_b7 :basis ?B .
} => {
    ?S :lawfulPurpose ?P .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:john_doe a :GDPRCompliant .
:jane_smith a :GDPRCompliant .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :john_doe a :GDPRCompliant . }
  pe:rule 6;
  pe:binding
    [ pe:var "P"; pe:value :marketing ],
    [ pe:var "S"; pe:value :john_doe ];
  pe:uses
    { :john_doe a :DataSubject . },
    { :john_doe :lawfulPurpose :marketing . },
    { :john_doe :retentionOKFor :marketing . },
    { :john_doe :minimizationOKFor :marketing . },
    { :john_doe :processorOK true . },
    { :john_doe :rightsOK true . }.
```

`pe:rule 6` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 40 steps, 40 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 38; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 56; pe:failed 0 ].
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
eyeron examples/gdpr-compliance.n3
eyeron -p examples/gdpr-compliance.n3
eyeron -c examples/gdpr-compliance.n3
```

---

## Takeaway

The label checks a matching purpose and the supplied evidence; it is not a
complete assessment of GDPR compliance.
