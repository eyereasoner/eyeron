# Classifying food with direct rules

[preduction-food-direct.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/preduction-food-direct.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/preduction-food-direct.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/preduction-food-direct.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/preduction-food-direct.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=preduction-food-direct)

---

## The question

Sample foods are classified using explicitly written N3 implications. Eyeron
follows those subclass-style rules to derive additional food categories and
their consequences.

**Which food classifications follow from the directly stated implications?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Five unnamed individuals supply the starting food classifications.
_:g a food:Grape .

# Each implication states one classification consequence directly.
# Repeated firings carry a food through the applicable category chains.
{
    ?U_0 a food:EdibleThing .
} => {
    ?U_0 a food:ConsumableThing .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
_:g a food:Grape .
_:cnd a food:CheeseNutsDessert .
_:pwlcs a food:EdibleThing .
_:pwlcs a food:ConsumableThing .
_:pwlcs a food:PastaWithLightCreamSauce .
_:ct a food:ConsumableThing .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ _:g a food:SweetFruit . }
  pe:rule 4;
  pe:binding [ pe:var "U_3"; pe:value _:g ];
  pe:uses { _:g a food:Grape . }.
```

`pe:rule 4` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 16 steps, 16 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 16; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 38; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/preduction-food-direct.n3
eyeron -p examples/preduction-food-direct.n3
eyeron -c examples/preduction-food-direct.n3
```

---

## Takeaway

A chain of written implications can express the classification model without
interpreting vocabulary declarations.
