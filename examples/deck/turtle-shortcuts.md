# Turtle Shortcuts

*Commas and semicolons: saying several things about one subject without repeating it.*

[turtle-shortcuts.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/turtle-shortcuts.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/turtle-shortcuts.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/turtle-shortcuts.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/turtle-shortcuts.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=turtle-shortcuts)

---

## The question

Alice knows Bob and Carol, and has a score of 8. Bob has a score of 3. A
person with a score of at least 5 vouches for everyone they know.

**Who is vouched for, and with what score?** Along the way, the example shows
two pieces of shorthand that make N3 data much shorter to write.

---

## What we tell Eyeron

```n3
:alice :knows :bob, :carol ;
    :score 8 .

:bob :score 3 .
```

Every N3 statement is a triple: subject, predicate, object. Writing each one
out in full would repeat `:alice` three times. Instead:

- a **comma** keeps the subject and the predicate and gives another object:
  `:alice :knows :bob, :carol` is two statements, Alice knows Bob and Alice
  knows Carol;
- a **semicolon** keeps the subject and starts a new predicate:
  `; :score 8` adds Alice's score.

So the first two lines are three statements about Alice.

```n3
{
    ?person :knows ?friend .
    ?person :score ?score .
    ?score math:notLessThan 5
} => {
    ?friend :knownBy ?person ;
        :scoredFor ?score
} .
```

The rule reads: *if a person knows a friend, and the person's score is not
less than 5, then the friend is known by the person and scored for that
score.* `math:notLessThan` is a built-in: Eyeron computes it instead of
looking it up. The same semicolon shortcut works inside the rule's
conclusion.

---

## What Eyeron concludes

```n3
:bob :knownBy :alice .
:bob :scoredFor 8 .
:carol :knownBy :alice .
:carol :scoredFor 8 .
```

Alice's score of 8 passes the test, so both of her friends are vouched for.
Bob's score of 3 plays no part: Bob knows nobody, so the rule never looks at
it.

---

## The proof, step by step

`eyeron -p` lists the four answers and then one step per statement they rest
on. Here is Bob's first answer:

```n3
{ :bob :knownBy :alice . }
  pe:rule 1;
  pe:binding
    [ pe:var "friend"; pe:value :bob ],
    [ pe:var "person"; pe:value :alice ],
    [ pe:var "score"; pe:value 8 ];
  pe:uses
    { :alice :knows :bob . },
    { :alice :score 8 . },
    { 8 math:notLessThan 5 . }.
…
{ :alice :knows :bob . }
  pe:fact "turtle-shortcuts.n3".
…
{ 8 math:notLessThan 5 . }
  pe:builtin math:notLessThan.
```

The rule used three statements. Two are facts from the file — note that the
proof spells out `:alice :knows :bob` in full, because the comma was only a
way of writing it. The third, *8 is not less than 5*, is marked `pe:builtin`:
it was computed, not given.

---

## Checked: what the report says

```n3
# checked: 8 steps, 8 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 7; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
```

- **C1 resolution**: each rule step and fact step matches the rule or fact it
  cites, with the bindings shown.
- **C2–C4**: no step depends on itself, every statement a step uses has its
  own step, and every premise of the rule is covered.
- **C5 re-decision**: the checker recomputed `8 math:notLessThan 5` itself
  rather than trusting the proof.
- **C7 relevance**: every step serves an answer.
- **C10 call fidelity**: the rule's conditions were checked as written.

There is no negation and no invented individual, so C6, C8 and C9 examined
nothing. All 8 steps were verified, none trusted: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/turtle-shortcuts.n3
eyeron -p examples/turtle-shortcuts.n3
eyeron -c examples/turtle-shortcuts.n3
```

Change Alice's score from `8` to `4` and run again: the rule no longer fires
and Eyeron derives nothing.

---

## Takeaway

Commas and semicolons are only shorthand: Eyeron reads them as the full
statements they stand for, and the proof shows those statements one by one.
