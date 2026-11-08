# Extending an ancestor relationship

[owl-transitive-property.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-transitive-property.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-transitive-property.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-transitive-property.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-transitive-property.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-transitive-property)

---

## The question

An ancestor property is declared transitive, with a chain of three links. An
explicit N3 rule combines adjacent links to derive the indirect ancestor
relationships.

**Which indirect ancestor links follow from the direct chain?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Three direct ancestor links form a chain; ancestor is declared transitive.
:ancestor a owl:TransitiveProperty .

{
    ?P a owl:TransitiveProperty .
    ?S ?P ?X .
    ?X ?P ?O .
} => {
    ?S ?P ?O
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:alice :ancestor :carol .
:bob :ancestor :dave .
:alice :ancestor :dave .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :alice :ancestor :carol . }
  pe:rule 1;
  pe:binding
    [ pe:var "O"; pe:value :carol ],
    [ pe:var "P"; pe:value :ancestor ],
    [ pe:var "S"; pe:value :alice ],
    [ pe:var "X"; pe:value :bob ];
  pe:uses
    { :ancestor a owl:TransitiveProperty . },
    { :alice :ancestor :bob . },
    { :bob :ancestor :carol . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 7 steps, 7 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 7; pe:failed 0 ];
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
eyeron examples/owl-transitive-property.n3
eyeron -p examples/owl-transitive-property.n3
eyeron -c examples/owl-transitive-property.n3
```

---

## Takeaway

The explicit transitivity rule repeatedly combines adjoining links.
