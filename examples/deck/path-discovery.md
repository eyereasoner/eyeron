# Finding flights with at most two stopovers

[path-discovery.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/path-discovery.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/path-discovery.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/path-discovery.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/path-discovery.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=path-discovery)

---

## The question

An airport graph describes available outbound routes. Recursive backward N3
rules find paths from Ostend-Bruges to Prague with at most two stopovers, and
scoped collection gathers the airport names for each path.

**Which routes reach Prague from Ostend-Bruges with at most two stopovers?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The airport corpus includes labels and directed outbound connections.
# The route rules appear after the data.
res:AIRLINE_10 rdfs:label "40-Mile Air" .

# find routes from Ostend-Bruges International Airport to Václav Havel Airport Prague with at most 2 stopovers
{
    ?source rdfs:label "Ostend-Bruges International Airport" .
    ?destination rdfs:label "Václav Havel Airport Prague" .
    (?source ?destination () 0 2) :route ?airports .
    (
        ?city {
            ?airports list:member ?airport .
            ?airport rdfs:label ?city
        }
        ?route
    ) log:collectAllIn ?scope .
} => {
    :discovered :airroute ?route .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:discovered :airroute ("Ostend-Bruges International Airport" "Liège Airport" "Heraklion International Nikos Kazantzakis Airport" "Václav Havel Airport Prague") .
:discovered :airroute ("Ostend-Bruges International Airport" "Liège Airport" "Diagoras Airport" "Václav Havel Airport Prague") .
:discovered :airroute ("Ostend-Bruges International Airport" "Liège Airport" "Palma De Mallorca Airport" "Václav Havel Airport Prague") .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :discovered :airroute ("Ostend-Bruges International Airport" "Liège Airport" "Heraklion International Nikos Kazantzakis Airport" "Václav Havel Airport Prague") . }
  pe:rule 3;
  pe:binding
    [ pe:var "airports"; pe:value (res:AIRPORT_310 res:AIRPORT_309 res:AIRPORT_1452 res:AIRPORT_1587) ],
    [ pe:var "destination"; pe:value res:AIRPORT_1587 ],
    [ pe:var "route"; pe:value ("Ostend-Bruges International Airport" "Liège Airport" "Heraklion International Nikos Kazantzakis Airport" "Václav Havel Airport Prague") ],
    [ pe:var "source"; pe:value res:AIRPORT_310 ];
  pe:uses
    { res:AIRPORT_310 rdfs:label "Ostend-Bruges International Airport" . },
    { res:AIRPORT_1587 rdfs:label "Václav Havel Airport Prague" . },
    { (res:AIRPORT_310 res:AIRPORT_1587 () 0 2) :route (res:AIRPORT_310 res:AIRPORT_309 res:AIRPORT_1452 res:AIRPORT_1587) . },
    {
        (?city {
            (res:AIRPORT_310 res:AIRPORT_309 res:AIRPORT_1452 res:AIRPORT_1587) list:member ?airport .
            ?airport rdfs:label ?city .
        } ("Ostend-Bruges International Airport" "Liège Airport" "Heraklion International Nikos Kazantzakis Airport" "Václav Havel Airport Prague")) log:collectAllIn ?scope .
    }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 42 steps, 42 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 21; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 21; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 12; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

The saved proof is large; write the results to files before inspecting them.

```sh
eyeron examples/path-discovery.n3 > /tmp/path-discovery-output.n3
eyeron -p examples/path-discovery.n3 > /tmp/path-discovery-proof.n3
eyeron -c examples/path-discovery.n3 > /tmp/path-discovery-check.n3
```

---

## References

[Source reference 1](https://aws.amazon.com/blogs/database/build-and-deploy-knowledge-graphs-faster-with-rdf-and-opencypher/)

---

## Takeaway

A stopover bound makes the route search finite, and collection turns each
route into airport names.
