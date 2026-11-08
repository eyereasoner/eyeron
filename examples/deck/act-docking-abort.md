# Propagating a docking abort signal

*One abort bit, four very different carriers, and a quantum seal that refuses to be copied.*

[act-docking-abort.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/act-docking-abort.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/act-docking-abort.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/act-docking-abort.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/act-docking-abort.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=act-docking-abort)

---

## The question

A spacecraft is docking when something goes wrong. The abort signal is a
single bit, but it has to show up on a lamp (green or red), in the flight
controller (low or high voltage), in a radio frame, and on an audit display
that records what happened. The docking hatch also carries a quantum
authenticity seal.

The constructor theory of information, by David Deutsch and Chiara Marletto,
treats such questions as a list of possible and impossible *tasks*. Classical
information can be copied freely between unlike media; quantum
superinformation cannot be universally cloned.

**Which tasks can the docking bay perform with its abort bit, and what is
ruled out for the seal?**

---

## What we tell Eyeron

Four media encode the same `:AbortBit`, each with its own two states:

```n3
:abortLamp a :InformationMedium ;
    :encodes :AbortBit ;
    :zeroState :Green ;
    :oneState :Red .
…
:quantumSeal a :SuperinformationMedium ;
    :encodes :SealVariable .
```

The first rule says what each medium can do on its own: flip its bit, clone
it locally, and tell its two states apart. The next two say that the bit can
be copied, and measured, from any medium into any other that carries it:

```n3
{
    ?A a :InformationMedium ;
        :encodes ?V .
    ?B a :InformationMedium ;
        :encodes ?V .
} => {
    [
        a :PossibleTask ;
        :kind :Copy ;
        :from ?A ;
        :to ?B ;
        :variable ?V
    ] .
} .
```

The `[ … ]` is a *blank node*: an unnamed task that the rule says exists.

---

## How tasks combine

Tasks can be chained. Here a blank node appears on the *left* of a rule as
well, where it simply means "some task with this description":

```n3
# Serial composition: copy into an intermediate medium, then measure from there.
{
    [
        a :PossibleTask ;
        :kind :Copy ;
        :from ?A ;
        :to ?B ;
        :variable ?V
    ] .
…
} => {
    [
        a :PossibleTask ;
        :kind :SerialNetwork ;
        :from ?A ;
        :via ?B ;
        :to ?C ;
        :variable ?V
    ] .
} .
```

A parallel network fans one source out to two targets in the same way. For
the seal, a superinformation medium `:cannot :UniversalClone`, and then it
also `:cannot :UnrestrictedAuditFanOut`.

---

## What Eyeron concludes

Each classical medium can flip and clone its bit, and the seal cannot be
cloned or fanned out:

```n3
:abortLamp :can :LocalPermutation .
:abortLamp :can :LocalClone .
…
:auditDisplay :can :LocalClone .
:quantumSeal :cannot :UniversalClone .
:quantumSeal :cannot :UnrestrictedAuditFanOut .
```

The bit can be copied between every pair of the four media, 16 copy answers
in all, such as:

```n3
(:abortLamp :auditDisplay) :canCopy :AbortBit .
(:radioFrame :flightPLC) :canCopy :AbortBit .
```

Nothing stops a rule from pairing a medium with itself, so the list also
contains copies like `(:abortLamp :abortLamp)`. Finally, the queries report
only *that* networks are possible, not which media they link:

```n3
:SerialNetwork a :PossibleTask .
:ParallelNetwork a :PossibleTask .
```

---

## The proof, step by step

The proof has 136 steps, most of them statements about tasks. It shows the
serial network with the first chain the reasoner found, and that chain is
the simplest one: copy the lamp to itself, then measure the lamp into
itself.

```n3
{ _:b7_145b3fbe5c3c9d00 a :PossibleTask . }
  pe:rule 4;
  pe:binding
    [ pe:var "A"; pe:value :abortLamp ],
    [ pe:var "B"; pe:value :abortLamp ],
    [ pe:var "C"; pe:value :abortLamp ],
    [ pe:var "V"; pe:value :AbortBit ];
  pe:uses
    { _:b3_8fad4d18d00ca2a a :PossibleTask . },
    { _:b3_8fad4d18d00ca2a :kind :Copy . },
…
    { _:b4_8fad4d18d00ca2a :kind :Measure . },
```

That is a valid answer to "is some serial network possible?", but it is a
reminder that the rules, as written, accept trivial chains.

---

## Checked, with obligations

```n3
# checked with obligations: 136 steps, 47 verified, 89 trusted
pe:verdict pe:checkedWithObligations;
pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 89; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 19; pe:failed 0 ];
```

- **C1 resolution** re-performs all 136 steps against the program, and
  **C2, C3, C4, C7, C10** confirm they are well founded, justified, complete,
  relevant, and answer each call as it was made.
- **C8 witness integrity** examines the 89 statements about new tasks: each
  task label is fresh and belongs to one firing of one rule.
- **C6 boundary consistency** checks the 19 task introductions against the
  proof's own evidence and finds nothing that already satisfied them.

The 89 trusted steps are those same task statements. A rule that says "there
is a task such that …" adds one only if no such task already existed, and
the proof cannot show that nothing else in the run did. So each becomes an
`unsatisfied` obligation, like this one:

```n3
pe:kind "unsatisfied";
_:b3_8fad4d18d00ca2a :kind :Copy .
```

The answers follow from the program, provided those introductions were
genuinely new.

---

## Try it

```sh
eyeron examples/act-docking-abort.n3      # the answer
eyeron -p examples/act-docking-abort.n3   # the answer with its proof
eyeron -c examples/act-docking-abort.n3   # the proof, checked
```

Add the line
`:quantumSeal a :InformationMedium ; :zeroState :SealOpen ; :oneState :SealClosed .`
and run again. The seal now gets `:can :LocalPermutation` and
`:can :LocalClone` next to `:cannot :UniversalClone`. Eyeron does not object:
no rule says that *can* and *cannot* clash, so a model that should be
consistent needs a rule that looks for such conflicts.

---

## Takeaway

Small rules about possible tasks compose into networks of copies and
measurements; the proof shows exactly which chain was used, and the check is
honest that each new task rests on an assumption.
