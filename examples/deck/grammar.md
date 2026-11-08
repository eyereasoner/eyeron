# Parsing a tiny command language

[grammar.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/grammar.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/grammar.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/grammar.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/grammar.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=grammar)

---

## The question

Commands consist of a supported verb followed by a supported noun. Backward N3
rules consume input lists and derive a structured command together with any
unconsumed words.

**Can the two input words be consumed as a complete command?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# An empty remainder requires the whole two-word command to be consumed.
{
    ((:open :door) ()) :sentence ?ast
} => {
    :query :parsed ?ast
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:query :parsed (:command :open :door) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :query :parsed (:command :open :door) . }
  pe:rule 6;
  pe:binding [ pe:var "ast"; pe:value (:command :open :door) ];
  pe:uses { ((:open :door) ()) :sentence (:command :open :door) . }.
```

`pe:rule 6` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 6 steps, 6 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
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
eyeron examples/grammar.n3
eyeron -p examples/grammar.n3
eyeron -c examples/grammar.n3
```

---

## Takeaway

Passing the remaining word list between rules expresses a small parser.
