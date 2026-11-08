# Restricting the number of cat pets

[owl-qualified-cardinality.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-qualified-cardinality.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-qualified-cardinality.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-qualified-cardinality.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-qualified-cardinality.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-qualified-cardinality)

---

## The question

A single-cat owner has at most one pet that is a cat
(owl:maxQualifiedCardinality 1 on :pet with owl:onClass :Cat). Alice is one,
and has the pets Milo and Felix, both cats, and Fido, a dog. An N3 rule counts
only the pets of the qualifying class, so it concludes that Milo and Felix are
the same cat (owl:sameAs) and leaves Fido alone.

**Which cat pets are equated by the at-most-one restriction?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The qualified restriction, a member, and her pets
:SingleCatOwner owl:maxQualifiedCardinality 1 ;
    owl:onProperty :pet ;
    owl:onClass :Cat .

# Under a maximum of one, any two values in the qualifying class are the
# same thing (each is also the same as itself).
{
    ?C owl:maxQualifiedCardinality 1 .
    ?C owl:onProperty ?P .
    ?C owl:onClass ?D .
    ?U a ?C .
    ?U ?P ?Y .
    ?Y a ?D .
    ?U ?P ?Z .
    ?Z a ?D
} => {
    ?Y owl:sameAs ?Z
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:milo owl:sameAs :milo .
:milo owl:sameAs :felix .
:felix owl:sameAs :milo .
:felix owl:sameAs :felix .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :milo owl:sameAs :milo . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :SingleCatOwner ],
    [ pe:var "D"; pe:value :Cat ],
    [ pe:var "P"; pe:value :pet ],
    [ pe:var "U"; pe:value :alice ],
    [ pe:var "Y"; pe:value :milo ],
    [ pe:var "Z"; pe:value :milo ];
  pe:uses
    { :SingleCatOwner owl:maxQualifiedCardinality 1 . },
    { :SingleCatOwner owl:onProperty :pet . },
    { :SingleCatOwner owl:onClass :Cat . },
    { :alice a :SingleCatOwner . },
    { :alice :pet :milo . },
    { :milo a :Cat . },
    { :alice :pet :milo . },
    { :milo a :Cat . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 12 steps, 12 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 12; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-qualified-cardinality.n3
eyeron -p examples/owl-qualified-cardinality.n3
eyeron -c examples/owl-qualified-cardinality.n3
```

---

## Takeaway

The class qualification includes the cats and leaves the dog outside this
restriction.
