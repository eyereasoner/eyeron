# Resolving a comparison before its inputs are written

[reordering.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/reordering.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/reordering.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/reordering.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/reordering.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=reordering)

---

## The question

Alice and Bob possess different objects. An N3 rule places an inequality test
before the facts that bind its variables, showing that premise matching can
resolve those inputs before testing the comparison.

**Can an inequality written first be evaluated after its inputs are found?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The two records have different object names and the same quantity.
:Alice :has (:Book 1) .

# The comparison is written before its inputs. Eyeron first finds bindings
# from the has facts, then tests whether the two object names differ.
{
    ?O1 log:notEqualTo ?O2 .

    ?W1 :has (?O1 ?N1) .
    ?W2 :has (?O2 ?N2) .
} => {
    :test :is true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:test :is true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :test :is true . }
  pe:rule 1;
  pe:binding
    [ pe:var "N1"; pe:value 1 ],
    [ pe:var "N2"; pe:value 1 ],
    [ pe:var "O1"; pe:value :Book ],
    [ pe:var "O2"; pe:value :Table ],
    [ pe:var "W1"; pe:value :Alice ],
    [ pe:var "W2"; pe:value :Bob ];
  pe:uses
    { :Book log:notEqualTo :Table . },
    { :Alice :has (:Book 1) . },
    { :Bob :has (:Table 1) . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 4 steps, 4 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
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
eyeron examples/reordering.n3
eyeron -p examples/reordering.n3
eyeron -c examples/reordering.n3
```

---

## Takeaway

Premise order in the text need not be the order in which bound comparisons are
evaluated.
