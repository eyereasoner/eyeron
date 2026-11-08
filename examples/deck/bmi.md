# Calculating an illustrative body mass index

*A small calculation, rounded and categorized, with every sum rechecked.*

[bmi.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/bmi.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/bmi.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/bmi.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/bmi.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=bmi)

---

## The question

Body mass index (BMI) is weight in kilograms divided by the square of height
in metres. Adult BMI values are grouped into bands: below 18.5 is
underweight, 18.5 up to 25 normal, 25 up to 30 overweight, and so on.

Someone weighs 72 kg and is 178 cm tall.

**What is their BMI, which band is it in, and what weight range would count
as healthy at that height?** (An illustration of arithmetic, not medical
advice.)

---

## What we tell Eyeron

```n3
:input :weight 72.0 ;
    :height 178.0 .
```

The first rule does the arithmetic with *built-ins*, predicates that Eyeron
computes. `(a b) math:quotient ?q` binds `?q` to a ÷ b; `math:product`
multiplies:

```n3
{
    :input :weight ?weight ;
        :height ?heightCm .
    (?heightCm 100.0) math:quotient ?meters .
    (?meters ?meters) math:product ?heightSquared .
    (?weight ?heightSquared) math:quotient ?bmi .
    (18.5 ?heightSquared) math:product ?healthyMin .
    (24.9 ?heightSquared) math:product ?healthyMax .
} => {
    :case :bmi ?bmi ;
        :healthyMin ?healthyMin ;
        :healthyMax ?healthyMax
} .
```

The healthy band runs the formula backwards: the weights that give a BMI of
18.5 and 24.9 at this height.

---

## Rounding and the categories

Three rules round the results for display: scale up, `math:rounded` to a
whole number, scale back down.

```n3
    (?bmi 100.0) math:product ?bmiScaled .
    ?bmiScaled math:rounded ?bmiInt .
    (?bmiInt 100.0) math:quotient ?bmiRounded .
```

Six rules give the category, each testing one range. The ranges do not
overlap, so exactly one rule fires:

```n3
{
    :case :bmi ?bmi .
    ?bmi math:notLessThan 18.5 .
    ?bmi math:lessThan 25.0
} => {
    :case :category "normal"
} .
```

---

## What Eyeron concludes

```n3
:case :bmi 22.724403484408533 .
:case :healthyMin 58.6154 .
:case :healthyMax 78.89316 .
:case :bmiRounded 22.72 .
:case :category "normal" .
:case :healthyMinRounded 58.6 .
:case :healthyMaxRounded 78.9 .
```

A BMI of 22.72, in the normal band; at 178 cm, weights from about 58.6 to
78.9 kg fall in the healthy band. The unrounded values show the full
precision of the computation.

---

## The proof, step by step

Each answer is a rule step that lists the built-in results it relied on.
The category, for example, comes from rule 6 and two comparisons:

```n3
{ :case :category "normal" . }
  pe:rule 6;
  pe:binding [ pe:var "bmi"; pe:value 22.724403484408533 ];
  pe:uses
    { :case :bmi 22.724403484408533 . },
    { 22.724403484408533 math:notLessThan 18.5 . },
    { 22.724403484408533 math:lessThan 25.0 . }.
```

and the BMI itself rests on the measurements and the arithmetic:

```n3
    { (178.0 100.0) math:quotient 1.78 . },
    { (1.78 1.78) math:product 3.1684 . },
    { (72.0 3.1684) math:quotient 22.724403484408533 . },
```

In all, the proof has 25 steps: 7 rule steps, 2 facts and 16 built-in
results.

---

## Checked: what the report says

```n3
# checked: 25 steps, 25 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 9; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 16; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 7; pe:failed 0 ].
```

- **C5 re-decision**: the checker redoes all 16 calculations and
  comparisons. A proof that claimed 72 ÷ 3.1684 were 20, or that 22.72 is
  below 18.5, would be rejected.
- **C1 resolution**: the 2 facts are in the file and the 7 rule steps match
  their rules under the recorded bindings.
- **C2, C3, C4, C7**: no circular steps, each step properly justified, every
  premise covered, nothing superfluous.
- **C10 call fidelity**: the 7 answers are checked as the program states
  them.

Nothing is taken on trust, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/bmi.n3      # the answer
eyeron -p examples/bmi.n3   # with its proof
eyeron -c examples/bmi.n3   # the proof, checked
```

Change the weight to `95.0`: the BMI becomes 29.98 and the category
`"overweight"`, while the healthy band, which depends only on height, stays
58.6 to 78.9.

---

## Takeaway

Even a plain calculation benefits from a proof: every division, rounding and
comparison is recorded, and the checker redoes each one.
