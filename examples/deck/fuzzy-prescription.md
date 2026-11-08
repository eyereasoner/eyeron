# Combining illustrative fuzzy conditions

[fuzzy-prescription.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/fuzzy-prescription.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/fuzzy-prescription.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/fuzzy-prescription.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/fuzzy-prescription.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=fuzzy-prescription)

---

## The question

Sample symptom and contraindication scores describe a historical toy
prescribing model. N3 rules combine fuzzy values and scoped tests to derive
its sample conclusions; this is not medical guidance.

**Which labels pass the toy model's indication and exclusion thresholds?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The supplied scores are illustrative membership values between zero and one.
(:Ann :Fever) fl:mu 0.8 .

# Require an indication above 0.7 and every listed exclusion at or below
# 0.01. The resulting labels describe this toy model only.
{
    ?Medication :prescribedFor ?Diagnosis .
    (?Who ?Diagnosis) fl:mu ?Membership .
    ?Membership math:greaterThan 0.7 .
    (
        {
            ?Medication :excludedFor ?Exclusion
        }
        {
            (?Who ?Exclusion) fl:mu ?Value .
            ?Value math:notGreaterThan 0.01
        }
    ) log:forAllIn ?SCOPE .
} => {
    ?Who :isPrescribed ?Medication
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:Joe :isPrescribed :aspirinLowDose .
:Joe :isPrescribed :betaBlocker .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Joe :isPrescribed :aspirinLowDose . }
  pe:rule 1;
  pe:binding
    [ pe:var "Diagnosis"; pe:value :AcuteMyocardialInfarction ],
    [ pe:var "Medication"; pe:value :aspirinLowDose ],
    [ pe:var "Membership"; pe:value 0.9 ],
    [ pe:var "SCOPE"; pe:value _:forAllIn ],
    [ pe:var "Who"; pe:value :Joe ];
  pe:uses
    { :aspirinLowDose :prescribedFor :AcuteMyocardialInfarction . },
    { (:Joe :AcuteMyocardialInfarction) fl:mu 0.9 . },
    { 0.9 math:greaterThan 0.7 . },
    {
        ({
            :aspirinLowDose :excludedFor ?Exclusion .
        } {
            (:Joe ?Exclusion) fl:mu ?Value .
            ?Value math:notGreaterThan 0.01 .
        }) log:forAllIn _:forAllIn .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 8 steps, 8 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
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
eyeron examples/fuzzy-prescription.n3
eyeron -p examples/fuzzy-prescription.n3
eyeron -c examples/fuzzy-prescription.n3
```

---

## Takeaway

The labels describe the supplied historical toy rulebook, rather than a
treatment recommendation.
