# Quantum Darwinism, a Toy Model

*Which observers agree on what they see? A rule-based cartoon of a physics idea.*

[quantum-darwinism.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/quantum-darwinism.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/quantum-darwinism.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/quantum-darwinism.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/quantum-darwinism.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=quantum-darwinism)

---

## The question

*Quantum Darwinism*, an idea of the physicist Wojciech Zurek, explains why
different observers agree about the world: the environment favours stable
"pointer" states, and records of them spread so widely that everyone reads
the same thing.

This example is a cartoon of that idea, not physics: amplitudes are just
numbers, and the "laws" are a handful of rules. Four observers each measure
one state.

**Which observers agree, and which disagree?**

---

## What we tell Eyeron

Four states with amplitudes; two of them are pointer states, and two pairs
are entangled:

```n3
:state1 a :QuantumState ;
    :hasAmplitude 0.9 ;
    :isPointerState true .
…
:state1 :entangledWith :state3 .
:state2 :entangledWith :state4 .
```

Who measures what: alice measures state1, bob state3, carol state2 and dave
state4. Pointer states decohere, and decohered states are observable:

```n3
{
    ?S a :QuantumState ;
        :isPointerState true
} => {
    ?S :hasDecohered true
} .
```

An observer estimates the amplitude of the state it measures, and observers
of entangled states are compared:

```n3
    ?O1 :estimatesAmplitude ?A1 .
    ?O2 :estimatesAmplitude ?A2 .
    ?A1 log:notEqualTo ?A2 .
} => {
    ?O1 :disagreesWith ?O2 .
} .
```

Agreement needs equal estimates *and* both states decohered. A third rule,
using `log:notIncludes`, says observers with equal estimates disagree when
the states have not both decohered. States also evolve (state1 into state5,
state2 into state6), inheriting amplitude, pointer status and entanglement.

---

## What Eyeron concludes

```n3
:alice :agreesWith :bob .
:carol :disagreesWith :dave .
```

Alice and Bob measured entangled pointer states with the same amplitude 0.9:
they agree. Carol and Dave measured entangled states with amplitudes 0.4 and
0.3: they disagree. Along the way:

```n3
:state1 :isObservable true .
:state5 :hasDecohered true .
:state5 :entangledWith :state3 .
```

The evolved state5 is a pointer state too, so it decoheres, and it inherits
state1's entanglement. Each pair is compared in one direction only, the
direction of its entanglement link.

---

## The proof: why carol and dave disagree

```n3
{ :carol :disagreesWith :dave . }
  pe:rule 6;
…
  pe:uses
    { :carol :measures :state2 . },
    { :dave :measures :state4 . },
    { :state2 :entangledWith :state4 . },
    { :carol :estimatesAmplitude 0.4 . },
    { :dave :estimatesAmplitude 0.3 . },
    { 0.4 log:notEqualTo 0.3 . }.
```

The disagreement rests on two measurement facts, the entanglement fact, the
two derived estimates and one built-in comparison. The whole proof has 39
steps: 22 rule steps, 16 facts and that one comparison. The `log:notIncludes`
rule never fired, so it is not in the proof.

---

## Checked: what the report says

```n3
# checked: 39 steps, 39 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 22; pe:failed 0 ].
```

- **C1–C4, C7**: each rule step matches its rule, nothing is circular, every
  premise is justified, every answer covered, nothing superfluous.
- **C5 re-decision**: the checker compared 0.4 and 0.3 itself.
- **C10 call fidelity**: the derived statements are reported as derived.

Nothing was taken on trust: **checked**.

---

## Try it

```sh
eyeron examples/quantum-darwinism.n3      # the answer
eyeron -p examples/quantum-darwinism.n3   # with its proof
eyeron -c examples/quantum-darwinism.n3   # the proof, checked
```

Change dave's state to `:hasAmplitude 0.4` and run again: carol and dave now
have equal estimates, but their states never decohered, so the
`log:notIncludes` rule makes them disagree instead.

---

## Takeaway

A few chained rules can tell a story about agreement, and the proof shows
exactly which facts made two observers agree or not; it says nothing about
real quantum physics.
