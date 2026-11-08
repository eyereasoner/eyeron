# Reading an RDF list's head and tail

[rdf-list.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf-list.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdf-list.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdf-list.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdf-list.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdf-list)

---

## The question

A two-item list is attached to a subject. Backward N3 rules expose its
rdf:first and rdf:rest values, and a forward rule checks the resulting head
and tail.

**Are the list's first item and remainder the expected values?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The list contains the integers one and two.
:X :val (1 2) .

# Check both projections: the head is 1 and the tail is the one-item list (2).
{
    ?X :val ?Y .
    ?Y :head ?H .
    ?Y :tail ?T .

    ?H log:equalTo 1 .
    ?T log:equalTo (2) .
} => {
    :result :is true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:result :is true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :is true . }
  pe:rule 3;
  pe:binding
    [ pe:var "H"; pe:value 1 ],
    [ pe:var "T"; pe:value (2) ],
    [ pe:var "X"; pe:value :X ],
    [ pe:var "Y"; pe:value (1 2) ];
  pe:uses
    { :X :val (1 2) . },
    { (1 2) :head 1 . },
    { (1 2) :tail (2) . },
    { 1 log:equalTo 1 . },
    { (2) log:equalTo (2) . }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 8 steps, 8 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ].
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
eyeron examples/rdf-list.n3
eyeron -p examples/rdf-list.n3
eyeron -c examples/rdf-list.n3
```

---

## Takeaway

A list can be inspected through RDF projections as well as N3 list operations.
