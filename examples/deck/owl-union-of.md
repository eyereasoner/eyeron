# Classifying members of a union

[owl-union-of.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-union-of.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-union-of.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-union-of.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-union-of.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-union-of)

---

## The question

Pet is defined as a union of cat and dog classes. Explicit N3 rules derive pet
memberships for the supplied animals and subclass links for the component
classes.

**Which animals belong to the union class Pet?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Pet lists Cat and Dog as component classes, with one member of each.
:Pet owl:unionOf (:Cat :Dog) .

{
    ?C owl:unionOf ?L .
    ?D list:in ?L .
    ?X a ?D
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
:milo a :Pet .
:fido a :Pet .
:Cat rdfs:subClassOf :Pet .
:Dog rdfs:subClassOf :Pet .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :milo a :Pet . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :Pet ],
    [ pe:var "D"; pe:value :Cat ],
    [ pe:var "L"; pe:value (:Cat :Dog) ],
    [ pe:var "X"; pe:value :milo ];
  pe:uses
    { :Pet owl:unionOf (:Cat :Dog) . },
    { :Cat list:in (:Cat :Dog) . },
    { :milo a :Cat . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 9 steps, 9 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 7; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
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
eyeron examples/owl-union-of.n3
eyeron -p examples/owl-union-of.n3
eyeron -c examples/owl-union-of.n3
```

---

## Takeaway

Membership in either listed component class supports membership in the union.
