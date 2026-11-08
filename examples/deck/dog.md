# When dog ownership requires a license

*Counting by adding ones: a one-rule version of the dog-license check.*

[dog.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/dog.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/dog.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/dog.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/dog.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=dog)

---

## The question

A license is required for anyone who owns more than four dogs. Alice owns
five dogs and Bob owns two.

**Who needs a license, decided in a single rule?**

---

## What we tell Eyeron

```n3
:alice :hasDog :dog1, :dog2, :dog3, :dog4, :dog5 .
:bob :hasDog :dog6, :dog7 .
```

```n3
{
    ?Subject :hasDog ?Any .
    (
        1 {
            ?Subject :hasDog ?Dog
        }
        ?List
    ) log:collectAllIn ?Scope .
    ?List math:sum ?Count .
    ?Count math:greaterThan 4 .
} => {
    ?Subject :mustHave :dogLicense .
} .
```

`log:collectAllIn` takes three things: what to collect, a pattern, and the
resulting list. Here what it collects is the number `1`, once for every dog
`?Dog` the person has. So Alice gets the list `(1 1 1 1 1)`. `math:sum` adds
the list up, and `math:greaterThan` compares the total with 4. The unbound
`?Scope` means "search what Eyeron currently knows".

---

## What Eyeron concludes

```n3
:alice :mustHave :dogLicense .
```

Only Alice: Bob's list is `(1 1)`, whose sum, 2, is not more than 4. The
count itself is not kept as a statement, unlike in the dog-license example.

---

## The proof, step by step

The proof has five steps; the main one is the rule step:

```n3
{ :alice :mustHave :dogLicense . }
  pe:rule 1;
  pe:binding
    [ pe:var "Any"; pe:value :dog1 ],
    [ pe:var "Count"; pe:value 5 ],
    [ pe:var "List"; pe:value (1 1 1 1 1) ],
    [ pe:var "Subject"; pe:value :alice ];
  pe:uses
    { :alice :hasDog :dog1 . },
    {
        (1 {
            :alice :hasDog ?Dog .
        } (1 1 1 1 1)) log:collectAllIn ?Scope .
    },
    { (1 1 1 1 1) math:sum 5 . },
    { 5 math:greaterThan 4 . }.
```

One fact and three built-in steps support it. Bob's failed attempt leaves no
trace: a proof records what holds, not what was tried.

---

## Checked: what the report says

```n3
# checked: 5 steps, 5 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
```

- **C1–C4** and **C7**: the rule step matches rule 1, the steps are
  well-founded and each one serves the answer.
- **C5 re-decision**: the sum, the comparison and the collection were
  recomputed.
- **C9 search closure**: the collection reads only `:hasDog` facts, which
  the program gives directly, so the checker can redo it over those facts and
  confirm the list `(1 1 1 1 1)` exactly.
- **C6 boundary consistency** and **C10 call fidelity**: nothing in the proof
  contradicts the collected list, and `?Dog` was left open as the rule asks.

Nothing is taken on trust: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/dog.n3      # the answer
eyeron -p examples/dog.n3   # the answer with its proof
eyeron -c examples/dog.n3   # the proof, checked
```

Change `4` to `1` in the rule and run again: now Bob, with two dogs, needs a
license as well.

---

## Takeaway

Collecting a 1 per item and adding them up is a way to count; when the items
are given facts, the checker confirms the count instead of trusting it.
