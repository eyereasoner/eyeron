# Propagating bounds through gradient descent

[gd-step-certified.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/gd-step-certified.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/gd-step-certified.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/gd-step-certified.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/gd-step-certified.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=gd-step-certified)

---

## The question

A one-dimensional quadratic is minimized from an uncertain starting interval.
N3 arithmetic rules propagate the supplied bounds through ten gradient steps
and derive interval checks.

**Which gradient steps meet the example's stated descent conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:gd a :GradientDescentProcedure ;
    :maxK 10 ;
    :a 1.0 .

# Step size η = 1/5
{
    (1.0 5) math:quotient ?eta .
} => {
    :gd :eta ?eta .
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
:result :eta "0.2"^^xsd:decimal .
:result :etaLeHalf true .
:result :fBounds (0 0.0 "1"^^xsd:decimal) .
:result :fBounds (1 0.0 "1.9599999999999997"^^xsd:decimal) .
:result :xBounds (8 "-13.75789056"^^xsd:decimal "15.75789056"^^xsd:decimal) .
:result :xBounds (9 "-19.661046784"^^xsd:decimal "21.661046784"^^xsd:decimal) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :k 0 . }
  pe:rule
    {
        {
            :gd :k ?k .
            :gd :xBounds (?k ?L ?U) .
            :gd :width (?k ?W) .
            :gd :midpoint (?k ?M ?halfW) .
            :gd :gBounds (?k ?gL ?gU) .
            :gd :pBounds (?k ?pL ?pU) .
            :gd :fLower (?k ?fL) .
            :gd :fUpper (?k ?fU) .
        } => {
            :result :k ?k .
            :result :xBounds (?k ?L ?U) .
            :result :midpoint (?k ?M ?halfW) .
            :result :width (?k ?W) .
            :result :gBounds (?k ?gL ?gU) .
            :result :pBounds (?k ?pL ?pU) .
            :result :fBounds (?k ?fL ?fU) .
        } .
…
    { :gd :gBounds (0 "-2"^^xsd:decimal "2"^^xsd:decimal) . },
    { :gd :pBounds (0 -0.4 0.4) . },
    { :gd :fLower (0 0.0) . },
    { :gd :fUpper (0 "1"^^xsd:decimal) . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 391 steps, 391 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 193; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 198; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1442; pe:failed 0 ].
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
eyeron examples/gd-step-certified.n3
eyeron -p examples/gd-step-certified.n3
eyeron -c examples/gd-step-certified.n3
```

---

## Takeaway

The certificate concerns the finite steps and conditions encoded in the
example.
