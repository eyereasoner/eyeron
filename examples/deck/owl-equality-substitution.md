# Substituting equal names in triples

[owl-equality-substitution.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-equality-substitution.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-equality-substitution.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-equality-substitution.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-equality-substitution.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-equality-substitution)

---

## The question

Bob and Robert are linked as the same individual, and two properties are also
equated. Explicit N3 rules substitute these names in subject, predicate, and
object positions.

**Which triples result from replacing names linked by sameAs?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Bob and Robert name the same individual; likes and enjoys are also equated.
:bob owl:sameAs :robert .

{
    ?X owl:sameAs ?Y .
    ?X ?P ?O
} => {
    ?Y ?P ?O
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:robert owl:sameAs :robert .
:robert :likes :pizza .
:robert :enjoys :pizza .
:alice :knows :robert .
:enjoys owl:sameAs :enjoys .
:bob :enjoys :pizza .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :robert owl:sameAs :robert . }
  pe:rule 1;
  pe:binding
    [ pe:var "O"; pe:value :robert ],
    [ pe:var "P"; pe:value owl:sameAs ],
    [ pe:var "X"; pe:value :bob ],
    [ pe:var "Y"; pe:value :robert ];
  pe:uses
    { :bob owl:sameAs :robert . },
    { :bob owl:sameAs :robert . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 10 steps, 10 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 10; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-equality-substitution.n3
eyeron -p examples/owl-equality-substitution.n3
eyeron -c examples/owl-equality-substitution.n3
```

---

## Takeaway

Subject, predicate and object substitution are performed by explicit rules.
