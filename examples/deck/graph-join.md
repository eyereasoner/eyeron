# Joining reviewer and approval evidence

[graph-join.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/graph-join.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/graph-join.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/graph-join.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/graph-join.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=graph-join)

---

## The question

Two statement records describe a reviewer's role in one graph and an approval
in another. An N3 rule joins the records through the reviewer and derives that
the approved claim is trusted.

**Which approved claim is supported by a reviewer in the staff graph?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# These are records of statements, with graph names stored as ordinary fields.
[ :subject :alice ; :predicate :role ; :object :reviewer ; :graph :staff ] a :Quad .

# The shared person must be a reviewer in staff and approve the claim in
# reviews; the graph fields keep the roles of the two records distinct.
{
    ?q1 :subject ?person ;
        :predicate :role ;
        :object :reviewer ;
        :graph :staff .
    ?q2 :subject ?person ;
        :predicate :approved ;
        :object ?claim ;
        :graph :reviews .
} => {
    ?claim :trusted true
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:claim1 :trusted true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :claim1 :trusted true . }
  pe:rule 1;
  pe:binding
    [ pe:var "claim"; pe:value :claim1 ],
    [ pe:var "person"; pe:value :alice ],
    [ pe:var "q1"; pe:value _:b1 ],
    [ pe:var "q2"; pe:value _:b2 ];
  pe:uses
    { _:b1 :subject :alice . },
    { _:b1 :predicate :role . },
    { _:b1 :object :reviewer . },
    { _:b1 :graph :staff . },
    { _:b2 :subject :alice . },
    { _:b2 :predicate :approved . },
    { _:b2 :object :claim1 . },
    { _:b2 :graph :reviews . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 9 steps, 9 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 9; pe:failed 0 ];
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
eyeron examples/graph-join.n3
eyeron -p examples/graph-join.n3
eyeron -c examples/graph-join.n3
```

---

## Takeaway

A shared person joins two records without discarding their graph fields.
