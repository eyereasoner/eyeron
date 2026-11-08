# Bounding an e-bike motor's temperature

[decimal-ebike-motor-thermal-envelope.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/decimal-ebike-motor-thermal-envelope.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/decimal-ebike-motor-thermal-envelope.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/decimal-ebike-motor-thermal-envelope.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/decimal-ebike-motor-thermal-envelope.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=decimal-ebike-motor-thermal-envelope)

---

## The question

An e-bike climb combines motor heating with cooling toward ambient
temperature. N3 arithmetic rules propagate the supplied decimal cooling bounds
and check the resulting temperature envelope.

**What motor temperatures are allowed by the supplied cooling bounds?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:ride a :EBikeThermalAssessment ;
    :samplePeriod "5.0"^^xsd:decimal ;
    :thermalTimeConstant "20.0"^^xsd:decimal ;
    :exactCoolingSymbol "exp(-1/4)" ;
…
    :initialMotorTemperature "33.0"^^xsd:decimal ;
    :warningLimit "35.0"^^xsd:decimal ;
    :hardLimit "45.0"^^xsd:decimal ;
    :maxStep 12 .

# The decimal interval is a finite certificate for exp(-1/4)
{
    :ride :coolingLower ?lo ;
        :coolingUpper ?hi .
    ?lo math:lessThan ?hi .
    ?lo math:greaterThan 0 .
    ?hi math:lessThan 1 .
} => {
    :ride :coolingCertificate :CertifiedDecimalInterval .
    :ride :contractiveCooling true .
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
:result :coolingStep 10 .
:result :coolingStep 11 .
:result :coolingStep 3 .
:result :coolingStep 4 .
:result :temperatureTrace (8 :Coast "34.24203310142329"^^xsd:decimal "34.242033106190284"^^xsd:decimal) .
:result :temperatureTrace (9 :Coast "32.197702615900376"^^xsd:decimal "32.19770262053712"^^xsd:decimal) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :summary ("cooling-symbol" "exp(-1/4)" "cooling-lower" 0.7788007830 "cooling-upper" 0.7788007831 "warning-limit-C" 35.0 "hard-limit-C" 45.0 "warning-recovery-step" 8 "warning-recovery-time-s" "40"^^xsd:decimal "decision" :ThermallySafeForThisAssistPlan) . }
  pe:rule
    {
        {
            :ride :exactCoolingSymbol ?sym .
            :ride :coolingLower ?aLo .
            :ride :coolingUpper ?aHi .
            :ride :warningLimit ?warn .
            :ride :hardLimit ?hard .
            :ride :firstRecoveredWarningAt ?k .
            :ride :firstRecoveredWarningTime ?t .
            :ride :rideDecision ?decision .
        } => {
            :result :summary ("cooling-symbol" ?sym "cooling-lower" ?aLo "cooling-upper" ?aHi "warning-limit-C" ?warn "hard-limit-C" ?hard "warning-recovery-step" ?k "warning-recovery-time-s" ?t "decision" ?decision) .
        } .
    };
  pe:binding
    [ pe:var "aHi"; pe:value 0.7788007831 ],
    [ pe:var "aLo"; pe:value 0.7788007830 ],
    [ pe:var "decision"; pe:value :ThermallySafeForThisAssistPlan ],
    [ pe:var "hard"; pe:value 45.0 ],
…
    { :ride :hardLimit 45.0 . },
    { :ride :firstRecoveredWarningAt 8 . },
    { :ride :firstRecoveredWarningTime "40"^^xsd:decimal . },
    { :ride :rideDecision :ThermallySafeForThisAssistPlan . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 210 steps, 210 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 94; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 116; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 435; pe:failed 0 ].
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
eyeron examples/decimal-ebike-motor-thermal-envelope.n3
eyeron -p examples/decimal-ebike-motor-thermal-envelope.n3
eyeron -c examples/decimal-ebike-motor-thermal-envelope.n3
```

---

## Takeaway

A finite temperature envelope carries uncertainty in the cooling factor
through the calculation.
