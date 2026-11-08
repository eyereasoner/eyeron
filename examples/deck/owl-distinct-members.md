# Expanding a list of distinct colors

[owl-distinct-members.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-distinct-members.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-distinct-members.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-distinct-members.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-distinct-members.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-distinct-members)

---

## The question

A list declares red, green, and blue to be distinct members. An explicit N3
rule enumerates different list entries and derives pairwise owl:differentFrom
statements.

**Which ordered pairs of colors are declared different?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The three named colors are listed as distinct.
:colours owl:distinctMembers (:red :green :blue) .

{
    ?A owl:distinctMembers ?L .
    ?X list:in ?L .
    ?Y list:in ?L .
    ?X log:notEqualTo ?Y
} => {
    ?X owl:differentFrom ?Y
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:red owl:differentFrom :green .
:red owl:differentFrom :blue .
:blue owl:differentFrom :red .
:blue owl:differentFrom :green .
:green owl:differentFrom :red .
:green owl:differentFrom :blue .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :red owl:differentFrom :green . }
  pe:rule 1;
  pe:binding
    [ pe:var "A"; pe:value :colours ],
    [ pe:var "L"; pe:value (:red :green :blue) ],
    [ pe:var "X"; pe:value :red ],
    [ pe:var "Y"; pe:value :green ];
  pe:uses
    { :colours owl:distinctMembers (:red :green :blue) . },
    { :red list:in (:red :green :blue) . },
    { :green list:in (:red :green :blue) . },
    { :red log:notEqualTo :green . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 16 steps, 16 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 7; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-distinct-members.n3
eyeron -p examples/owl-distinct-members.n3
eyeron -c examples/owl-distinct-members.n3
```

---

## Takeaway

List enumeration turns a compact declaration into pairwise statements.
