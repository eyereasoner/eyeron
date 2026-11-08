# Activating a Stored Graph

*A graph kept as a value becomes a set of facts, because a rule says so.*

[implicit-quantification-extra.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/implicit-quantification-extra.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/implicit-quantification-extra.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/implicit-quantification-extra.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/implicit-quantification-extra.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=implicit-quantification-extra)

---

## The question

In N3 a set of statements can be wrapped in braces and handled as a single
value, a *quoted graph*. Quoting a statement does not assert it: `:a :b { :c
:d :e }` says something *about* the statement `:c :d :e`, without claiming
it is true.

**Can a rule take such a stored graph and turn its contents into real facts?**

---

## What we tell Eyeron

```n3
:a :b {
    :c :d :e
} .

{
    ?x :b ?y
} => ?y .
```

The fact stores a quoted graph as the object of `:a :b`. The rule is unusual:
its conclusion is not a graph in braces but the bare variable `?y`. Whatever
`?y` is bound to when the condition matches becomes the conclusion. Here that
is the stored graph, so its statement is asserted.

Variables like `?x` and `?y` need no declaration: N3 treats them as
quantified over the whole rule, which is what "implicit quantification" in the
file name refers to.

---

## What Eyeron concludes

```n3
:c :d :e .
```

The statement that was only quoted is now a derived fact.

---

## The proof, step by step

```n3
{ :c :d :e . }
  pe:rule 1;
  pe:binding
    [ pe:var "x"; pe:value :a ],
    [ pe:var "y"; pe:value {
        :c :d :e .
    } ];
```

The binding for `y` is itself a graph. The step uses the stored fact
`:a :b { :c :d :e . }`, which the proof cites as a fact from the file.

---

## Checked: what the report says

```n3
# checked: 2 steps, 2 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
```

Both steps were re-performed (C1): substituting the bound graph for `?y`
gives exactly the claimed conclusion. No step depends on itself (C2), every
step serves the answer (C7), and nothing is trusted.

---

## Try it

```sh
eyeron examples/implicit-quantification-extra.n3
eyeron -p examples/implicit-quantification-extra.n3
eyeron -c examples/implicit-quantification-extra.n3
```

Put a second statement inside the braces, such as `:c :d :e . :f :g :h`, and
both come out as facts.

---

## Takeaway

A quoted graph is data until a rule decides to assert it; a variable can be a
whole rule conclusion.
