# Comparing electric-vehicle range models

[ev-range-worlds.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/ev-range-worlds.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/ev-range-worlds.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/ev-range-worlds.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/ev-range-worlds.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=ev-range-worlds)

---

## The question

Several model worlds estimate whether a vehicle can complete a trip. N3
arithmetic rules compare a reference model with simplified assumptions about
speed, temperature, payload, and energy use.

**Which trip judgments change when the range assumptions change?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Worlds and trips
:World a rdfs:Class .

# Temperature factor
#
# temp < 0         → factor 1.2 (cold penalty)
# 0 ≤ temp < 10    → factor 1.1 (cool penalty)
# temp ≥ 10        → factor 1.0 (no penalty)
{
    ?T :tempFactor 1.2 .
} <= {
    ?T :tempC ?Temp .
    ?Temp math:lessThan 0.0 .
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
:CityShort :safeInWorld :W0 .
:MountainCool :safeInWorld :W0 .
:MountainCool :riskyInWorld :W3 .
:ColdHighwayMidBattery :riskyInWorld :W3 .
:CityShort :safeInWorld :W1 .
:HighwayLongCold :safeInWorld :W1 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :CityShort :safeInWorld :W0 . }
  pe:rule 10;
  pe:binding
    [ pe:var "Cap"; pe:value 40.0 ],
    [ pe:var "E0"; pe:value 0.4835555555555555 ],
    [ pe:var "T"; pe:value :CityShort ];
  pe:uses
    { :CityShort :energyRequired_W0 0.4835555555555555 . },
    { :CityShort :batteryKWh 40.0 . },
    { 0.4835555555555555 math:notGreaterThan 40.0 . }.
```

`pe:rule 10` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 127 steps, 127 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 68; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 59; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 225; pe:failed 0 ].
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
eyeron examples/ev-range-worlds.n3
eyeron -p examples/ev-range-worlds.n3
eyeron -c examples/ev-range-worlds.n3
```

---

## Takeaway

Model comparisons reveal which assumptions support an optimistic or
pessimistic range judgment.
