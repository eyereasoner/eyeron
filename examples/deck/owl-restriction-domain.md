# Deriving a class from a property's domain

[owl-restriction-domain.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-restriction-domain.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-restriction-domain.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-restriction-domain.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-restriction-domain.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-restriction-domain)

---

## The question

Every pet owner has some unnamed property with the value :milo (an
owl:hasValue restriction), and that property's domain is Person: whatever has
it is a person. An N3 rule follows this nest of blank nodes and derives that
PetOwner is a subclass of Person.

**How does the nested restriction imply that every PetOwner is a Person?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# A class under a restriction on an unnamed property with domain Person
:PetOwner rdfs:subClassOf [
    owl:onProperty [ rdfs:domain :Person ] ;
    owl:hasValue :milo
] .

# Members of a hasValue restriction all have the property, so they are in
# its domain; a subclass of the restriction is a subclass of that domain.
{
    ?C rdfs:subClassOf ?Restriction .
    ?Restriction owl:onProperty ?Property ;
        owl:hasValue ?Value .
    ?Property rdfs:domain ?Domain
} => {
    ?C rdfs:subClassOf ?Domain
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:PetOwner rdfs:subClassOf :Person .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :PetOwner rdfs:subClassOf :Person . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :PetOwner ],
    [ pe:var "Domain"; pe:value :Person ],
    [ pe:var "Property"; pe:value _:b2 ],
    [ pe:var "Restriction"; pe:value _:b1 ],
    [ pe:var "Value"; pe:value :milo ];
  pe:uses
    { :PetOwner rdfs:subClassOf _:b1 . },
    { _:b1 owl:onProperty _:b2 . },
    { _:b1 owl:hasValue :milo . },
    { _:b2 rdfs:domain :Person . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 5 steps, 5 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-restriction-domain.n3
eyeron -p examples/owl-restriction-domain.n3
eyeron -c examples/owl-restriction-domain.n3
```

---

## Takeaway

Following the blank-node links connects the value restriction to its
property's domain.
