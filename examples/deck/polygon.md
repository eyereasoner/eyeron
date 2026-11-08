# Calculating a polygon's signed area

[polygon.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/polygon.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/polygon.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/polygon.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/polygon.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=polygon)

---

## The question

A list of coordinate pairs describes a polygon. Recursive backward N3 rules
combine adjacent points with arithmetic to calculate the example's area.

**What signed area follows from the ordered vertex list?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The last vertex repeats the first, closing the polygon for the edge sum.
{
    ((4 2) (6 2) (7 6) (4 6) (5 5) (5 3) (4 2)) polygon:area ?AREA
} => {
    ((4 2) (6 2) (7 6) (4 6) (5 5) (5 3) (4 2)) polygon:area ?AREA
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
((4 2) (6 2) (7 6) (4 6) (5 5) (5 3) (4 2)) polygon:area 7 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ((4 2) (6 2) (7 6) (4 6) (5 5) (5 3) (4 2)) polygon:area 7 . }
  pe:rule 2;
  pe:binding
    [ pe:var "AREA"; pe:value 7 ],
    [ pe:var "AREA1"; pe:value 9 ],
    [ pe:var "POINTS"; pe:value ((4 2) (6 2) (7 6) (4 6) (5 5) (5 3) (4 2)) ],
    [ pe:var "POINTS1"; pe:value ((6 2) (7 6) (4 6) (5 5) (5 3) (4 2)) ],
    [ pe:var "POINTS2"; pe:value ((7 6) (4 6) (5 5) (5 3) (4 2)) ],
    [ pe:var "X1"; pe:value 4 ],
    [ pe:var "X2"; pe:value 6 ],
    [ pe:var "Y1"; pe:value 2 ],
    [ pe:var "Y2"; pe:value 2 ],
    [ pe:var "Z1"; pe:value 8 ],
    [ pe:var "Z2"; pe:value 12 ],
    [ pe:var "Z3"; pe:value -4 ],
    [ pe:var "Z4"; pe:value -2 ];
  pe:uses
    { ((4 2) (6 2) (7 6) (4 6) (5 5) (5 3) (4 2)) list:firstRest ((4 2) ((6 2) (7 6) (4 6) (5 5) (5 3) (4 2))) . },
    { ((6 2) (7 6) (4 6) (5 5) (5 3) (4 2)) list:firstRest ((6 2) ((7 6) (4 6) (5 5) (5 3) (4 2))) . },
    { ((6 2) (7 6) (4 6) (5 5) (5 3) (4 2)) polygon:area 9 . },
    { (4 2) math:product 8 . },
    { (2 6) math:product 12 . },
    { (8 12) math:difference -4 . },
    { (-4 2) math:quotient -2 . },
    { (-2 9) math:sum 7 . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 43 steps, 43 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 7; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 36; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 7; pe:failed 0 ].
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
eyeron examples/polygon.n3
eyeron -p examples/polygon.n3
eyeron -c examples/polygon.n3
```

---

## References

[Source reference 1](https://www.mathopenref.com/coordpolygonarea.html)

---

## Takeaway

The area calculation depends on adjacent coordinates and the direction in
which the vertices are listed.
