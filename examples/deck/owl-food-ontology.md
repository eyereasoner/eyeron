# Food Ontology

*A grape is a sweet fruit, a sweet fruit is edible: climbing a class hierarchy.*

[owl-food-ontology.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-food-ontology.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-food-ontology.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-food-ontology.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-food-ontology.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-food-ontology)

---

## The question

The OWL Guide, the W3C's introduction to the Web Ontology Language,
describes foods and wines. Its food part is a hierarchy of classes: pasta is
an edible thing, pasta with white sauce is pasta, a grape is a sweet fruit,
and so on, up to *consumable thing* at the top.

We have five foods, each with just one type: a grape, a cheese-and-nuts
dessert, a pasta with light cream sauce, a meal, and some consumable thing.

**What are all the types of each food, once the hierarchy is taken into
account?**

---

## What we tell Eyeron

The foods are blank nodes: things written `_:g` that have no name of their
own, only a label inside this file.

```n3
_:g a food:Grape .
_:cnd a food:CheeseNutsDessert .
_:pwlcs a food:PastaWithLightCreamSauce .
```

The hierarchy is 35 `rdfs:subClassOf` statements, each saying that every
member of the first class is a member of the second:

```n3
food:Grape rdfs:subClassOf food:SweetFruit .
food:SweetFruit rdfs:subClassOf food:EdibleThing .
food:EdibleThing rdfs:subClassOf food:ConsumableThing .
```

Four rules from RDF Schema give `rdfs:subClassOf` its meaning. The one that
does the work here moves a member up to the superclass:

```n3
{
    ?C rdfs:subClassOf ?D .
    ?X a ?C
} => {
    ?X a ?D
} .
```

Another makes subclass transitive; two more would widen property domains
and ranges, but this vocabulary declares none, so they never fire.

The program ends with a query. `log:query` says what to print: instead of
every derived statement, only the instances of its right-hand side.

```n3
{
    ?A a ?B .
} log:query {
    ?A a ?B .
} .
```

---

## What Eyeron concludes

The answer lists every type of every food: the 5 given ones and 11 derived.
For the grape:

```n3
_:g a food:Grape .
_:g a food:SweetFruit .
_:g a food:EdibleThing .
_:g a food:ConsumableThing .
```

The pasta climbs furthest, through white-sauce pasta and pasta to edible and
consumable thing; the dessert goes through dessert and edible thing; the
meal is directly a consumable thing. The thing that was only a consumable
thing gains nothing.

Because the foods are blank nodes, Eyeron may print other labels than
`_:g` in another run; what matters is which statements belong together.

---

## The proof, step by step

Every derived type is one application of rule 1. The grape is edible
because it is a sweet fruit:

```n3
{ _:g a food:EdibleThing . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value food:SweetFruit ],
    [ pe:var "D"; pe:value food:EdibleThing ],
    [ pe:var "X"; pe:value _:g ];
  pe:uses
    { food:SweetFruit rdfs:subClassOf food:EdibleThing . },
    { _:g a food:SweetFruit . }.
```

and it is a sweet fruit by the same rule, from the given `_:g a food:Grape`.
The proof has 30 steps: 11 steps of rule 1, 5 of rule 2 (subclass links
derived by transitivity, which some steps use as shortcuts), and 14 given
facts. The query rule itself does not get a number: rules are counted
without it.

---

## Checked: what the report says

```n3
# checked: 30 steps, 30 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 64; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 64; pe:failed 0 ].
```

- **C1 resolution**, **C2 well-foundedness** and **C3 justification**: each
  of the 30 steps really is the rule application or fact it cites, none
  depends on itself, and each has one proper justification.
- **C4 coverage**: the 64 premises and claims all resolve.
- **C7 relevance**: every step serves an answer, and every answer is an
  instance of the query.
- **C10 call fidelity**: because the program has a query, the checker also
  confirms that each answer has its own query application and that no step
  uses a query answer as evidence: answers are output, not new facts.

There is nothing to recompute or assume, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/owl-food-ontology.n3      # the types
eyeron -p examples/owl-food-ontology.n3   # with the proof
eyeron -c examples/owl-food-ontology.n3   # the proof, checked
```

Add `_:e a food:EatingGrape .` and the new food climbs one step further than
the grape: eating grape, grape, sweet fruit, edible and consumable thing.

---

## Takeaway

A class hierarchy plus one short rule turns a single type into every type a
thing has, and the query keeps the answer to what was asked.
