# Following a chain of classes

[rdfs-subclass-closure.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdfs-subclass-closure.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdfs-subclass-closure.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdfs-subclass-closure.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdfs-subclass-closure.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdfs-subclass-closure)

---

## The question

Cat is a subclass of mammal, which is a subclass of animal. Explicit N3 rules
extend the class hierarchy and derive inherited memberships and related range
consequences.

**Which class links and memberships follow through the hierarchy?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Milo is a cat; Cat is below Mammal, which is below Animal.
:Cat rdfs:subClassOf :Mammal .

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

These are the saved conclusions.

```n3
:milo a :Mammal .
:Cat rdfs:subClassOf :Animal .
:milo a :Animal .
:pet rdfs:range :Animal .
:pet rdfs:range :Mammal .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :milo a :Mammal . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :Cat ],
    [ pe:var "D"; pe:value :Mammal ],
    [ pe:var "X"; pe:value :milo ];
  pe:uses
    { :Cat rdfs:subClassOf :Mammal . },
    { :milo a :Cat . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 9 steps, 9 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/rdfs-subclass-closure.n3
eyeron -p examples/rdfs-subclass-closure.n3
eyeron -c examples/rdfs-subclass-closure.n3
```

---

## Takeaway

Recursive subclass rules extend declarations and pass classifications along
them.
