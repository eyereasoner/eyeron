# Inferring an object's class from a property range

[rdfs-range.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdfs-range.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdfs-range.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdfs-range.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdfs-range.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdfs-range)

---

## The question

The teaches property has Subject as its range, and Alice teaches logic. An
explicit N3 rule follows that range declaration to derive that logic is a
subject.

**What does the teaches relationship imply about logic's class?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The teaches property has range Subject; Alice teaches logic.
:teaches rdfs:range :Subject .

{
    ?P rdfs:range ?C .
    ?X ?P ?Y
} => {
    ?Y a ?C
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:logic a :Subject .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :logic a :Subject . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :Subject ],
    [ pe:var "P"; pe:value :teaches ],
    [ pe:var "X"; pe:value :alice ],
    [ pe:var "Y"; pe:value :logic ];
  pe:uses
    { :teaches rdfs:range :Subject . },
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
eyeron examples/rdfs-range.n3
eyeron -p examples/rdfs-range.n3
eyeron -c examples/rdfs-range.n3
```

---

## Takeaway

The explicit range rule classifies the object of the property.
