# Querying Nested JSON Data

*A user document with nested objects and arrays, queried shape by shape.*

[jsonterm-advanced.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/jsonterm-advanced.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/jsonterm-advanced.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/jsonterm-advanced.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/jsonterm-advanced.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=jsonterm-advanced)

---

## The question

A web shop stores each user as a JSON document: a profile with an address,
a list of roles, preferences, and a list of orders. We want to pick out a few
facts from it: the user's name, whether the profile qualifies for review,
which preference profile it has, and what the order history looks like.

**Can N3 rules reach into nested JSON-shaped data and pull out what they
need?**

---

## What we tell Eyeron

The document is written in N3 with `[ … ]` for each JSON object, `( … )`
for each array, and a named symbol `j:null` for JSON's `null`:

```n3
[
    j:id "user-101" ;
    j:profile [
        j:name "Alice" ;
        j:active true ;
        j:address [
            j:city "Ghent" ;
            j:country "BE"
        ]
    ] ;
…
] ex:kind j:UserDocument .
```

The first rule looks two levels deep, into the profile and its address:

```n3
{
    ?Doc ex:kind j:UserDocument .
    ?Doc j:profile [
        j:name ?Name ;
        j:active true ;
        j:address [ j:country "BE" ]
    ] .
} => {
    ?Doc ex:userName ?Name .
    ?Doc ex:eligibleForReview true .
} .
```

A `[ … ]` block in a rule only has to match the fields it names: the
address also has a city, which the rule ignores. Lists are different: they
match element by element, in order. The third rule uses that to describe the
whole order history:

```n3
{
    ?Doc j:orders (
        [ j:id ?FirstId ; j:total 125 ; j:items ("book" "pen") ]
        [ j:id ?SecondId ; j:total 45 ; j:items ("notebook") ; j:coupon j:null ]
    ) .
} => {
```

A last rule sets `ex:test ex:is true` when the three earlier rules have all
fired for the same document.

---

## What Eyeron concludes

```n3
_:b1 ex:userName "Alice" .
_:b1 ex:eligibleForReview true .
_:b1 ex:profileTag "multilingual-dark-profile" .
_:b1 ex:hasHighValueStarterOrder true .
_:b1 ex:hasCouponlessFollowup true .
ex:test ex:is true .
```

The document has no name of its own, so Eyeron writes it as the blank node
`_:b1`. Every query matched, and the summary test passed.

---

## The proof, step by step

The proof unpacks the nested blocks into plain triples, with a fresh blank
node for every inner object (`_:b2` for the profile, `_:b3` for the
address):

```n3
{ _:b1 ex:userName "Alice" . }
  pe:rule 1;
  pe:binding
    [ pe:var "Doc"; pe:value _:b1 ],
    [ pe:var "Name"; pe:value "Alice" ];
  pe:uses
    { _:b1 ex:kind j:UserDocument . },
    { _:b1 j:profile _:b2 . },
    { _:b2 j:name "Alice" . },
    { _:b2 j:active true . },
    { _:b2 j:address _:b3 . },
    { _:b3 j:country "BE" . }.
```

The final test then cites the four derived statements:

```n3
{ ex:test ex:is true . }
  pe:rule 4;
  pe:binding [ pe:var "Doc"; pe:value _:b1 ];
```

---

## Checked: what the report says

```n3
# checked: 24 steps, 24 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 24; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 30; pe:failed 0 ];
```

Each of the 24 steps was re-performed against the program (C1): the rule
steps really follow from their bindings, and every unpacked triple really is
part of the document. No step depends on itself (C2) and all of them serve
the answers (C7). Pure pattern matching leaves nothing to trust.

---

## Try it

```sh
eyeron examples/jsonterm-advanced.n3
eyeron -c examples/jsonterm-advanced.n3
```

Change the address country from `"BE"` to `"NL"`. The first rule no longer
matches, so the name and review eligibility disappear, and with them the
final test; the preference and order conclusions remain.

---

## Takeaway

Nested JSON maps directly onto N3: objects match by the fields you name,
arrays match exactly, and each match is traceable to the triples it used.
