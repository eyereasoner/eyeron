# Selecting towns by population

[filter-town.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/filter-town.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/filter-town.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/filter-town.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/filter-town.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=filter-town)

---

## The question

Two towns have different populations. An N3 rule uses a numeric comparison to
classify the town whose population is greater than 1,500.

**Which town has a population strictly greater than 1,500?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The two population figures fall on opposite sides of the threshold.
:town1 :population 1000 .

# Use a strict comparison: a population of exactly 1,500 would not qualify.
{
    ?x :population ?p .
    ?p math:greaterThan 1500 .
} => {
    ?x a :largeTown
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:town2 a :largeTown .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :town2 a :largeTown . }
  pe:rule 1;
  pe:binding
    [ pe:var "p"; pe:value 2000 ],
    [ pe:var "x"; pe:value :town2 ];
  pe:uses
    { :town2 :population 2000 . },
    { 2000 math:greaterThan 1500 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
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
eyeron examples/filter-town.n3
eyeron -p examples/filter-town.n3
eyeron -c examples/filter-town.n3
```

---

## Takeaway

A numeric condition selects the qualifying fact before deriving its
classification.
