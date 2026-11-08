# Resetting a sensor's alarm memory

*A battery can wipe the alarm bit; warm surroundings alone cannot.*

[act-sensor-memory-reset.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/act-sensor-memory-reset.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/act-sensor-memory-reset.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/act-sensor-memory-reset.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/act-sensor-memory-reset.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=act-sensor-memory-reset)

---

## The question

A radiation sensor remembers an alarm in a single bit, now set to *Alarm*.
Before the sensor can be used again, the bit must be put back to *Clear*,
reliably. Two resources are at hand: a charged battery pack, and the room
around it, a bath of ambient heat.

**Can the battery reset the memory? Can the warm room do it alone?**

The example is written in the style of *constructor theory*, a way of doing
physics that states which tasks are possible and which are impossible. Here
"cannot" is something Eyeron derives and prints, just like "can".

---

## What we tell Eyeron

The situation, as facts:

```n3
:alarmLatch a :OneBitMemory ;
    :zeroState :Clear ;
    :oneState :Alarm ;
    :currentState :Alarm .
…
:batteryPack a :WorkMedium ;
    :chargeState :Charged ;
    :canSupply :DirectedEnergyTransfer .
…
:ambientBath a :HeatMedium ;
    :temperatureBand :RoomTemperature ;
    :provides :UndirectedThermalContact .
```

`;` repeats the subject, so each block says several things about one thing.
A battery is a *work medium*: it can push energy in a chosen direction. The
room is a *heat medium*: it only offers undirected thermal contact.

Rules then say what is possible. The first one:

```n3
{
    ?W a :WorkMedium ;
        :chargeState :Charged ;
        :canSupply :DirectedEnergyTransfer .
    ?M a :OneBitMemory .
} => {
    ?W :can :DriveControlledReset .
    ?M :can :ReliableResetFromWork .
} .
```

*A charged work medium that can transfer energy directionally can drive a
controlled reset, and a one-bit memory can then be reliably reset from
work.* Further rules chain this into *the memory can be prepared in its
standard state* and *the sensor is ready for reuse*.

And what is impossible:

```n3
{
    ?H a :HeatMedium ;
        :provides :UndirectedThermalContact .
    ?M a :OneBitMemory .
} => {
    ?H :cannot :DriveControlledReset .
    ?M :cannot :ReliableResetFromHeatAlone .
} .
```

This is not negation, "it failed to find a way". It is a positive statement
the model makes: undirected heat is not a resource for a controlled reset.

Last, two `log:query` rules choose what to print: every `:can` and every
`:cannot` statement, and nothing else.

---

## What Eyeron concludes

```n3
:batteryPack :can :DriveControlledReset .
:alarmLatch :can :ReliableResetFromWork .
:alarmLatch :can :PrepareStandardState .
:batteryPack :can :DegradeToHeatDuringReset .
:alarmSensor :can :ReadyForReuse .
:ambientBath :cannot :DriveControlledReset .
:alarmLatch :cannot :ReliableResetFromHeatAlone .
:ambientBath :cannot :ReconstructChargedWorkMediumByItself .
:alarmLatch :cannot :PrepareStandardStateFromHeatAlone .
:alarmSensor :cannot :ReadyForReuseFromHeatAlone .
```

With the battery, the sensor is ready for reuse; with only the room, it is
not. One more pair shows the one-way street: using the battery degrades its
work into heat, and the room cannot turn that heat back into a charged
battery by itself.

These follow from the model's assumptions, written as rules; Eyeron does not
compute any physics.

---

## The proof, step by step

The proof has 18 steps: 8 given facts and 10 rule applications. The chain
behind *the room alone cannot ready the sensor* ends like this:

```n3
{ :alarmLatch :cannot :PrepareStandardStateFromHeatAlone . }
  pe:rule 6;
  pe:binding [ pe:var "M"; pe:value :alarmLatch ];
  pe:uses { :alarmLatch :cannot :ReliableResetFromHeatAlone . }.

{ :alarmSensor :cannot :ReadyForReuseFromHeatAlone . }
  pe:rule 7;
  pe:binding [ pe:var "M"; pe:value :alarmLatch ];
  pe:uses
    { :alarmSensor :hasMemory :alarmLatch . },
    { :alarmLatch :cannot :PrepareStandardStateFromHeatAlone . }.
```

and the irreversibility conclusion rests on the battery's degradation path:

```n3
{ :ambientBath :cannot :ReconstructChargedWorkMediumByItself . }
  pe:rule 8;
  pe:binding
    [ pe:var "H"; pe:value :ambientBath ],
    [ pe:var "W"; pe:value :batteryPack ];
  pe:uses
    { :batteryPack :can :DegradeToHeatDuringReset . },
    { :ambientBath a :HeatMedium . }.
```

The `log:query` rules need no steps of their own: each answer they select is
already proved.

---

## Checked: what the report says

```n3
# checked: 18 steps, 18 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 18; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 28; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 46; pe:failed 0 ].
```

- **C1 resolution**, **C2 well-foundedness**, **C3 justification** and
  **C4 coverage**: every step matches the rule or fact it cites, nothing
  depends on itself, and every premise is accounted for.
- **C7 relevance**: every step serves an answer, and every answer is one a
  query asks for.
- **C10 call fidelity**: each printed answer has a real query application
  behind it, not just the right shape.

No built-ins, negations or invented individuals are involved, so the other
conditions examined nothing. All 18 steps were verified: **checked**.

---

## Try it

```sh
eyeron examples/act-sensor-memory-reset.n3      # the answer
eyeron -p examples/act-sensor-memory-reset.n3   # with its proof
eyeron -c examples/act-sensor-memory-reset.n3   # the proof, checked
```

Change the battery's `:chargeState :Charged` (in its facts, not in the rules)
to `:Empty` and run again: every `:can` conclusion disappears, and so does
the irreversibility statement, which needed the battery's degradation path.
The four statements about heat alone remain.

---

## Takeaway

Possibility and impossibility can both be written as plain rules, and Eyeron
shows, step by step, why the battery can reset the alarm and why the warm
room alone cannot.
