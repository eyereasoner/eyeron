# Fitting a line and inspecting residuals

[saffron-slopeworks.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/saffron-slopeworks.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/saffron-slopeworks.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/saffron-slopeworks.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/saffron-slopeworks.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=saffron-slopeworks)

---

## The question

A point set includes a conspicuous outlier. N3 arithmetic and list rules
calculate a linear fit, predictions, and residual checks from the supplied
finite data.

**How does the fitted line describe the supplied points and outlier?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# DATA
:Reg1 :points (
    [ :x 1.0 ; :y 2.1 ]
    [ :x 2.0 ; :y 2.9 ]
    [ :x 3.0 ; :y 3.8 ]
…
    [ :x 8.0 ; :y 15.0 ]
    # an obvious high-residual outlier
) ;
    :predictX 8.5 .

# (4) FLAG HIGH-RESIDUAL POINTS: |e| > 2*RMSE
{
    :Reg1 :points ?pts ;
        :slope ?b ;
        :intercept ?a ;
        :rmse ?rmse .
    ?pts list:member ?p .
    ?p :x ?x ;
        :y ?y .

    (?b ?x) math:product ?bx .
    (?a ?bx) math:sum ?yhat .
    (?y ?yhat) math:difference ?e .
    ?e math:absoluteValue ?ae .

    (2.0 ?rmse) math:product ?thr .
    ?ae math:greaterThan ?thr .
} => {
    :Reg1 :highResidual [
…
        :yhat ?yhat ;
        :residual ?e
    ] .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The ellipsis omits part of the source; the linked file
contains the full program.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:Reg1 :n 8 .
:Reg1 :sumX "36"^^xsd:decimal .
_:sk_1 :x 8.5 .
_:sk_1 :y "11.369047619047619"^^xsd:decimal .
:Reg1 :sumY "46"^^xsd:decimal .
:Reg1 :sumXX "204"^^xsd:decimal .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Reg1 :n 8 . }
  pe:rule 1;
  pe:binding
    [ pe:var "n"; pe:value 8 ],
    [ pe:var "pts"; pe:value (_:b1 _:b2 _:b3 _:b4 _:b5 _:b6 _:b7 _:b8) ],
    [ pe:var "sumX"; pe:value "36"^^xsd:decimal ],
    [ pe:var "sumXX"; pe:value "204"^^xsd:decimal ],
    [ pe:var "sumXY"; pe:value "266"^^xsd:decimal ],
    [ pe:var "sumY"; pe:value "46"^^xsd:decimal ],
    [ pe:var "sumYY"; pe:value 379.72 ],
    [ pe:var "x2s"; pe:value ("1"^^xsd:decimal "4"^^xsd:decimal "9"^^xsd:decimal "16"^^xsd:decimal "25"^^xsd:decimal "36"^^xsd:decimal "49"^^xsd:decimal "64"^^xsd:decimal) ],
    [ pe:var "xs"; pe:value (1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0) ],
    [ pe:var "xys"; pe:value (2.1 5.8 11.399999999999999 16.8 25.5 35.400000000000006 "49"^^xsd:decimal "120"^^xsd:decimal) ],
    [ pe:var "y2s"; pe:value (4.41 8.41 14.44 17.64 26.009999999999998 34.81 "49"^^xsd:decimal "225"^^xsd:decimal) ],
    [ pe:var "ys"; pe:value (2.1 2.9 3.8 4.2 5.1 5.9 7.0 15.0) ];
  pe:uses
    { :Reg1 :points (_:b1 _:b2 _:b3 _:b4 _:b5 _:b6 _:b7 _:b8) . },
    { (_:b1 _:b2 _:b3 _:b4 _:b5 _:b6 _:b7 _:b8) list:length 8 . },
    {
        (?x {
            (_:b1 _:b2 _:b3 _:b4 _:b5 _:b6 _:b7 _:b8) list:member ?p .
…
            (?x ?y) math:product ?xy .
        } (2.1 5.8 11.399999999999999 16.8 25.5 35.400000000000006 "49"^^xsd:decimal "120"^^xsd:decimal)) log:collectAllIn ?_:s1 .
    },
    { (2.1 5.8 11.399999999999999 16.8 25.5 35.400000000000006 "49"^^xsd:decimal "120"^^xsd:decimal) math:sum "266"^^xsd:decimal . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 66 steps, 51 verified, 15 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 25; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 41; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 21; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Witness integrity checks the introduction and use of unnamed individuals.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `collected`,
`unsatisfied`.

---

## Try it

```sh
eyeron examples/saffron-slopeworks.n3
eyeron -p examples/saffron-slopeworks.n3
eyeron -c examples/saffron-slopeworks.n3
```

---

## Takeaway

Residuals expose where a fitted model differs from individual observations.
