# Approximating an integral with Simpson's rule

[ultramarine-simpson-forge.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/ultramarine-simpson-forge.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/ultramarine-simpson-forge.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/ultramarine-simpson-forge.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/ultramarine-simpson-forge.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=ultramarine-simpson-forge)

---

## The question

A fixed set of sample points supplies alternating Simpson weights. N3
arithmetic and list rules combine the weighted function values and derive
numerical integration results and checks.

**Which finite integral approximation follows from the weighted samples?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# DATA
:Simpson1 :h 0.5 ;
    :samples (
        [ :k 0 ; :x 0.0 ; :coef 1.0 ]
        [ :k 1 ; :x 0.5 ; :coef 4.0 ]
        [ :k 2 ; :x 1.0 ; :coef 2.0 ]
        [ :k 3 ; :x 1.5 ; :coef 4.0 ]
        [ :k 4 ; :x 2.0 ; :coef 1.0 ]
    ) .

# (1) PER-SAMPLE VALUES: y, y', ds = sqrt(1 + (y')^2)
{
    :Simpson1 :samples ?ss .
    ?ss list:member ?s .
    ?s :x ?x ;
        :coef ?c .

    # y = sin(x) + x^2
    ?x math:sin ?sinx .
    (?x 2.0) math:exponentiation ?x2 .
    (?sinx ?x2) math:sum ?y .

    # y' = cos(x) + 2x
    ?x math:cos ?cosx .
    (2.0 ?x) math:product ?twox .
    (?cosx ?twox) math:sum ?dy .

    # ds = sqrt(1 + dy^2)
    (?dy 2.0) math:exponentiation ?dy2 .
…
        :dy ?dy ;
        :ds ?ds
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
_:b1 :y "0"^^xsd:decimal .
_:b1 :dy "1"^^xsd:decimal .
_:sk_5 :xbar "1.405937477143825"^^xsd:decimal .
_:sk_5 :ybar "1.5346247788330099"^^xsd:decimal .
_:b1 :ds "1.4142135623730951"^^xsd:decimal .
:Simpson1 :sampleResult _:sk_0 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ _:b1 :y "0"^^xsd:decimal . }
  pe:rule 1;
  pe:binding
    [ pe:var "c"; pe:value 1.0 ],
    [ pe:var "cosx"; pe:value "1"^^xsd:decimal ],
    [ pe:var "ds"; pe:value 1.4142135623730951 ],
    [ pe:var "dy"; pe:value "1"^^xsd:decimal ],
    [ pe:var "dy2"; pe:value "1"^^xsd:decimal ],
    [ pe:var "onePlus"; pe:value "2"^^xsd:decimal ],
    [ pe:var "s"; pe:value _:b1 ],
    [ pe:var "sinx"; pe:value "0"^^xsd:decimal ],
    [ pe:var "ss"; pe:value (_:b1 _:b2 _:b3 _:b4 _:b5) ],
    [ pe:var "twox"; pe:value "0"^^xsd:decimal ],
    [ pe:var "x"; pe:value 0.0 ],
    [ pe:var "x2"; pe:value "0"^^xsd:decimal ],
    [ pe:var "y"; pe:value "0"^^xsd:decimal ];
  pe:uses
    { :Simpson1 :samples (_:b1 _:b2 _:b3 _:b4 _:b5) . },
    { (_:b1 _:b2 _:b3 _:b4 _:b5) list:member _:b1 . },
    { _:b1 :x 0.0 . },
    { _:b1 :coef 1.0 . },
…
    { ("1"^^xsd:decimal "0"^^xsd:decimal) math:sum "1"^^xsd:decimal . },
    { ("1"^^xsd:decimal 2.0) math:exponentiation "1"^^xsd:decimal . },
    { (1.0 "1"^^xsd:decimal) math:sum "2"^^xsd:decimal . },
    { ("2"^^xsd:decimal 0.5) math:exponentiation 1.4142135623730951 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 139 steps, 97 verified, 42 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 73; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 66; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 53; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 61; pe:failed 0 ];
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
eyeron examples/ultramarine-simpson-forge.n3
eyeron -p examples/ultramarine-simpson-forge.n3
eyeron -c examples/ultramarine-simpson-forge.n3
```

---

## Takeaway

Simpson weights and supplied function values determine this numerical
approximation.
