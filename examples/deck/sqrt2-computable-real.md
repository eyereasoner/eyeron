# Bracketing the square root of two by bisection

[sqrt2-computable-real.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/sqrt2-computable-real.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/sqrt2-computable-real.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/sqrt2-computable-real.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/sqrt2-computable-real.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=sqrt2-computable-real)

---

## The question

An initial interval from one to two is repeatedly split. N3 arithmetic rules
compare midpoint squares with two and derive a finite sequence of lower and
upper bounds.

**Which lower and upper bounds result from successive bisections?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:sqrt2 a :ComputableReal ;
    :computedBy :bisectSqrt2 .

# 1) Bisection step:
# Given interval(n, L, U), midpoint M = (L+U)/2.
# If M^2 < 2 then next is [M, U], else next is [L, M].
# Case A: M^2 < 2  => raise lower bound
{
    :bisectSqrt2 :interval (?n ?L ?U) .
    :bisectSqrt2 :maxN ?N .
    ?n math:lessThan ?N .

    (?n 1) math:sum ?n1 .
    (?L ?U) math:sum ?s .
    (?s 2) math:quotient ?M .
    (?M ?M) math:product ?M2 .
    ?M2 math:lessThan 2 .
} => {
    :bisectSqrt2 :interval (?n1 ?M ?U) .
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
:result :containsSqrt2 (0 true) .
:result :containsSqrt2 (1 true) .
:result :containsSqrt2 (10 true) .
:result :containsSqrt2 (11 true) .
:result :width (8 "0.00390625"^^xsd:decimal) .
:result :width (9 "0.001953125"^^xsd:decimal) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :interval (0 1.0 2.0) . }
  pe:rule
    {
        {
            :sqrt2 :bounds (?n ?L ?U) .
            :bisectSqrt2 :width (?n ?W) .
            :bisectSqrt2 :epsilon (?n ?eps) .
            (?L ?U) math:sum ?s .
            (?s 2) math:quotient ?M .
            (?W 2) math:quotient ?errBound .
        } => {
            :result :interval (?n ?L ?U) .
            :result :width (?n ?W) .
            :result :eps (?n ?eps) .
            :result :midpoint (?n ?M ?errBound) .
        } .
    };
  pe:binding
    [ pe:var "L"; pe:value 1.0 ],
    [ pe:var "M"; pe:value 1.5 ],
    [ pe:var "U"; pe:value 2.0 ],
…
    { :bisectSqrt2 :epsilon (0 "1"^^xsd:decimal) . },
    { (1.0 2.0) math:sum "3"^^xsd:decimal . },
    { ("3"^^xsd:decimal 2) math:quotient 1.5 . },
    { ("1"^^xsd:decimal 2) math:quotient 0.5 . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 274 steps, 274 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 144; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 130; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 862; pe:failed 0 ].
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
eyeron examples/sqrt2-computable-real.n3
eyeron -p examples/sqrt2-computable-real.n3
eyeron -c examples/sqrt2-computable-real.n3
```

---

## Takeaway

Squaring the midpoint determines which half of the bracket to retain.
