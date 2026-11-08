# Classifying complex-matrix stability

[complex-matrix-stability.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/complex-matrix-stability.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/complex-matrix-stability.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/complex-matrix-stability.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/complex-matrix-stability.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=complex-matrix-stability)

---

## The question

Small diagonal matrices have complex entries. N3 backward rules calculate
eigenvalue magnitudes and classify discrete-time behavior. Queries return the
spectral radius and the unstable, stable, or damped classification.

**What do the eigenvalue magnitudes say about each diagonal matrix?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Editable input
:Case :unstableMatrix :A_unstable ;
    :stableMatrix :A_stable ;
    :dampedMatrix :A_damped .

# Materialized scenario facts
{
    :Case :unstableMatrix ?Mu ;
        :stableMatrix ?Ms ;
        :dampedMatrix ?Md .
    ?Mu :classification :unstable ;
        :spectralRadius 2 .
    ?Ms :classification :stable ;
        :spectralRadius 1 .
    ?Md :classification :damped ;
        :spectralRadius 0 .
} => {
    :Case :scenarioOk true .
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
:A_unstable :spectralRadius 2 .
:A_stable :spectralRadius 1 .
:A_stable :classification :stable .
:A_damped :classification :damped .
:A_damped :spectralRadius 0 .
:A_unstable :classification :unstable .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :A_unstable :spectralRadius 2 . }
  pe:rule 7;
  pe:binding [ pe:var "M"; pe:value :A_unstable ];
  pe:uses { :A_unstable :spectralRadiusSq 4 . }.
```

`pe:rule 7` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 56 steps, 56 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 43; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 13; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 113; pe:failed 0 ].
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
eyeron examples/complex-matrix-stability.n3
eyeron -p examples/complex-matrix-stability.n3
eyeron -c examples/complex-matrix-stability.n3
```

---

## Takeaway

The classification follows the stated discrete-time criterion for these sample
matrices.
