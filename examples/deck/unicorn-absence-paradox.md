# Unicorn Absence Paradox

*A rule that holds only while there are no unicorns, and then makes one.*

[unicorn-absence-paradox.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/unicorn-absence-paradox.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/unicorn-absence-paradox.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=unicorn-absence-paradox)

---

## The question

Russell and Wittgenstein teach philosophy. A first rule relates each course
to its teachers, but only *while no unicorn is known at all*. A second rule
says that once such a relation exists, *some* unicorn exists.

The first rule's result brings about the unicorn whose absence it needed.

**Can Eyeron keep the relation, or does it notice the paradox?**

---

## What we tell Eyeron

```n3
:philosophy :teacher :russell .
:philosophy :teacher :wittgenstein .

{
    ?course :teacher ?person .
    ?scope log:notIncludes {
        ?x a :Unicorn .
    } .
} => {
    ?course :something ?person .
} .

{
    ?course :something ?person .
} => {
    _:x a :Unicorn .
} .
```

In the first rule, `?x` occurs only inside the absence test, so the test
reads *there is no unicorn whatsoever* in the current graph. In the second
rule, `_:x` is a **blank node** in the conclusion: it introduces a new,
unnamed individual, *some* unicorn.

---

## What Eyeron concludes

Nothing. The first rule fires, the second creates a unicorn, and now the
current graph includes `?x a :Unicorn` for that unicorn — the very pattern
the first rule required to be absent. Eyeron stops with an **inference
fuse** and exits with code 65:

```text
# Inference fuse triggered.
# Contradiction: assumes the current graph lacks this, but the current graph includes it.
# Invalidated assumption:
#   _:current_graph log:notIncludes {
#       ?x a :Unicorn .
#   } .
```

The unicorn has no name, but it still counts: an unnamed individual is
enough to refute "there is none".

There is no proof or check report: a fuse ends the run without an answer.

---

## Try it

```sh
eyeron examples/unicorn-absence-paradox.n3
echo $?    # 65
```

Delete the second rule: Eyeron then concludes
`:philosophy :something :russell .` and
`:philosophy :something :wittgenstein .` and exits normally.

---

## Takeaway

An absence test is checked against what inference derives afterwards, even
when what appears is an unnamed individual.
