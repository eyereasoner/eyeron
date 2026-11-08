# Propagating a category alignment

*If a vehicle with a plate counts as a car, so does every passenger car.*

[minimal-skos-alignment.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/minimal-skos-alignment.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/minimal-skos-alignment.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/minimal-skos-alignment.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/minimal-skos-alignment.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=minimal-skos-alignment)

---

## The question

Two organisations describe vehicles with their own vocabularies. A traffic
camera dataset (number-plate recognition, `anpr:`) has categories such as
*vehicle with plate* and *passenger car*. A reference vocabulary (`ref:`) has
*car*. Someone has linked the two at one point only.

**For reporting, which dataset categories should be treated as a car?**

---

## What we tell Eyeron

The vocabularies use SKOS, the W3C standard for thesauri and category schemes:

```n3
ref:Car a skos:Concept .

anpr:VehicleWithPlate a skos:Concept ;
    skos:broadMatch ref:Car .

anpr:PassengerCar a skos:Concept ;
    skos:broader anpr:VehicleWithPlate .
```

`skos:broadMatch` links across schemes: the reference *car* is a broader
match for *vehicle with plate*. `skos:broader` works inside one scheme: a
passenger car is a kind of vehicle with plate.

```n3
{
    ?a skos:broadMatch ?b .
} => {
    ?a ex:treatedAs ?b .
} .

{
    ?x skos:broader ?y .
    ?y ex:treatedAs ?z .
} => {
    ?x ex:treatedAs ?z .
} .
```

Rule 1 turns the cross-scheme link into a reporting decision. Rule 2 passes
that decision down to narrower categories.

---

## What Eyeron concludes

```n3
anpr:VehicleWithPlate ex:treatedAs ref:Car .
anpr:PassengerCar ex:treatedAs ref:Car .
```

The passenger car was never linked to the reference scheme directly; it
inherits the treatment from its broader category.

---

## The proof, step by step

```n3
{ anpr:PassengerCar ex:treatedAs ref:Car . }
  pe:rule 2;
  pe:binding
    [ pe:var "x"; pe:value anpr:PassengerCar ],
    [ pe:var "y"; pe:value anpr:VehicleWithPlate ],
    [ pe:var "z"; pe:value ref:Car ];
  pe:uses
    { anpr:PassengerCar skos:broader anpr:VehicleWithPlate . },
    { anpr:VehicleWithPlate ex:treatedAs ref:Car . }.
```

The second conclusion rests on the first, which rule 1 derived from the
`skos:broadMatch` fact. Four steps in all: two rule steps, two facts.

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
```

- **C1 resolution**: both rule steps match their rules with the recorded
  bindings, and both facts are in the source.
- **C2 well-foundedness**: the chain runs one way, from facts to rule 1 to
  rule 2.
- **C3, C4, C7, C10**: each step is justified and covered, nothing is
  irrelevant, and the answers are checked as the questions were asked.

There are no calculations or negations, so the remaining conditions examined
nothing. All 4 steps are verified.

---

## Try it

```sh
eyeron examples/minimal-skos-alignment.n3
eyeron -c examples/minimal-skos-alignment.n3
```

Add a narrower category below passenger car:

```n3
anpr:Taxi a skos:Concept ;
    skos:broader anpr:PassengerCar .
```

Eyeron also concludes `anpr:Taxi ex:treatedAs ref:Car .`, through rule 2
applied twice.

---

## Takeaway

One alignment link plus one propagation rule is enough to carry a mapping
down a whole category tree, with each inherited decision traceable.
