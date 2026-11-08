# Unicorn Self-Denial

*"Not a unicorn, therefore a unicorn": a rule set that undoes itself.*

[unicorn-self-denial.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/unicorn-self-denial.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/unicorn-self-denial.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=unicorn-self-denial)

---

## The question

Russell and Wittgenstein teach philosophy. Two rules are added:

- a teacher is *not* a unicorn, unless we know they are one;
- whatever is not a unicorn *is* a unicorn.

The second rule turns the first rule's conclusion into the very claim it
denies. It is a little like the barber who shaves everyone who does not
shave himself.

**What happens when Eyeron applies these rules?**

---

## What we tell Eyeron

```n3
:philosophy :teacher :russell .
:philosophy :teacher :wittgenstein .

{
    ?course :teacher ?x .
    ?scope log:notIncludes {
        ?x :isA :Unicorn .
    } .
} => {
    ?x :isNot :Unicorn .
} .

{
    ?x :isNot :Unicorn .
} => {
    ?x :isA :Unicorn .
} .
```

`?scope log:notIncludes { … }` is **scoped negation**: it holds when the
pattern is not in the current graph, everything known at that point. The
first rule depends on the absence of `?x :isA :Unicorn`; the second rule
produces exactly that statement.

---

## What Eyeron concludes

Nothing. Eyeron concludes that Russell is not a unicorn, the second rule
makes him one, and that contradicts the absence the first step assumed.
Eyeron stops with an **inference fuse** and exits with code 65:

```text
# Inference fuse triggered.
# Contradiction: assumes the current graph lacks this, but the current graph includes it.
# Invalidated assumption:
#   _:current_graph log:notIncludes {
#       :russell :isA :Unicorn .
#   } .
```

The broken assumption is about one individual, Russell: the absence is
decided for each teacher separately, and Russell's is the first to fail.
Wittgenstein would fail the same way, but the run has already stopped.

There is no proof or check report: a fuse ends the run without an answer.

---

## Try it

```sh
eyeron examples/unicorn-self-denial.n3
echo $?    # 65
```

Delete the second rule: Eyeron then concludes
`:russell :isNot :Unicorn .` and `:wittgenstein :isNot :Unicorn .` and exits
normally.

---

## Takeaway

A rule set that refutes its own negative premise has no consistent answer;
Eyeron detects that and says which assumption broke.
