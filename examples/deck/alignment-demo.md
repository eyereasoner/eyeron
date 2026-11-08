# Aligning traffic categories

[alignment-demo.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/alignment-demo.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/alignment-demo.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/alignment-demo.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/alignment-demo.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=alignment-demo)

---

## The question

Two traffic datasets use different category names. N3 rules follow SKOS
concept mappings to derive a shared reporting category and carry that
alignment to more specific categories.

**How can two traffic vocabularies support the same reporting category?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 1) Minimal concepts (3 schemes)
ref:Car a skos:Concept ;
    skos:prefLabel "Car (reference reporting class)"@en .

# 3) Generic SKOS-ish rules needed for alignment reasoning
# Treat skos:broadMatch as a "broader-than" link for roll-up
{
    ?a skos:broadMatch ?b .
} => {
    ?a skos:broader ?b .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
ref:Car ex:narrowerOrEqualOf ref:Car .
tel:Car ex:narrowerOrEqualOf tel:Car .
anpr:VehicleWithPlate ex:rollsUpTo ref:Car .
anpr:PassengerCar ex:rollsUpTo ref:Car .
tel:HeavyVehicle ex:narrowerOrEqualOf tel:HeavyVehicle .
anpr:VehicleWithPlate ex:narrowerOrEqualOf anpr:VehicleWithPlate .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ref:Car ex:narrowerOrEqualOf ref:Car . }
  pe:rule 9;
  pe:binding [ pe:var "c"; pe:value ref:Car ];
  pe:uses { ref:Car a skos:Concept . }.
```

`pe:rule 9` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 41 steps, 41 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 41; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 32; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/alignment-demo.n3
eyeron -p examples/alignment-demo.n3
eyeron -c examples/alignment-demo.n3
```

---

## Takeaway

Explicit mapping rules make the vocabulary alignment inspectable.
