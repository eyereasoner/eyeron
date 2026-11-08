# Expanding a disjoint union of pet classes

[owl-disjoint-union.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-disjoint-union.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-disjoint-union.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-disjoint-union.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-disjoint-union.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-disjoint-union)

---

## The question

Pet is described as a disjoint union of cat, dog, and bird classes. An N3 rule
traverses the class list to derive pairwise disjointness and a union
statement.

**Which pairwise disjointness facts follow from the listed pet classes?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Pet is the disjoint union of Cat, Dog and Bird.
:Pet owl:disjointUnionOf (:Cat :Dog :Bird) .

{
    ?C owl:disjointUnionOf ?L .
    ?A list:in ?L .
    ?B list:in ?L .
    ?A log:notEqualTo ?B
} => {
    ?A owl:disjointWith ?B .
    ?C owl:unionOf ?L
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:Cat owl:disjointWith :Dog .
:Pet owl:unionOf (:Cat :Dog :Bird) .
:Bird owl:disjointWith :Cat .
:Bird owl:disjointWith :Dog .
:Cat owl:disjointWith :Bird .
:Dog owl:disjointWith :Cat .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Cat owl:disjointWith :Dog . }
  pe:rule 1;
  pe:binding
    [ pe:var "A"; pe:value :Cat ],
    [ pe:var "B"; pe:value :Dog ],
    [ pe:var "C"; pe:value :Pet ],
    [ pe:var "L"; pe:value (:Cat :Dog :Bird) ];
  pe:uses
    { :Pet owl:disjointUnionOf (:Cat :Dog :Bird) . },
    { :Cat list:in (:Cat :Dog :Bird) . },
    { :Dog list:in (:Cat :Dog :Bird) . },
    { :Cat log:notEqualTo :Dog . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 17 steps, 17 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 8; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 7; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-disjoint-union.n3
eyeron -p examples/owl-disjoint-union.n3
eyeron -c examples/owl-disjoint-union.n3
```

---

## Takeaway

Traversing the class list expands the compact disjoint-union declaration.
