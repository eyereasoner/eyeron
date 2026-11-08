# A comparison written before its input fact

[well-formedness-error.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/well-formedness-error.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/well-formedness-error.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/well-formedness-error.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/well-formedness-error.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=well-formedness-error)

---

## The question

Alice has a score, but the rule writes its numeric comparison before the
clause that binds that score. Eyeron resolves the premises and derives the
classification, illustrating premise reordering.

**Can the rule evaluate a score comparison that is written before the score fact?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The score fact supplies the comparison input.
:alice :score 10 .

# Despite the filename, this is accepted: Eyeron binds score from the
# second premise before applying the first premise's numeric comparison.
{
    ?score math:greaterThan 5 .
    :alice :score ?score .
} => {
    :alice a :Bad
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:alice a :Bad .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :alice a :Bad . }
  pe:rule 1;
  pe:binding [ pe:var "score"; pe:value 10 ];
  pe:uses
    { 10 math:greaterThan 5 . },
    { :alice :score 10 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
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
eyeron examples/well-formedness-error.n3
eyeron -p examples/well-formedness-error.n3
eyeron -c examples/well-formedness-error.n3
```

---

## Takeaway

The example succeeds by resolving the comparison's input before testing it.
