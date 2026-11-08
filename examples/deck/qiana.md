# Reasoning with a Quoted Belief

*Einstein says not all that glitters is gold, and Eyeron takes him at his word.*

[qiana.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/qiana.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/qiana.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/qiana.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/qiana.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=qiana)

---

## The question

Some statements are about other statements: *Einstein says that not all that
glitters is gold.* Two principles go with it: everyone believes what Einstein
says, and what Einstein says is true. This is the running example of Qiana, a
logic for quantifying over formulas by Simon Coumes, Fabian Suchanek and
colleagues.

**What does Fabian believe, and what follows about the glittering north
star?**

---

## What we tell Eyeron

What Einstein says is a *quoted formula*: braces around a statement talk
about it without asserting it. Here the quoted statement is itself a rule:

```n3
:Einstein :says {
    {
        ?x a :glitter
    } => {
        ?x :notNecessarilyA :gold
    }
} .
```

Everyone believes what Einstein says. This is a *backward* rule, written
with `<=`: Eyeron uses it only when a question asks who believes what.

```n3
{
    ?x :believes ?phi
} <= {
    :Einstein :says ?phi
} .
```

And what Einstein says is true. The conclusion is just the variable `?phi`,
so the quoted formula itself gets asserted:

```n3
{
    :Einstein :says ?phi
} => ?phi .
```

Finally one fact: `:northStar a :glitter .`

---

## What Eyeron concludes

```n3
:Fabian :believes {
    {
        ?x a :glitter .
    } => {
        ?x :notNecessarilyA :gold .
    } .
} .

:northStar :notNecessarilyA :gold .
```

Fabian appears nowhere in the facts: the query asks what he believes, and the
backward rule answers for anyone. The second line needed two moves: the
quoted rule became a real rule, and that rule then applied to the north star.

---

## The proof: a rule that came from a quote

```n3
{ :northStar :notNecessarilyA :gold . }
  pe:rule
    {
        {
            ?x a :glitter .
        } => {
            ?x :notNecessarilyA :gold .
        } .
    };
  pe:binding [ pe:var "x"; pe:value :northStar ];
  pe:uses { :northStar a :glitter . }.
…
  pe:rule 2;
```

The north-star step does not cite a numbered rule of the program: it cites
the rule *itself*, quoted in the proof. A later step shows where that rule
came from: rule 2 ("what Einstein says is true") applied to the fact that
Einstein said it. Fabian's belief is a separate step by rule 1. Five steps
in all.

---

## Checked: what the report says

```n3
# checked: 5 steps, 5 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C3"; pe:name "justification"; pe:checked 5; pe:failed 0 ];
```

- **C1 resolution**: every step is an instance of what it cites, including
  the quoted rule.
- **C3 justification**: a rule that is not in the source program may only be
  used if the proof derives it; here rule 2 does.
- **C2, C4, C7**: nothing is circular, both answers are covered, nothing is
  superfluous.
- **C10 call fidelity**: both queries were answered as asked.

All 5 steps are verified: **checked**.

---

## Try it

```sh
eyeron examples/qiana.n3      # the answer
eyeron -p examples/qiana.n3   # with its proof
eyeron -c examples/qiana.n3   # the proof, checked
```

Add `:pyrite a :glitter .` and run again: pyrite is not necessarily gold
either.

---

## Takeaway

In N3 a formula can be data one moment and a rule the next; the proof
records the moment it changed, so a checker can follow it.
