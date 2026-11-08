# A rule that produces another rule

*A fact about a cat switches on a rule about dogs.*

[derived-rule.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/derived-rule.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/derived-rule.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/derived-rule.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/derived-rule.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=derived-rule)

---

## The question

Minka is a cat and Charly is a dog. The program does not have a rule about
dogs at the start: it has a rule that, once there is a cat, *creates* one.

**Does the created rule fire, and can the proof show where it came from?**

---

## What we tell Eyeron

```n3
:Minka a :Cat .
:Charly a :Dog .

{
    ?x a :Cat .
} => {
    {
        ?y a :Dog .
    } => {
        :test :is true .
    } .
} .
```

A rule is `{ conditions } => { conclusions }`. In N3 a conclusion may itself
be a rule. So this rule reads: *if anything is a cat, then add the rule "if
anything is a dog, the test passes"*.

---

## What Eyeron concludes

```n3
{
    ?y a :Dog .
} => {
    :test :is true .
} .

:test :is true .
```

First the new rule, then what it concluded about Charly.

---

## The proof, step by step

The proof has four steps:

```n3
{ :test :is true . }
  pe:rule
    {
        {
            ?y a :Dog .
        } => {
            :test :is true .
        } .
    };
  pe:binding [ pe:var "y"; pe:value :Charly ];
  pe:uses { :Charly a :Dog . }.
```

The test result cites the generated rule, written out in full, with `y`
standing for Charly. Another step proves the generated rule itself: rule 1
with `x` standing for Minka, using the fact that Minka is a cat.

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
pe:condition [ pe:id "C2"; pe:name "well-foundedness"; pe:checked 4; pe:failed 0 ];
```

- **C1 resolution**: each step is what it cites, including the step that
  cites the generated rule.
- **C2 well-foundedness** and **C3 justification**: no step depends on
  itself, and every premise is proved.
- **C4 coverage** and **C7 relevance**: both answers are covered, the
  generated rule a step cites is itself a proved conclusion, and every step
  serves an answer.
- **C10 call fidelity**: the conditions were matched as the proof says.

The verdict is **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/derived-rule.n3      # the answer
eyeron -p examples/derived-rule.n3   # the answer with its proof
eyeron -c examples/derived-rule.n3   # the proof, checked
```

Remove `:Minka a :Cat .` and run again: there is no cat, so the dog rule is
never created and nothing is concluded.

---

## Takeaway

Rules can be conclusions, and a proof can trace a result back through the
rule that produced the rule that produced it.
