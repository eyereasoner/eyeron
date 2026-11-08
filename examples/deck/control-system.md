# Deriving actuator commands

[control-system.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/control-system.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/control-system.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/control-system.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/control-system.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=control-system)

---

## The question

Sensor readings, targets, and disturbances describe a small control problem.
N3 arithmetic rules derive commands that anticipate a Disturbance readings
provide the anticipatory correction for actuator 1. and correct the remaining
error. A query returns the commands.

**Which commands follow from the supplied readings, targets and disturbances?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Measurements feed the command formulas; some supplied observations are unused.
# A pair is converted by the backward measurement10 rules below.
:input1 :measurement1 (6 11) .

# Actuator 1 scales the derived input and subtracts log10 of disturbance1.
# The exponentiation relation is called with its exponent still unknown.
{
    :input1 :measurement10 ?M1 .
    :input2 :measurement2 true .
    :disturbance1 :measurement3 ?D1 .
    (?M1 19.6) math:product ?C1 .
    (10 ?C2) math:exponentiation ?D1 .
    (?C1 ?C2) math:difference ?C .
} => {
    :actuator1 :control1 ?C .
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
:actuator2 :control1 26.08 .
:actuator1 :control1 39.27346198678276 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :actuator2 :control1 26.08 . }
  pe:rule 2;
  pe:binding
    [ pe:var "C"; pe:value 26.08 ],
    [ pe:var "C1"; pe:value "29"^^xsd:decimal ],
    [ pe:var "C2"; pe:value -2.92 ],
    [ pe:var "D"; pe:value -2 ],
    [ pe:var "E"; pe:value 5 ],
    [ pe:var "M3"; pe:value 56967 ],
    [ pe:var "M4"; pe:value 24 ],
    [ pe:var "N"; pe:value 1.46 ],
    [ pe:var "P3"; pe:value 22 ],
    [ pe:var "T2"; pe:value 29 ];
  pe:uses
    { :input3 :measurement3 56967 . },
    { :state3 :observation3 22 . },
    { :output2 :measurement4 24 . },
    { :output2 :target2 29 . },
    { (29 24) math:difference 5 . },
    { (22 24) math:difference -2 . },
    { (5.8 5) math:product "29"^^xsd:decimal . },
    { (7.3 5) math:quotient 1.46 . },
    { (1.46 -2) math:product -2.92 . },
    { ("29"^^xsd:decimal -2.92) math:sum 26.08 . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 22 steps, 22 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 10; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 12; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 25; pe:failed 0 ].
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
eyeron examples/control-system.n3
eyeron -p examples/control-system.n3
eyeron -c examples/control-system.n3
```

---

## Takeaway

Each actuator command can be traced through its arithmetic helpers to its
inputs.
