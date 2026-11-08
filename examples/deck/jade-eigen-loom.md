# Calculating principal directions in two dimensions

[jade-eigen-loom.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/jade-eigen-loom.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/jade-eigen-loom.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/jade-eigen-loom.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/jade-eigen-loom.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=jade-eigen-loom)

---

## The question

A sample point cloud includes an outlier. N3 arithmetic and list rules
calculate a two-dimensional principal-component model and derive the example's
projections and checks.

**Which principal directions and projections follow from the point cloud?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# DATA
:PCA1 :points (
    [ :id 1 ; :x 2.0 ; :y 1.0 ]
    [ :id 2 ; :x 3.0 ; :y 2.0 ]
    [ :id 3 ; :x 4.0 ; :y 3.2 ]
…
    [ :id 6 ; :x 7.0 ; :y 13.0 ]
    [ :id 7 ; :x 20.0 ; :y -3.0 ]
    # outlier-ish
) .

# (3) PRINCIPAL AXIS ANGLE θ
# θ = 0.5 * atan2(2b, a-d)
# We emulate atan2 with piecewise rules using atan(ratio) and π adjustments.
# Common helpers (only when diff != 0): phi = atan((2b)/(a-d))
{
    :PCA1 :covXX ?a ;
        :covYY ?d ;
        :covXY ?b .
    (?a ?d) math:difference ?diff .
    ?diff math:notEqualTo 0.0 .
    (2.0 ?b) math:product ?twoB .
    (?twoB ?diff) math:quotient ?ratio .
    ?ratio math:atan ?phi .
} => {
    :PCA1 :_phi ?phi ;
        :_diff ?diff ;
        :_twoB ?twoB ;
        :_b ?b .
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
:PCA1 :n 7 .
:PCA1 :meanX "6.714285714285714"^^xsd:decimal .
_:sk_7 :b "9.857012770495839"^^xsd:decimal .
_:sk_7 :area "470.52568540824956"^^xsd:decimal .
:PCA1 :meanY "4.171428571428572"^^xsd:decimal .
:PCA1 :covXX "31.91836734693877"^^xsd:decimal .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :PCA1 :n 7 . }
  pe:rule 1;
  pe:binding
    [ pe:var "covXX"; pe:value 31.91836734693877 ],
    [ pe:var "covXY"; pe:value -10.193877551020407 ],
    [ pe:var "covYY"; pe:value 22.836326530612244 ],
    [ pe:var "dx2s"; pe:value (22.22448979591837 13.795918367346939 7.367346938775511 2.9387755102040822 0.5102040816326533 0.08163265306122441 176.51020408163262) ],
    [ pe:var "dxdys"; pe:value (14.951020408163266 8.06530612244898 2.6367346938775515 -1.5918367346938767 -2.6632653061224496 2.522448979591836 -95.27755102040815) ],
    [ pe:var "dy2s"; pe:value (10.057959183673471 4.715102040816328 0.9436734693877553 0.8622448979591825 13.902244897959184 77.94367346938776 51.42938775510204) ],
    [ pe:var "meanX"; pe:value 6.714285714285714 ],
    [ pe:var "meanY"; pe:value 4.171428571428572 ],
    [ pe:var "n"; pe:value 7 ],
    [ pe:var "pts"; pe:value (_:b1 _:b3 _:b4 _:b5 _:b6 _:b7 _:b8) ],
    [ pe:var "ssXX"; pe:value 223.4285714285714 ],
    [ pe:var "ssXY"; pe:value -71.35714285714285 ],
    [ pe:var "ssYY"; pe:value 159.8542857142857 ],
    [ pe:var "sumX"; pe:value "47"^^xsd:decimal ],
    [ pe:var "sumY"; pe:value 29.200000000000003 ],
    [ pe:var "xs"; pe:value (2.0 3.0 4.0 5.0 6.0 7.0 20.0) ],
    [ pe:var "ys"; pe:value (1.0 2.0 3.2 5.1 7.9 13.0 -3.0) ];
  pe:uses
…
        } (14.951020408163266 8.06530612244898 2.6367346938775515 -1.5918367346938767 -2.6632653061224496 2.522448979591836 -95.27755102040815)) log:collectAllIn ?_:m1 .
    },
    { (14.951020408163266 8.06530612244898 2.6367346938775515 -1.5918367346938767 -2.6632653061224496 2.522448979591836 -95.27755102040815) math:sum -71.35714285714285 . },
    { (-71.35714285714285 7) math:quotient -10.193877551020407 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 223 steps, 183 verified, 40 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 72; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 151; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 40; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 57; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Witness integrity checks the introduction and use of unnamed individuals.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `unsatisfied`.

---

## Try it

```sh
eyeron examples/jade-eigen-loom.n3
eyeron -p examples/jade-eigen-loom.n3
eyeron -c examples/jade-eigen-loom.n3
```

---

## Takeaway

The fitted directions are supported by the finite statistics calculated from
the supplied points.
