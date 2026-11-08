# Developing an engineering design

[engineering-becoming.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/engineering-becoming.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/engineering-becoming.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/engineering-becoming.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/engineering-becoming.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=engineering-becoming)

---

## The question

A validated design supplies requirements for a later revision. N3 rules
evaluate options against a new goal and derive a compatible revision that can
serve as a future baseline.

**Which design revision meets the new goal and inherited requirements?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# CATEGORIES
:DesignRevision a :Category .

# RULE 1
# A NEW REVISION INHERITS SATISFIED REQUIREMENTS
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
:r2 :considers :carbonFrame .
:r3 :considers :ribbedHousing .
:r3 :availableForFutureIteration :yes .
:r3 :status :approvedBaseline .
:r2 :inheritsRequirement :stiffnessReq .
:r2 :inheritsRequirement :assemblyReq .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :r2 :considers :carbonFrame . }
  pe:rule 2;
  pe:binding
    [ pe:var "goal"; pe:value :reduceWeight ],
    [ pe:var "opt"; pe:value :carbonFrame ],
    [ pe:var "rev"; pe:value :r2 ];
  pe:uses
    { :r2 :designGoal :reduceWeight . },
    { :reduceWeight :suggests :carbonFrame . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 37 steps, 37 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 37; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 24; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/engineering-becoming.n3
eyeron -p examples/engineering-becoming.n3
eyeron -c examples/engineering-becoming.n3
```

---

## Takeaway

A validated baseline supplies constraints for the next supported design.
