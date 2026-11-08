# Building Collatz sequences

[collatz.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/collatz.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/collatz.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/collatz.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/collatz.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=collatz)

---

## The question

Selected positive integers are repeatedly halved when even or replaced by
three times the number plus one when odd. Recursive backward N3 rules build
their sequences down to one.

**What sequences reach one from the nine selected starting numbers?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Ask only for these nine starts; this does not test the general conjecture.
{
    (1 2 3 4 5 6 8 10 16) list:member ?N .
    ?N :collatz ?Sequence
} => {
    :sequences :collatz (?N ?Sequence)
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
:sequences :collatz (1 (1)) .
:sequences :collatz (2 (2 1)) .
:sequences :collatz (10 (10 5 16 8 4 2 1)) .
:sequences :collatz (16 (16 8 4 2 1)) .
:sequences :collatz (3 (3 10 5 16 8 4 2 1)) .
:sequences :collatz (4 (4 2 1)) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :sequences :collatz (1 (1)) . }
  pe:rule 4;
  pe:binding
    [ pe:var "N"; pe:value 1 ],
    [ pe:var "Sequence"; pe:value (1) ];
  pe:uses
    { (1 2 3 4 5 6 8 10 16) list:member 1 . },
    { 1 :collatz (1) . }.
```

`pe:rule 4` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 63 steps, 63 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 18; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 45; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 18; pe:failed 0 ].
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
eyeron examples/collatz.n3
eyeron -p examples/collatz.n3
eyeron -c examples/collatz.n3
```

---

## Takeaway

These finite trajectories demonstrate recursion; they do not prove the Collatz
conjecture.
