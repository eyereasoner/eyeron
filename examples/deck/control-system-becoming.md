# Developing a controller revision

[control-system-becoming.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/control-system-becoming.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/control-system-becoming.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/control-system-becoming.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/control-system-becoming.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=control-system-becoming)

---

## The question

An approved controller supplies a baseline for a new design goal. N3 rules
inherit validated requirements, select a compatible strategy, and derive a new
controller that can become the next baseline.

**Which compatible controller revision can grow from the approved baseline?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# CATEGORIES
:ControllerRevision a :Category .

# RULE 1
# A NEW REVISION INHERITS PREVIOUSLY SATISFIED REQUIREMENTS
{
    ?later :derivesFrom ?earlier .
    ?earlier :satisfies ?req .
} => {
    ?later :inheritsRequirement ?req .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:c2 :considers :leadCompensator .
:c2 :targets :overshootReq .
:c3 :satisfies :stabilityReq .
:c3 :satisfies :trackingReq .
:c3 :considers :integralAction .
:c3 :targets :disturbanceRejectionReq .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :c2 :considers :leadCompensator . }
  pe:rule 2;
  pe:binding
    [ pe:var "ctrl"; pe:value :c2 ],
    [ pe:var "goal"; pe:value :reduceOvershoot ],
    [ pe:var "strategy"; pe:value :leadCompensator ];
  pe:uses
    { :c2 :designGoal :reduceOvershoot . },
    { :reduceOvershoot :suggests :leadCompensator . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 52 steps, 52 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 52; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 33; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/control-system-becoming.n3
eyeron -p examples/control-system-becoming.n3
eyeron -c examples/control-system-becoming.n3
```

---

## Takeaway

Inherited requirements and a new goal jointly determine the supported
revision.
