# Calculating a leg-length discrepancy model

[lldm.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/lldm.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/lldm.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/lldm.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/lldm.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=lldm)

---

## The question

Sample image coordinates define points and lines for a measurement. N3
arithmetic rules derive the geometric quantities used by the example's
leg-length comparison.

**Which discrepancy follows from the supplied image coordinates?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Image landmark coordinates in centimetres for one sample measurement.
:meas47 a :Measurement ;
    :p1xCm 10.1 ;
    :p1yCm 7.8 ;
    :p2xCm 45.1 ;
    :p2yCm 5.6 ;
    :p3xCm 3.6 ;
    :p3yCm 29.8 ;
    :p4xCm 54.7 ;
    :p4yCm 28.5 .

# Work from coordinate differences to projections and squared distances,
# then take square roots to compare the two measured lengths.
{
    ?M a :Measurement ;
        :p1xCm ?X ;
        :p2xCm ?Y .
    (?X ?Y) math:difference ?Z
} => {
    ?M :dx12Cm ?Z
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:meas47 :dx12Cm "-35"^^xsd:decimal .
:meas47 :dy12Cm "2.2"^^xsd:decimal .
:meas47 :dCm "-1.9082339805374957"^^xsd:decimal .
:meas47 a :LLDAlarm .
:meas47 :dy13Cm "-22"^^xsd:decimal .
:meas47 :dy24Cm "-22.9"^^xsd:decimal .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :meas47 :dx12Cm "-35"^^xsd:decimal . }
  pe:rule 1;
  pe:binding
    [ pe:var "M"; pe:value :meas47 ],
    [ pe:var "X"; pe:value 10.1 ],
    [ pe:var "Y"; pe:value 45.1 ],
    [ pe:var "Z"; pe:value "-35"^^xsd:decimal ];
  pe:uses
    { :meas47 a :Measurement . },
    { :meas47 :p1xCm 10.1 . },
    { :meas47 :p2xCm 45.1 . },
    { (10.1 45.1) math:difference "-35"^^xsd:decimal . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 85 steps, 85 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 47; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 38; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 38; pe:failed 0 ].
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
eyeron examples/lldm.n3
eyeron -p examples/lldm.n3
eyeron -c examples/lldm.n3
```

---

## References

[Source reference 1](https://web.archive.org/web/20220524062310/http://www.agfa.com/w3c/2002/10/medicad/op/)

---

## Takeaway

The result traces a geometric model from landmarks to a leg-length comparison.
