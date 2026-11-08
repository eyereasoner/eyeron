# Scoring illustrative diagnoses

*Naive Bayes by hand: multiply, compare, and let a checker redo the sums.*

[bayes-diagnosis.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/bayes-diagnosis.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/bayes-diagnosis.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/bayes-diagnosis.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/bayes-diagnosis.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=bayes-diagnosis)

---

## The question

A patient has fever, a cough, a smell symptom and shortness of breath, and
is not sneezing. Four conditions could explain it: COVID-19, influenza,
allergic rhinitis and bacterial pneumonia.

A simple way to weigh them is *naive Bayes*: start from how common each
condition is (its *prior*) and multiply by how likely each finding is if the
patient has it. The bigger the product, the better the condition fits.

**Which condition scores highest, and how do they rank?** The numbers are
made up for illustration; this is not medical guidance.

---

## What we tell Eyeron

One block of facts per condition: its prior, then the probability of each
finding given that condition.

```n3
:COVID19 :prior 0.05 ;
    :fever 0.70 ;
    :cough 0.65 ;
    :smell 0.40 ;
    :noSneezing 0.85 ;
    :breath 0.20 .
```

The score rule multiplies them one by one with the built-in `math:product`,
which Eyeron computes rather than looks up:

```n3
    (?prior ?fever) math:product ?p1 .
    (?p1 ?cough) math:product ?p2 .
    …
    (?p4 ?breath) math:product ?score .
} => {
    ?d :score ?score
} .
```

`?d` matches every condition, so one rule scores all four. The scores are
not divided by their total (not *normalized*), so they are not
probabilities; only their sizes relative to each other and to the
thresholds matter.

---

## Thresholds

Four more rules turn a score into labels:

```n3
{
    ?d :score ?score .
    ?score math:notLessThan 0.001
} => {
    ?d :screenedIn true
} .
```

and a rank: `"high"` from 0.0015, `"medium"` from 0.0005 up to 0.0015, and
`"low"` below 0.0005. The ranges do not overlap, so each condition gets
exactly one rank.

---

## What Eyeron concludes

```n3
:COVID19 :score 0.0015470000000000002 .
:Influenza :score 0.00004800000000000001 .
:AllergicRhinitis :score 7.500000000000003e-7 .
:BacterialPneumonia :score 0.00004787999999999999 .
:COVID19 :screenedIn true .
:COVID19 :rank "high" .
:Influenza :rank "low" .
:AllergicRhinitis :rank "low" .
:BacterialPneumonia :rank "low" .
```

COVID-19 fits about 30 times better than the next condition, and is the only
one screened in. Influenza and bacterial pneumonia end up almost tied.
Allergic rhinitis is far behind: fever and the absence of sneezing are
unlikely with it.

The long tails such as `0.0015470000000000002` are ordinary floating-point
rounding: the products are computed in binary, and Eyeron prints them
exactly as computed.

---

## The proof, step by step

Each score is one rule step, with all the intermediate products as
bindings:

```n3
{ :COVID19 :score 0.0015470000000000002 . }
  pe:rule 1;
  pe:binding
    [ pe:var "breath"; pe:value 0.20 ],
    …
    [ pe:var "p1"; pe:value 0.034999999999999996 ],
    [ pe:var "p2"; pe:value 0.02275 ],
    [ pe:var "p3"; pe:value 0.0091 ],
    [ pe:var "p4"; pe:value 0.0077350000000000006 ],
    [ pe:var "prior"; pe:value 0.05 ],
    [ pe:var "score"; pe:value 0.0015470000000000002 ],
    [ pe:var "smell"; pe:value 0.40 ];
  pe:uses
    { :COVID19 :prior 0.05 . },
    …
    { (0.05 0.70) math:product 0.034999999999999996 . },
```

and each label rests on its score and a comparison:

```n3
{ :COVID19 :rank "high" . }
  pe:rule 3;
  …
  pe:uses
    { :COVID19 :score 0.0015470000000000002 . },
    { 0.0015470000000000002 math:notLessThan 0.0015 . }.
```

The whole proof has 58 steps: 9 rule steps, 24 facts and 25 built-in
results.

---

## Checked: what the report says

```n3
# checked: 58 steps, 58 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 33; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 25; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 9; pe:failed 0 ].
```

- **C5 re-decision**: the checker recomputes all 20 products and 5
  comparisons. A proof that inflated a score, or misplaced it against a
  threshold, would fail.
- **C1 resolution**: the 24 facts are in the file and the 9 rule steps match
  their rules.
- **C2, C3, C4, C7**: no circular steps, every step justified, every premise
  covered, nothing superfluous.
- **C10 call fidelity**: the 9 answers are checked as the program states
  them.

Nothing is taken on trust: the verdict is **checked**. It vouches for the
arithmetic and the rules, not for the made-up probabilities themselves.

---

## Try it

```sh
eyeron examples/bayes-diagnosis.n3      # the scores and ranks
eyeron -p examples/bayes-diagnosis.n3   # with the proof
eyeron -c examples/bayes-diagnosis.n3   # the proof, checked
```

Make influenza far more common, `:Influenza :prior 0.50`: its score rises to
0.0008 and its rank to `"medium"`, still below the screening threshold.

---

## Takeaway

A score is only as trustworthy as its arithmetic; here every multiplication
and comparison is written down and recomputed by the checker.
