# Comparing matrix-stability judgments

[complex-matrix-stability-worlds.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/complex-matrix-stability-worlds.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/complex-matrix-stability-worlds.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/complex-matrix-stability-worlds.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/complex-matrix-stability-worlds.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=complex-matrix-stability-worlds)

---

## The question

Different model worlds assess complex matrices under different criteria. N3
rules derive stability judgments within each world and expose how the
assumptions affect the answers.

**When do the model worlds disagree about a matrix's stability?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Worlds (higher-order "look")
:World a rdfs:Class .

# Complex helpers (built from W3C math:* built-ins)
#
# A complex number z = x + i y is represented as (x y).
# Complex addition: (a+ib) + (c+id) = (a+c, b+d)
{
    ((?Ar ?Ai) (?Br ?Bi)) complex:sum (?Cr ?Ci) .
} <= {
    (?Ar ?Br) math:sum ?Cr .
    (?Ai ?Bi) math:sum ?Ci .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:Id :stableInWorld :W0 .
:DampedDiag :stableInWorld :W0 .
:DampedDiag :dampedInWorld :W2 .
:Rotation :dampedInWorld :W2 .
:Rotation :stableInWorld :W0 .
:Id :stableInWorld :W1 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Id :stableInWorld :W0 . }
  pe:rule 20;
  pe:binding
    [ pe:var "A"; pe:value :Id ],
    [ pe:var "rho"; pe:value "1"^^xsd:decimal ];
  pe:uses
    { :Id :spectralRadius "1"^^xsd:decimal . },
    { "1"^^xsd:decimal math:notGreaterThan 1.0 . }.
```

`pe:rule 20` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 195 steps, 195 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 86; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 109; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 435; pe:failed 0 ].
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
eyeron examples/complex-matrix-stability-worlds.n3
eyeron -p examples/complex-matrix-stability-worlds.n3
eyeron -c examples/complex-matrix-stability-worlds.n3
```

---

## Takeaway

Different stability criteria can give different answers for the same matrix.
