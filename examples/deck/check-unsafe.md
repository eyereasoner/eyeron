# An unbound rule conclusion

*A rule that would have to say "everyone": Eyeron concludes nothing.*

[check-unsafe.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/check-unsafe.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/check-unsafe.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=check-unsafe)

---

## The question

Alice knows Bob. A rule says that when Alice knows Bob, *someone* is seen.
But who? The rule never says: the person in its conclusion is a variable
that no premise fills in.

**What should a reasoner derive from a rule whose conclusion names nobody in
particular?**

---

## What we tell Eyeron

```n3
:alice :knows :bob .

{
    :alice :knows :bob
} => {
    ?someone a :Seen
} .
```

In a rule, a `?` variable stands for *every* value it can take. Variables
normally get their values from the premises: matching `?S a ?A` against a
fact fills in `S` and `A`. Here the premise has no variables at all, and
`?someone` occurs only in the conclusion. Read literally, the rule says
*"if Alice knows Bob, then everything is seen"*, which is not one fact that
can be written down. A rule like this is called *unsafe*.

---

## What Eyeron concludes

Nothing. The premise holds, but the conclusion has no value for
`?someone`, so the rule produces no fact and the output golden is empty.
Eyeron does not invent an individual, and does not write down a statement
with a variable in it.

The proof of nothing is empty too: `eyeron -c` reports
`# checked: 0 steps, 0 verified, 0 trusted`, and there is no saved proof or
check report for this example.

---

## Try it

```sh
eyeron examples/check-unsafe.n3
eyeron -c examples/check-unsafe.n3
```

If what you meant was *"someone is seen"*, use a blank node, which stands
for some individual: change `?someone a :Seen` to `_:someone a :Seen`.
Eyeron then concludes `_:someone_… a :Seen .`, introducing one fresh
individual. If you meant Bob, write `:bob a :Seen` and that is what it
concludes.

---

## Takeaway

A variable that only a rule's conclusion mentions has nothing to stand for;
say *some* individual with a blank node, or a particular one by name.
