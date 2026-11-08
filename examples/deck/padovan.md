# Calculating selected Padovan numbers

[padovan.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/padovan.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/padovan.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/padovan.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/padovan.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=padovan)

---

## The question

Three starting values and a recurrence define the Padovan sequence. Recursive
backward N3 rules carry a small tuple of state values to calculate the
requested finite cases.

**What are the first eleven values under these starting conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Request just the first eleven values, from index 0 through 10.
{
    (0 1 2 3 4 5 6 7 8 9 10) list:member ?N .
    ?N :padovan ?Result
} => {
    :sequence :padovan (?N ?Result)
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
:sequence :padovan (0 0) .
:sequence :padovan (1 1) .
:sequence :padovan (9 7) .
:sequence :padovan (10 9) .
:sequence :padovan (2 1) .
:sequence :padovan (3 1) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :sequence :padovan (0 0) . }
  pe:rule 6;
  pe:binding
    [ pe:var "N"; pe:value 0 ],
    [ pe:var "Result"; pe:value 0 ];
  pe:uses
    { (0 1 2 3 4 5 6 7 8 9 10) list:member 0 . },
    { 0 :padovan 0 . }.
```

`pe:rule 6` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 103 steps, 103 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 69; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 34; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 69; pe:failed 0 ].
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
eyeron examples/padovan.n3
eyeron -p examples/padovan.n3
eyeron -c examples/padovan.n3
```

---

## Takeaway

A moving window computes the recurrence with three carried values.
