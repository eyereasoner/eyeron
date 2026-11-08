# JSON-Shaped Terms

*Objects and arrays from JSON, written as N3 blank nodes and lists.*

[jsonterm.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/jsonterm.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/jsonterm.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/jsonterm.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/jsonterm.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=jsonterm)

---

## The question

Much data on the web arrives as JSON: objects with named fields, and arrays.
N3 has close counterparts. A `[ … ]` block is an anonymous node with
properties, much like a JSON object, and `( … )` is a list, much like an
array.

**Can a rule match a nested, JSON-like structure field by field?**

---

## What we tell Eyeron

```n3
[
    j:user "alice" ;
    j:roles ("admin" j:null)
] ("likes" 1) [
    j:city "Paris" ;
    j:coords (2.35 48.85)
] .
```

This is one statement. Its subject is a user object, its object a place
object, and its predicate is the list `("likes" 1)`. In N3 a list is a term
like any other, so it can even sit in the predicate position. JSON has no
`null` in RDF, so the example uses a named symbol `j:null` for it.

```n3
{
    [
        j:user ?U ;
        j:roles ("admin" j:null)
    ] ("likes" 1) [
        j:city "Paris" ;
        j:coords (2.35 48.85)
    ] .
} => {
    ex:test ex:is true .
} .
```

The rule repeats the same shape with the user name left open as `?U`.
Brackets in a rule condition act as variables, so they can match the
anonymous nodes of the data.

---

## What Eyeron concludes

```n3
ex:test ex:is true .
```

The whole structure matched: lists compared element by element, including
the decimal coordinates and `j:null`.

---

## The proof, step by step

```n3
{ ex:test ex:is true . }
  pe:rule 1;
  pe:binding [ pe:var "U"; pe:value "alice" ];
  pe:uses
    { _:b1 j:user "alice" . },
    { _:b1 j:roles ("admin" j:null) . },
    { _:b1 ("likes" 1) _:b2 . },
    { _:b2 j:city "Paris" . },
    { _:b2 j:coords (2.35 48.85) . }.
```

The nested block is unpacked into five plain triples, with `_:b1` for the
user object and `_:b2` for the place. Each of them is then cited as a fact
from `jsonterm.n3`.

---

## Checked: what the report says

```n3
# checked: 6 steps, 6 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
```

All six steps (one rule step and five facts) were re-performed against the
program (C1), none depends on itself (C2), and all serve the answer (C7).
Nothing is trusted.

---

## Try it

```sh
eyeron examples/jsonterm.n3
eyeron -p examples/jsonterm.n3
```

Change `"Paris"` in the data to `"Lyon"` and run again: the shape no longer
matches and nothing is concluded.

---

## Takeaway

Blank-node blocks and lists give N3 the shape of JSON, and rules can match
those shapes as directly as flat triples.
