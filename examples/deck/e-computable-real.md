# Approximating e with interval bounds

[e-computable-real.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/e-computable-real.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/e-computable-real.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/e-computable-real.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/e-computable-real.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=e-computable-real)

---

## The question

Finite factorial-series calculations represent the number e through successive
bounds. N3 arithmetic rules derive interval results and checks for the
requested approximation stages.

**Which finite lower and upper approximations does the factorial series provide?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:e a :ComputableReal ;
    :computedBy :seriesE .

{
    :seriesE :fact (?k ?f) .
    :seriesE :maxK ?maxK .
    ?k math:lessThan ?maxK .

    (?k 1) math:sum ?k1 .
    (?f ?k1) math:product ?f1 .
} => {
    :seriesE :fact (?k1 ?f1) .
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
:result :chosenM 10 .
:result :chosenM 11 .
:result :chosenM 12 .
:result :chosenM 13 .
:result :width (8 "8.193389712664089e-13"^^xsd:double) .
:result :width (9 "5.0981091545465446e-14"^^xsd:double) .
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
            :e :bounds (?n ?m ?L ?U) .
            :e :width (?n ?W) .
            :e :epsilon (?n ?eps) .
            :e :guaranteeWidthLe2PowNegN (?n true) .
            (?L ?U) math:sum ?s .
            (?s 2) math:quotient ?M .
            (?W 2) math:quotient ?errBound .
        } => {
            :result :requestN ?n .
            :result :chosenM ?m .
            :result :interval (?n ?L ?U) .
            :result :width (?n ?W) .
            :result :eps (?n ?eps) .
            :result :midpoint (?n ?M ?errBound) .
        } .
    };
  pe:binding
…
    { :e :guaranteeWidthLe2PowNegN (0 true) . },
    { (2.7180555555555554 2.718287037037037) math:sum 5.436342592592593 . },
    { (5.436342592592593 2) math:quotient 2.7181712962962963 . },
    { (0.0002314814814814815 2) math:quotient 0.00011574074074074075 . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 462 steps, 462 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 208; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 254; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1550; pe:failed 0 ].
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
eyeron examples/e-computable-real.n3
eyeron -p examples/e-computable-real.n3
eyeron -c examples/e-computable-real.n3
```

---

## Takeaway

A real number can be approached through finite computations with explicit
interval results.
