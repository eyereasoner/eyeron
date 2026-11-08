# Finding paths around a cycle

[cyclic-reachability.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/cyclic-reachability.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/cyclic-reachability.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/cyclic-reachability.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/cyclic-reachability.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=cyclic-reachability)

---

## The question

Three edges form a directed cycle. Recursive forward N3 rules derive reachable
pairs, stopping when every consequence is already present.

**Which node pairs are reachable around the three-node cycle?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The three one-way edges form a closed loop.
:a :edge :b .

# Every edge gives a direct path.
{
    ?x :edge ?y
} => {
    ?x :path ?y
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:a :path :b .
:b :path :c .
:b :path :b .
:c :path :c .
:a :path :c .
:c :path :a .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :a :path :b . }
  pe:rule 1;
  pe:binding
    [ pe:var "x"; pe:value :a ],
    [ pe:var "y"; pe:value :b ];
  pe:uses { :a :edge :b . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 12 steps, 12 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 12; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 9; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/cyclic-reachability.n3
eyeron -p examples/cyclic-reachability.n3
eyeron -c examples/cyclic-reachability.n3
```

---

## Takeaway

A cyclic graph has a finite closure when repeated conclusions add no new
facts.
