# Deriving differences from disjoint classes

[owl-disjoint-classes.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-disjoint-classes.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-disjoint-classes.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-disjoint-classes.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-disjoint-classes.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-disjoint-classes)

---

## The question

Cats and dogs are declared disjoint, with one member of each. Explicit N3
rules derive that their members differ and include a fuse for membership in
both classes.

**Which members must be different when their classes are disjoint?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Milo is a cat and Fido is a dog; their classes are disjoint.
:Cat owl:disjointWith :Dog .

{
    ?A owl:disjointWith ?B .
    ?X a ?A .
    ?Y a ?B
} => {
    ?X owl:differentFrom ?Y
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:milo owl:differentFrom :fido .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :milo owl:differentFrom :fido . }
  pe:rule 1;
  pe:binding
    [ pe:var "A"; pe:value :Cat ],
    [ pe:var "B"; pe:value :Dog ],
    [ pe:var "X"; pe:value :milo ],
    [ pe:var "Y"; pe:value :fido ];
  pe:uses
    { :Cat owl:disjointWith :Dog . },
    { :milo a :Cat . },
    { :fido a :Dog . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 4 steps, 4 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
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
eyeron examples/owl-disjoint-classes.n3
eyeron -p examples/owl-disjoint-classes.n3
eyeron -c examples/owl-disjoint-classes.n3
```

---

## Takeaway

Explicit disjointness rules propagate member differences and identify
inconsistent membership.
