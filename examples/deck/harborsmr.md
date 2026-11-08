# Sharing a limited energy-export insight

[harborsmr.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/harborsmr.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/harborsmr.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/harborsmr.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/harborsmr.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=harborsmr)

---

## The question

A port hydrogen hub needs a temporary scheduling decision without receiving
raw reactor telemetry. N3 rules check the modeled trust and use constraints
and derive a bounded flexible-export insight.

**May the receiver use the limited energy-export insight under the supplied policy?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The insight, reserve conditions, request and dispatch plan are supplied data.
:case a arc:Case ;
    :caseName "harborsmr" ;
    arc:question "May the port hydrogen hub use a temporary SMR flexible-export insight to schedule electrolysis for the next four-hour balancing window?" ;
    :requestPurpose "electrolysis_dispatch" ;
    :requestAction odrl:use ;
    :hubAuthAt "2026-06-18T13:10:00+00:00"^^xsd:dateTime .

# Trip a fuse if a Permit coexists with an excessive request, an outage,
# an expired authorization or a mismatched load.
{
    :case :decision :Permit .
    :electrolyzerRequest :requestedMW ?req .
    :flexInsight :exportMW ?cap .
    ?req math:greaterThan ?cap .
} => false .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:decision :target <https://example.org/insight/harborsmr> .
:decision :outcome "Allowed" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :decision :target <https://example.org/insight/harborsmr> . }
  pe:rule 1;
  pe:binding
    [ pe:var "AuthorizedAt"; pe:value "2026-06-18T13:10:00+00:00"^^xsd:dateTime ],
    [ pe:var "CoolingMarginPct"; pe:value 18 ],
    [ pe:var "Device"; pe:value "port-hydrogen-hub" ],
    [ pe:var "DispatchMW"; pe:value 16 ],
    [ pe:var "Event"; pe:value "day_ahead_balancing" ],
    [ pe:var "ExpiresAt"; pe:value "2026-06-18T18:00:00+00:00"^^xsd:dateTime ],
    [ pe:var "ExportLimitMW"; pe:value 18 ],
    [ pe:var "Load"; pe:value "PEM_electrolyzer_train_2" ],
    [ pe:var "PlanRequestedMW"; pe:value 16 ],
    [ pe:var "RequestedMW"; pe:value 16 ],
    [ pe:var "ReserveMarginMW"; pe:value 24 ],
    [ pe:var "SerializedInsight"; pe:value "{\"createdat\":\"2026-06-18t13:00:00+00:00\",\"expiresat\":\"2026-06-18t18:00:00+00:00\",\"exportmw\":18,\"id\":\"https://example.org/insight/harborsmr\",\"metric\":\"temporary_flexible_export_window\",\"scopedevice\":\"port-hydrogen-hub\",\"scopeevent\":\"day_ahead_balancing\",\"targetload\":\"pem_electrolyzer_train_2\",\"type\":\"ins:insight\"}" ],
    [ pe:var "WindowEnd"; pe:value "2026-06-18T18:00:00+00:00"^^xsd:dateTime ],
    [ pe:var "WindowStart"; pe:value "2026-06-18T14:00:00+00:00"^^xsd:dateTime ];
  pe:uses
    { :secureAggregate :reserveMarginMW 24 . },
    { 24 math:greaterThan 19 . },
    { :secureAggregate :coolingMarginPct 18 . },
…
    { :electrolyzerRequest :requestedMW 16 . },
    { :dispatchPlan :forLoad "PEM_electrolyzer_train_2" . },
    { :electrolyzerRequest :targetLoad "PEM_electrolyzer_train_2" . },
    { 16 math:notGreaterThan 16 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 40 steps, 40 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 34; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 84; pe:failed 0 ].
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
eyeron examples/harborsmr.n3
eyeron -p examples/harborsmr.n3
eyeron -c examples/harborsmr.n3
```

---

## Takeaway

The decision depends on the modeled trust and use constraints attached to the
insight.
