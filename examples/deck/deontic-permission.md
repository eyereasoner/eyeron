# Representing permissions across worlds

[deontic-permission.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/deontic-permission.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/deontic-permission.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/deontic-permission.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/deontic-permission.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=deontic-permission)

---

## The question

Linked worlds describe where propositions hold. N3 rules derive permission
from an accessible world and distinguish it from conditions that hold
throughout the accessible worlds.

**Which propositions hold in at least one accessible world?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# accessibility relations between possible worlds
:w1 log:hasAccessTo :w2 .

# P is obligatory in world W if P holds in all worlds accessible from W
{
    ?W1 log:hasAccessTo ?W .
    ?P log:holdsIn ?W1 .
    (
        {
            ?W1 log:hasAccessTo ?W2
        }
        {
            ?P log:holdsIn ?W2
        }
    ) log:forAllIn ?Sc .
} => {
    ?P log:isObligatoryIn ?W1 .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
{
    :s1 :p1 :o1 .
} log:isObligatoryIn :w1 .
{
    :s2 :p2 :o2 .
} log:isObligatoryIn :w1 .
{
    {
        :s3 :p3 :o3 .
    } => false .
} log:isPermittedIn :w2 .
{
    :s3 :p3 :o3 .
} log:isForbiddenIn :w2 .
{
    :s1 :p1 :o1 .
} log:isObligatoryIn :w2 .
{
    :s2 :p2 :o2 .
} log:isObligatoryIn :w2 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :w1 log:hasAccessTo :w2 . }
  pe:fact "deontic-permission.n3".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 30 steps, 30 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 25; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 63; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/deontic-permission.n3
eyeron -p examples/deontic-permission.n3
eyeron -c examples/deontic-permission.n3
```

---

## Takeaway

Permission in this model is witnessed by a suitable accessible world.
