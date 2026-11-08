# Matching a rule as data

*A rule that looks for rules, and finds itself.*

[rule-matching.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rule-matching.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rule-matching.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rule-matching.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rule-matching.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rule-matching)

---

## The question

In N3 a rule is not hidden machinery: it is a statement like any other, kept
in the same graph as the facts. So a rule can look at other rules.

**If a rule asks "is there any rule here at all?", what does it find?**

---

## What we tell Eyeron

```n3
{
    ?A => ?B .
} => {
    :result :is true .
} .
```

That is the whole program: one rule. Its left side is the pattern
`?A => ?B` — *some premise A implies some conclusion B*. The `=>` arrow is
shorthand for the predicate `log:implies`, so the pattern is an ordinary
triple pattern whose subject and object happen to be variables.

If anything in the graph matches, the rule concludes `:result :is true`.

---

## What Eyeron concludes

```n3
:result :is true .
```

There is exactly one implication in the program: the rule itself. Its
premise is the quoted graph `{ ?A => ?B . }` and its conclusion the quoted
graph `{ :result :is true . }`, so the rule matches itself and fires once.

---

## The proof: the rule as its own evidence

```n3
{ :result :is true . }
  pe:rule 1;
  pe:binding
    [ pe:var "A"; pe:value {
        ?__rulefact_0__A log:implies ?__rulefact_0__B .
    } ],
…
  pe:uses
…
        } => {
            :result :is true .
        } .
```

The conclusion comes from rule 1, with `A` bound to the rule's own premise
and `B` to its own conclusion. The premise it uses is the rule, cited as a
fact of `rule-matching.n3`. The variables inside the quoted rule are renamed
(`?__rulefact_0__A`) so they cannot be confused with the variables of the
rule that is doing the matching.

---

## Checked: what the report says

```n3
# checked: 2 steps, 2 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
```

- **C1 resolution**: the rule step and the fact step are what they claim:
  binding A and B as recorded turns the rule's premise into the cited fact.
- **C2–C4**: no step depends on itself, the fact really is in the source,
  and every premise is covered by a step.
- **C7 relevance**: everything in the proof serves the answer.
- **C10 call fidelity**: the premise `?A => ?B` was checked as it was
  written in the rule.

Nothing is computed, negated or invented, so C5, C6, C8 and C9 have nothing
to examine. Both steps are verified, none trusted: **checked**.

---

## Try it

```sh
eyeron examples/rule-matching.n3
eyeron -p examples/rule-matching.n3
eyeron -c examples/rule-matching.n3
```

---

## Takeaway

In N3 rules are data: a rule can match rules, including itself, and the proof
cites a rule as evidence just as it cites a fact.
