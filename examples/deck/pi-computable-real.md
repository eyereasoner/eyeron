# Approximating pi with finite interval calculations

[pi-computable-real.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/pi-computable-real.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/pi-computable-real.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/pi-computable-real.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/pi-computable-real.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=pi-computable-real)

---

## The question

Two arctangent series are combined using Machin's formula. N3 arithmetic rules
derive successive finite bounds and checks for the supplied approximation
procedure.

**Which finite bounds result from the two arctangent series?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:pi a :ComputableReal ;
    :computedBy :machinPi .

# 0) Define x1 = 1/5 and x2 = 1/239 as rationals (via quotients)
#
# IMPORTANT FIX:
# math:quotient produces a *numeric literal* as object.
# Do NOT store that numeric as an IRI like :x1 / :x2 (that breaks math: builtins).
{
    (1.0 5) math:quotient ?x .
} => {
    :atan5 :x ?x .
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
:result :certifiedAt (0 true) .
:result :certifiedAt (1 true) .
:result :certifiedAt (10 true) .
:result :certifiedAt (11 true) .
:result :width (8 "0"^^xsd:decimal) .
:result :width (9 "0"^^xsd:decimal) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :requestN 0 . }
  pe:rule
    {
        {
            :pi :bounds (?n ?t ?L ?U) .
            :pi :width (?n ?W) .
            :pi :epsilon (?n ?eps) .
            (?L ?U) math:sum ?s .
            (?s 2) math:quotient ?M .
            (?W 2) math:quotient ?errBound .
        } => {
            :result :requestN ?n .
            :result :chosenT ?t .
            :result :interval (?n ?L ?U) .
            :result :width (?n ?W) .
            :result :eps (?n ?eps) .
            :result :midpoint (?n ?M ?errBound) .
        } .
    };
  pe:binding
    [ pe:var "L"; pe:value 3.1395730293250343 ],
…
    { :pi :epsilon (0 "1"^^xsd:decimal) . },
    { (3.1395730293250343 3.1416210293270863) math:sum 6.281194058652121 . },
    { (6.281194058652121 2) math:quotient 3.1405970293260603 . },
    { (0.002048000002051964 2) math:quotient 0.001024000001025982 . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 690 steps, 690 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 305; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 385; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2216; pe:failed 0 ].
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
eyeron examples/pi-computable-real.n3
eyeron -p examples/pi-computable-real.n3
eyeron -c examples/pi-computable-real.n3
```

---

## Takeaway

A finite interval calculation approximates pi while keeping its construction
explicit.
