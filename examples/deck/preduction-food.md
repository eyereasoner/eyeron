# Classifying food from vocabulary declarations

[preduction-food.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/preduction-food.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/preduction-food.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/preduction-food.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/preduction-food.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=preduction-food)

---

## The question

A small food model describes class relationships and sample instances. N3
rules interpret the declarations and derive the food classifications selected
by the query.

**Which classifications follow when the rules interpret the food vocabulary?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Five unnamed individuals supply the starting food classifications.
_:g a food:Grape .

# Interpret subclass declarations: each member also belongs to its superclass.
{
    ?C rdfs:subClassOf ?D .
    ?X a ?C
} => {
    ?X a ?D
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
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value food:Grape ],
    [ pe:var "D"; pe:value food:SweetFruit ],
    [ pe:var "X"; pe:value _:g ];
  pe:uses
    { food:Grape rdfs:subClassOf food:SweetFruit . },
    { _:g a food:Grape . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 30 steps, 30 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 30; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 64; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/preduction-food.n3
eyeron -p examples/preduction-food.n3
eyeron -c examples/preduction-food.n3
```

---

## Takeaway

The vocabulary declarations gain their behavior from the explicit interpreting
rules.
