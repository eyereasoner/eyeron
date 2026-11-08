# Planning a restaurant reservation

[resto.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/resto.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/resto.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/resto.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/resto.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=resto)

---

## The question

A dinner plan and service descriptions define steps toward a restaurant
reservation. N3 rules compose the modeled services, introduce result
witnesses, and derive a plan. A query returns the reservation details.

**Which modeled service sequence supports the restaurant reservation?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Initial question
:Ruben a foaf:Person .

# RESTdesc-style service descriptions
# Preferences API: from person + document to address.
{
    :Ruben a foaf:Person .
    :PlanningDocument a foaf:Document .
} => {
    :reqPreferences http:methodName "GET" ;
        http:requestURI :preferencesEndpoint ;
        http:resp :respPreferences .
    :respPreferences http:body :GentAddress .
    :Ruben foaf:based_near :GentAddress .
    :GentAddress a con:Address ;
        resto:label "Gent" .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:Goal resto:restaurant :Maximiliaan .
:Goal resto:reservation :Reservation42 .
:Goal resto:onDate "2026-04-08" .
:Goal resto:isOutside true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Goal resto:restaurant :Maximiliaan . }
  pe:rule 8;
  pe:binding
    [ pe:var "Date"; pe:value "2026-04-08" ],
    [ pe:var "Outside"; pe:value true ],
    [ pe:var "Place"; pe:value :TableArea42 ],
    [ pe:var "Reservation"; pe:value :Reservation42 ],
    [ pe:var "Restaurant"; pe:value :Maximiliaan ];
  pe:uses
    { :Maximiliaan resto:hasReservation :Reservation42 . },
    { :Reservation42 resto:onDate "2026-04-08" . },
    { :Reservation42 resto:place :TableArea42 . },
    { :TableArea42 resto:isOutside true . }.
```

`pe:rule 8` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 21 steps, 21 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 21; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 68; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/resto.n3
eyeron -p examples/resto.n3
eyeron -c examples/resto.n3
```

---

## References

[Source reference 1](https://github.com/RESTdesc/RestoProof)

---

## Takeaway

A plan can link service conditions to result witnesses and a final reservation
query.
