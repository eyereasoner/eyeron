# Spectral Week

*How much energy two plants store in a week, worked out one product at a time.*

[spectral-week.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/spectral-week.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/spectral-week.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/spectral-week.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/spectral-week.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=spectral-week)

---

## The question

Plants use mostly red and blue light. A greenhouse gives many hours of strong
light; a shady spot gives less. A sunflower grows in the greenhouse, a fern
in the shade, and each absorbs red and blue in its own proportion and turns a
quarter of what it absorbs into stored energy. The numbers are illustrative,
in made-up units.

**How much energy does each plant store in a week?**

---

## What we tell Eyeron

Each location's light, as hours per day and intensity per hour:

```n3
:Greenhouse :redHours 8.0 ;
    :blueHours 2.0 ;
    :redIntensity 120.0 ;
    :blueIntensity 200.0 .
```

Each plant's place, absorption and conversion:

```n3
:Sunflower a :Plant ;
    :location :Greenhouse ;
    :absorbRed 0.85 ;
    :absorbBlue 0.55 ;
    :conversion 0.25 .
```

The `;` repeats the subject for the next statement. Then seven small rules,
each doing one multiplication or addition with the `math:` built-ins. The
first gives a location's daily red energy:

```n3
{
    ?Loc :redIntensity ?RI ;
        :redHours ?RH .
    (?RI ?RH) math:product ?Ered .
} => {
    ?Loc :redEnergy ?Ered .
} .
```

The others follow the comments in the program: blue energy, the red and blue
energy each plant absorbs, their sum, the daily stored energy (absorbed ×
conversion) and the weekly one:

```n3
{
    ?P :dailyStored ?D .
    (?D 7) math:product ?W .
} => {
    ?P :weeklyStored ?W .
} .
```

---

## What Eyeron concludes

Every intermediate value is printed, ending in the weekly totals:

```n3
:Greenhouse :redEnergy "960"^^xsd:decimal .
:Sunflower :absorbedEnergy "1036"^^xsd:decimal .
:Sunflower :dailyStored "259"^^xsd:decimal .
:Fern :dailyStored "33"^^xsd:decimal .
:Sunflower :weeklyStored "1813"^^xsd:decimal .
:Fern :weeklyStored "231"^^xsd:decimal .
```

For the sunflower: 120 × 8 = 960 red and 200 × 2 = 400 blue; it absorbs
960 × 0.85 = 816 and 400 × 0.55 ≈ 220, together 1036; a quarter is 259 a day,
1813 a week.

One value shows the arithmetic is binary floating point underneath:

```n3
:Sunflower :absorbedBlue "220.00000000000003"^^xsd:decimal .
```

400 × 0.55 is not exactly representable that way, and the tiny error shows
in this intermediate value; the sum after it rounds back to 1036.

---

## The proof, step by step

The proof has 46 steps: 14 rule steps, 14 built-in steps and 18 facts. Each
derived value cites its rule, its inputs and the calculation:

```n3
{ :Sunflower :weeklyStored "1813"^^xsd:decimal . }
  pe:rule 7;
  pe:binding
    [ pe:var "D"; pe:value "259"^^xsd:decimal ],
    [ pe:var "P"; pe:value :Sunflower ],
    [ pe:var "W"; pe:value "1813"^^xsd:decimal ];
  pe:uses
    { :Sunflower :dailyStored "259"^^xsd:decimal . },
    { ("259"^^xsd:decimal 7) math:product "1813"^^xsd:decimal . }.

{ ("259"^^xsd:decimal 7) math:product "1813"^^xsd:decimal . }
  pe:builtin math:product.
```

and so on back to the light hours of each location.

---

## Checked: what the report says

```n3
# checked: 46 steps, 46 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 14; pe:failed 0 ];
```

- **C1 resolution**: the 14 rule steps are the program's rules under their
  bindings, and the 18 facts are in the program.
- **C5 re-decision**: the checker recomputes all 14 products and sums itself.
- **C2**, **C3**, **C4** and **C7**: the steps form a proper, fully covered
  tree with nothing extra; **C10** confirms the 14 answers as derived.

No negation or invented individual is involved. All 46 steps are verified:
the verdict is **checked**.

---

## Try it

```sh
eyeron examples/spectral-week.n3      # the answer
eyeron -p examples/spectral-week.n3   # the answer with its proof
eyeron -c examples/spectral-week.n3   # the proof, checked
```

Move the fern into the greenhouse (`:location :Greenhouse` in its
description): it then stores 171 a day and 1197 a week.

---

## Takeaway

A long calculation becomes a chain of small, named steps, and each one is
recomputed by the checker, so every intermediate number can be traced and
trusted.
