# Deriving connections in a road network

*No route-finding rules at all: two words of ontology and a general rule set.*

[road-ontology.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/road-ontology.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/road-ontology.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/road-ontology.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/road-ontology.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=road-ontology)

---

## The question

Ten one-way roads connect French cities: Paris to Chartres, Chartres to
Le Mans, Le Mans to Angers, Angers to Nantes, and others. One could write
rules about roads and routes. But the same knowledge can be stated as
*meaning*: a one-way road is a kind of path, and paths chain together. Then
a general-purpose rule set, which knows nothing about roads, can work out
the routes.

**Does such a rule set conclude that Paris reaches Nantes?**

---

## What we tell Eyeron

The roads:

```n3
:paris :oneway :chartres .
…
:chartres :oneway :lemans .
:lemans :oneway :angers .
…
:angers :oneway :nantes .
```

What the road words mean, in the vocabularies of RDF Schema and OWL, the Web
Ontology Language:

```n3
:oneway rdfs:subPropertyOf :path .
:path a owl:TransitiveProperty .
```

*Every one-way road is a path*, and *path is transitive*: a path from A to B
and one from B to C give one from A to C.

Then comes a general rule set for RDFS and OWL, about 20 rules for domains
and ranges, subclasses, inverse, symmetric and functional properties, lists,
and more. Two of them do the work here:

```n3
{
    ?P rdfs:subPropertyOf ?R .
    ?S ?P ?O
} => {
    ?S ?R ?O
} .

{
    ?P a owl:TransitiveProperty .
    ?X ?P ?O .
    ?S ?P ?X
} => {
    ?S ?P ?O
} .
```

Note the variable in the middle position, `?S ?P ?O`: these rules range over
*properties*, so they apply to roads, family trees or class hierarchies
alike.

Finally the query:

```n3
{
    :paris :path :nantes .
} log:query {
    :paris :path :nantes .
} .
```

---

## What Eyeron concludes

```n3
:paris :path :nantes .
```

Yes. Eyeron works out other paths too, and the rule set derives more general
facts besides, but the `log:query` prints only this one.

---

## The proof: subproperty, then transitivity

The proof chains Paris → Chartres → Le Mans → Angers → Nantes. The last
leg shows both rules:

```n3
{ :paris :path :nantes . }
  pe:rule 7;
  pe:binding
    [ pe:var "O"; pe:value :nantes ],
    [ pe:var "P"; pe:value :path ],
    [ pe:var "S"; pe:value :paris ],
    [ pe:var "X"; pe:value :angers ];
  pe:uses
    { :path a owl:TransitiveProperty . },
    { :angers :path :nantes . },
    { :paris :path :angers . }.
…
{ :angers :path :nantes . }
  pe:rule 4;
…
  pe:uses
    { :oneway rdfs:subPropertyOf :path . },
    { :angers :oneway :nantes . }.
```

Rule 7, transitivity, joins *Paris to Angers* with *Angers to Nantes*.
*Angers to Nantes* comes from rule 4, the subproperty rule, applied to the
road. *Paris to Angers* is split again by transitivity, and so on. In all,
13 steps: 7 rule steps (3 transitivity, 4 subproperty) and 6 fact steps,
which cite the four roads and the two ontology statements.

---

## Checked: what the report says

```n3
# checked: 13 steps, 13 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 13; pe:failed 0 ];
pe:condition [ pe:id "C3"; pe:name "justification"; pe:checked 13; pe:failed 0 ];
```

- **C1 resolution**: each rule step is the cited general rule, with the
  recorded bindings for `P`, `S`, `O`, …
- **C2 well-foundedness**: the transitivity rule is recursive, but no path
  is used to prove itself.
- **C3 justification**: the roads and ontology statements cited are in
  `road-ontology.n3`.
- **C4 coverage**, **C7 relevance**, **C10 call fidelity**: every premise has
  a step, nothing is padding, and premises and query were checked as
  written.

Of the 20-odd rules in the program, the proof needs two; the rest are not
cited. 13 of 13 verified: **checked**.

---

## Try it

```sh
eyeron examples/road-ontology.n3
eyeron -p examples/road-ontology.n3
eyeron -c examples/road-ontology.n3
```

Delete the line `:path a owl:TransitiveProperty .` and run again: only
single roads count as paths now, there is no road straight from Paris to
Nantes, and nothing is printed.

---

## Takeaway

Stating what words mean lets a general rule set do the reasoning: two
ontology statements replace hand-written route rules, and the proof shows
exactly which general rules were used.
