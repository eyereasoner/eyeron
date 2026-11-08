# Relating complementary classes

[owl-complement-of.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-complement-of.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-complement-of.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-complement-of.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-complement-of.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-complement-of)

---

## The question

Vertebrate and invertebrate are declared complementary. Explicit N3 rules
derive the reverse complement and disjointness links and include a fuse for an
individual placed in both classes.

**Which complement and disjointness links follow from the declaration?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Vertebrate and Invertebrate are declared complements.
:Vertebrate owl:complementOf :Invertebrate .

{
    ?C owl:complementOf ?D
} => {
    ?D owl:complementOf ?C
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:Invertebrate owl:complementOf :Vertebrate .
:Invertebrate owl:disjointWith :Vertebrate .
:Vertebrate owl:disjointWith :Invertebrate .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Invertebrate owl:complementOf :Vertebrate . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :Vertebrate ],
    [ pe:var "D"; pe:value :Invertebrate ];
  pe:uses { :Vertebrate owl:complementOf :Invertebrate . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 4 steps, 4 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-complement-of.n3
eyeron -p examples/owl-complement-of.n3
eyeron -c examples/owl-complement-of.n3
```

---

## Takeaway

The complement rules describe the relationship and include a fuse for
inconsistent membership.
