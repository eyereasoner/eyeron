# Classifying every value of a restricted property

[owl-all-values-from.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-all-values-from.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-all-values-from.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-all-values-from.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-all-values-from.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-all-values-from)

---

## The question

A cat owner has a pet, and cat is a subclass of animal. Explicit N3 rules
interpret the supplied OWL restriction facts to derive value types and related
restriction consequences.

**Which types follow for the values of the restricted pet property?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Alice is a cat owner with the pet Milo; cats are animals.
:CatOwner owl:onProperty :hasPet ;
    owl:allValuesFrom :Cat .

{
    ?C owl:allValuesFrom ?Y .
    ?C owl:onProperty ?P .
    ?U a ?C .
    ?U ?P ?V
} => {
    ?V a ?Y
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:CatOwner rdfs:subClassOf :AnimalOwner .
:milo a :Cat .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :milo a :Cat . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :CatOwner ],
    [ pe:var "P"; pe:value :hasPet ],
    [ pe:var "U"; pe:value :alice ],
    [ pe:var "V"; pe:value :milo ],
    [ pe:var "Y"; pe:value :Cat ];
  pe:uses
    { :CatOwner owl:allValuesFrom :Cat . },
    { :CatOwner owl:onProperty :hasPet . },
    { :alice a :CatOwner . },
    { :alice :hasPet :milo . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 9 steps, 9 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-all-values-from.n3
eyeron -p examples/owl-all-values-from.n3
eyeron -c examples/owl-all-values-from.n3
```

---

## Takeaway

The OWL vocabulary is interpreted by the explicit N3 rules included in this
example.
