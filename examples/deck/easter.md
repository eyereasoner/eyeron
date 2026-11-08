# Calculating Easter dates

[easter.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/easter.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/easter.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/easter.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/easter.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=easter)

---

## The question

The years 2024 through 2050 supply a finite calendar calculation. A backward
N3 rule applies integer arithmetic to derive the Easter month and day for each
selected year.

**What Easter day and month are calculated for 2024 through 2050?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Evaluate the finite range 2024 through 2050.
{
    (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26) list:member ?x0 .
    (2024 ?x0) math:sum ?x1 .
    ?x1 :easter (?x2 ?x3) .
} => {
    ?x1 :easter (?x2 ?x3) .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
2024 :easter (31 3) .
2025 :easter (20 4) .
2049 :easter (18 4) .
2050 :easter (10 4) .
2026 :easter (5 4) .
2027 :easter (28 3) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ 2024 :easter (31 3) . }
  pe:rule 1;
  pe:binding
    [ pe:var "x0"; pe:value 2024 ],
    [ pe:var "x1"; pe:value 10 ],
    [ pe:var "x10"; pe:value 6 ],
    [ pe:var "x11"; pe:value 190 ],
    [ pe:var "x12"; pe:value 210 ],
    [ pe:var "x13"; pe:value 205 ],
    [ pe:var "x14"; pe:value 199 ],
    [ pe:var "x15"; pe:value 214 ],
    [ pe:var "x16"; pe:value 4 ],
    [ pe:var "x17"; pe:value 6 ],
    [ pe:var "x18"; pe:value 0 ],
    [ pe:var "x19"; pe:value 0 ],
    [ pe:var "x2"; pe:value 20 ],
    [ pe:var "x20"; pe:value 12 ],
    [ pe:var "x21"; pe:value -4 ],
    [ pe:var "x22"; pe:value 0 ],
    [ pe:var "x23"; pe:value 40 ],
    [ pe:var "x24"; pe:value 5 ],
…
    { (4 5 0 114) math:sum 123 . },
    { (123 31) math:integerQuotient 3 . },
    { (123 31) math:remainder 30 . },
    { (30 1) math:sum 31 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 519 steps, 519 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 27; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 492; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 972; pe:failed 0 ].
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
eyeron examples/easter.n3
eyeron -p examples/easter.n3
eyeron -c examples/easter.n3
```

---

## Takeaway

The calendar calculation is a reproducible chain of integer quotients and
remainders.
