# Negative Dependency Cycle

*A conclusion that takes away the reason it was drawn.*

[variable-predicate-dependency.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/variable-predicate-dependency.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/variable-predicate-dependency.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=variable-predicate-dependency)

---

## The question

An item `:a` comes from a blocked source. Two rules apply:

- an item from a blocked source is *derived*, as long as it is not known to
  be *blocked*;
- every derived item is *blocked*.

If `:a` is derived, it becomes blocked, and then the reason for deriving it
is gone. There is no consistent way to apply both rules.

**What does Eyeron do with a program like that?**

---

## What we tell Eyeron

```n3
:a :source :blocked .

{
    ?x :source :blocked .
    ?SCOPE log:notIncludes {
        ?x a :Blocked
    } .
} => {
    ?x a :Derived
} .

{
    ?x a :Derived
} => {
    ?x a :Blocked
} .
```

`?SCOPE log:notIncludes { … }` is **scoped negation**: it holds when the
pattern is absent from the current graph. So the first rule depends on the
*absence* of `:Blocked`, and the second rule produces `:Blocked` from the
first rule's result: a **negative dependency cycle**.

---

## What Eyeron concludes

Nothing. Eyeron derives `:a a :Derived`, then `:a a :Blocked`, and notices
that the second contradicts the absence the first relied on. It stops with
an **inference fuse**, prints which assumption broke, and exits with code 65
instead of 0:

```text
# Inference fuse triggered.
# Contradiction: assumes the current graph lacks this, but the current graph includes it.
# Invalidated assumption:
#   _:current_graph log:notIncludes {
#       :a a :Blocked .
#   } .
```

Returning `:a a :Derived` would have been wrong: it was drawn from a fact,
"`:a` is not blocked", that is no longer true. Stopping is the honest
outcome.

There is no proof or check report for this example: a fuse ends the run
without an answer to prove.

---

## Try it

```sh
eyeron examples/variable-predicate-dependency.n3
echo $?    # 65
```

Delete the second rule and run again: the cycle is gone, Eyeron concludes
`:a a :Derived` and exits with 0.

---

## Takeaway

Scoped negation is checked against what inference derives afterwards; when
a conclusion undoes its own premise, Eyeron refuses to answer rather than
answer wrongly.
