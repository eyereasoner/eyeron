# Calculating a transistor-switch model

[transistor-switch.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/transistor-switch.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/transistor-switch.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/transistor-switch.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/transistor-switch.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=transistor-switch)

---

## The question

Supply voltage, resistances, gain, and low or high inputs define a toy switch.
N3 arithmetic rules derive currents and output conditions and check the
modeled switching behavior.

**Which output conditions follow for the modeled low and high inputs?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Facts
:case :name "transistor-switch" .

# Logic
# Low-input branch: below turn-on, the transistor stays in cutoff.
{
    ?state list:in (:low :high) .
    ?state :inputMv ?vin .
    :case :vbeOnMv ?vbe .
    ?vin math:notGreaterThan ?vbe .
    :case :supplyMv ?vcc .
} => {
    ?state :baseCurrentUa 0 .
    ?state :collectorGainLimitUa 0 .
    ?state :collectorLoadLimitUa 0 .
    ?state :collectorCurrentUa 0 .
    ?state :loadVoltageMv 0 .
    ?state :collectorEmitterVoltageMv ?vcc .
    ?state :cutoff true .
    ?state :saturation false .
    ?state :stateLabel "cutoff / OFF" .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:low :stateLabel "cutoff / OFF" .
:low :collectorCurrentUa 0 .
:high :collectorCurrentUa 4800 .
:high :collectorEmitterVoltageMv 200 .
:low :collectorEmitterVoltageMv 5000 .
:high :stateLabel "saturation / ON" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :low :collectorCurrentUa 0 . }
  pe:rule 1;
  pe:binding
    [ pe:var "state"; pe:value :low ],
    [ pe:var "vbe"; pe:value 700 ],
    [ pe:var "vcc"; pe:value 5000 ],
    [ pe:var "vin"; pe:value 0 ];
  pe:uses
    { :low list:in (:low :high) . },
    { :low :inputMv 0 . },
    { :case :vbeOnMv 700 . },
    { 0 math:notGreaterThan 700 . },
    { :case :supplyMv 5000 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 29 steps, 29 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 17; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 12; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 102; pe:failed 0 ].
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
eyeron examples/transistor-switch.n3
eyeron -p examples/transistor-switch.n3
eyeron -c examples/transistor-switch.n3
```

---

## Takeaway

The switch behavior is a consequence of the supplied toy circuit equations and
constants.
