# Following a wake switch into an alarm state

[tunnel-junction-wake-switch-becoming.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/tunnel-junction-wake-switch-becoming.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/tunnel-junction-wake-switch-becoming.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/tunnel-junction-wake-switch-becoming.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/tunnel-junction-wake-switch-becoming.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=tunnel-junction-wake-switch-becoming)

---

## The question

A tunnel-junction device moves through preparation, bias, and wake-up
conditions. N3 rules derive the supported state transitions and contrast them
with a conventional junction that cannot meet the modeled low-bias task.

**Which modeled device can progress from preparation to an alarm?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:case a arc:Case ;
    arc:question "Can a tunnel-junction wake switch become a low-bias wake-triggering state in a regime where a conventional PN junction cannot?" .

# CAN-BECOME rules — viable state transitions
# A heavily doped, narrow junction with overlapping states can become a
# quantum-transfer-supporting junction.
{
    ?J a :PNJunction ;
        :doping :Heavy ;
        :depletionWidth :Narrow ;
        :stateAlignment :Overlap .
} => {
    ?J :canBecome :QuantumTransferState ;
        :transportMode :TunnelingDominant .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:tunnelJunction :canBecome :QuantumTransferState .
:tunnelJunction :canBecome :SubThresholdCurrentState .
:ordinaryJunction :cannotBecome :NegativeDifferentialResponseState .
:ordinaryJunction :cannotBecome :LeakAlarmWakeServingState .
:tunnelJunction :canBecome :NegativeDifferentialResponseState .
:tunnelJunction :canBecome :UltraLowBiasSwitchingState .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :tunnelJunction :canBecome :QuantumTransferState . }
  pe:rule 1;
  pe:binding [ pe:var "J"; pe:value :tunnelJunction ];
  pe:uses
    { :tunnelJunction a :PNJunction . },
    { :tunnelJunction :doping :Heavy . },
    { :tunnelJunction :depletionWidth :Narrow . },
    { :tunnelJunction :stateAlignment :Overlap . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 24 steps, 24 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 24; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 43; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/tunnel-junction-wake-switch-becoming.n3
eyeron -p examples/tunnel-junction-wake-switch-becoming.n3
eyeron -c examples/tunnel-junction-wake-switch-becoming.n3
```

---

## Takeaway

The transition chain makes the low-bias requirement and the contrast device's
limitation explicit.
