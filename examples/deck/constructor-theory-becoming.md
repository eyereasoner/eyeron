# Building a sequence of possible transformations

[constructor-theory-becoming.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/constructor-theory-becoming.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/constructor-theory-becoming.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/constructor-theory-becoming.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/constructor-theory-becoming.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=constructor-theory-becoming)

---

## The question

A substrate can move between named attributes when suitable constructors are
available. N3 rules distinguish possible and impossible tasks and derive the
states reachable through supported transformations.

**Which attributes are reachable through the available constructors?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# CATEGORIES
:SubstrateVersion a :Category .

# RULE 1
# A TASK FORBIDDEN BY A PRINCIPLE IS IMPOSSIBLE
{
    ?task :forbiddenBy ?principle .
} => {
    ?task :status :impossibleTask .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:perfectRestoreTask :status :impossibleTask .
:writeTask :status :possibleTask .
:v3 :hasAttribute :stabilizedMemory .
:v3 :availableForFurtherTask :yes .
:writer :retainsCapacityFor :writeTask .
:stabilizeTask :status :possibleTask .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :perfectRestoreTask :status :impossibleTask . }
  pe:rule 1;
  pe:binding
    [ pe:var "principle"; pe:value :noMiraclePrinciple ],
    [ pe:var "task"; pe:value :perfectRestoreTask ];
  pe:uses { :perfectRestoreTask :forbiddenBy :noMiraclePrinciple . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 30 steps, 30 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 30; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 16; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/constructor-theory-becoming.n3
eyeron -p examples/constructor-theory-becoming.n3
eyeron -c examples/constructor-theory-becoming.n3
```

---

## Takeaway

Reachability follows from the transformation tasks declared possible in this
model.
