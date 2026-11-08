# Checking a Bloom-filter probability envelope

[high-trust-rdf-bloom-envelope.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/high-trust-rdf-bloom-envelope.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/high-trust-rdf-bloom-envelope.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/high-trust-rdf-bloom-envelope.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/high-trust-rdf-bloom-envelope.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=high-trust-rdf-bloom-envelope)

---

## The question

An RDF artifact supplies graph counts, filter parameters, and decimal bounds.
N3 arithmetic rules derive false-positive estimates and check them against the
stated lookup budgets.

**Do the filter parameters and supplied probability bounds meet the lookup budget?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:artifact a :HighTrustRdfArtifact ;
    :canonicalTripleCount 1200 ;
    :spoIndexTripleCount 1200 ;
    :bloomBits 16384 ;
…
    :expMinusLambdaLower 0.5988792348 ;
    :expMinusLambdaUpper 0.5988792349 ;
    :maybePositivePolicy :ConfirmAgainstCanonicalGraph ;
    :definiteNegativePolicy :ReturnAbsent .

# Parameter sanity
{
    :artifact :canonicalTripleCount ?n ;
        :spoIndexTripleCount ?s ;
        :bloomBits ?m ;
        :hashFunctions ?k ;
        :negativeLookupsPerBatch ?q ;
        :fpRateBudget ?r ;
        :extraExactLookupsBudget ?e .
    ?n math:greaterThan 0 .
    ?s math:greaterThan 0 .
    ?m math:greaterThan 0 .
    ?k math:greaterThan 0 .
    ?q math:greaterThan 0 .
    ?r math:greaterThan 0 .
    ?e math:greaterThan 0 .
} => {
    :artifact :parameterSanity true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called. The ellipsis omits part of the source; the
linked file contains the full program.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:result :expIntervalCertificate :CertifiedDecimalInterval .
:result :summary ("parameter-sanity" true "index-agreement" true "transcendental" "exp(-k*n/m)" "lambda" "0.5126953125"^^xsd:decimal "certified-lambda" 0.5126953125 "exp-lower" 0.5988792348 "exp-upper" 0.5988792349 "fp-lower" "0.0016708059567271017"^^xsd:decimal "fp-upper" "0.0016708059596428394"^^xsd:decimal "expected-extra-exact-lookups-upper" "83.54029798214196"^^xsd:decimal "decision" :AcceptForHighTrustUse) .
:result :withinExactLookupBudget true .
:result :withinFpRateBudget true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :summary ("parameter-sanity" true "index-agreement" true "transcendental" "exp(-k*n/m)" "lambda" 0.5126953125 "certified-lambda" 0.5126953125 "exp-lower" 0.5988792348 "exp-upper" 0.5988792349 "fp-lower" 0.0016708059567271017 "fp-upper" 0.0016708059596428394 "expected-extra-exact-lookups-upper" 83.54029798214196 "decision" :AcceptForHighTrustUse) . }
  pe:rule
    {
        {
            :artifact :parameterSanity ?sanity .
            :artifact :indexAgreement ?agreement .
            :artifact :lambda ?lambda .
            :artifact :certifiedLambda ?certifiedLambda .
            :artifact :exactTranscendentalSymbol ?sym .
            :artifact :expMinusLambdaLower ?eLo .
            :artifact :expMinusLambdaUpper ?eHi .
            :artifact :fpRateLower ?fpLo .
            :artifact :fpRateUpper ?fpHi .
            :artifact :expectedExtraExactLookupsUpper ?extraHi .
            :artifact :deploymentDecision ?decision .
        } => {
            :result :summary ("parameter-sanity" ?sanity "index-agreement" ?agreement "transcendental" ?sym "lambda" ?lambda "certified-lambda" ?certifiedLambda "exp-lower" ?eLo "exp-upper" ?eHi "fp-lower" ?fpLo "fp-upper" ?fpHi "expected-extra-exact-lookups-upper" ?extraHi "decision" ?decision) .
        } .
    };
  pe:binding
    [ pe:var "agreement"; pe:value true ],
…
    { :artifact :fpRateLower 0.0016708059567271017 . },
    { :artifact :fpRateUpper 0.0016708059596428394 . },
    { :artifact :expectedExtraExactLookupsUpper 83.54029798214196 . },
    { :artifact :deploymentDecision :AcceptForHighTrustUse . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 49 steps, 49 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 28; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 21; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 103; pe:failed 0 ].
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
eyeron examples/high-trust-rdf-bloom-envelope.n3
eyeron -p examples/high-trust-rdf-bloom-envelope.n3
eyeron -c examples/high-trust-rdf-bloom-envelope.n3
```

---

## Takeaway

The acceptance result depends on the stated counts, interval certificate and
budget.
