# Solving a Sudoku and checking its cells

[sudoku.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/sudoku.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/sudoku.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/sudoku.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/sudoku.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=sudoku)

---

## The question

The supplied nine-by-nine puzzle is solved through the sudoku:solve built-in.
N3 rules work with the returned grid and derive the example's solution facts
and checks.

**Which full grid satisfies the supplied puzzle, and what value is in each cell?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Map digit characters returned by the solver to their numeric values.
:digit1 :char "1" ;
    :digitValue 1 .

# Ask the Sudoku built-in for a solution satisfying the puzzle constraints.
{
    :case :puzzle ?puzzle .
    ?puzzle sudoku:solve ?solution .
} => {
    :case :solution ?solution
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:case :solution "162857493534129678789643521475312986913586742628794135356478219241935867897261354" .
:r1c1 :value 1 .
:r8c4 :value 9 .
:r9c2 :value 9 .
:r2c4 :value 1 .
:r3c9 :value 1 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :case :solution "162857493534129678789643521475312986913586742628794135356478219241935867897261354" . }
  pe:rule 1;
  pe:binding
    [ pe:var "puzzle"; pe:value "100007090030020008009600500005300900010080002600004000300000010040000007007000300" ],
    [ pe:var "solution"; pe:value "162857493534129678789643521475312986913586742628794135356478219241935867897261354" ];
  pe:uses
    { :case :puzzle "100007090030020008009600500005300900010080002600004000300000010040000007007000300" . },
    { "100007090030020008009600500005300900010080002600004000300000010040000007007000300" sudoku:solve "162857493534129678789643521475312986913586742628794135356478219241935867897261354" . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 426 steps, 426 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 182; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 244; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 82; pe:failed 0 ].
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
eyeron examples/sudoku.n3
eyeron -p examples/sudoku.n3
eyeron -c examples/sudoku.n3
```

---

## Takeaway

The solver returns a grid, and ordinary rules expose its cells as individual
facts.
