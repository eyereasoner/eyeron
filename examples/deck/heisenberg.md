# Checking supplied uncertainty bounds

[heisenberg.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/heisenberg.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/heisenberg.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/heisenberg.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/heisenberg.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=heisenberg)

---

## The question

A quantum-state model provides uncertainties and comparison bounds. N3
arithmetic rules multiply the supplied values and check which modeled
uncertainty relations they satisfy.

**Do the supplied uncertainty products meet, exceed or fall below their bounds?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Uncertainties and comparison bounds are supplied floating-point values.
# The tuple facts map each product and bound to an output status property.
:psi a :QuantumState .

# Compute the three uncertainty products independently.
{
    :psi :deltaX ?dX .
    :psi :deltaP ?dP .
    (?dX ?dP) math:product ?prod .
} => {
    :psi :prodXP ?prod .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:psi a :QuantumState .
:psi :deltaX "0.7071067811865476"^^xsd:double .
:psi :sxszStatus "saturates" .
:psi :xszStatus "satisfied" .
:psi :deltaP "0.7071067811865476"^^xsd:double .
:psi :deltaSx "0.5"^^xsd:double .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :psi :prodXP 0.5000000000000001 . }
  pe:rule 1;
  pe:binding
    [ pe:var "dP"; pe:value "0.7071067811865476"^^xsd:double ],
    [ pe:var "dX"; pe:value "0.7071067811865476"^^xsd:double ],
    [ pe:var "prod"; pe:value 0.5000000000000001 ];
  pe:uses
    { :psi :deltaX "0.7071067811865476"^^xsd:double . },
    { :psi :deltaP "0.7071067811865476"^^xsd:double . },
    { ("0.7071067811865476"^^xsd:double "0.7071067811865476"^^xsd:double) math:product 0.5000000000000001 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 28 steps, 28 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 17; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 11; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 46; pe:failed 0 ].
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
eyeron examples/heisenberg.n3
eyeron -p examples/heisenberg.n3
eyeron -c examples/heisenberg.n3
```

---

## Takeaway

The rules check numerical inputs within a tolerance; they do not derive
uncertainties from a quantum state.
