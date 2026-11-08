# Transferring a claim between equal names

*Lois knows Superman can fly. Does she know Clark Kent can?*

[graph-term-opacity.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/graph-term-opacity.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/graph-term-opacity.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/graph-term-opacity.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/graph-term-opacity.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=graph-term-opacity)

---

## The question

Superman and Clark Kent are the same person. Lois Lane knows that Superman
can fly. Should a reasoner conclude that she knows Clark Kent can fly?

Philosophers call this *referential opacity*: what someone knows is about the
words they know it under, not just about the things the words name. In N3, a
statement inside braces is a *quoted graph*, a piece of text-like data that is
left alone. An equality fact does not reach inside it on its own.

**Does Eyeron keep the quote as it is, and can a rule transfer it when we
want it to?**

---

## What we tell Eyeron

```n3
:superman owl:sameAs :clarkKent .
:loisLane :knows {
    :superman :can :fly
} .
```

`owl:sameAs` is the Web Ontology Language word for "is the same thing as".
The braces make `{ :superman :can :fly }` a single value: Lois knows *that
statement*, which is not asserted as a fact by itself.

Then one rule, which says so explicitly:

```n3
{
    ?x owl:sameAs ?y .
    ?s ?p {
        ?x ?q ?r
    }
} => {
    ?s ?p {
        ?y ?q ?r
    }
} .
```

*If x is the same as y, and someone stands in some relation to a quoted
statement about x, then they stand in that relation to the same statement
about y.* The pattern `{ ?x ?q ?r }` matches a quoted graph holding exactly
one statement.

---

## What Eyeron concludes

```n3
:loisLane :knows {
    :clarkKent :can :fly .
} .
```

This comes from the rule, not from the equality. Delete the rule and run
again: Eyeron derives nothing at all, because `owl:sameAs` is just another
statement to it and quoted graphs are never rewritten behind your back.

---

## The proof, step by step

```n3
{
  :loisLane :knows {
      :clarkKent :can :fly .
  } .
}
  pe:rule 1;
  pe:binding
    [ pe:var "p"; pe:value :knows ],
    [ pe:var "q"; pe:value :can ],
    [ pe:var "r"; pe:value :fly ],
    [ pe:var "s"; pe:value :loisLane ],
    [ pe:var "x"; pe:value :superman ],
    [ pe:var "y"; pe:value :clarkKent ];
```

One rule step, with six variables bound. Two of them, `q` and `r`, were
bound by matching *inside* the quoted graph. The step uses the two facts of
the program, each recorded with `pe:fact "graph-term-opacity.n3"`.

---

## Checked: what the report says

```n3
# checked: 3 steps, 3 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 4; pe:failed 0 ];
```

- **C1 resolution**: putting the six bindings into rule 1 gives exactly the
  claimed statement, quoted graph and all.
- **C2 well-foundedness**, **C3 justification** and **C4 coverage**: the two
  facts really are in the program and every premise has a step.
- **C7 relevance**: every step serves the answer.

No calculation, negation or invented individual is involved, so the other
conditions examined nothing. The verdict is **checked**.

---

## Try it

```sh
eyeron examples/graph-term-opacity.n3
eyeron -c examples/graph-term-opacity.n3
```

Change Lois's knowledge to `{ :superman :can :fly . :superman :wears :cape }`
and run again: nothing is derived, since a one-statement pattern does not
match a two-statement graph.

---

## Takeaway

In N3, quoted statements stay as written. If you want equal names to carry
claims across, you say so in a rule, and the proof shows exactly where you did.
