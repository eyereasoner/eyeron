# Faltings' finiteness theorem

*Using a famous theorem as a rule, without pretending to prove it.*

[faltings-genus2-finiteness.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/faltings-genus2-finiteness.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/faltings-genus2-finiteness.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/faltings-genus2-finiteness.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/faltings-genus2-finiteness.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=faltings-genus2-finiteness)

---

## The question

The curve *y² = x(x+1)(x−2)(x+2)(x−3)* has some points whose coordinates are
fractions (rational points): for instance (0, 0) and (3, 0). Could it have
infinitely many?

In 1983 Gerd Faltings proved that a curve of *genus* two or more (here, an
equation like this one with a polynomial of degree five or six) has only
finitely many rational points over a number field. That proof is far beyond a
rule engine, but applying the theorem is not.

**Given the theorem as a rule, what does Eyeron conclude about this curve?**

---

## What we tell Eyeron

The curve, the field it is defined over, and five of its rational points:

```n3
:C a :Curve ;
    :equation "y^2 = x(x+1)(x-2)(x+2)(x-3)" ;
    :definedOver :Q ;
    :genus 2 ;
    rdfs:label "Example genus-2 curve" .

:Q a :NumberField ;
    rdfs:label "the rationals" .
…
:P4 a :RationalPoint ;
    :onCurve :C ;
    :x 3 ;
    :y 0 .
```

The genus is given as a fact; nothing here computes it from the equation.
The points are listed for the reader, and no rule uses them.

The theorem becomes a rule. `math:notLessThan` is a built-in comparison: it
holds when the genus is at least 2.

```n3
{
    ?curve a :Curve ;
        :definedOver ?field ;
        :genus ?g .
    ?field a :NumberField .
    ?g math:notLessThan 2 .
} => {
    ?curve :coveredBy :FaltingsTheorem ;
        :hasRationalPointsCardinality :Finite .
} .
```

A semicolon repeats the subject, so `?curve` has three properties here. A
second rule says the same conclusion in other words:

```n3
{
    ?curve :hasRationalPointsCardinality :Finite .
} => {
    ?curve :doesNotHaveInfinitelyManyRationalPoints true .
} .
```

---

## What Eyeron concludes

```n3
:C :coveredBy :FaltingsTheorem .
:C :hasRationalPointsCardinality :Finite .
:C :doesNotHaveInfinitelyManyRationalPoints true .
```

The curve falls under the theorem, so its rational points are finite in
number. Eyeron does not say how many there are, nor that the five listed are
all of them.

---

## The proof, step by step

```n3
{ :C :hasRationalPointsCardinality :Finite . }
  pe:rule 1;
  pe:binding
    [ pe:var "curve"; pe:value :C ],
    [ pe:var "field"; pe:value :Q ],
    [ pe:var "g"; pe:value 2 ];
  pe:uses
    { :C a :Curve . },
    { :C :definedOver :Q . },
    { :C :genus 2 . },
    { :Q a :NumberField . },
    { 2 math:notLessThan 2 . }.
…
{ 2 math:notLessThan 2 . }
  pe:builtin math:notLessThan.
```

The theorem's rule fires once and gives both of its conclusions; four facts
from the file and one comparison back it. The third answer comes from rule 2.
That is 8 steps in all.

---

## Checked: what the report says

```n3
# checked: 8 steps, 8 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
```

- **C1 resolution**: the rule steps match their rules and bindings, and the
  facts are in the file.
- **C5 re-decision**: the checker compared 2 with 2 again itself.
- **C2**, **C3**, **C4**, **C7** and **C10**: nothing is circular, unbacked,
  unaccounted for or irrelevant, and the conditions were checked as written.

The verdict is **checked**: the conclusion really follows from the rule as
stated. Whether the rule is a faithful statement of Faltings' theorem is a
question for mathematicians, not for the checker.

---

## Try it

```sh
eyeron examples/faltings-genus2-finiteness.n3
eyeron -c examples/faltings-genus2-finiteness.n3
```

Change `:genus 2 ;` into `:genus 1 ;` and run again: nothing is concluded.
Curves of genus one (elliptic curves) can have infinitely many rational
points, and the theorem says nothing about them.

---

## Takeaway

A rule can carry a proven theorem into a knowledge base, and the proof shows
exactly which facts made it apply, while being honest that the theorem
itself was taken as given.
