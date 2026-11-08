# Deriving successive relational occasions

[whitehead-becoming.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/whitehead-becoming.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/whitehead-becoming.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/whitehead-becoming.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/whitehead-becoming.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=whitehead-becoming)

---

## The question

A small philosophical model links past occasions, inherited features,
potential forms, and aims. N3 rules derive new occasions and their realized
properties from those relationships.

**Which new occasions and properties follow from the supplied relational model?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# CATEGORIES
:ActualOccasion a :Category .

# RULE 1
# PREHENSION AS BECOMING-FROM
{
    ?later :prehends ?earlier .
} => {
    ?later :becomesFrom ?earlier .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:o1 :ingresses :red .
:o1 :ingresses :warm .
:o3 :ingresses :bright .
:o3 :ingresses :warm .
:o2 :mayRealize :bright .
:o3 :mayRealize :dark .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :o1 :ingresses :red . }
  pe:rule 6;
  pe:binding
    [ pe:var "form"; pe:value :red ],
    [ pe:var "o"; pe:value :o1 ];
  pe:uses
    { :o1 :realizes :red . },
    { :red a :PurePotential . }.
```

`pe:rule 6` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 53 steps, 53 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 53; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 40; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/whitehead-becoming.n3
eyeron -p examples/whitehead-becoming.n3
eyeron -c examples/whitehead-becoming.n3
```

---

## Takeaway

New modeled occasions inherit evidence and realize the forms supported by the
written rules.
