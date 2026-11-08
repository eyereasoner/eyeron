# Comparing exoplanet-validation models

[exoplanet-validation-worlds.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/exoplanet-validation-worlds.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/exoplanet-validation-worlds.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/exoplanet-validation-worlds.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/exoplanet-validation-worlds.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=exoplanet-validation-worlds)

---

## The question

Candidate signals are assessed under several probability models. N3 rules
derive world-specific confidence judgments and compare a Bayes-based reference
with simplified validation criteria.

**Which candidate judgments differ across the probability models?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Worlds and candidates
:World a rdfs:Class .

# Bayes PPV computation (used by W0 and W3)
#
# PPV = Se * pOcc / (Se * pOcc + (1 - Sp) * (1 - pOcc))
{
    ?C :ppv_Planet ?PPV .
} <= {
    ?C a :Candidate ;
        :occurrence ?pOcc ;
        :sensitivity ?Se ;
        :specificity ?Sp .

    # numerator = Se * pOcc
    (?Se ?pOcc) math:product ?num .

    # pNo = 1 - pOcc
    (1.0 ?pOcc) math:difference ?pNo .

    # fpr = 1 - Sp  (false-positive rate of pipeline)
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
:MstarShortPeriod :confirmsInWorld :W0 .
:CommonHotNeptuneGood :confirmsInWorld :W0 .
:CommonHotNeptuneGood :rejectsInWorld :W3 .
:CommonHotNeptuneLowSpec :rejectsInWorld :W3 .
:RareWideOrbit :confirmsInWorld :W1 .
:MstarShortPeriod :confirmsInWorld :W1 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :MstarShortPeriod :confirmsInWorld :W0 . }
  pe:rule 2;
  pe:binding
    [ pe:var "C"; pe:value :MstarShortPeriod ],
    [ pe:var "PPV"; pe:value 0.9611650485436893 ];
  pe:uses
    { :MstarShortPeriod :ppv_Planet 0.9611650485436893 . },
    { 0.9611650485436893 math:notLessThan 0.9 . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 75 steps, 75 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 36; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 39; pe:failed 0 ];
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
eyeron examples/exoplanet-validation-worlds.n3
eyeron -p examples/exoplanet-validation-worlds.n3
eyeron -c examples/exoplanet-validation-worlds.n3
```

---

## Takeaway

A confidence judgment depends on the chosen validation model and its supplied
evidence.
