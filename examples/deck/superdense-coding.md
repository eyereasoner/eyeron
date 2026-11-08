# Modeling superdense coding and teleportation

[superdense-coding.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/superdense-coding.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/superdense-coding.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/superdense-coding.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/superdense-coding.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=superdense-coding)

---

## The question

Boolean relations provide a finite representation of quantum communication
protocols. N3 rules compose these relations to derive the supplied
superdense-coding and teleportation results.

**Which results follow when the finite protocol relations are composed?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# |R) = |0, 0) + |1, 1)
false dqc:r false .

# remove answers that appear an even number of times
{
    ?X dqc:sdcoding ?Y .
    (
        1 {
            ?X dqc:sdcoding ?Y
        }
        ?A
    ) log:collectAllIn ?SCOPE .
    ?A math:sum ?B .
    (?B 2) math:remainder 1 .
} => {
    ?X dqc:superdense-coding ?Y .
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
1 dqc:superdense-coding 1 .
3 dqc:superdense-coding 3 .
0 dqc:superdense-coding 0 .
2 dqc:superdense-coding 2 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ 1 dqc:superdense-coding 1 . }
  pe:rule 12;
  pe:binding
    [ pe:var "A"; pe:value (1) ],
    [ pe:var "B"; pe:value 1 ],
    [ pe:var "X"; pe:value 1 ],
    [ pe:var "Y"; pe:value 1 ];
  pe:uses
    { 1 dqc:sdcoding 1 . },
    {
        (1 {
            1 dqc:sdcoding 1 .
        } (1)) log:collectAllIn ?SCOPE .
    },
    { (1) math:sum 1 . },
    { (1 2) math:remainder 1 . }.
```

`pe:rule 12` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 30 steps, 26 verified, 4 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 24; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 18; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `collected`.

---

## Try it

```sh
eyeron examples/superdense-coding.n3
eyeron -p examples/superdense-coding.n3
eyeron -c examples/superdense-coding.n3
```

---

## References

[Source reference 1](https://arxiv.org/pdf/1101.3764.pdf)

[Source reference 2](https://arxiv.org/pdf/1010.2929.pdf)

---

## Takeaway

Boolean relations model the supplied protocol cases; the example is not a
physical experiment.
