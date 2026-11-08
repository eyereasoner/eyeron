# Comparing screening-confidence models

[screening-trust-worlds.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/screening-trust-worlds.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/screening-trust-worlds.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/screening-trust-worlds.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/screening-trust-worlds.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=screening-trust-worlds)

---

## The question

Several model worlds judge sample screening scenarios. N3 arithmetic rules
compare a prevalence-aware Bayes calculation with simplified confidence
criteria and derive world-specific judgments.

**Which screening judgments change when prevalence is included?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Worlds and scenarios
:World a rdfs:Class .

# Bayes PPV computation (World 0 and World 3 use this)
#
# PPV = Se * p / (Se * p + (1 - Sp) * (1 - p))
{
    ?S :ppv_Bayes ?PPV .
} <= {
    ?S a :Scenario ;
        :prevalence ?p ;
        :sensitivity ?Se ;
        :specificity ?Sp .

    # numerator = Se * p
    (?Se ?p) math:product ?num .

    # pNeg = 1 - p
    (1.0 ?p) math:difference ?pNeg .

    # fpr = 1 - Sp  (false-positive rate)
    (1.0 ?Sp) math:difference ?fpr .
…

    # PPV = num / denom
    (?num ?denom) math:quotient ?PPV .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called. The ellipsis omits part of the source; the
linked file contains the full program.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:HighRiskClinic :trustsPositiveInWorld :W0 .
:CommonMassGoodTest :trustsPositiveInWorld :W0 .
:CommonMassGoodTest :rejectsPositiveInWorld :W3 .
:CommonMassLowSpec :rejectsPositiveInWorld :W3 .
:RareMassScreening :trustsPositiveInWorld :W1 .
:HighRiskClinic :trustsPositiveInWorld :W1 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :HighRiskClinic :trustsPositiveInWorld :W0 . }
  pe:rule 2;
  pe:binding
    [ pe:var "PPV"; pe:value 0.9166666666666666 ],
    [ pe:var "S"; pe:value :HighRiskClinic ];
  pe:uses
    { :HighRiskClinic :ppv_Bayes 0.9166666666666666 . },
    { 0.9166666666666666 math:notLessThan 0.9 . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 73 steps, 73 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 36; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 37; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 116; pe:failed 0 ].
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
eyeron examples/screening-trust-worlds.n3
eyeron -p examples/screening-trust-worlds.n3
eyeron -c examples/screening-trust-worlds.n3
```

---

## Takeaway

Comparing worlds makes the assumptions behind a confidence label visible.
