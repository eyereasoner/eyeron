# Selecting a route by risk-adjusted cost

[dijkstra-risk-path.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/dijkstra-risk-path.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/dijkstra-risk-path.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/dijkstra-risk-path.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/dijkstra-risk-path.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/dijkstra-risk-path.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=dijkstra-risk-path)

---

## The question

Candidate routes have scores that combine the modeled route costs and risks.
N3 rules compare those scores, select the supported route, and derive an
explanation with checks.

**Which candidate has the best supplied risk-adjusted score?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The selected route must be strictly lower than each enumerated alternative.
{
    :pathB :score ?Best .
    :pathC :score ?CScore .
    :pathRelay :score ?RelayScore .
    :pathDirectC :score ?DirectCScore .
    :pathViaC :score ?ViaCScore .
    ?Best math:lessThan ?CScore .
    ?Best math:lessThan ?RelayScore .
    ?Best math:lessThan ?DirectCScore .
    ?Best math:lessThan ?ViaCScore .
} => {
    :Case :selectedPath :pathB .
    :Case :trustGate :noEnumeratedPathIsLower .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The companion input supplies additional facts; load it
together with the rules in the commands below.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
selected path : ClinicA -> DepotB -> LabD -> HubZ
raw cost : 10.00
risk sum : 0.55
risk-adjusted score : 11.10
edges in selected path : 3
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Case :notes :riskCanOutweighRawCost . }
  pe:rule 2;
  pe:binding
    [ pe:var "Best"; pe:value 11.1 ],
    [ pe:var "BestRaw"; pe:value 10 ],
    [ pe:var "Risk"; pe:value 1.6 ],
    [ pe:var "ViaCScore"; pe:value 11.2 ],
    [ pe:var "ViaRaw"; pe:value 8 ];
  pe:uses
    { :pathViaC :rawCost 8 . },
    { :pathViaC :score 11.2 . },
    { :pathViaC :riskSum 1.6 . },
    { :pathB :rawCost 10 . },
    { :pathB :score 11.1 . },
    { 8 math:lessThan 10 . },
    { 11.1 math:lessThan 11.2 . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 22 steps, 22 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 16; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
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
eyeron examples/dijkstra-risk-path.n3 examples/input/dijkstra-risk-path.trig
eyeron -p examples/dijkstra-risk-path.n3 examples/input/dijkstra-risk-path.trig
eyeron -c examples/dijkstra-risk-path.n3 examples/input/dijkstra-risk-path.trig
```

---

## Takeaway

A selected route is justified relative to the example's scoring policy and
candidate data.
