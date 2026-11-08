# Keeping provenance tied to its graph

[context-association.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/context-association.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/context-association.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/context-association.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/context-association.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=context-association)

---

## The question

Data, signature, and metadata facts are represented as four-item tuples that
include a graph name. N3 rules follow the provenance links and test that
evidence from another graph does not answer the local question.

**Can the provenance chain be followed without mixing evidence from different graphs?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Each four-item tuple records subject, predicate, object and graph.
# The graph names link the data, signature description and its metadata.
(:bob :name "Bob" :g0) :quad true .

# Join every signature field within the same signature graph, then follow
# that graph's metadata link. These are metadata checks, not cryptography.
{
    (:bob :name "Bob" ?dataGraph) :quad true .
    (?dataGraph :proof ?dataSignature ?signatureGraph) :quad true .
    (?proof :type :DataIntegrityProof ?signatureGraph) :quad true .
    (?proof :cryptosuite "ecdsa-rdfc-2019" ?signatureGraph) :quad true .
    (?proof :issuer ?issuer ?signatureGraph) :quad true .
    ?issuer log:equalTo <https://university.example/issuers/14> .
    (?proof :validUntil "2025-04-03T00:00:00.000Z"^^xsd:dateTime ?signatureGraph) :quad true .
    (?signatureGraph :proof ?metadataSignature ?metadataGraph) :quad true .
    (?metadataProof :type :DataIntegrityProof ?metadataGraph) :quad true .
    (?metadataProof :proofPurpose "assertionMethod" ?metadataGraph) :quad true .
} => {
    (:bob ?dataGraph ?signatureGraph ?metadataGraph "ecdsa-rdfc-2019" ?issuer) :association true
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
(:bob :g0 :g1 :g3 "ecdsa-rdfc-2019" <https://university.example/issuers/14>) :association true .
:test :graphScopeRespected true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ (:bob :g0 :g1 :g3 "ecdsa-rdfc-2019" <https://university.example/issuers/14>) :association true . }
  pe:rule 1;
  pe:binding
    [ pe:var "dataGraph"; pe:value :g0 ],
    [ pe:var "dataSignature"; pe:value :dataSignature ],
    [ pe:var "issuer"; pe:value <https://university.example/issuers/14> ],
    [ pe:var "metadataGraph"; pe:value :g3 ],
    [ pe:var "metadataProof"; pe:value :signature2 ],
    [ pe:var "metadataSignature"; pe:value :signature2 ],
    [ pe:var "proof"; pe:value :signature1 ],
    [ pe:var "signatureGraph"; pe:value :g1 ];
  pe:uses
    { (:bob :name "Bob" :g0) :quad true . },
    { (:g0 :proof :dataSignature :g1) :quad true . },
    { (:signature1 :type :DataIntegrityProof :g1) :quad true . },
    { (:signature1 :cryptosuite "ecdsa-rdfc-2019" :g1) :quad true . },
    { (:signature1 :issuer <https://university.example/issuers/14> :g1) :quad true . },
    { <https://university.example/issuers/14> log:equalTo <https://university.example/issuers/14> . },
    { (:signature1 :validUntil "2025-04-03T00:00:00.000Z"^^xsd:dateTime :g1) :quad true . },
    { (:g1 :proof :signature2 :g3) :quad true . },
    { (:signature2 :type :DataIntegrityProof :g3) :quad true . },
    { (:signature2 :proofPurpose "assertionMethod" :g3) :quad true . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 13 steps, 13 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 11; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/context-association.n3
eyeron -p examples/context-association.n3
eyeron -c examples/context-association.n3
```

---

## Takeaway

Keeping the graph field in every join preserves the distinction between data
and its metadata.
