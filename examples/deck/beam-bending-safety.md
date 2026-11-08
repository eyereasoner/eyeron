# Checking a beam's bending stress

*Four beams, one formula, and a safety verdict for each that a checker recomputes.*

[beam-bending-safety.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/beam-bending-safety.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/beam-bending-safety.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/beam-bending-safety.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/beam-bending-safety.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=beam-bending-safety)

---

## The question

A beam rests on two supports and carries a load in the middle. The load
bends it, and bending stretches the bottom of the beam and squeezes the top.
That *bending stress* must stay below what the material allows.

Textbook mechanics gives the numbers for a rectangular beam:

- the largest bending moment is M = P × L / 4 (load times span, over four);
- the beam's resistance, its *section modulus*, is S = b × h² / 6 (width
  times height squared, over six);
- the stress is σ = M / S, and the *safety factor* is allowed stress ÷ σ.

**Which of four beam designs are safe?**

---

## What we tell Eyeron

Four designs, all allowed a stress of 12000. For example:

```n3
:FloorBase a :BeamDesign ;
    :description "base floor beam under design load" ;
    :span 3.0 ;
    :pointLoad 5.0 ;
    :width 0.05 ;
    :height 0.2 ;
    :allowableStress 12000.0 .
```

`FloorOverload` is the same beam with a load of `10.0`; `FloorTall` has the
base load on a beam `0.3` tall; `ShelfLight` is a short shelf with a light
load.

The formulas are *backward rules*, written with `<=`: the conclusion comes
first, and Eyeron works it out only when something asks for it.

```n3
{
    ?B :sectionModulus ?S .
} <= {
    ?B a :BeamDesign ;
        :width ?b ;
        :height ?h .

    (?h 2) math:exponentiation ?h2 .
    (?b ?h2) math:product ?bh2 .
    (?bh2 6.0) math:quotient ?S .
} .
```

The `math:` predicates are built-ins that compute: `(?h 2)
math:exponentiation ?h2` squares the height.

---

## Safe or not, and what to print

Two rules decide the verdict, one for each side of the limit:

```n3
{
    ?B :isSafe true .
} <= {
    ?B :bendingStress ?sigma ;
        :allowableStress ?allow .
    ?sigma math:notGreaterThan ?allow .
} .
```

The program ends with three queries. `log:query` says which statements to
print, and asking them is what sets the backward rules in motion:

```n3
{
    ?Subject :isSafe ?Value .
} log:query {
    ?Subject :isSafe ?Value .
} .
```

---

## What Eyeron concludes

```n3
:ShelfLight :bendingStress 8333.333333333334 .
:FloorBase :bendingStress 11249.999999999996 .
:FloorOverload :bendingStress 22499.999999999993 .
:FloorTall :bendingStress 5000.000000000001 .
:ShelfLight :safetyFactor 1.44 .
:FloorBase :safetyFactor 1.066666666666667 .
:FloorOverload :safetyFactor 0.5333333333333335 .
:FloorTall :safetyFactor 2.3999999999999995 .
:ShelfLight :isSafe true .
:FloorBase :isSafe true .
:FloorTall :isSafe true .
:FloorOverload :isSafe false .
```

The base floor beam is just safe, with a factor of about 1.07. Doubling the
load doubles the stress, to almost twice the limit. Making the beam 1.5
times taller instead cuts the stress to 5000, because resistance grows with
the *square* of the height. The odd trailing digits are floating-point
rounding.

The intermediate moments and section moduli are not printed: the queries do
not ask for them.

---

## The proof, step by step

Each answer unfolds into the chain of formulas behind it. The shelf's
stress, for instance, is rule 3 applied to a moment and a section modulus:

```n3
{ :ShelfLight :bendingStress 8333.333333333334 . }
  pe:rule 3;
  …
  pe:uses
    { :ShelfLight :maxMoment 0.2 . },
    { :ShelfLight :sectionModulus 0.000024 . },
    { (0.2 0.000024) math:quotient 8333.333333333334 . }.
```

and the moment in turn comes from rule 1, the given facts and two
calculations:

```n3
{ :ShelfLight :maxMoment 0.2 . }
  pe:rule 1;
  …
  pe:uses
    { :ShelfLight a :BeamDesign . },
    { :ShelfLight :span 0.8 . },
    { :ShelfLight :pointLoad 1.0 . },
    { (1.0 0.8) math:product 0.8 . },
    { (0.8 4.0) math:quotient 0.2 . }.
```

The failing verdict is just as explicit:

```n3
{ :FloorOverload :isSafe false . }
  pe:rule 6;
  …
    { 22499.999999999993 math:greaterThan 12000.0 . }.
```

In all: 71 steps, of which 20 rule steps, 24 facts and 27 built-in results.

---

## Checked: what the report says

```n3
# checked: 71 steps, 71 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 44; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 27; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 112; pe:failed 0 ].
```

- **C5 re-decision**: the checker redoes all 27 calculations and comparisons:
  a proof cannot understate a stress or call 22500 less than 12000.
- **C1 resolution**: every fact is in the file and every rule step matches
  its backward rule under the recorded values.
- **C10 call fidelity**: the 12 answers are what the three queries ask
  for, and the rule steps behind them are the calls those rules make.
- **C2, C3, C4, C7**: no circular steps, each properly justified, every
  premise covered, nothing superfluous.

Nothing is taken on trust, so the verdict is **checked**. It confirms the
arithmetic and the verdicts under this simple model; it says nothing about
whether the model fits a real beam.

---

## Try it

```sh
eyeron examples/beam-bending-safety.n3      # the answers
eyeron -p examples/beam-bending-safety.n3   # with the proof
eyeron -c examples/beam-bending-safety.n3   # the proof, checked
```

Give `FloorOverload` a height of `0.3` instead of `0.2`: its stress drops
to 10000 and it becomes safe, with a factor of about 1.2.

---

## Takeaway

Backward rules let formulas be written once and computed on demand; the
proof keeps every intermediate number, and the checker redoes each one.
