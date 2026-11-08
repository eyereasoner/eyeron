# Inferring a subject's class from a property domain

[rdfs-domain.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdfs-domain.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdfs-domain.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdfs-domain.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdfs-domain.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdfs-domain)

---

## The question

The teaches property has Teacher as its domain, and Alice teaches logic. An
explicit N3 rule follows that domain declaration to derive that Alice is a
teacher.

**What does Alice's teaches relationship imply about Alice's class?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The teaches property has domain Teacher; Alice teaches logic.
:teaches rdfs:domain :Teacher .

{
    ?P rdfs:domain ?C .
    ?X ?P ?Y
} => {
    ?X a ?C
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:alice a :Teacher .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :alice a :Teacher . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :Teacher ],
    [ pe:var "P"; pe:value :teaches ],
    [ pe:var "X"; pe:value :alice ],
    [ pe:var "Y"; pe:value :logic ];
  pe:uses
    { :teaches rdfs:domain :Teacher . },
    { :alice :teaches :logic . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/rdfs-domain.n3
eyeron -p examples/rdfs-domain.n3
eyeron -c examples/rdfs-domain.n3
```

---

## Takeaway

The explicit domain rule classifies the subject of the property.
