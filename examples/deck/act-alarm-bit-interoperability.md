# Sharing a harbor alarm bit

*A lamp and a relay can pass one bit back and forth; a quantum token cannot be copied the same way.*

[act-alarm-bit-interoperability.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/act-alarm-bit-interoperability.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/act-alarm-bit-interoperability.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/act-alarm-bit-interoperability.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/act-alarm-bit-interoperability.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=act-alarm-bit-interoperability)

---

## The question

A harbor has one alarm: on or off. It is shown by an optical beacon (a blue
or a red lamp) and held in a relay register (low or high voltage). The two
look nothing alike, yet they carry the same bit, so it should be possible to
copy the alarm from one to the other.

The constructor theory of information, by David Deutsch and Chiara Marletto,
describes physics in exactly these terms: which tasks are possible and which
are impossible. It also says that some media, like quantum systems, carry
*superinformation*, whose states cannot all be cloned.

**Which tasks can the harbor perform with its alarm bit, and what is ruled
out for a quantum-like token?**

---

## What we tell Eyeron

Two classical media that encode the same variable, and a quantum-like token:

```n3
:opticalBeacon a :InformationMedium ;
    :encodes :AlarmBit ;
    :zeroState :BlueLamp ;
    :oneState :RedLamp .
…
:quantumToken a :SuperinformationMedium ;
    :encodes :PolarizationVariable ;
```

The relay register is described just like the beacon, with `:LowVoltage` and
`:HighVoltage`. A `;` repeats the subject, so each block is several
statements about one thing.

The key rule: two information media that encode the same variable can
interoperate, and a copy task between them is possible.

```n3
{
    ?A a :InformationMedium ;
        :encodes ?V .
    ?B a :InformationMedium ;
        :encodes ?V .
} => {
    ?A :can :InteroperateForVariable .
    ?B :can :InteroperateForVariable .
    [
        a :PossibleTask ;
        :taskType :Copy ;
        :from ?A ;
        :to ?B ;
        :variable ?V
    ] .
} .
```

The `[ … ]` in the conclusion is a *blank node*: a new, unnamed thing, here a
task, that the rule says exists each time it fires. Nothing requires `?A` and
`?B` to differ, so a medium paired with itself also gets a copy task.

Two more rules handle the token: a superinformation medium `:cannot
:UniversalClone`, and whatever cannot be universally cloned also cannot fan
its whole state space out freely. The first rule lets each classical medium
flip its own bit (`:LocalPermutation`).

---

## What Eyeron concludes

`log:query` rules pick what to print: every *can* and *cannot*, and every copy
task as a pair `(from to)`:

```n3
:opticalBeacon :can :LocalPermutation .
:relayRegister :can :LocalPermutation .
:opticalBeacon :can :InteroperateForVariable .
:relayRegister :can :InteroperateForVariable .
:quantumToken :cannot :UniversalClone .
:quantumToken :cannot :UnrestrictedStateFanOut .
(:opticalBeacon :relayRegister) :canCopy :AlarmBit .
(:relayRegister :opticalBeacon) :canCopy :AlarmBit .
```

The alarm can be copied either way between beacon and relay. The answer also
lists `(:opticalBeacon :opticalBeacon)` and `(:relayRegister :relayRegister)`:
copying within one medium, which the rule allows as it is written. The token
gets only *cannot* statements.

---

## The proof, step by step

The proof has 40 steps. A copy answer cites the query rule and the five
statements about one task. That task is a blank node, written with a label
such as `_:b2_3711e27ffff54b58`:

```n3
{ (:opticalBeacon :relayRegister) :canCopy :AlarmBit . }
…
  pe:uses
    { _:b2_3711e27ffff54b58 a :PossibleTask . },
    { _:b2_3711e27ffff54b58 :taskType :Copy . },
    { _:b2_3711e27ffff54b58 :from :opticalBeacon . },
    { _:b2_3711e27ffff54b58 :to :relayRegister . },
    { _:b2_3711e27ffff54b58 :variable :AlarmBit . }.
```

Each of those five statements comes from rule 2 firing with beacon and relay:

```n3
{ _:b2_3711e27ffff54b58 a :PossibleTask . }
  pe:rule 2;
  pe:binding
    [ pe:var "A"; pe:value :opticalBeacon ],
    [ pe:var "B"; pe:value :relayRegister ],
    [ pe:var "V"; pe:value :AlarmBit ];
```

The token's limits are two short steps: rule 3 from its two facts, then
rule 4 from that.

---

## Checked, with obligations

```n3
# checked with obligations: 40 steps, 20 verified, 20 trusted
pe:verdict pe:checkedWithObligations;
pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 20; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 4; pe:failed 0 ];
```

- **C1 resolution** confirms all 40 steps against the program's rules and
  facts, and **C2, C3, C4, C7, C10** that they are well founded, justified,
  complete, relevant and answer the calls as made.
- **C8 witness integrity** examines the 20 statements about the four copy
  tasks: each task label is fresh, mentioned nowhere in the program, and used
  consistently by one firing of rule 2.
- **C6 boundary consistency** looks at the four task introductions and finds
  nothing in the proof's own evidence that already satisfied them.

Those 20 statements are the trusted part. When a rule says "there is a task
such that …", Eyeron introduces a new one only if no such task was already
there. The proof does not record everything the run derived, so the checker
cannot confirm that; it lists one `unsatisfied` obligation per statement:

```n3
pe:kind "unsatisfied";
_:b2_3711e27ffff54b58 :to :relayRegister .
```

The verdict **checked with obligations** means: the answers follow from the
program, provided no task like these existed before the rule made one.

---

## Try it

```sh
eyeron examples/act-alarm-bit-interoperability.n3      # the answer
eyeron -p examples/act-alarm-bit-interoperability.n3   # the answer with its proof
eyeron -c examples/act-alarm-bit-interoperability.n3   # the proof, checked
```

Add a third medium for the same bit, such as
`:sirenPanel a :InformationMedium ; :encodes :AlarmBit ; :zeroState :Silent ; :oneState :Sounding .`,
and run again: the copy answers grow from 4 to 9, every ordered pair of the
three media.

---

## Takeaway

Stating what is possible and impossible as rules lets Eyeron work out which
media can share a bit, and the check says honestly which part rests on the
assumption that each new task really was new.
