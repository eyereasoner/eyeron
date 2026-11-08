# Extending equality links

[owl-same-as.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-same-as.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-same-as.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-same-as.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-same-as.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-same-as)

---

## The question

Bob is the same as Robert, and Robert the same as Rob (owl:sameAs). N3 rules
make sameAs symmetric and transitive, so Eyeron links all three names to each
other and to themselves. A third rule is an inference fuse (=> false) for
things stated to be both the same and different.

**Which equality links follow from the three connected names?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Two identity statements
:bob owl:sameAs :robert .

# Symmetry.
{
    ?X owl:sameAs ?Y
} => {
    ?Y owl:sameAs ?X
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:robert owl:sameAs :bob .
:bob owl:sameAs :rob .
:rob owl:sameAs :rob .
:rob owl:sameAs :bob .
:bob owl:sameAs :bob .
:robert owl:sameAs :robert .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :robert owl:sameAs :bob . }
  pe:rule 1;
  pe:binding
    [ pe:var "X"; pe:value :bob ],
    [ pe:var "Y"; pe:value :robert ];
  pe:uses { :bob owl:sameAs :robert . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 9 steps, 9 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 7; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-same-as.n3
eyeron -p examples/owl-same-as.n3
eyeron -c examples/owl-same-as.n3
```

---

## Takeaway

Symmetry and transitivity extend the links; an explicit fuse guards a
same-and-different conflict.
