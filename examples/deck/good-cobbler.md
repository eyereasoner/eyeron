# Keeping a qualified description together

[good-cobbler.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/good-cobbler.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/good-cobbler.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/good-cobbler.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/good-cobbler.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=good-cobbler)

---

## The question

Joe is described as a good cobbler using a two-item list. An N3 rule preserves
that qualified description in a quoted conclusion instead of treating good and
cobbler as separate facts.

**How can a good-cobbler description be kept together in a conclusion?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The list keeps good attached to the cobbler qualification.
:joe :is (:good :Cobbler) .

# Match a good-at-a-trade description and return that same description
# inside a graph; no general good-person claim is produced.
{
    ?X :is (:good ?Y) .
} => {
    :test :is {
        ?X :is (:good ?Y)
    } .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:test :is {
    :joe :is (:good :Cobbler) .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
@prefix : <https://eyereasoner.github.io/ns#> .
@prefix pe: <https://eyereasoner.github.io/pe#> .

:test :is {
    :joe :is (:good :Cobbler) .
} .

{
  :test :is {
      :joe :is (:good :Cobbler) .
  } .
}
  pe:rule 1;
  pe:binding
    [ pe:var "X"; pe:value :joe ],
    [ pe:var "Y"; pe:value :Cobbler ];
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 2 steps, 2 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
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
eyeron examples/good-cobbler.n3
eyeron -p examples/good-cobbler.n3
eyeron -c examples/good-cobbler.n3
```

---

## References

[Source reference 1](https://shs.hal.science/halshs-04148373/document)

[Source reference 2](http://intrologic.stanford.edu/chapters/chapter_11.html)

---

## Takeaway

A qualification attached to a trade need not become a separate claim of
goodness in general.
