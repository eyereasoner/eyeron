# Comparing junctions in a discrete tunneling model

[pn-junction-tunneling.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/pn-junction-tunneling.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/pn-junction-tunneling.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/pn-junction-tunneling.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/pn-junction-tunneling.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=pn-junction-tunneling)

---

## The question

Two junction widths and finite energy-level lists describe a toy electronic
model. N3 arithmetic and list rules derive overlap and current-related results
across the supplied bias points.

**Which finite energy-level overlaps support the modeled current at each bias?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Facts
:case :name "pn-junction-tunneling" .

# Logic
# Heavy doping is modeled as a much narrower depletion region.
{
    :case :tunnelDepletionWidthNm ?t .
    :case :ordinaryDepletionWidthNm ?o .
    ?t math:lessThan ?o .
} => {
    :case :barrierIsNarrower true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:case :peakBias 2 .
:case :peakCurrent 4 .
:case :negativeDifferentialRegion true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :case :peakBias 2 . }
  pe:rule 7;
  pe:binding
    [ pe:var "c0"; pe:value 2 ],
    [ pe:var "c1"; pe:value 3 ],
    [ pe:var "c3"; pe:value 3 ],
    [ pe:var "c4"; pe:value 2 ],
    [ pe:var "c5"; pe:value 1 ],
    [ pe:var "c6"; pe:value 0 ],
    [ pe:var "peak"; pe:value 4 ];
  pe:uses
    { :b2 :currentProxy 4 . },
    { :b0 :currentProxy 2 . },
    { 4 math:greaterThan 2 . },
    { :b1 :currentProxy 3 . },
    { 4 math:greaterThan 3 . },
    { :b3 :currentProxy 3 . },
    { 4 math:greaterThan 3 . },
    { :b4 :currentProxy 2 . },
    { 4 math:greaterThan 2 . },
    { :b5 :currentProxy 1 . },
    { 4 math:greaterThan 1 . },
    { :b6 :currentProxy 0 . },
    { 4 math:greaterThan 0 . }.
```

`pe:rule 7` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 138 steps, 138 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 74; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 64; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 344; pe:failed 0 ].
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
eyeron examples/pn-junction-tunneling.n3
eyeron -p examples/pn-junction-tunneling.n3
eyeron -c examples/pn-junction-tunneling.n3
```

---

## Takeaway

The outputs describe the supplied discrete tunneling model and its finite
level lists.
