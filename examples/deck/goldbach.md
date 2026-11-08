# Finding prime pairs for selected even numbers

[goldbach.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/goldbach.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/goldbach.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/goldbach.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/goldbach.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=goldbach)

---

## The question

Selected even integers are tested for decompositions into two primes.
Recursive backward N3 rules check factors and enumerate the prime pairs; the
finite results do not prove Goldbach's conjecture.

**Which prime pairs sum to the selected even numbers?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Try the finite even-number list and candidate first primes from 2 to 25.
# Requiring P <= Q avoids reporting the same partition in both orders.
{
    (4 6 8 10 12 20 28 50) list:member ?N .
    (2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25) list:member ?P .
    (?N ?P) math:difference ?Q .
    ?P math:notGreaterThan ?Q .
    ?P :prime true .
    ?Q :prime true .
} => {
    :partitions :goldbach (?N ?P ?Q)
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
:partitions :goldbach (4 2 2) .
:partitions :goldbach (6 3 3) .
:partitions :goldbach (50 13 37) .
:partitions :goldbach (50 19 31) .
:partitions :goldbach (8 3 5) .
:partitions :goldbach (10 3 7) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :partitions :goldbach (4 2 2) . }
  pe:rule 4;
  pe:binding
    [ pe:var "N"; pe:value 4 ],
    [ pe:var "P"; pe:value 2 ],
    [ pe:var "Q"; pe:value 2 ];
  pe:uses
    { (4 6 8 10 12 20 28 50) list:member 4 . },
    { (2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25) list:member 2 . },
    { (4 2) math:difference 2 . },
    { 2 math:notGreaterThan 2 . },
    { 2 :prime true . },
    { 2 :prime true . }.
```

`pe:rule 4` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 226 steps, 226 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 74; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 152; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 74; pe:failed 0 ].
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
eyeron examples/goldbach.n3
eyeron -p examples/goldbach.n3
eyeron -c examples/goldbach.n3
```

---

## Takeaway

Finding decompositions for finite cases does not prove Goldbach's conjecture.
