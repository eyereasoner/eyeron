# Approximating pi with an alternating series

[nilakantha-pi.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/nilakantha-pi.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/nilakantha-pi.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/nilakantha-pi.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/nilakantha-pi.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=nilakantha-pi)

---

## The question

The Nilakantha series is evaluated with three, seven, and eleven terms.
Recursive backward N3 rules alternate arithmetic corrections and return the
corresponding finite approximations.

**Which finite approximations does the alternating series produce?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
{
    (4 8 12) list:member ?N .
    ?N :pi ?Pi
} => {
    :nilakantha :approximation (?N ?Pi)
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
:nilakantha :approximation (4 3.145238095238095) .
:nilakantha :approximation (8 3.142071817071817) .
:nilakantha :approximation (12 3.1417360992606653) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :nilakantha :approximation (4 3.145238095238095) . }
  pe:rule 4;
  pe:binding
    [ pe:var "N"; pe:value 4 ],
    [ pe:var "Pi"; pe:value 3.145238095238095 ];
  pe:uses
    { (4 8 12) list:member 4 . },
    { 4 :pi 3.145238095238095 . }.
```

`pe:rule 4` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 134 steps, 134 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 30; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 104; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 30; pe:failed 0 ].
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
eyeron examples/nilakantha-pi.n3
eyeron -p examples/nilakantha-pi.n3
eyeron -c examples/nilakantha-pi.n3
```

---

## Takeaway

The reported values come from the requested finite term counts, not an exact
representation of pi.
