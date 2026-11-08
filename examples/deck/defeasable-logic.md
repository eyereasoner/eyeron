# A bird-flight default with an exception

[defeasable-logic.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/defeasable-logic.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/defeasable-logic.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/defeasable-logic.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/defeasable-logic.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=defeasable-logic)

---

## The question

Birds normally fly, while penguins are marked abnormal in this model. N3 rules
use scoped absence tests to apply the default only when its exception is
absent.

**Which birds qualify for the flight default after exceptions are considered?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Strict facts
:tweety a :Bird .

# Taxonomy: every penguin is a bird
{
    ?X a :Penguin
} => {
    ?X a :Bird
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:tweety :flies true .
:polly :flies false .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :tweety :flies true . }
  pe:rule 3;
  pe:binding
    [ pe:var "SCOPE"; pe:value {
        <http://example.org/a> <http://example.org/b> <http://example.org/c> .
    } ],
    [ pe:var "X"; pe:value :tweety ];
  pe:uses
    { :tweety a :Bird . },
    {
        {
            <http://example.org/a> <http://example.org/b> <http://example.org/c> .
        } log:notIncludes {
            :tweety :abnormal true .
        } .
    }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 8 steps, 8 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 12; pe:failed 0 ].
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
eyeron examples/defeasable-logic.n3
eyeron -p examples/defeasable-logic.n3
eyeron -c examples/defeasable-logic.n3
```

---

## Takeaway

A default requires absence of its modeled exception, not just evidence for its
positive premise.
