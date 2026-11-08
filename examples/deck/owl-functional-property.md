# Functional Property

*One birthplace, two spellings: Ghent and Gent are the same city.*

[owl-functional-property.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-functional-property.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-functional-property.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-functional-property.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-functional-property.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-functional-property)

---

## The question

Everyone is born in exactly one place. In OWL, a property that can have at
most one value per subject is an `owl:FunctionalProperty`.

Two sources recorded Alice's birthplace: one wrote `:Ghent`, the other
`:Gent` (the Dutch spelling). If birthplace is functional, these cannot be
two different places.

**What may we conclude about Ghent and Gent?**

---

## What we tell Eyeron

```n3
:birthplace a owl:FunctionalProperty .
:alice :birthplace :Ghent, :Gent .
```

The comma is N3 shorthand: it repeats subject and predicate, so the second
line states two facts.

The rule says: when a functional property gives one subject two values,
those values are the same thing (`owl:sameAs`).

```n3
{
    ?P a owl:FunctionalProperty .
    ?S ?P ?X .
    ?S ?P ?Y
} => {
    ?X owl:sameAs ?Y
} .
```

A second rule ends in `false` instead of conclusions. That is an *inference
fuse*: if its left side ever holds, the data contradicts itself, and Eyeron
stops with an error rather than carry on.

```n3
{
    ?P a owl:FunctionalProperty .
    ?S ?P ?X .
    ?S ?P ?Y .
    ?X owl:differentFrom ?Y
} => false .
```

---

## What Eyeron concludes

```n3
:Ghent owl:sameAs :Gent .
:Gent owl:sameAs :Ghent .
```

It also concludes that each name is the same as itself:

```n3
:Ghent owl:sameAs :Ghent .
:Gent owl:sameAs :Gent .
```

Nothing in the rule asks `?X` and `?Y` to differ, so both may match the same
value. Those two statements are harmless, and true, but they show that a
rule says exactly what it says. The fuse never fires: nothing states that
the two places are different.

---

## The proof, step by step

```n3
{ :Ghent owl:sameAs :Gent . }
  pe:rule 1;
  pe:binding
    [ pe:var "P"; pe:value :birthplace ],
    [ pe:var "S"; pe:value :alice ],
    [ pe:var "X"; pe:value :Ghent ],
    [ pe:var "Y"; pe:value :Gent ];
  pe:uses
    { :birthplace a owl:FunctionalProperty . },
    { :alice :birthplace :Ghent . },
    { :alice :birthplace :Gent . }.
```

Rule 1, with `P` as birthplace, `S` as Alice and the two spellings as `X`
and `Y`, applied to three given facts. The proof has 7 steps: one rule step
per conclusion, and the 3 facts.

---

## Checked: what the report says

```n3
# checked: 7 steps, 7 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 7; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 1; pe:failed 0 ];
```

- **C1 resolution**, **C2 well-foundedness**, **C3 justification** and
  **C4 coverage**: each step is what it cites, there are no cycles, and every
  premise and claim resolves to a step or a given fact.
- **C6 boundary consistency** looked at the program's one fuse: the facts
  the proof relies on do not satisfy its left side, so the proof does not
  rest on contradictory data.
- **C7 relevance** and **C10 call fidelity**: every step serves a claim,
  and the 4 rule steps make only the calls their rule makes.

The verdict is **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/owl-functional-property.n3      # the conclusions
eyeron -p examples/owl-functional-property.n3   # with the proof
eyeron -c examples/owl-functional-property.n3   # the proof, checked
```

Add `:Ghent owl:differentFrom :Gent .` and run again: the fuse fires,
Eyeron prints the rule and the matched instance, and exits with code 65
instead of giving conclusions.

---

## Takeaway

A functional property turns two values into one identity, and a fuse makes
sure that identity is not contradicted by the data.
