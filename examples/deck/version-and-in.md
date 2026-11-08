# Priority Levels

*Gold or platinum gets priority; everyone else is ordinary.*

[version-and-in.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/version-and-in.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/version-and-in.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/version-and-in.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/version-and-in.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=version-and-in)

---

## The question

A loyalty programme has three customers: Alice holds a gold level, Bob
bronze, Carol platinum. Gold and platinum customers get priority. Anyone
else is an ordinary customer.

**Who gets priority, and who is ordinary?**

---

## What we tell Eyeron

```n3
:alice :level "gold" .
:bob :level "bronze" .
:carol :level "platinum" .
```

The levels, as plain text strings.

```n3
{
    ?x :level "gold"
} => {
    ?x :priority true
} .

{
    ?x :level "platinum"
} => {
    ?x :priority true
} .
```

Two rules with the same conclusion: either level is enough. Writing a rule
per alternative is how N3 says *or* in a condition.

```n3
{
    ?x :level ?level .
    ?SCOPE log:notIncludes {
        ?x :priority true
    }
} => {
    ?x :ordinary true
} .
```

"Everyone else" is an absence: a customer with some level for whom
`?x :priority true` is *not* in the current graph. `log:notIncludes` with a
variable scope tests exactly that. Eyeron first finishes deriving priority,
then tests for its absence.

---

## What Eyeron concludes

```n3
:alice :priority true .
:carol :priority true .
:bob :ordinary true .
```

Alice and Carol have priority; Bob is ordinary. Alice and Carol are not
called ordinary, because their priority was already known when the absence
was tested.

---

## The proof, step by step

```n3
{ :bob :ordinary true . }
  pe:rule 3;
…
  pe:uses
    { :bob :level "bronze" . },
…
        } log:notIncludes {
            :bob :priority true .
        } .
…
:priority pe:derived
    { :alice :priority true . },
    { :carol :priority true . }.
```

Bob's step rests on his level and on the absence of
`:bob :priority true`. The last statement is the **search certificate**: a
list of every `:priority` statement the program derived. It is what makes
the absence checkable: Bob is not on the list.

---

## Checked: what the report says

```n3
# checked: 7 steps, 7 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
```

- **C1, C3**: the three rule steps match their rules; the levels are facts
  of the file.
- **C9 search closure**: the checker confirmed that the certificate is
  complete — the only rules that conclude `:priority` are the gold and
  platinum rules, and their only results are Alice and Carol.
- **C5 re-decision** and **C6 boundary consistency**: with that list, the
  absence test for Bob was decided again and holds, and nothing in the proof
  contradicts it.

All 7 steps were verified and none was taken on trust: the verdict is
**checked**, absence included.

---

## Try it

```sh
eyeron examples/version-and-in.n3
eyeron -c examples/version-and-in.n3
```

Add `:dave :level "silver" .`: Dave has a level but not a priority one, so
he is ordinary too.

---

## Takeaway

Alternatives are separate rules, and "everyone else" is a scoped absence;
a search certificate lets the checker verify that absence instead of
trusting it.
