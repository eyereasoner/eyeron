# Matching nested lists

*Patterns shaped like the data reach inside lists within lists.*

[collection-nesting.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/collection-nesting.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/collection-nesting.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/collection-nesting.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/collection-nesting.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=collection-nesting)

---

## The question

A value can be a list, and a list can hold other lists. To use such data a
rule has to reach inside: take the first item here, the second item of the
inner list there.

**Can rule patterns pick out values at different depths of a nested list?**

---

## What we tell Eyeron

```n3
:root :nested (1 (:node :q) (2)) .
```

`( … )` is a list. This one has three members: the number `1`, the two-item
list `(:node :q)`, and the one-item list `(2)`.

Three rules each match the list with a pattern of the same shape:

```n3
{
    :root :nested (?first ?second ?third)
} => {
    :test :first ?first
} .

{
    :root :nested (?first (:node ?value) ?third)
} => {
    :test :secondProperty ?value
} .

{
    :root :nested (?first ?second (?value))
} => {
    :test :thirdFirst ?value
} .
```

A list pattern matches a list of the same length, member by member. A
variable matches any member, even a whole list; a nested pattern such as
`(:node ?value)` matches only a member with that shape.

---

## What Eyeron concludes

```n3
:test :first 1 .
:test :secondProperty :q .
:test :thirdFirst 2 .
```

One value from each level: the first member, the second item of the inner
pair, and the only item of the last list.

---

## The proof, step by step

Each conclusion is one rule step on the same fact. The bindings show what
each variable matched, including whole lists:

```n3
{ :test :first 1 . }
  pe:rule 1;
  pe:binding
    [ pe:var "first"; pe:value 1 ],
    [ pe:var "second"; pe:value (:node :q) ],
    [ pe:var "third"; pe:value (2) ];
  pe:uses { :root :nested (1 (:node :q) (2)) . }.

{ :root :nested (1 (:node :q) (2)) . }
  pe:fact "collection-nesting.n3".
```

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
```

- **C1 resolution**: putting the recorded values into each rule's pattern
  gives exactly the fact in the program.
- C2, C3, C4, C7 and C10 confirm there is no cycle, every premise is
  supported, nothing is padding, and the answers come from the rules as
  written.

All 4 steps are verified; the verdict is **checked**.

---

## Try it

```sh
eyeron examples/collection-nesting.n3
eyeron -c examples/collection-nesting.n3
```

Change `(:node :q)` in the fact to `(:other :q)`. The second rule's pattern
no longer fits, so `:test :secondProperty` disappears, while the other two
conclusions stay.

---

## Takeaway

A list pattern is a picture of the data: write the shape you expect, and the
variables pick out the parts.
