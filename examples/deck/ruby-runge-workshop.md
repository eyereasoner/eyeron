# Interpolating sample points

[ruby-runge-workshop.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/ruby-runge-workshop.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/ruby-runge-workshop.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/ruby-runge-workshop.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/ruby-runge-workshop.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=ruby-runge-workshop)

---

## The question

A set of points and evaluation parameters define a small numerical workload.
N3 arithmetic and list rules calculate interpolation values and related
derivative or root checks.

**What interpolation values and related checks follow from the sample points?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# DATA
:Interp1 :points (
    [ :id 1 ; :x -2.0 ; :y 7.0 ]
    [ :id 2 ; :x -1.0 ; :y 1.0 ]
    [ :id 3 ; :x 0.0 ; :y -1.0 ]
…
    :x0 0.6 ;
    :h 0.001 ;
    :bracketA 0.0 ;
    :bracketB 1.0 .

# derivative from yPlus, yMinus
{
    :Interp1 :yAtXPlus ?yP ;
        :yAtXMinus ?yM ;
        :h ?h .
    (?yP ?yM) math:difference ?dy .
    (2.0 ?h) math:product ?twoH .
    (?dy ?twoH) math:quotient ?dydx .
} => {
    :Interp1 :derivativeAtX0 ?dydx .
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
:Interp1 :yAtX0 "-0.28000000000000014"^^xsd:decimal .
:Interp1 :yAtXPlus "-0.27759800000000023"^^xsd:decimal .
_:sk_0 :ya "-1"^^xsd:decimal .
_:sk_0 :yb "1"^^xsd:decimal .
:Interp1 :xPlus "0.601"^^xsd:decimal .
:Interp1 :yAtXMinus "-0.2823980000000002"^^xsd:decimal .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Interp1 :yAtX0 -0.28000000000000014 . }
  pe:rule 1;
  pe:binding
    [ pe:var "pts"; pe:value (_:b1 _:b2 _:b3 _:b4 _:b5) ],
    [ pe:var "terms"; pe:value (0.1568 -0.1456 -0.5824 0.5823999999999999 -0.2912) ],
    [ pe:var "x0"; pe:value 0.6 ],
    [ pe:var "y0"; pe:value -0.28000000000000014 ];
  pe:uses
    { :Interp1 :points (_:b1 _:b2 _:b3 _:b4 _:b5) . },
    { :Interp1 :x0 0.6 . },
    {
        (?term {
            (_:b1 _:b2 _:b3 _:b4 _:b5) list:member ?pi .
            ?pi :x ?xi .
            ?pi :y ?yi .
            (?f {
                (_:b1 _:b2 _:b3 _:b4 _:b5) list:member ?pj .
                ?pj :x ?xj .
                ?xj math:notEqualTo ?xi .
                (0.6 ?xj) math:difference ?num .
                (?xi ?xj) math:difference ?den .
…
            (?yi ?basis) math:product ?term .
        } (0.1568 -0.1456 -0.5824 0.5823999999999999 -0.2912)) log:collectAllIn ?_:lag0 .
    },
    { (0.1568 -0.1456 -0.5824 0.5823999999999999 -0.2912) math:sum -0.28000000000000014 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 35 steps, 30 verified, 5 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 18; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 17; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 13; pe:failed 0 ];
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
eyeron examples/ruby-runge-workshop.n3
eyeron -p examples/ruby-runge-workshop.n3
eyeron -c examples/ruby-runge-workshop.n3
```

---

## Takeaway

The numerical workload makes its interpolation and checking steps explicit.
