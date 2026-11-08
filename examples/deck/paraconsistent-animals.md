# Keeping conflicting animal claims inspectable

[paraconsistent-animals.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/paraconsistent-animals.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/paraconsistent-animals.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/paraconsistent-animals.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/paraconsistent-animals.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=paraconsistent-animals)

---

## The question

A quoted animal model can derive both positive and negative flight claims. N3
rules inspect its deductive closure and use scoped absence tests without
treating those ordinary conflicting claims as an inference fuse.

**Which animal claims have positive evidence, negative evidence or both?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 2) Status computation using:
# ?KB log:conclusion ?C .
# ?C  log:includes / log:notIncludes  { ... } .
#
# Status values: :TrueOnly / :FalseOnly / :Both
# Helper: get the closure once per match (no need to print it)
{
    :kb :hasFormula ?F .
    ?F log:conclusion ?C .
    ?C log:includes {
        ?x :canFly true .
    } .
    ?C log:includes {
        ?x :canFly false .
    } .
} => {
    ?x :canFlyStatus :Both .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:tweety :canFlyStatus :Both .
:mythic :canFlyStatus :Both .
:mythic :movesBySafely :Unknown .
:mythic :migratesSafely :Undecided .
:falco :canFlyStatus :TrueOnly .
:batsy :canFlyStatus :TrueOnly .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :mythic :canFlyStatus :Both . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value {
        :tweety a :Bird .
        :tweety a :Penguin .
        :falco a :Bird .
        :opus a :Penguin .
        :batsy a :Mammal .
        :batsy a :Bat .
        :nemo a :Fish .
        :mythic a :Bird .
        :mythic :canFly false .
        {
            :mythic a :Bird .
        } => {
            :mythic :canFly true .
            :mythic :hasWings true .
        } .
        {
            :mythic a :Penguin .
…
        } log:includes {
            :mythic :canFly false .
        } .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 63 steps, 57 verified, 6 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 37; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 26; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 36; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `impure built-in`.

---

## Try it

```sh
eyeron examples/paraconsistent-animals.n3
eyeron -p examples/paraconsistent-animals.n3
eyeron -c examples/paraconsistent-animals.n3
```

---

## Takeaway

Ordinary conflicting claims remain inspectable unless an explicit fuse makes
them fatal.
