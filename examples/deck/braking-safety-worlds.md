# Comparing stopping-distance models

[braking-safety-worlds.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/braking-safety-worlds.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/braking-safety-worlds.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/braking-safety-worlds.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/braking-safety-worlds.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=braking-safety-worlds)

---

## The question

Several models assess the same braking scenarios with different assumptions.
N3 rules calculate stopping distances and compare the resulting safety
judgments, including the effect of reaction time.

**Which braking scenarios change verdict when a model includes reaction time?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Worlds and scenarios
:World a rdfs:Class .

# Core stopping-distance rules
# World 0: physics-based distance with 1.0s reaction
#
# d_react = v * 1.0
# d_brake = v^2 / (2 mu g) with g ≈ 9.8
# d_stop  = d_react + d_brake
{
    ?S :stopDistance_W0 ?d0 .
} <= {
    ?S a :Scenario ;
        :speed ?v ;
        :mu ?mu .

    (?v 1.0) math:product ?d_react .

    (?v 2) math:exponentiation ?v2 .
    (?mu 2.0) math:product ?tmp1 .
    (?tmp1 9.8) math:product ?denom .
    (?v2 ?denom) math:quotient ?d_brake .

    (?d_react ?d_brake) math:sum ?d0 .
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
:CityDry :safeInWorld :W0 .
:CityWet :safeInWorld :W0 .
:CityWet :riskyInWorld :W3 .
:CityIce :riskyInWorld :W3 .
:CityDry :safeInWorld :W1 .
:HighwayDryShortGap :safeInWorld :W1 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :CityDry :safeInWorld :W0 . }
  pe:rule 5;
  pe:binding
    [ pe:var "S"; pe:value :CityDry ],
    [ pe:var "d0"; pe:value 26.222066326530612 ],
    [ pe:var "da"; pe:value 40.0 ];
  pe:uses
    { :CityDry :stopDistance_W0 26.222066326530612 . },
    { :CityDry :availDistance 40.0 . },
    { 26.222066326530612 math:notGreaterThan 40.0 . }.
```

`pe:rule 5` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 94 steps, 94 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 48; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 46; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 184; pe:failed 0 ].
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
eyeron examples/braking-safety-worlds.n3
eyeron -p examples/braking-safety-worlds.n3
eyeron -c examples/braking-safety-worlds.n3
```

---

## Takeaway

A safety label depends on the model assumptions as well as the scenario
inputs.
