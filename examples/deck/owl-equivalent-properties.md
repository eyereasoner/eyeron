# Equivalent Properties

*Three names for one relationship, and a statement that carries over to all of them.*

[owl-equivalent-properties.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-equivalent-properties.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-equivalent-properties.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-equivalent-properties.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-equivalent-properties.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-equivalent-properties)

---

## The question

Different data sets often use different words for the same thing. One says
`:parent`, another `:hasChild`, a third `:child`. The Web Ontology Language
(OWL) lets you declare that two properties mean the same with
`owl:equivalentProperty`.

We know that `:parent` is equivalent to `:hasChild`, that `:hasChild` is
equivalent to `:child`, and that Alice is Bob's parent in the first
vocabulary.

**Under which names is Alice related to Bob, and what else follows from the
two declarations?**

---

## What we tell Eyeron

```n3
:parent owl:equivalentProperty :hasChild .
:hasChild owl:equivalentProperty :child .
:alice :parent :bob .
```

Eyeron has no built-in OWL knowledge. What `owl:equivalentProperty` means is
written as ordinary N3 rules in the same file. The first rule carries a
statement over to an equivalent property:

```n3
{
    ?P owl:equivalentProperty ?Q .
    ?S ?P ?O
} => {
    ?S ?Q ?O
} .
```

Notice `?S ?P ?O`: the predicate itself is a variable, so the rule works for
any property. A second rule does the same in the other direction. Two more
make equivalence symmetric and transitive:

```n3
{
    ?P owl:equivalentProperty ?Q
} => {
    ?Q owl:equivalentProperty ?P
} .
```

```n3
{
    ?P owl:equivalentProperty ?Q .
    ?Q owl:equivalentProperty ?R
} => {
    ?P owl:equivalentProperty ?R
} .
```

The last two say that equivalent properties are subproperties of each other
(`rdfs:subPropertyOf` both ways), and that mutual subproperties are
equivalent.

---

## What Eyeron concludes

Alice is related to Bob under the other two names:

```n3
:alice :hasChild :bob .
:alice :child :bob .
```

The two declarations grow into the full picture: every pair of the three
properties is equivalent, in both directions, and each is a subproperty of
the others.

```n3
:parent owl:equivalentProperty :child .
:child owl:equivalentProperty :parent .
:parent rdfs:subPropertyOf :child .
:child rdfs:subPropertyOf :parent .
```

There is a surprise too: each property is equivalent to itself.

```n3
:parent owl:equivalentProperty :parent .
:child rdfs:subPropertyOf :child .
```

That comes from combining symmetry and transitivity: `:parent` is equivalent
to `:hasChild`, which is equivalent back to `:parent`. It is true, and OWL
agrees, but it shows how rules written for one purpose can produce more than
you first expect. In total Eyeron derives 18 statements.

---

## The proof, step by step

The proof of `:alice :child :bob` goes through `:hasChild`:

```n3
{ :alice :child :bob . }
  pe:rule 1;
  pe:binding
    [ pe:var "O"; pe:value :bob ],
    [ pe:var "P"; pe:value :hasChild ],
    [ pe:var "Q"; pe:value :child ],
    [ pe:var "S"; pe:value :alice ];
  pe:uses
    { :hasChild owl:equivalentProperty :child . },
    { :alice :hasChild :bob . }.
```

Rule 1 is the "carry over" rule, with `P` standing for `:hasChild` and `Q`
for `:child`. Its second premise, `:alice :hasChild :bob`, is itself
derived, by rule 1 again, from the given fact `:alice :parent :bob`:

```n3
{ :alice :hasChild :bob . }
  pe:rule 1;
  pe:binding
    [ pe:var "O"; pe:value :bob ],
    [ pe:var "P"; pe:value :parent ],
    [ pe:var "Q"; pe:value :hasChild ],
    [ pe:var "S"; pe:value :alice ];
  pe:uses
    { :parent owl:equivalentProperty :hasChild . },
    { :alice :parent :bob . }.
```

The whole proof has 21 steps: 18 rule steps, one for each conclusion, and 3
for the given facts they rest on.

---

## Checked: what the report says

```n3
# checked: 21 steps, 21 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 21; pe:failed 0 ];
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 43; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 39; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 18; pe:failed 0 ].
```

- **C1 resolution**: every step re-performs one application of the rule it
  cites, or states a fact of the program.
- **C2 well-foundedness** and **C3 justification**: no step depends on
  itself, and each has exactly one well-formed justification.
- **C4 coverage**: all 43 premises and claims point to a step or a given fact.
- **C7 relevance**: every step serves one of the 18 claims.
- **C10 call fidelity**: the 18 rule steps make only the calls their rules
  make; there are no negations or queries to be careful about.

Nothing is recomputed, assumed or invented here, so C5, C6, C8 and C9 had
nothing to examine. The verdict is **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/owl-equivalent-properties.n3      # the conclusions
eyeron -p examples/owl-equivalent-properties.n3   # with the proof
eyeron -c examples/owl-equivalent-properties.n3   # the proof, checked
```

Add `:child owl:equivalentProperty :offspring .` and Alice is also Bob's
`:offspring`, with a longer proof chain behind it.

---

## Takeaway

Four short rules give `owl:equivalentProperty` its meaning, and every
statement they produce, even the unexpected ones, comes with a checked
reason.
