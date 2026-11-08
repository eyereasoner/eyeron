# Ancestors

*Two rules, one of them recursive, find every ancestor in a small family.*

[query.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/query.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/query.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/query.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/query.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=query)

---

## The question

Alice is Bob's parent and Bob is Carol's parent; in another branch, Dora is
Emma's parent. A parent is an ancestor, and so is a parent's parent, and so
on up the line, however long it is.

**Who is an ancestor of whom?**

---

## What we tell Eyeron

```n3
:alice :parentOf :bob .
:bob :parentOf :carol .
:dora :parentOf :emma .
```

Three facts. Then two rules:

```n3
{
    ?x :parentOf ?y
} => {
    ?x :ancestorOf ?y
} .

{
    ?x :parentOf ?y .
    ?y :ancestorOf ?z
} => {
    ?x :ancestorOf ?z
} .
```

The first says a parent is an ancestor. The second is *recursive*: it uses
`:ancestorOf` to conclude `:ancestorOf`. A parent of an ancestor is an
ancestor too, so the chain can be as long as the family tree is deep.

The program has no query, so Eyeron prints everything it derived.

---

## What Eyeron concludes

```n3
:alice :ancestorOf :bob .
:bob :ancestorOf :carol .
:dora :ancestorOf :emma .
:alice :ancestorOf :carol .
```

Three direct ancestors, one per parent link, and one indirect: Alice is
Carol's ancestor through Bob. The two branches never mix.

---

## The proof, step by step

```n3
{ :alice :ancestorOf :carol . }
  pe:rule 2;
  pe:binding
    [ pe:var "x"; pe:value :alice ],
    [ pe:var "y"; pe:value :bob ],
    [ pe:var "z"; pe:value :carol ];
  pe:uses
    { :alice :parentOf :bob . },
    { :bob :ancestorOf :carol . }.
…
{ :bob :ancestorOf :carol . }
  pe:rule 1;
```

The indirect answer uses rule 2 with a parent fact and a *derived* statement,
Bob being Carol's ancestor, which has its own step by rule 1. The proof has
7 steps: four rule steps and three facts.

---

## Checked: what the report says

```n3
# checked: 7 steps, 7 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C2"; pe:name "well-foundedness"; pe:checked 7; pe:failed 0 ];
```

- **C1 resolution**: each step is what it cites.
- **C2 well-foundedness**: with a recursive rule this matters most. No
  ancestor statement is justified, even indirectly, by itself; every chain
  bottoms out in parent facts.
- **C3, C4, C7**: every premise has a step, every answer is covered, nothing
  is superfluous.
- **C10 call fidelity**: the answers are the program's derived statements.

All 7 steps verified: **checked**.

---

## Try it

```sh
eyeron examples/query.n3      # the answer
eyeron -p examples/query.n3   # with its proof
eyeron -c examples/query.n3   # the proof, checked
```

Add `:carol :parentOf :dan .` and run again: Dan gets three ancestors,
Carol, Bob and Alice.

---

## Takeaway

A recursive rule handles chains of any length in two lines, and the proof
unwinds each chain back to the facts it came from.
