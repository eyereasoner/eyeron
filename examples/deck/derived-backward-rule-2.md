# Generating unconditional backward rules

*A rule that writes rules: two facts are introduced as backward rules, and ordinary reasoning uses them.*

[derived-backward-rule-2.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/derived-backward-rule-2.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/derived-backward-rule-2.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/derived-backward-rule-2.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/derived-backward-rule-2.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=derived-backward-rule-2)

---

## The question

This is the Socrates example with a twist: the two starting facts, *Socrates
is human* and *every human is mortal*, are not stated directly. Instead a
rule produces two *backward rules* that answer those questions when asked.

**Can facts that exist only as generated rules still feed ordinary
reasoning, and can the result be checked?**

---

## What we tell Eyeron

```n3
true => {
    {
        :Socrates a :Human .
    } <= true .
    {
        :Human rdfs:subClassOf :Mortal
    } <= true .
} .
```

N3 lets a rule's conclusion contain rules. `true => { … }` fires once,
unconditionally. Its conclusion holds two backward rules, `{ … } <= true`:
each says its statement holds whenever someone asks, with no conditions.
After this rule fires, the program has two new rules, not two new facts.

The rest is the familiar subclass rule and a test:

```n3
{
    ?S a ?A .
    ?A rdfs:subClassOf ?B .
} => {
    ?S a ?B .
} .
…
{
    :Socrates a :Mortal .
} => {
    :test :is true .
} .
```

When the subclass rule looks for something that is a human, the generated
backward rule answers.

---

## What Eyeron concludes

```n3
{
    :Socrates a :Human .
} <= true .

{
    :Human rdfs:subClassOf :Mortal .
} <= true .

:Socrates a :Mortal .
:test :is true .
```

The generated rules are conclusions in their own right, so Eyeron prints
them. The two facts they produce on demand are not printed: they were never
stored, only answered.

---

## The proof, step by step

The proof has six steps. A generated rule is justified by the rule that made
it; here rule 1 needs no premises:

```n3
{
  {
      :Socrates a :Human .
  } <= true .
}
  pe:rule 1.
```

When the fact *Socrates is human* is used, its step cites the generated rule
itself, written out in full, rather than a rule number:

```n3
{ :Socrates a :Human . }
  pe:rule
    {
        {
            :Socrates a :Human .
        } <= true .
    }.
```

Rule 2, the subclass rule, then combines the two answers into *Socrates is
mortal*, and rule 3 turns that into the test result.

---

## Checked: what the report says

```n3
# checked: 6 steps, 6 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 9; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
```

- **C1 resolution**: each step matches the rule it cites, generated or
  written by hand.
- **C2 well-foundedness** and **C3 justification**: no step depends on
  itself, and every premise is proved.
- **C4 coverage** and **C7 relevance**: the steps cover all four answers,
  each generated rule a step cites is itself proved, and every step serves an
  answer.
- **C10 call fidelity**: the backward rules were called with the questions
  the steps claim.

Nothing is taken on trust, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/derived-backward-rule-2.n3      # the answer
eyeron -p examples/derived-backward-rule-2.n3   # the answer with its proof
eyeron -c examples/derived-backward-rule-2.n3   # the proof, checked
```

---

## Takeaway

In N3 rules are data a rule can produce, and a proof can cite a generated
rule just as it cites one written by hand.
