# An inference fuse involving a quoted rule

*A program that judges its own rule, and stops.*

[liar.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/liar.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/liar.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=liar)

---

## The question

Some programs should never run to the end: when a contradiction appears,
the right answer is to stop and say so. N3 has a way to write that, a rule
whose conclusion is `false`, called an *inference fuse*.

**What happens when a program contains a rule, and also a rule saying that
having that rule is a contradiction?**

---

## What we tell Eyeron

```n3
{
    :Alice a :Liar
} => false .
```

*If Alice is a liar, that is a contradiction.* Nothing says Alice is a liar,
so this rule on its own would never fire.

```n3
{
    {
        :Alice a :Liar
    } => false
} => false .
```

The second rule's premise is not a fact about Alice but a quoted rule: the
first rule itself. In N3 a rule is also a statement, so the premise matches
the first rule as written in the program, and the second rule fires: its
conclusion is `false`.

---

## What Eyeron concludes

Nothing. A fuse stops the run: Eyeron prints which rule fired and exits with
code 65 instead of 0.

```text
# Inference fuse triggered.
# Fired rule:
```

There is no proof or check report for this example: a fuse is the end of the
run, not an answer to prove.

---

## Try it

```sh
eyeron examples/liar.n3; echo $?   # the fuse, exit code 65
```

Change the first rule's conclusion to `{ :Alice :status :suspect }`. The
quoted rule in the second rule no longer matches anything in the program, so
it does not fire: Eyeron runs to the end, concludes nothing, and exits with
0. Add `:Alice a :Liar .` as well and it concludes `:Alice :status :suspect`.

---

## Takeaway

In N3 rules are data too, so a rule can be about another rule; and a rule
that concludes `false` turns a contradiction into a clear, deliberate stop.
