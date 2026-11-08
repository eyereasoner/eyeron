# Counting dogs for a license rule

*Five dogs need a license, two do not: counting with a collection.*

[dog-license.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/dog-license.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/dog-license.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/dog-license.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/dog-license.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=dog-license)

---

## The question

Suppose a town requires a license for anyone who keeps more than four dogs.
Alice has five dogs and Bob has two. To apply the rule, we first have to
count, and counting means looking at *all* of someone's dogs at once, not one
at a time.

**How many dogs does each person have, and who needs a license?**

---

## What we tell Eyeron

```n3
:alice :hasDog :dog1, :dog2, :dog3, :dog4, :dog5 .
:bob :hasDog :dog6, :dog7 .
```

The comma repeats the subject and predicate: Alice has dog1, Alice has dog2,
and so on.

```n3
{
    ?person :hasDog ?anyDog .
    (
        ?dog {
            ?person :hasDog ?dog
        }
        ?dogs
    ) log:collectAllIn ?SCOPE .
    ?dogs list:length ?count .
} => {
    ?person :dogCount ?count
} .
```

`log:collectAllIn` is a built-in that gathers every answer: here, every
`?dog` such that the person has that dog, into the list `?dogs`. The scope
`?SCOPE` is left unbound, which means "the facts Eyeron currently knows".
`list:length` then counts the list. The first line, `?person :hasDog
?anyDog`, just picks the people who own a dog at all.

```n3
{
    ?person :dogCount ?count .
    ?count math:greaterThan 4
} => {
    ?person :mustHave :dogLicense
} .
```

---

## What Eyeron concludes

```n3
:alice :dogCount 5 .
:bob :dogCount 2 .
:alice :mustHave :dogLicense .
```

Alice has five dogs and needs a license; Bob has two and does not. Note that
the first rule fired once per person, not once per dog: rules derive each
statement only once.

---

## The proof, step by step

The proof has ten steps. Alice's count comes from rule 1:

```n3
{ :alice :dogCount 5 . }
  pe:rule 1;
  pe:binding
    [ pe:var "anyDog"; pe:value :dog1 ],
    [ pe:var "count"; pe:value 5 ],
    [ pe:var "dogs"; pe:value (:dog1 :dog2 :dog3 :dog4 :dog5) ],
    [ pe:var "person"; pe:value :alice ];
  pe:uses
    { :alice :hasDog :dog1 . },
    {
        (?dog {
            :alice :hasDog ?dog .
        } (:dog1 :dog2 :dog3 :dog4 :dog5)) log:collectAllIn ?SCOPE .
    },
    { (:dog1 :dog2 :dog3 :dog4 :dog5) list:length 5 . }.
```

Its three premises are a given fact, the collection with the list it found,
and the length of that list. The collection and the length are built-in
steps (`pe:builtin`), which the checker can redo. The license follows by
rule 2 from the count and `5 math:greaterThan 4`.

---

## Checked: what the report says

```n3
# checked: 10 steps, 10 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
```

- **C1–C4** and **C7**: every rule step matches its rule, nothing is
  circular, every premise is proved, and every step serves an answer.
- **C5 re-decision**: the five built-in steps were recomputed: two lengths,
  `5 > 4`, and the two collections.
- **C9 search closure**: a collection over "what is currently known" is
  normally something a checker has to take on trust, since it cannot see
  everything the run knew. Here the dogs are only ever given as facts, never
  derived, so the checker can redo each collection over the program's facts
  and confirm the two lists exactly.
- **C6 boundary consistency**: nothing in the proof contradicts the two
  collected lists.
- **C10 call fidelity**: each collection was the call its rule makes, with
  `?dog` left open.

Because C9 settled the collections, nothing was taken on trust: the verdict
is **checked**.

---

## Try it

```sh
eyeron examples/dog-license.n3      # the answer
eyeron -p examples/dog-license.n3   # the answer with its proof
eyeron -c examples/dog-license.n3   # the proof, checked
```

Give Bob three more dogs, `:bob :hasDog :dog8, :dog9, :dog10 .`, and run
again: Bob's count becomes 5 and he needs a license too.

---

## Takeaway

Counting needs a view of all the facts at once; a collection gives it, and
when those facts come straight from the program, the checker can confirm the
count rather than trust it.
