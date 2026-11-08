# Slide 33

*A rule that reads another rule and recognizes an OWL restriction in it.*

[slide33.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/slide33.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/slide33.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/slide33.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/slide33.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=slide33)

---

## The question

In the Web Ontology Language (OWL), a *restriction* is a class defined by a
condition. Here `:aaa` is the class of things whose `:bbb` values are all
`:ccc`. Separately, the program contains a rule that says exactly that of one
thing, `:xxx`: whatever `:xxx` relates to by `:bbb` is a `:ccc`.

**Can Eyeron look at that rule and conclude that `:xxx` belongs to `:aaa`?**

---

## What we tell Eyeron

The restriction, as two facts:

```n3
:aaa owl:onProperty :bbb .
:aaa owl:allValuesFrom :ccc .
```

A rule about `:xxx`:

```n3
{
    :xxx :bbb ?y .
} => {
    ?y a :ccc .
} .
```

In N3 a rule is also a statement: `{ … } => { … }` is a triple whose
subject and object are quoted graphs. So another rule can match it. That is
what the second rule does:

```n3
{
    ?a owl:onProperty ?b .
    ?a owl:allValuesFrom ?c .
    {
        ?x ?b ?y .
    } => {
        ?y a ?c .
    } .
} => {
…
    ?x a ?a .
} .
```

Its premise looks for a restriction `(b only c)` and a rule saying every `b`
value of some `x` is a `c`. When both are present, `x` is an `a`. (The rule
also adds a new rule, "if `x` is an `a`, its `b` values are `c`".)

Finally `{ ?S a ?C . } log:query { ?S a ?C . } .` prints every type
statement.

---

## What Eyeron concludes

```n3
:xxx a :aaa .
```

---

## The proof, step by step

```n3
{ :xxx a :aaa . }
  pe:rule 2;
  pe:binding
    [ pe:var "a"; pe:value :aaa ],
    [ pe:var "b"; pe:value :bbb ],
    [ pe:var "c"; pe:value :ccc ],
    [ pe:var "x"; pe:value :xxx ],
    [ pe:var "y"; pe:value ?__rulefact_0__y ];
```

The answer comes from rule 2, the rule-reading rule. Its uses are the two
restriction facts and the quoted rule about `:xxx`, which the proof cites as
a fact of the program. The variable `y` of that quoted rule stays a variable,
renamed `?__rulefact_0__y`: it is part of the rule being matched, not a
value.

```n3
{ :aaa owl:onProperty :bbb . }
  pe:fact "slide33.n3".
```

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
```

- **C1 resolution**: the rule step is rule 2 under the recorded bindings,
  and the three fact steps, including the quoted rule, are in the program.
- **C2 well-foundedness**, **C3 justification**, **C4 coverage** and **C7
  relevance**: a proper tree, fully covered, with nothing extra.
- **C10 call fidelity**: the printed answer matches what the query asked for.

Nothing is computed, negated or invented, so the other conditions examined
nothing. All 4 steps are verified; the verdict is **checked**.

---

## Try it

```sh
eyeron examples/slide33.n3      # the answer
eyeron -p examples/slide33.n3   # the answer with its proof
eyeron -c examples/slide33.n3   # the proof, checked
```

Add `:xxx :bbb :zzz .` and run again: the rule about `:xxx` now fires too,
and `:zzz a :ccc .` joins the answer. Or change the restriction to
`:aaa owl:allValuesFrom :ddd .`: it no longer matches the rule, and nothing
is printed.

---

## Takeaway

Because N3 rules are statements, rules can inspect rules, which lets a few
lines express what an OWL restriction means.
