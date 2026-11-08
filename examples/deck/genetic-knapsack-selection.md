# Checking a knapsack selection's local optimum

[genetic-knapsack-selection.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/genetic-knapsack-selection.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/genetic-knapsack-selection.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/genetic-knapsack-selection.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/genetic-knapsack-selection.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/genetic-knapsack-selection.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=genetic-knapsack-selection)

---

## The question

A companion dataset records a local search over item selections and its
neighbor summary. N3 rules check the final weight and supplied best-neighbor
value, then report that stopping point alongside a supplied global optimum.
The rules do not run the search or prove global optimality.

**Does the supplied final selection pass the capacity and neighbor-summary checks?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The companion input supplies the final candidate and neighbor summary.
# Check capacity and the claimed best neighbor; no mutation loop runs here.
{
    :Run :capacity ?Capacity .
    :FinalLocal :weight ?Weight ;
        :value ?Value .
    :NeighborSummary :bestNeighborValue ?BestNeighbor ;
        :capacityRespected true .
    ?Weight math:notGreaterThan ?Capacity .
    ?BestNeighbor math:notGreaterThan ?Value .
} => {
    :Run :localSearchStopsAt :FinalLocal .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The companion input supplies additional facts; load it
together with the rules in the commands below.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
final genome : 101000000101
selected items : item01, item03, item10, item12
weight : 50 / 50
value : 101
fitness : 999899
generations evaluated : 5
exhaustive optimum value : 104 at genome 001000011111
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Run :localSearchStopsAt :FinalLocal . }
  pe:rule 1;
  pe:binding
    [ pe:var "BestNeighbor"; pe:value 101 ],
    [ pe:var "Capacity"; pe:value 50 ],
    [ pe:var "Value"; pe:value 101 ],
    [ pe:var "Weight"; pe:value 50 ];
  pe:uses
    { :Run :capacity 50 . },
    { :FinalLocal :weight 50 . },
    { :FinalLocal :value 101 . },
    { :NeighborSummary :bestNeighborValue 101 . },
    { :NeighborSummary :capacityRespected true . },
    { 50 math:notGreaterThan 50 . },
    { 101 math:notGreaterThan 101 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 17 steps, 17 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 14; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
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
eyeron examples/genetic-knapsack-selection.n3 examples/input/genetic-knapsack-selection.trig
eyeron -p examples/genetic-knapsack-selection.n3 examples/input/genetic-knapsack-selection.trig
eyeron -c examples/genetic-knapsack-selection.n3 examples/input/genetic-knapsack-selection.trig
```

---

## Takeaway

The rules validate supplied summary values; they do not execute the local
search or establish its global optimum.
