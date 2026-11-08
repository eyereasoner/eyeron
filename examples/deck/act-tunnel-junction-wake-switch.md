# Waking a leak alarm with a tunnel junction

*Two diodes, one tiny voltage: which can wake the alarm?*

[act-tunnel-junction-wake-switch.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/act-tunnel-junction-wake-switch.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/act-tunnel-junction-wake-switch.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/act-tunnel-junction-wake-switch.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/act-tunnel-junction-wake-switch.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=act-tunnel-junction-wake-switch)

---

## The question

A leak alarm sits on a remote pipe and sleeps most of the time. To save its
battery, it must wake on a very small voltage, a few microwatts' worth. The
wake switch is a diode, and two kinds are on offer: a *tunnel diode*, whose
electrons can slip through the junction's barrier by quantum tunnelling, and
an ordinary diode, which needs a bigger push.

**Which junction can serve the alarm's wake circuit, and which cannot?**

The example states possibilities and impossibilities side by side, in the
style of constructor theory: both "can" and "cannot" are conclusions.

---

## What we tell Eyeron

Each device is described by a few properties:

```n3
:tunnelJunction a :PNJunction ;
    :junctionKind :TunnelDiode ;
    :doping :Heavy ;
    :depletionWidth :Narrow ;
    :stateAlignment :Overlap ;
    :biasRegime :LowForwardBias ;
    :scanProfile :PeakToValley ;
    :deviceRole :WakeSwitch .
```

The ordinary junction has `:doping :Standard`, `:depletionWidth :Wide` and
`:stateAlignment :NoOverlap`, but the same low bias and the same role.

A chain of rules builds up what the tunnel junction can do. It starts here:

```n3
{
    ?J a :PNJunction ;
        :doping :Heavy ;
        :depletionWidth :Narrow ;
        :stateAlignment :Overlap .
} => {
    ?J :can :QuantumBarrierTransfer .
    ?J :transportMode :TunnelingDominant .
} .
```

*A heavily doped junction with a narrow barrier and overlapping energy states
can move charge through the barrier.* Later rules add, step by step:
sub-threshold current at low bias, a negative differential response when
scanned through its peak and valley, ultra-low-bias switching as a wake
switch, and finally:

```n3
{
    ?J :can :UltraLowBiasSwitching .
    :leakAlarmNode :needs :MicrowattWakeSwitching .
} => {
    ?J :can :ServeLeakAlarmWakeCircuit .
} .
```

A mirror chain of `:cannot` rules starts from the opposite properties:

```n3
{
    ?J a :PNJunction ;
        :doping :Standard ;
        :depletionWidth :Wide ;
        :stateAlignment :NoOverlap .
} => {
    ?J :cannot :QuantumBarrierTransfer .
} .
```

These are positive rules, not negation: a junction is said not to tunnel
because of properties it has, not because Eyeron failed to prove that it
does. Two `log:query` rules at the end print just the `:can` and `:cannot`
statements.

---

## What Eyeron concludes

```n3
:tunnelJunction :can :QuantumBarrierTransfer .
:tunnelJunction :can :SubThresholdCurrent .
:tunnelJunction :can :NegativeDifferentialResponse .
:tunnelJunction :can :UltraLowBiasSwitching .
:tunnelJunction :can :ServeLeakAlarmWakeCircuit .
:ordinaryJunction :cannot :QuantumBarrierTransfer .
:ordinaryJunction :cannot :SubThresholdCurrent .
:ordinaryJunction :cannot :UltraLowBiasSwitching .
:ordinaryJunction :cannot :NegativeDifferentialResponse .
:ordinaryJunction :cannot :ServeLeakAlarmWakeCircuit .
```

The tunnel junction can wake the alarm; the ordinary one cannot. The derived
`:transportMode` is not printed, because no query asks for it.

These conclusions follow from the model's assumptions about the devices.
Eyeron does no device physics: the physics is in which rules were written.

---

## The proof, step by step

The proof has 24 steps. The tunnel junction's chain starts from four of its
facts:

```n3
{ :tunnelJunction :can :QuantumBarrierTransfer . }
  pe:rule 1;
  pe:binding [ pe:var "J"; pe:value :tunnelJunction ];
  pe:uses
    { :tunnelJunction a :PNJunction . },
    { :tunnelJunction :doping :Heavy . },
    { :tunnelJunction :depletionWidth :Narrow . },
    { :tunnelJunction :stateAlignment :Overlap . }.
```

and ends with the alarm's need:

```n3
{ :tunnelJunction :can :ServeLeakAlarmWakeCircuit . }
  pe:rule 5;
  pe:binding [ pe:var "J"; pe:value :tunnelJunction ];
  pe:uses
    { :tunnelJunction :can :UltraLowBiasSwitching . },
    { :leakAlarmNode :needs :MicrowattWakeSwitching . }.
```

Each answer has its own rule step; the given facts appear once each, as
`pe:fact` steps.

---

## Checked: what the report says

```n3
# checked: 24 steps, 24 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 24; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 34; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 43; pe:failed 0 ].
```

- **C1 resolution**, **C2 well-foundedness**, **C3 justification**,
  **C4 coverage**: each step matches its rule or fact, nothing depends on
  itself, and every premise is proved or given.
- **C7 relevance**: every step serves an answer, and every answer is an
  instance of a query.
- **C10 call fidelity**: each printed answer is backed by a real query
  application.

No built-ins, negations or invented individuals occur, so the other
conditions examined nothing. All 24 steps were verified: **checked**.

---

## Try it

```sh
eyeron examples/act-tunnel-junction-wake-switch.n3      # the answer
eyeron -p examples/act-tunnel-junction-wake-switch.n3   # with its proof
eyeron -c examples/act-tunnel-junction-wake-switch.n3   # the proof, checked
```

Change the tunnel junction's `:depletionWidth :Narrow` to `:Wide` and run
again: the tunnel junction drops out of the answer entirely. It no longer
meets the `:can` conditions, and it does not meet the `:cannot` conditions
either, so the model says nothing about it — the two chains are not
automatically each other's opposite.

---

## Takeaway

Chains of plain rules can weigh two designs against each other, and the
proof shows exactly which property of each device decides the outcome.
