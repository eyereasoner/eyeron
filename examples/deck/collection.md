# Representing a nested collection

*A list with a blank node and a list inside it, as the subject of a
statement.*

[collection.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/collection.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=collection)

---

## The question

N3 can treat a whole list as one thing and say something about it. The
members of that list can themselves be anything: a number, an unnamed node,
another list.

**Does Eyeron read such a nested collection correctly?** This example is
about reading, not reasoning: it derives no new facts about the list.

---

## What we tell Eyeron

```n3
(1 _:b2 (2)) :p2 :q2 .
_:b2 :p :q .
```

`( … )` is a list, here with three members: the number `1`, the blank node
`_:b2`, and the one-member list `(2)`. The whole list is the subject of the
statement `:p2 :q2`. The second line describes the blank node: `_:b2` is a
node without a global name, and using the same label twice in a document
means the same node.

The program then prints a short note with `log:outputString`, through a
`log:query`:

```n3
{
    :__md_output :text ?text
} log:query {
    :__md_output log:outputString ?text
} .
```

When a program produces such text, Eyeron prints the text and nothing else.

---

## What Eyeron concludes

Only the note:

```text
# collection
## Source files
- [N3 rules](../collection.n3)
- [Input TriG](../input/collection.trig)
```

The note links an input file that the repository does not have; the example
has no companion input. Its test is that it parses, so there is no saved
output, proof or check report.

---

## Try it

```sh
eyeron examples/collection.n3
eyeron -a examples/collection.n3
```

`-a` prints the parsed form, where you can see the two statements with the
nested list and the blank node. Delete the note's five lines and the output
is empty: Eyeron prints what it derives, and here it derives nothing.

---

## Takeaway

A list in N3 is a single term that can stand anywhere a name can, and it can
hold other lists and unnamed nodes.
