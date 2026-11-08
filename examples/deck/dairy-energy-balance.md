# Estimating a cow's energy balance

[dairy-energy-balance.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/dairy-energy-balance.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/dairy-energy-balance.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/dairy-energy-balance.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/dairy-energy-balance.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=dairy-energy-balance)

---

## The question

Sample body weight, milk yield, and feed intake describe a dairy cow. N3
arithmetic rules calculate the modeled energy requirements and compare them
with the available feed energy.

**Does the modeled feed energy cover the cow's calculated requirements?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Cow and feeding properties
:Cow a rdfs:Class .

# "negative" | "near" | "positive"
# Derived quantities (backward rules)
# maintenanceNEL = 0.08 * bodyWeight
{
    ?C :maintenanceNEL ?mNEL .
} <= {
    ?C a :Cow ;
        :bodyWeight ?BW .

    (?BW 0.08) math:product ?mNEL .
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
:EarlyLactDeficit :energyBalance -43.5 .
:MidLactBalanced :energyBalance 7.049999999999983 .
:LateLactPositive :milkSupported 24.375 .
:PastureLowEnergy :milkSupported 11.499999999999998 .
:LateLactPositive :energyBalance 20.400000000000006 .
:PastureLowEnergy :energyBalance -8.000000000000014 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :EarlyLactDeficit :energyBalance -43.5 . }
  pe:rule 5;
  pe:binding
    [ pe:var "C"; pe:value :EarlyLactDeficit ],
    [ pe:var "EB"; pe:value -43.5 ],
    [ pe:var "Req"; pe:value "180"^^xsd:decimal ],
    [ pe:var "Sup"; pe:value 136.5 ];
  pe:uses
    { :EarlyLactDeficit :energySupply 136.5 . },
    { :EarlyLactDeficit :energyReq "180"^^xsd:decimal . },
    { (136.5 "180"^^xsd:decimal) math:difference -43.5 . }.
```

`pe:rule 5` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 81 steps, 81 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 48; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 33; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 126; pe:failed 0 ].
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
eyeron examples/dairy-energy-balance.n3
eyeron -p examples/dairy-energy-balance.n3
eyeron -c examples/dairy-energy-balance.n3
```

---

## Takeaway

The result follows the supplied quantities and energy formulas, rather than a
general feeding recommendation.
