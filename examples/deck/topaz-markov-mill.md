# Calculating a finite Markov-chain workload

[topaz-markov-mill.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/topaz-markov-mill.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/topaz-markov-mill.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/topaz-markov-mill.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/topaz-markov-mill.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=topaz-markov-mill)

---

## The question

Three states and transition rows define a probability model. N3 arithmetic and
list rules derive the supplied state-distribution calculations and checks from
those rows.

**Which state distributions follow from the supplied transition rows?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# DATA
:MC1 :states (:A :B :C) ;

    # Transition matrix P, encoded as explicit row nodes
    :row [ :from :A ; :pA 0.80 ; :pB 0.15 ; :pC 0.05 ] ;
    :row [ :from :B ; :pA 0.10 ; :pB 0.70 ; :pC 0.20 ] ;
    :row [ :from :C ; :pA 0.25 ; :pB 0.25 ; :pC 0.50 ] ;

    # Initial distribution π0 over (A,B,C)
    :pi0 [ :pA 0.60 ; :pB 0.30 ; :pC 0.10 ] .

# (1) ROW-STOCHASTIC CHECK: pA+pB+pC = 1.0
{
    :MC1 :row ?r .
    ?r :pA ?a ;
        :pB ?b ;
        :pC ?c .
    (?a ?b) math:sum ?ab .
    (?ab ?c) math:sum ?sum .
    ?sum math:equalTo 1.0 .
} => {
    :MC1 :rowOk ?r .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:MC1 :rowOk _:b1 .
:MC1 :rowOk _:b2 .
_:sk_7 :tvToUniform "0.15913333333333338"^^xsd:decimal .
_:sk_7 :l2ToUniform "0.2115715410426617"^^xsd:decimal .
:MC1 :rowOk _:b3 .
:MC1 :pi1 _:sk_0 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :MC1 :rowOk _:b1 . }
  pe:rule 1;
  pe:binding
    [ pe:var "a"; pe:value 0.80 ],
    [ pe:var "ab"; pe:value 0.9500000000000001 ],
    [ pe:var "b"; pe:value 0.15 ],
    [ pe:var "c"; pe:value 0.05 ],
    [ pe:var "r"; pe:value _:b1 ],
    [ pe:var "sum"; pe:value "1"^^xsd:decimal ];
  pe:uses
    { :MC1 :row _:b1 . },
    { _:b1 :pA 0.80 . },
    { _:b1 :pB 0.15 . },
    { _:b1 :pC 0.05 . },
    { (0.80 0.15) math:sum 0.9500000000000001 . },
    { (0.9500000000000001 0.05) math:sum "1"^^xsd:decimal . },
    { "1"^^xsd:decimal math:equalTo 1.0 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 222 steps, 194 verified, 28 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 70; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 152; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 28; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 51; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `unsatisfied`.

---

## Try it

```sh
eyeron examples/topaz-markov-mill.n3
eyeron -p examples/topaz-markov-mill.n3
eyeron -c examples/topaz-markov-mill.n3
```

---

## Takeaway

Each finite update is an arithmetic consequence of the chosen transition
model.
