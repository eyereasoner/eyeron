# Mapping a person's description to FOAF

*Saying the same thing in a second vocabulary, one rule per term.*

[schema-foaf-mapping.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/schema-foaf-mapping.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/schema-foaf-mapping.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/schema-foaf-mapping.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/schema-foaf-mapping.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=schema-foaf-mapping)

---

## The question

On the web, people are described in more than one vocabulary.
[schema.org](https://schema.org/) is what search engines read;
[FOAF](http://xmlns.com/foaf/spec/) ("friend of a friend") is older and used
by many linked-data tools. Both have a *Person* and a *name*, under different
web addresses.

**Given Alice described in schema.org terms, what does her FOAF description
look like?**

---

## What we tell Eyeron

```n3
ex:alice a schema:Person ;
    schema:name "Alice Example" ;
    schema:givenName "Alice" ;
    schema:familyName "Example" .
```

The `;` repeats the subject: four statements about `ex:alice`. The prefixes
`schema:`, `foaf:` and `ex:` abbreviate long web addresses.

Then one rule per term to translate:

```n3
# Rule 1: If something is a schema:Person, also treat it as a foaf:Person
{
    ?p a schema:Person .
} => {
    ?p a foaf:Person .
} .

# Rule 2: Map schema:name to foaf:name
{
    ?p schema:name ?name .
} => {
    ?p foaf:name ?name .
} .
```

Rules 3 and 4 do the same for the given name and the family name.

---

## What Eyeron concludes

```n3
ex:alice a foaf:Person .
ex:alice foaf:name "Alice Example" .
ex:alice foaf:givenName "Alice" .
ex:alice foaf:familyName "Example" .
```

Alice's FOAF description, statement for statement. The schema.org input is
not repeated; Eyeron prints what it derived.

---

## The proof: one rule, one fact, per statement

```n3
{ ex:alice foaf:name "Alice Example" . }
  pe:rule 2;
  pe:binding
    [ pe:var "name"; pe:value "Alice Example" ],
    [ pe:var "p"; pe:value ex:alice ];
  pe:uses { ex:alice schema:name "Alice Example" . }.

{ ex:alice schema:name "Alice Example" . }
  pe:fact "schema-foaf-mapping.n3".
```

Each FOAF statement has a rule step that names its mapping rule and a fact
step that points back at the schema.org statement it came from: eight steps
for four answers. For data integration this is a lineage record: every
translated value can be traced to its source.

---

## Checked: what the report says

```n3
# checked: 8 steps, 8 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 8; pe:failed 0 ];
pe:condition [ pe:id "C3"; pe:name "justification"; pe:checked 8; pe:failed 0 ];
```

- **C1 resolution**: each rule step is its mapping rule with the recorded
  bindings.
- **C3 justification**: each fact step names a statement that really is in
  `schema-foaf-mapping.n3`.
- **C2, C4, C7, C10**: no circularity, every premise covered, nothing
  padding, and each premise checked as its rule asks it.

Nothing is computed, negated or invented. 8 of 8 verified: **checked**.

---

## Try it

```sh
eyeron examples/schema-foaf-mapping.n3
eyeron -p examples/schema-foaf-mapping.n3
eyeron -c examples/schema-foaf-mapping.n3
```

Add `ex:bob a schema:Person ; schema:name "Bob" .` and run again: Bob gets
`a foaf:Person` and `foaf:name "Bob"`, and no given or family name, since
none was stated.

---

## Takeaway

Vocabulary mapping is a few one-line rules, and the proof doubles as
provenance: every translated statement points to its source.
