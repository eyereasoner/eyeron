# A default confronted by explicit contrary evidence

[nixon-diamond.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/nixon-diamond.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/nixon-diamond.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/nixon-diamond.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/nixon-diamond.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=nixon-diamond)

---

## The question

Nixon is both a Quaker and a Republican in a small default model. N3 rules
derive a nonpacifist classification and guard the pacifist default with a
scoped absence test.

**Does the pacifist default survive the explicit contrary classification?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Facts
ex:RichardNixon a ex:Quaker, ex:Republican .

# Rule 1  (lower priority)  – “Usually Quakers are pacifist”
# Fires only when NON-pacifism has **not** already been derived for ?x
{
    ?x a ex:Quaker .
    ?SCOPE log:notIncludes {
        ?x a ex:NonPacifist
    } .
    # SNAF guard
} => {
    ?x a ex:Pacifist
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
ex:RichardNixon a ex:Quaker .
ex:RichardNixon a ex:Republican .
ex:RichardNixon a ex:NonPacifist .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ex:RichardNixon a ex:NonPacifist . }
  pe:rule 2;
  pe:binding [ pe:var "x"; pe:value ex:RichardNixon ];
  pe:uses { ex:RichardNixon a ex:Republican . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/nixon-diamond.n3
eyeron -p examples/nixon-diamond.n3
eyeron -c examples/nixon-diamond.n3
```

---

## Takeaway

A positive exception can prevent an absence-guarded default from applying.
