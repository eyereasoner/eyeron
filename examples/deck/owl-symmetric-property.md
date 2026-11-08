# Reversing a symmetric relationship

[owl-symmetric-property.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-symmetric-property.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-symmetric-property.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-symmetric-property.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-symmetric-property.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-symmetric-property)

---

## The question

A knows relationship is declared symmetric. An explicit N3 rule derives that
Bob knows Alice from the fact that Alice knows Bob.

**Does Bob know Alice when Alice knows Bob through a symmetric property?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Alice knows Bob, and knows is declared symmetric.
:knows a owl:SymmetricProperty .

{
    ?P a owl:SymmetricProperty .
    ?S ?P ?O
} => {
    ?O ?P ?S
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:bob :knows :alice .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :bob :knows :alice . }
  pe:rule 1;
  pe:binding
    [ pe:var "O"; pe:value :bob ],
    [ pe:var "P"; pe:value :knows ],
    [ pe:var "S"; pe:value :alice ];
  pe:uses
    { :knows a owl:SymmetricProperty . },
    { :alice :knows :bob . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

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
eyeron examples/owl-symmetric-property.n3
eyeron -p examples/owl-symmetric-property.n3
eyeron -c examples/owl-symmetric-property.n3
```

---

## Takeaway

The reverse link comes from the explicit symmetry rule.
