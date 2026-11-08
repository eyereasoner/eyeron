# Ancestors

*Three parent links, one recursive rule, six ancestors.*

[ancestor.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/ancestor.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/ancestor.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/ancestor.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/ancestor.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=ancestor)

---

## The question

A family tree records only who is whose parent: Alice is Bob's parent, Bob is
Carol's, and Carol is Dana's. Grandparents and great-grandparents are not
written down anywhere, yet they follow.

**Who is an ancestor of whom?**

---

## What we tell Eyeron

```n3
:alice :parent :bob .
:bob :parent :carol .
:carol :parent :dana .
```

Three statements, each a subject, a predicate and an object, ending in ` .`.

```n3
{
    ?x :parent ?y
} => {
    ?x :ancestor ?y
} .

{
    ?x :parent ?y .
    ?y :ancestor ?z
} => {
    ?x :ancestor ?z
} .
```

`{ … } => { … }` is a rule: when the left side holds, Eyeron concludes the
right side. Names starting with `?` are variables. The first rule says *a
parent is an ancestor*. The second says *a parent of an ancestor is an
ancestor too*.

---

## How the rules work

The second rule is recursive: it needs `:ancestor` facts, and it makes them.
Eyeron reasons forward in rounds, so each round can build on the last:

1. The first rule turns each parent link into an ancestor link.
2. The second rule adds grandparents: Alice of Carol, Bob of Dana.
3. Run again, it adds the great-grandparent: Alice of Dana.
4. Nothing new appears, so Eyeron stops.

The chain could be a thousand links long; the same two rules would follow it
to the end.

---

## What Eyeron concludes

```n3
:alice :ancestor :bob .
:bob :ancestor :carol .
:carol :ancestor :dana .
:alice :ancestor :carol .
:bob :ancestor :dana .
:alice :ancestor :dana .
```

Six ancestor links: the three direct ones and three that skip a generation or
two. The parent facts we gave are not repeated.

---

## The proof, step by step

`eyeron -p` gives one step for every statement the answers rest on. The
deepest answer, Alice as Dana's ancestor, is proved like this:

```n3
{ :alice :ancestor :dana . }
  pe:rule 2;
  pe:binding
    [ pe:var "x"; pe:value :alice ],
    [ pe:var "y"; pe:value :bob ],
    [ pe:var "z"; pe:value :dana ];
  pe:uses
    { :alice :parent :bob . },
    { :bob :ancestor :dana . }.
```

*Alice is Dana's ancestor by rule 2, because Alice is Bob's parent and Bob is
Dana's ancestor.* That second statement has its own step, again by rule 2,
resting on Bob being Carol's parent and Carol being Dana's ancestor, which in
turn rests on rule 1 and a given fact:

```n3
{ :carol :ancestor :dana . }
  pe:rule 1;
  pe:binding
    [ pe:var "x"; pe:value :carol ],
    [ pe:var "y"; pe:value :dana ];
  pe:uses { :carol :parent :dana . }.

{ :carol :parent :dana . }
  pe:fact "ancestor.n3".
```

The whole proof has 9 steps: 3 given facts and 6 rule applications, one per
answer. Steps are shared, so `:bob :ancestor :dana` is proved once and used
for Alice.

---

## Checked: what the report says

`eyeron -c` builds the proof and checks it step by step against the program:

```n3
# checked: 9 steps, 9 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 9; pe:failed 0 ];
pe:condition [ pe:id "C2"; pe:name "well-foundedness"; pe:checked 9; pe:failed 0 ];
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 15; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 15; pe:failed 0 ];
```

- **C1 resolution**: putting each step's bindings into the rule it names
  gives exactly that step.
- **C2 well-foundedness**: no step depends on itself. This matters for a
  recursive rule: the proof may not argue in a circle.
- **C3 justification**: each step has one well-formed reason, a fact or a
  rule with bindings.
- **C4 coverage**: every premise and every claim is either proved by a step
  or given in the source.
- **C7 relevance**: every step serves one of the six answers.
- **C10 call fidelity** counts 6 items and finds nothing amiss: with no
  negation and no query here, there are no tests or query answers to misuse.

There is nothing to recompute, no negation and no invented individual, so the
other conditions examined nothing. All 9 steps were verified, none taken on
trust: the verdict is **checked**. It confirms these answers; it does not
claim there are no others.

---

## Try it

```sh
eyeron examples/ancestor.n3      # the answer
eyeron -p examples/ancestor.n3   # with its proof
eyeron -c examples/ancestor.n3   # the proof, checked
```

Add `:dana :parent :erin .` and run again: four new ancestor links appear,
from each of Alice, Bob, Carol and Dana to Erin.

---

## Takeaway

A recursive rule turns a handful of direct links into everything they imply,
and the proof shows exactly which links each conclusion rests on.
