# Has Key

*Same name, same birth date: two records of one person.*

[owl-has-key.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-has-key.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-has-key.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-has-key.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-has-key.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-has-key)

---

## The question

Databases identify records by keys. OWL can do the same with
`owl:hasKey`: if two members of a class agree on every key property, they
are the same individual.

Here a person is identified by given name and birth date together. There
are three person records. All three are called Alice; `:alice` and `:alias`
were born on 2 January 1990, `:other` on 4 March 1991.

**Which records describe the same person?**

---

## What we tell Eyeron

```n3
:Person owl:hasKey (:givenName :birthDate) .
:alice a :Person ;
    :givenName "Alice" ;
    :birthDate "1990-01-02" .
:other a :Person ;
    :givenName "Alice" ;
    :birthDate "1991-03-04" .
```

`( … )` is a list; the semicolon repeats the subject for the next
statement. The record `:alias` looks just like `:alice`.

The rule picks two different members `?X` and `?Y` of a keyed class and
then asks whether they agree on *every* property in the key:

```n3
{
    ?C owl:hasKey ?L .
    ?X a ?C .
    ?Y a ?C .
    ?X log:notEqualTo ?Y .
    (
        {
            ?P list:in ?L
        }
        {
            ?X ?P ?Z .
            ?Y ?P ?Z
        }
    ) log:forAllIn ?SCOPE
} => {
    ?X owl:sameAs ?Y
} .
```

`log:notEqualTo` is a built-in that holds when its two sides differ.
`log:forAllIn` is a universal test: for every `?P` in the key list, `?X` and
`?Y` must share a value `?Z`. It is tested against everything Eyeron knows
at that point, the *current graph*.

---

## What Eyeron concludes

```n3
:alice owl:sameAs :alias .
:alias owl:sameAs :alice .
```

`:other` shares the name but not the birth date, so it stays a different
person.

---

## The proof, step by step

```n3
{ :alice owl:sameAs :alias . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :Person ],
    [ pe:var "L"; pe:value (:givenName :birthDate) ],
    [ pe:var "SCOPE"; pe:value _:forAllIn ],
    [ pe:var "X"; pe:value :alice ],
    [ pe:var "Y"; pe:value :alias ];
  pe:uses
    { :Person owl:hasKey (:givenName :birthDate) . },
    { :alice a :Person . },
    { :alias a :Person . },
    { :alice log:notEqualTo :alias . },
    {
        ({
            ?P list:in (:givenName :birthDate) .
        } {
            :alice ?P ?Z .
            :alias ?P ?Z .
        }) log:forAllIn _:forAllIn .
    }.
```

The five premises are three given facts and two built-in steps:

```n3
{ :alice log:notEqualTo :alias . }
  pe:builtin log:notEqualTo.
```

and the `log:forAllIn` test, justified as `pe:builtin log:forAllIn`. The
proof has 9 steps: 2 rule steps, 3 facts and 4 built-in steps.

---

## Checked: what the report says

```n3
# checked with obligations: 9 steps, 7 verified, 2 trusted
pe:verdict pe:checkedWithObligations;
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 4; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
pe:obligation [
    pe:kind "collected";
```

- **C1–C4** and **C7**: the rule steps and facts are what they cite, there
  are no cycles, every premise resolves, and every step serves a claim.
- **C5 re-decision** examined the 4 built-in steps; the two
  `log:notEqualTo` tests are simply recomputed.
- The two `log:forAllIn` tests depend on the whole current graph, which a
  proof does not record. **C9 search closure** tried to settle them from
  the proof's search certificate, but they match `?X ?P ?Z`, a triple whose
  predicate is a variable, and such a test cannot be settled that way.
- So they stay **obligations** of kind `collected`: the verdict is *checked
  with obligations*, and the answers are conditional on those tests having
  held. **C6 boundary consistency** did confirm that nothing in the proof
  itself contradicts them.

Seven steps are verified; two are taken on trust, and the report says so.

---

## Try it

```sh
eyeron examples/owl-has-key.n3      # the conclusions
eyeron -p examples/owl-has-key.n3   # with the proof
eyeron -c examples/owl-has-key.n3   # the proof, checked
```

Change the birth date of `:other` to `"1990-01-02"`: now all three records
match the key, and Eyeron concludes six `owl:sameAs` statements, one for
each ordered pair.

---

## Takeaway

A key turns "agrees on every key property" into identity; the universal
test that decides it is honest about what a proof alone cannot re-establish.
