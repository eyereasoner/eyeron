# Generating an inverse relation

*Declare that "child of" is the inverse of "parent of", and let a rule write the rule that follows from it.*

[derived-backward-rule.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/derived-backward-rule.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/derived-backward-rule.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/derived-backward-rule.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/derived-backward-rule.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=derived-backward-rule)

---

## The question

We know that Alice is Bob's parent. We also know, as a general statement,
that "child of" is the inverse of "parent of". A question about who is
whose child should be answerable from the parent fact, without anyone
writing a dedicated rule for each pair of inverse properties.

**Can a declaration about properties be turned into a working rule, so that
Bob's parent can be found?**

---

## What we tell Eyeron

```n3
:parentOf :invOf :childOf .

:alice :parentOf :bob .
```

A *meta-rule*, a rule that produces rules, reads every inverse declaration:

```n3
{
    ?p :invOf ?q .
} => {
    {
        ?x ?q ?y .
    } <= {
        ?y ?p ?x .
    } .
} .
```

Here the variables `?p` and `?q` stand for properties, not for people. For
each `?p :invOf ?q` it concludes a backward rule, `{ … } <= { … }`: *x is
q of y if y is p of x*. Backward rules are used on demand, whenever some
other rule asks a question they can answer.

One ordinary forward rule asks such a question:

```n3
{
    ?x :childOf ?y .
} => {
    ?x :hasParent ?y .
} .
```

---

## What Eyeron concludes

```n3
{
    ?x :childOf ?y .
} <= {
    ?y :parentOf ?x .
} .

:bob :hasParent :alice .
```

The generated rule is printed with `:parentOf` and `:childOf` filled in.
The statement *Bob is Alice's child* was used but never stored, so only the
final *Bob has parent Alice* appears.

---

## The proof, step by step

The proof has five steps. The interesting one shows the generated rule at
work:

```n3
{ :bob :childOf :alice . }
  pe:rule
    {
        {
            ?__backward_0_2_17565fa1c50f71ff__x :childOf ?__backward_0_2_17565fa1c50f71ff__y .
        } <= {
            ?__backward_0_2_17565fa1c50f71ff__y :parentOf ?__backward_0_2_17565fa1c50f71ff__x .
        } .
    };
  pe:binding
    [ pe:var "x"; pe:value :bob ],
    [ pe:var "y"; pe:value :alice ];
  pe:uses { :alice :parentOf :bob . }.
```

Instead of a rule number it cites the generated rule itself. Its variables
carry long internal names, so that they cannot clash with variables of other
rules. With x as Bob and y as Alice, it uses the given fact *Alice is
parent of Bob*. Another step shows that the generated rule came from rule 1
applied to the declaration `:parentOf :invOf :childOf`.

---

## Checked: what the report says

```n3
# checked: 5 steps, 5 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ].
```

- **C1 resolution**: each step matches what it cites, including the step
  that cites the generated rule.
- **C2 well-foundedness**, **C3 justification**, **C4 coverage** and
  **C7 relevance**: no circular steps, every premise proved, both answers
  covered, nothing superfluous.
- **C10 call fidelity**: the question the forward rule asked was answered as
  the proof claims.

The verdict is **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/derived-backward-rule.n3      # the answer
eyeron -p examples/derived-backward-rule.n3   # the answer with its proof
eyeron -c examples/derived-backward-rule.n3   # the proof, checked
```

Add `:carol :parentOf :dave .` and run again: Dave's parent is found by
the same generated rule.

---

## Takeaway

A single meta-rule turns any declaration of inverse properties into a
working rule, and the proof records both where the rule came from and how it
was used.
