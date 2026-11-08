# Tracing shared-fork coordination

[dining-philosophers.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/dining-philosophers.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/dining-philosophers.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/dining-philosophers.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/dining-philosophers.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=dining-philosophers)

---

## The question

Five philosophers share forks whose ownership and clean or dirty state change
over rounds. N3 rules construct the supplied Chandy–Misra-style trace and
check that each philosopher eats three times.

**Does the supplied shared-fork trace let each philosopher eat three times?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Minimal vocabulary
dp:Philosopher a dp:Class .

# Chandy–Misra rules
# R1: Hungry philosophers request any adjacent fork they do not hold.
# (We do left and right separately for clarity.)
{
    ?C a dp:Config .
    ?C dp:hungry ?P .
    ?P dp:leftFork ?F .
    [ a dp:ForkState ; dp:in ?C ; dp:fork ?F ; dp:holder ?Q ] .
    ?Q log:notEqualTo ?P .
} => {
    [ a dp:Request ; dp:in ?C ; dp:from ?P ; dp:to ?Q ; dp:fork ?F ] .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
_:b26_9becced462d6de a dp:Request .
_:b26_9becced462d6de dp:in dp:C0 .
_:b40_a2117ddfcb17c961 dp:holder dp:P2 .
_:b40_a2117ddfcb17c961 dp:cleanliness dp:Dirty .
_:b26_9becced462d6de dp:from dp:P3 .
_:b26_9becced462d6de dp:to dp:P2 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ _:b26_9becced462d6de a dp:Request . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value dp:C0 ],
    [ pe:var "F"; pe:value dp:F23 ],
    [ pe:var "P"; pe:value dp:P3 ],
    [ pe:var "Q"; pe:value dp:P2 ];
  pe:uses
    { dp:C0 a dp:Config . },
    { dp:C0 dp:hungry dp:P3 . },
    { dp:P3 dp:leftFork dp:F23 . },
    { _:b2 a dp:ForkState . },
    { _:b2 dp:in dp:C0 . },
    { _:b2 dp:fork dp:F23 . },
    { _:b2 dp:holder dp:P2 . },
    { dp:P2 log:notEqualTo dp:P3 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 1033 steps, 323 verified, 710 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 1023; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 10; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 710; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 806; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `unsatisfied`.

---

## Try it

```sh
eyeron examples/dining-philosophers.n3
eyeron -p examples/dining-philosophers.n3
eyeron -c examples/dining-philosophers.n3
```

---

## Takeaway

The rules expose the ownership and cleanliness conditions at each coordination
step.
