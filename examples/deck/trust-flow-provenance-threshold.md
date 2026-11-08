# Combining provenance into a trust score

[trust-flow-provenance-threshold.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/trust-flow-provenance-threshold.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/trust-flow-provenance-threshold.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/trust-flow-provenance-threshold.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/trust-flow-provenance-threshold.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=trust-flow-provenance-threshold)

---

## The question

Messages identify their publishers, signatures, transformations, and receiver.
N3 arithmetic rules combine the supplied confidence factors and derive whether
each message meets the receiver's threshold.

**Which messages meet the receiver's confidence threshold?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Each message names its publisher, transformation, signature and receiver.
:messageA a fpv:Message ;
    prov:wasAttributedTo :PublisherA ;
    prov:wasGeneratedBy :TransformA ;
    fpv:hasSignature :SignatureA ;
    fpv:receiver :ReceiverApp .

# Multiply publisher trust, signature strength and transformation quality.
{
    ?message a fpv:Message ;
        prov:wasAttributedTo ?publisher ;
        prov:wasGeneratedBy ?transform ;
        fpv:hasSignature ?signature ;
        fpv:receiver ?receiver .
    ?publisher fpv:publisherTrust ?publisherTrust .
    ?signature fpv:signatureStrength ?signatureTrust .
    ?transform fpv:qualityScore ?quality .
    (?publisherTrust ?signatureTrust ?quality) math:product ?confidence .
} => {
    ?message fpv:confidence ?confidence .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:messageA fpv:confidence "0.8937599999999999"^^xsd:decimal .
:messageB fpv:confidence "0.41999999999999993"^^xsd:decimal .
:messageB fpv:trustFlowState fpv:quarantine .
:messageB dpv:hasRisk risk:LowTrustDataSource .
:messageA fpv:trustFlowState fpv:accepted .
:messageA dpv:hasStatus fpv:HighTrustFlow .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :messageA fpv:confidence 0.8937599999999999 . }
  pe:rule 1;
  pe:binding
    [ pe:var "confidence"; pe:value 0.8937599999999999 ],
    [ pe:var "message"; pe:value :messageA ],
    [ pe:var "publisher"; pe:value :PublisherA ],
    [ pe:var "publisherTrust"; pe:value 0.95 ],
    [ pe:var "quality"; pe:value 0.96 ],
    [ pe:var "receiver"; pe:value :ReceiverApp ],
    [ pe:var "signature"; pe:value :SignatureA ],
    [ pe:var "signatureTrust"; pe:value 0.98 ],
    [ pe:var "transform"; pe:value :TransformA ];
  pe:uses
    { :messageA a fpv:Message . },
    { :messageA prov:wasAttributedTo :PublisherA . },
    { :messageA prov:wasGeneratedBy :TransformA . },
    { :messageA fpv:hasSignature :SignatureA . },
    { :messageA fpv:receiver :ReceiverApp . },
    { :PublisherA fpv:publisherTrust 0.95 . },
    { :SignatureA fpv:signatureStrength 0.98 . },
    { :TransformA fpv:qualityScore 0.96 . },
    { (0.95 0.98 0.96) math:product 0.8937599999999999 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 27 steps, 27 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 23; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
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
eyeron examples/trust-flow-provenance-threshold.n3
eyeron -p examples/trust-flow-provenance-threshold.n3
eyeron -c examples/trust-flow-provenance-threshold.n3
```

---

## Takeaway

The score combines supplied factors; a numeric signature score is not
cryptographic verification.
