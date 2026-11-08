# Following a chain of properties

[rdfs-subproperty-closure.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdfs-subproperty-closure.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdfs-subproperty-closure.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdfs-subproperty-closure.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdfs-subproperty-closure.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdfs-subproperty-closure)

---

## The question

Mother-of is a subproperty of parent-of, which is a subproperty of
ancestor-of. Explicit N3 rules extend these declarations and derive inherited
relationships and domain or range consequences.

**Which relationships follow through the property hierarchy?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Alice is Bob's mother; motherOf is below parentOf and ancestorOf.
:motherOf rdfs:subPropertyOf :parentOf .

{
    ?P rdfs:subPropertyOf ?Q .
    ?S ?P ?O
} => {
    ?S ?Q ?O
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:motherOf rdfs:subPropertyOf :ancestorOf .
:motherOf rdfs:domain :Person .
:alice :parentOf :bob .
:alice :ancestorOf :bob .
:motherOf rdfs:range :Person .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :alice :parentOf :bob . }
  pe:rule 1;
  pe:binding
    [ pe:var "O"; pe:value :bob ],
    [ pe:var "P"; pe:value :motherOf ],
    [ pe:var "Q"; pe:value :parentOf ],
    [ pe:var "S"; pe:value :alice ];
  pe:uses
    { :motherOf rdfs:subPropertyOf :parentOf . },
    { :alice :motherOf :bob . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 10 steps, 10 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 10; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/rdfs-subproperty-closure.n3
eyeron -p examples/rdfs-subproperty-closure.n3
eyeron -c examples/rdfs-subproperty-closure.n3
```

---

## Takeaway

Explicit subproperty rules carry a relationship into broader properties.
