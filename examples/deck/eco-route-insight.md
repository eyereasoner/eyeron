# Deriving a limited eco-route suggestion

[eco-route-insight.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/eco-route-insight.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/eco-route-insight.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/eco-route-insight.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/eco-route-insight.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/eco-route-insight.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=eco-route-insight)

---

## The question

A current route and an alternative have fuel indices and travel times. N3
rules check the allowed delay and improvement thresholds, then derive a scoped
route insight and its explanation.

**Does the alternative save fuel while staying within the allowed delay?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The companion input supplies fuel indices and travel times. Recommend
# the alternative only if it saves fuel and stays within the delay limit.
{
    :currentRoute :fuelIndex ?Current ;
        :etaMinutes ?CurrentEta .
    :altLowFuel :fuelIndex ?Alt ;
        :etaMinutes ?AltEta .
    :Policy :fuelIndexThreshold ?Threshold ;
        :maxEtaDelayMinutes ?MaxDelay .
    ?Current math:greaterThan ?Threshold .
    ?Alt math:lessThan ?Current .
    (?AltEta ?CurrentEta) math:difference ?Delay .
    ?Delay math:notGreaterThan ?MaxDelay .
    (?Current ?Alt) math:difference ?Saving .
} => {
    :Insight :status "issue" ;
        :showEcoBanner "yes" ;
        :suggestedRoute :altLowFuel ;
        :estimatedSaving ?Saving .
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
insight status : issue
show eco banner : yes
audience : Depot X
allowed use : ui.eco.banner
suggested route : alt-low-fuel
current fuel index : 120.75
suggested fuel index : 99.75
estimated saving : 21.00
expires at : 2025-01-01T11:00:00Z
raw data exported : no
signature algorithm : HMAC-SHA256
payload digest : 00e19becd91e81d6881749655d23d43002d9ea714bba61e855eafbc8ef9a5135
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Insight :status "issue" . }
  pe:rule 1;
  pe:binding
    [ pe:var "Alt"; pe:value 99.75 ],
    [ pe:var "AltEta"; pe:value 66 ],
    [ pe:var "Current"; pe:value 120.75 ],
    [ pe:var "CurrentEta"; pe:value 64 ],
    [ pe:var "Delay"; pe:value 2 ],
    [ pe:var "MaxDelay"; pe:value 5 ],
    [ pe:var "Saving"; pe:value "21"^^xsd:decimal ],
    [ pe:var "Threshold"; pe:value 120 ];
  pe:uses
    { :currentRoute :fuelIndex 120.75 . },
    { :currentRoute :etaMinutes 64 . },
    { :altLowFuel :fuelIndex 99.75 . },
    { :altLowFuel :etaMinutes 66 . },
    { :Policy :fuelIndexThreshold 120 . },
    { :Policy :maxEtaDelayMinutes 5 . },
    { 120.75 math:greaterThan 120 . },
    { 99.75 math:lessThan 120.75 . },
    { (66 64) math:difference 2 . },
    { 2 math:notGreaterThan 5 . },
    { (120.75 99.75) math:difference "21"^^xsd:decimal . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 33 steps, 33 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 27; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
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
eyeron examples/eco-route-insight.n3 examples/input/eco-route-insight.trig
eyeron -p examples/eco-route-insight.n3 examples/input/eco-route-insight.trig
eyeron -c examples/eco-route-insight.n3 examples/input/eco-route-insight.trig
```

---

## Takeaway

The recommendation depends on both an improvement and the example's delay
threshold.
