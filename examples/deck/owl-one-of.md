# Classifying an enumerated set of colors

[owl-one-of.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-one-of.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-one-of.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-one-of.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-one-of.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-one-of)

---

## The question

The class PrimaryColour is defined by listing its members: red, green and blue
(owl:oneOf). An N3 rule walks the list with the list:in built-in and derives
that each listed colour is a primary colour.

**Which colors belong to the enumerated class?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# A class given by the list of its members
:PrimaryColour owl:oneOf (:red :green :blue) .

{
    ?C owl:oneOf ?L .
    ?X list:in ?L
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
:red a :PrimaryColour .
:green a :PrimaryColour .
:blue a :PrimaryColour .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :red a :PrimaryColour . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :PrimaryColour ],
    [ pe:var "L"; pe:value (:red :green :blue) ],
    [ pe:var "X"; pe:value :red ];
  pe:uses
    { :PrimaryColour owl:oneOf (:red :green :blue) . },
    { :red list:in (:red :green :blue) . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 7 steps, 7 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ].
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
eyeron examples/owl-one-of.n3
eyeron -p examples/owl-one-of.n3
eyeron -c examples/owl-one-of.n3
```

---

## Takeaway

A list of members can be interpreted by a rule that derives each membership.
