# Estimating a field's nitrogen balance

[field-nitrogen-balance.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/field-nitrogen-balance.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/field-nitrogen-balance.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/field-nitrogen-balance.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/field-nitrogen-balance.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=field-nitrogen-balance)

---

## The question

Soil nitrogen, fertilizer, losses, and crop demand describe a field. N3
arithmetic rules derive available nitrogen and the modeled deficit or surplus.

**Does the modeled available nitrogen cover the field's crop demand?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Field designs and N properties
:Field a rdfs:Class .

# "under", "balanced", "over"
# Derived quantities (backward rules)
# totalN = soilN + fertN
{
    ?F :totalN ?tot .
} <= {
    ?F a :Field ;
        :soilN ?soil ;
        :fertN ?fert .

    (?soil ?fert) math:sum ?tot .
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
:LowInputDry :status "under" .
:BalancedLoam :status "balanced" .
:LowInputDry :leachIndex "0"^^xsd:decimal .
:BalancedLoam :leachIndex "0"^^xsd:decimal .
:HighInputRisk :status "over" .
:SandyOverFertil :status "over" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :LowInputDry :status "under" . }
  pe:rule 8;
  pe:binding
    [ pe:var "F"; pe:value :LowInputDry ],
    [ pe:var "a"; pe:value "85"^^xsd:decimal ],
    [ pe:var "d"; pe:value 130.0 ],
    [ pe:var "dLow"; pe:value "117"^^xsd:decimal ];
  pe:uses
    { :LowInputDry :cropNdemand 130.0 . },
    { :LowInputDry :availN "85"^^xsd:decimal . },
    { (0.9 130.0) math:product "117"^^xsd:decimal . },
    { "85"^^xsd:decimal math:lessThan "117"^^xsd:decimal . }.
```

`pe:rule 8` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 79 steps, 79 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 44; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 35; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 130; pe:failed 0 ].
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
eyeron examples/field-nitrogen-balance.n3
eyeron -p examples/field-nitrogen-balance.n3
eyeron -c examples/field-nitrogen-balance.n3
```

---

## Takeaway

The balance follows the stated inputs, losses and demand in this finite field
model.
