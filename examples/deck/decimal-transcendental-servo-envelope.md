# Bounding a servo's sampled error

[decimal-transcendental-servo-envelope.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/decimal-transcendental-servo-envelope.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/decimal-transcendental-servo-envelope.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/decimal-transcendental-servo-envelope.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/decimal-transcendental-servo-envelope.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=decimal-transcendental-servo-envelope)

---

## The question

A sampled servo's error decays by a factor represented with decimal bounds. N3
rules propagate the upper and lower envelopes and derive when the modeled
error meets the tolerance.

**At which sampled step does the supplied error envelope meet tolerance?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:servo a :SampledServoEnvelope ;
    :samplePeriod "0.020"^^xsd:decimal ;
    :timeConstant "0.060"^^xsd:decimal ;
    :exactPoleSymbol "exp(-1/3)" ;
    :poleLower "0.7165313105"^^xsd:decimal ;
    :poleUpper "0.7165313106"^^xsd:decimal ;
    :initialAbsError "12.5"^^xsd:decimal ;
    :tolerance "0.5"^^xsd:decimal ;
    :maxStep 12 .

# The decimal interval is a finite certificate for a transcendental
{
    :servo :poleLower ?lo ;
        :poleUpper ?hi .
    ?lo math:lessThan ?hi .
    ?hi math:lessThan 1 .
    ?lo math:greaterThan 0 .
} => {
    :servo :poleCertificate :CertifiedDecimalInterval .
    :servo :contractivePole true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:result :contractionAt 0 .
:result :contractionAt 1 .
:result :contractionAt 10 .
:result :contractionAt 11 .
:result :envelope (9 "0.6223383540214966"^^xsd:decimal "0.6223383548031854"^^xsd:decimal) .
:result :summary ("exact-pole" "exp(-1/3)" "decimal-lower" "0.7165313105"^^xsd:decimal "decimal-upper" "0.7165313106"^^xsd:decimal "tolerance" "0.5"^^xsd:decimal "first-settled-step" 10 "first-settled-time-s" "0.2"^^xsd:decimal) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :summary ("exact-pole" "exp(-1/3)" "decimal-lower" 0.7165313105 "decimal-upper" 0.7165313106 "tolerance" 0.5 "first-settled-step" 10 "first-settled-time-s" 0.2) . }
  pe:rule
    {
        {
            :servo :firstSettledStep ?k .
            :servo :firstSettledTime ?t .
            :servo :tolerance ?tol .
            :servo :exactPoleSymbol ?sym .
            :servo :poleLower ?aLo .
            :servo :poleUpper ?aHi .
        } => {
            :result :summary ("exact-pole" ?sym "decimal-lower" ?aLo "decimal-upper" ?aHi "tolerance" ?tol "first-settled-step" ?k "first-settled-time-s" ?t) .
        } .
    };
  pe:binding
    [ pe:var "aHi"; pe:value 0.7165313106 ],
    [ pe:var "aLo"; pe:value 0.7165313105 ],
    [ pe:var "k"; pe:value 10 ],
    [ pe:var "sym"; pe:value "exp(-1/3)" ],
    [ pe:var "t"; pe:value 0.2 ],
    [ pe:var "tol"; pe:value 0.5 ];
…
    { :servo :tolerance 0.5 . },
    { :servo :exactPoleSymbol "exp(-1/3)" . },
    { :servo :poleLower 0.7165313105 . },
    { :servo :poleUpper 0.7165313106 . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 126 steps, 126 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 61; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 65; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 294; pe:failed 0 ].
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
eyeron examples/decimal-transcendental-servo-envelope.n3
eyeron -p examples/decimal-transcendental-servo-envelope.n3
eyeron -c examples/decimal-transcendental-servo-envelope.n3
```

---

## Takeaway

The rules propagate stated decimal bounds rather than substituting an exact
symbolic decay factor.
