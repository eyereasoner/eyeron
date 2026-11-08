# Checking a traveler's possible coordinates

[water-chemistry.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/water-chemistry.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/water-chemistry.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/water-chemistry.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/water-chemistry.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=water-chemistry)

---

## The question

A traveler may be in one of five named cities, each with latitude and
longitude data. An N3 rule enumerates the city list to derive possible
coordinates, and a query selects the coordinates of Ghent.

**Which possible coordinates are selected for Ghent?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The hypothesis lists possible cities; it does not choose a single current city.
h:traveler1 h:inOneOf (
    t:Antwerp-Belgium t:Boston-USA t:Cambridge-USA t:Ghent-Belgium t:Ostend-Belgium
) .

# Derive a coordinate pair for every city in the traveler's possible-city list.
{
    ?T h:inOneOf ?LIST .
    ?C list:in ?LIST .
    ?C t:position-tensor (?LA ?LO) .
} => {
    ?T h:location (?LA ?LO) .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
h:traveler1 h:location (51.0535 3.7304) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ h:traveler1 h:location (51.0535 3.7304) . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value t:Ghent-Belgium ],
    [ pe:var "LA"; pe:value 51.0535 ],
    [ pe:var "LIST"; pe:value (t:Antwerp-Belgium t:Boston-USA t:Cambridge-USA t:Ghent-Belgium t:Ostend-Belgium) ],
    [ pe:var "LO"; pe:value 3.7304 ],
    [ pe:var "T"; pe:value h:traveler1 ];
  pe:uses
    { h:traveler1 h:inOneOf (t:Antwerp-Belgium t:Boston-USA t:Cambridge-USA t:Ghent-Belgium t:Ostend-Belgium) . },
    { t:Ghent-Belgium list:in (t:Antwerp-Belgium t:Boston-USA t:Cambridge-USA t:Ghent-Belgium t:Ostend-Belgium) . },
    { t:Ghent-Belgium t:position-tensor (51.0535 3.7304) . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 4 steps, 4 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
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
eyeron examples/water-chemistry.n3
eyeron -p examples/water-chemistry.n3
eyeron -c examples/water-chemistry.n3
```

---

## Takeaway

Despite the filename, this program enumerates city coordinates rather than
modeling water chemistry.
