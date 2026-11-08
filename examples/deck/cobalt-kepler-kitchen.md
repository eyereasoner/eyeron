# Calculating orbital quantities

[cobalt-kepler-kitchen.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/cobalt-kepler-kitchen.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/cobalt-kepler-kitchen.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/cobalt-kepler-kitchen.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/cobalt-kepler-kitchen.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=cobalt-kepler-kitchen)

---

## The question

Sample orbits and a transfer maneuver supply a numerical workload. N3
arithmetic and list rules calculate orbital quantities and transfer results
from the supplied finite data.

**What orbital and transfer quantities follow from the sample inputs?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# DATA (units: km, s; mu in km^3/s^2)
:Earth :mu 398600.4418 .

# (2) AVERAGE PERIOD ACROSS ORBITS
{
    :OrbitSet :orbits ?os .

    (
        ?T {
            ?os list:member ?orb .
            ?orb :period ?T .
        }
        ?Ts
    ) log:collectAllIn _:avgScope .
    ?Ts list:length ?n .
    ?Ts math:sum ?sumT .
    (?sumT ?n) math:quotient ?avgT .
} => {
    :OrbitSet :avgPeriod ?avgT .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
_:b1 :periapsis "6993"^^xsd:decimal .
_:b1 :apoapsis "7006.999999999999"^^xsd:decimal .
:Transfer1 :timeOfFlight "19178.15420570903"^^xsd:decimal .
:OrbitSet :avgPeriod "45023.28154304274"^^xsd:decimal .
_:b1 :period "5828.516637686015"^^xsd:decimal .
_:b1 :specificEnergy "-28.471460128571426"^^xsd:decimal .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Transfer1 :transferSemiMajorAxis "24582"^^xsd:decimal . }
  pe:rule 3;
  pe:binding
    [ pe:var "aT"; pe:value "24582"^^xsd:decimal ],
    [ pe:var "aT3"; pe:value "14854281265368"^^xsd:decimal ],
    [ pe:var "aT3OverMu"; pe:value 37266093.329673775 ],
    [ pe:var "adv1"; pe:value 2.3367957823862033 ],
    [ pe:var "adv2"; pe:value 1.4339314509179262 ],
    [ pe:var "dv1"; pe:value 2.3367957823862033 ],
    [ pe:var "dv2"; pe:value 1.4339314509179262 ],
    [ pe:var "dvTotal"; pe:value 3.7707272333041297 ],
    [ pe:var "mu"; pe:value 398600.4418 ],
    [ pe:var "muOverR1"; pe:value 56.94292025714285 ],
    [ pe:var "muOverR2"; pe:value 9.453572758751541 ],
    [ pe:var "muTerm1"; pe:value 97.67070578969047 ],
    [ pe:var "muTerm2"; pe:value 2.692010792907852 ],
    [ pe:var "oneOverAT"; pe:value 0.00004068017248393133 ],
    [ pe:var "r1"; pe:value 7000.0 ],
    [ pe:var "r1r2"; pe:value "49164"^^xsd:decimal ],
    [ pe:var "r2"; pe:value 42164.0 ],
    [ pe:var "sqrtTT"; pe:value 6104.596082434428 ],
…
    { ("24582"^^xsd:decimal 3.0) math:exponentiation "14854281265368"^^xsd:decimal . },
    { ("14854281265368"^^xsd:decimal 398600.4418) math:quotient 37266093.329673775 . },
    { (37266093.329673775 0.5) math:exponentiation 6104.596082434428 . },
    { (3.141592653589793 6104.596082434428) math:product 19178.15420570903 . }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 208 steps, 186 verified, 22 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 60; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 148; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 21; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 46; pe:failed 0 ];
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
eyeron examples/cobalt-kepler-kitchen.n3
eyeron -p examples/cobalt-kepler-kitchen.n3
eyeron -c examples/cobalt-kepler-kitchen.n3
```

---

## Takeaway

The numerical result is a chain of explicit arithmetic operations on the
supplied orbit data.
