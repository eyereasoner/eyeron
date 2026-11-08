# Placing four nonattacking queens

[four-queens.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/four-queens.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/four-queens.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/four-queens.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/four-queens.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=four-queens)

---

## The question

Four row choices define a small chessboard search. Recursive backward N3 rules
build placements and check that queens share neither a row nor a diagonal.

**Which placements keep all four queens out of each other's attack lines?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Row choices are 1 through 4; each new list item occupies the next column.
:r1 a :Row ;
    :n 1 .

# Start with four empty columns and report every complete safe placement.
{
    (4 ()) :place ?rows
} => {
    :query :solution ?rows
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
:query :solution (3 1 4 2) .
:query :solution (2 4 1 3) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :query :solution (3 1 4 2) . }
  pe:rule 5;
  pe:binding [ pe:var "rows"; pe:value (3 1 4 2) ];
  pe:uses { (4 ()) :place (3 1 4 2) . }.
```

`pe:rule 5` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 86 steps, 86 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 40; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 46; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 32; pe:failed 0 ].
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
eyeron examples/four-queens.n3
eyeron -p examples/four-queens.n3
eyeron -c examples/four-queens.n3
```

---

## Takeaway

Recursion builds candidate placements while row and diagonal checks reject
conflicts.
