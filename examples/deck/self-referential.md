# Rules that inspect their own vocabulary

*A program that lists the words it uses, including the words of its own rules.*

[self-referential.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/self-referential.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/self-referential.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/self-referential.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/self-referential.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=self-referential)

---

## The question

This program has no facts at all, only three rules. One of them collects
every predicate (the middle word of a statement) it can see. But in N3 the
rules are statements too, and what a rule concludes becomes something to
look at.

**What vocabulary does a program with no facts end up describing?**

---

## What we tell Eyeron

```n3
{
    ?X ?Y ?Z
} => {
    :answer :contains ?Y
} .
```

The first rule matches *any* statement and records its predicate.

```n3
{
    ?X => ?Z
} => {
    :answer :contains log:implies .
} .
```

The second matches any rule. `=>` is shorthand for the predicate
`log:implies`, so when it finds one, the answer contains `log:implies`.

```n3
{
    :answer :contains :contains, log:implies .
} => {
    :test :is true
} .
```

The third is a test: it passes when the answer names both `:contains` and
`log:implies`. The comma shares a subject and predicate between two objects.

---

## What Eyeron concludes

```n3
:answer :contains log:implies .
:answer :contains :contains .
:test :is true .
:answer :contains :is .
```

The program bootstraps itself. The second rule sees the rules and contributes
`log:implies`. That new statement uses `:contains`, which the first rule
picks up. Now the test passes, and `:test :is true` in turn adds `:is`.

---

## The proof: from the rules outwards

The proof starts where the program does, with a rule seen as data:

```n3
{ :answer :contains log:implies . }
  pe:rule 2;
…
  pe:fact "self-referential.n3".
```

Rule 2 fired on rule 1, which is cited as a fact of the source. Then each
conclusion feeds the next:

```n3
{ :answer :contains :contains . }
  pe:rule 1;
  pe:binding
    [ pe:var "X"; pe:value :answer ],
    [ pe:var "Y"; pe:value :contains ],
    [ pe:var "Z"; pe:value log:implies ];
  pe:uses { :answer :contains log:implies . }.

{ :test :is true . }
  pe:rule 3;
  pe:uses
    { :answer :contains :contains . },
    { :answer :contains log:implies . }.
```

Five steps in all: one fact (a rule) and four rule steps, one per answer.

---

## Checked: what the report says

```n3
# checked: 5 steps, 5 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C2"; pe:name "well-foundedness"; pe:checked 5; pe:failed 0 ];
```

- **C1 resolution**: each step is the cited rule with the recorded
  bindings, or a statement of the source.
- **C2 well-foundedness**: although the answers feed each other, no step
  rests on itself; the chain starts from the rules of the program.
- **C3, C4, C7, C10**: the cited rule is in the source, every premise has a
  step, nothing is padding, and each premise was checked as its rule asks it.

No calculation, negation or invented individual is involved. 5 of 5 steps
verified: **checked**.

---

## Try it

```sh
eyeron examples/self-referential.n3
eyeron -p examples/self-referential.n3
eyeron -c examples/self-referential.n3
```

---

## Takeaway

Because N3 rules are statements, a rule that looks at "all statements" also
sees the rules, and the proof records exactly how that bootstrapping happened.
