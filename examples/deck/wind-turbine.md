# Deriving a maintenance recommendation

[wind-turbine.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/wind-turbine.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/wind-turbine.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/wind-turbine.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/wind-turbine.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=wind-turbine)

---

## The question

A turbine's sensor readings are compared with explicit limits. N3 rules derive
inspection and maintenance requirements from the modeled anomalies and gearbox
condition. A query returns the required actions.

**Which inspection or maintenance actions follow from the sensor limits?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Sensor data
:turbine1 :label "North field turbine" ;
    :vibration "0.42"^^xsd:decimal ;
    :temperature "78"^^xsd:decimal ;
    :rpm "1650"^^xsd:decimal ;
    :gearboxStatus :degraded .

# Test each supplied reading against its own limit before combining anomalies.
{
    ?T :vibration ?V .
    :highVibrationThreshold :value ?VT .
    ?V math:greaterThan ?VT .
} => {
    ?T :hasAnomaly :highVibration .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:turbine1 :requires :gearboxMaintenance .
:turbine1 :requires :urgentInspection .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :turbine1 :requires :gearboxMaintenance . }
  pe:rule 4;
  pe:binding [ pe:var "T"; pe:value :turbine1 ];
  pe:uses { :turbine1 :gearboxStatus :degraded . }.
```

`pe:rule 4` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 11 steps, 11 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 15; pe:failed 0 ].
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
eyeron examples/wind-turbine.n3
eyeron -p examples/wind-turbine.n3
eyeron -c examples/wind-turbine.n3
```

---

## Takeaway

Each requested action is traceable to the anomaly and condition rules that
support it.
