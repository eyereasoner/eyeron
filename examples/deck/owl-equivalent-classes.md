# Propagating equivalent class memberships

[owl-equivalent-classes.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-equivalent-classes.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-equivalent-classes.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-equivalent-classes.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-equivalent-classes.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-equivalent-classes)

---

## The question

Human, person, and individual classes are linked by equivalence declarations.
Explicit N3 rules extend those links and derive the corresponding
classifications for the sample people.

**Which class memberships follow from the equivalence links?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Three class names are linked by equivalence, with two sample members.
:Human owl:equivalentClass :Person .

{
    ?A owl:equivalentClass ?B .
    ?X a ?A
} => {
    ?X a ?B
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:alice a :Person .
:Person owl:equivalentClass :Human .
:Person rdfs:subClassOf :Person .
:Individual rdfs:subClassOf :Individual .
:Human owl:equivalentClass :Individual .
:Human owl:equivalentClass :Human .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :alice a :Person . }
  pe:rule 1;
  pe:binding
    [ pe:var "A"; pe:value :Human ],
    [ pe:var "B"; pe:value :Person ],
    [ pe:var "X"; pe:value :alice ];
  pe:uses
    { :Human owl:equivalentClass :Person . },
    { :alice a :Human . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 24 steps, 24 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 24; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 20; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-equivalent-classes.n3
eyeron -p examples/owl-equivalent-classes.n3
eyeron -c examples/owl-equivalent-classes.n3
```

---

## Takeaway

Equivalent-class rules propagate both vocabulary links and instance
classifications.
