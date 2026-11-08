# Classifying a quoted Socrates statement

[quoted-socrates.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/quoted-socrates.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/quoted-socrates.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/quoted-socrates.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/quoted-socrates.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=quoted-socrates)

---

## The question

A quoted graph says that Socrates is human, and a class link relates humans to
mortals. An N3 rule derives the corresponding quoted mortality statement.

**Can the quoted human statement support a quoted mortality statement?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The Human statement is inside a graph value; it is not a top-level fact.
:we :have {
    :Socrates rdf:type :Human .
} .

# Match the quoted type, follow its subclass link and produce another
# quoted statement under have, keeping it apart from asserted data.
{
    ?A rdfs:subClassOf ?B .
    :we :have {
        ?S rdf:type ?A .
    }
} => {
    :we :have {
        ?S rdf:type ?B .
    }
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:we :have {
    :Socrates a :Mortal .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Human rdfs:subClassOf :Mortal . }
  pe:fact "quoted-socrates.n3".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
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
eyeron examples/quoted-socrates.n3
eyeron -p examples/quoted-socrates.n3
eyeron -c examples/quoted-socrates.n3
```

---

## Takeaway

A rule can transform quoted evidence while leaving it quoted.
