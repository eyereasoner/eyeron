# Contrasting trusted and tampered filter data

[high-trust-rdf-bloom-tamper-contrast.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/high-trust-rdf-bloom-tamper-contrast.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/high-trust-rdf-bloom-tamper-contrast.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/high-trust-rdf-bloom-tamper-contrast.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/high-trust-rdf-bloom-tamper-contrast.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=high-trust-rdf-bloom-tamper-contrast)

---

## The question

Two RDF artifacts supply different filter parameters and certificates. N3
rules check the stated consistency and probability conditions, exposing why
the tampered case fails the modeled acceptance tests.

**Which checks distinguish the trusted artifact from the tampered one?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Trusted artifact
:trustedArtifact a :HighTrustRdfArtifact ;
    :canonicalTripleCount 1200 ;
    :spoIndexTripleCount 1200 ;
    :bloomBits 16384 ;
…
    :expMinusLambdaLower 0.5988792348 ;
    :expMinusLambdaUpper 0.5988792349 ;
    :maybePositivePolicy :ConfirmAgainstCanonicalGraph ;
    :definiteNegativePolicy :ReturnAbsent .

# Exact structural agreement of graph and SPO index
{
    ?a :canonicalTripleCount ?n ;
        :spoIndexTripleCount ?n .
} => {
    ?a :indexAgreement true .
    ?a :tripleCount ?n .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The ellipsis omits part of the source; the linked file
contains the full program.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:result :decision [
  :artifact :trustedArtifact ;
  :hardened :AcceptForHighTrustUse ;
  :weak :AcceptUnderWeakBudgetOnlyRules
] .
:result :decision [
  :artifact :tamperedArtifact ;
  :hardened :RejectForHighTrustUse ;
  :weak :AcceptUnderWeakBudgetOnlyRules
] .
:result :rejectReason [
  :artifact :tamperedArtifact ;
  :why :NonPositiveBloomBits
] .
:result :rejectReason [
  :artifact :tamperedArtifact ;
  :why :CertifiedLambdaMismatch
] .
:result :summary (:tamperedArtifact "lambda" -700 "certified-lambda" 0.5126953125 "weak-fp-upper" "-194754273881"^^xsd:decimal "weak-extra-exact-upper" "-194754273881"^^xsd:decimal "weak-decision" :AcceptUnderWeakBudgetOnlyRules "hardened-decision" :RejectForHighTrustUse) .
:result :summary (:trustedArtifact "lambda" "0.5126953125"^^xsd:decimal "certified-lambda" 0.5126953125 "weak-fp-upper" "0.0016708059596428394"^^xsd:decimal "weak-extra-exact-upper" "83.54029798214196"^^xsd:decimal "weak-decision" :AcceptUnderWeakBudgetOnlyRules "hardened-decision" :AcceptForHighTrustUse) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :decision _:b1_451871e9cc2af5ab . }
  pe:rule
    {
        {
            ?a :weakDecision ?weak .
            ?a :hardenedDecision ?hard .
        } => {
            :result :decision _:b1 .
            _:b1 :artifact ?a .
            _:b1 :weak ?weak .
            _:b1 :hardened ?hard .
        } .
    };
  pe:binding
    [ pe:var "a"; pe:value :trustedArtifact ],
    [ pe:var "hard"; pe:value :AcceptForHighTrustUse ],
    [ pe:var "weak"; pe:value :AcceptUnderWeakBudgetOnlyRules ];
  pe:uses
    { :trustedArtifact :weakDecision :AcceptUnderWeakBudgetOnlyRules . },
    { :trustedArtifact :hardenedDecision :AcceptForHighTrustUse . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 102 steps, 102 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 70; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 32; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 17; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 238; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/high-trust-rdf-bloom-tamper-contrast.n3
eyeron -p examples/high-trust-rdf-bloom-tamper-contrast.n3
eyeron -c examples/high-trust-rdf-bloom-tamper-contrast.n3
```

---

## Takeaway

Contrasting inputs make the conditions behind a filter's acceptance visible.
