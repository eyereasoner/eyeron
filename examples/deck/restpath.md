# Composing a path of described web requests

*Nine web calls in a row, each one opening the way to the next.*

[restpath.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/restpath.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/restpath.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/restpath.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/restpath.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=restpath)

---

## The question

A web API is often explored step by step: you fetch one resource, its
response tells you where to go next, and so on. If each kind of call is
described as a rule — *given a link of this kind, a GET request gives a link
of the next kind* — then planning a route through the API becomes reasoning.

Here there are nine such calls, and we start with one link from `x` to `y`.

**Can we get from `x` to `y` by the goal link, `ex:relGoal`?**

---

## What we tell Eyeron

The starting point is one link:

```n3
<x> ex:rel1 <y> .
```

`<x>` is a *relative* IRI; it is resolved against the `@base` declared above
it, so it stands for `https://eyereasoner.github.io/eye/reasoning/restpath/x`.

The first call:

```n3
{
    ?a1 ex:rel1 ?b1 .
} => {
    ?request http:methodName "GET" .
    ?request http:requestURI ?a1 .
    ?request http:resp ?resp .
    ?resp http:body ?b1 .
    ?a1 ex:rel2 ?b1 .
    ?a2 ex:rel2 ?b2 .
    ?a3 ex:rel2 ?b3 .
} .
```

It reads: given a `rel1` link from `a1` to `b1`, a GET request on `a1` has a
response whose body is `b1`, and `a1` has a `rel2` link to `b1`. The
following rules repeat the pattern from `rel2` to `rel3`, and so on; the last
one also gives the goal link:

```n3
    ?a1 ex:rel10 ?b1 .
    ?a2 ex:rel10 ?b2 .
    ?a3 ex:rel10 ?b3 .
    ?a1 ex:relGoal ?b1 .
```

And the query asks for just the answer we care about:

```n3
<https://eyereasoner.github.io/eye/reasoning/restpath/x> ex:relGoal <https://eyereasoner.github.io/eye/reasoning/restpath/y> .
```

---

## What the request descriptions do — and do not do

Look at `?request`, `?resp`, `?a2` or `?b3`: no premise of the rule gives
them a value. A `?` variable in N3 is universal, so a conclusion such as
`?request http:methodName "GET"` would say something about *everything*.
Eyeron derives only the conclusion triples whose variables the premises
bind; the others are not added. (To say *"there is some request"*, a rule
would use a blank node such as `_:request`; see Section 4 of the
specification.)

So in this program the request descriptions document the calls, but what
Eyeron derives and proves is the chain of links `rel2`, `rel3`, …, `rel10`
and finally `relGoal`.

---

## What Eyeron concludes

```n3
<https://eyereasoner.github.io/eye/reasoning/restpath/x> ex:relGoal <https://eyereasoner.github.io/eye/reasoning/restpath/y> .
```

Yes: after nine calls, `x` reaches `y` by the goal link. Because of the
`log:query`, this is the only line printed.

---

## The proof: nine calls, one fact

The proof goes back down the chain, one call per step:

```n3
{ <https://eyereasoner.github.io/eye/reasoning/restpath/x> ex:relGoal <https://eyereasoner.github.io/eye/reasoning/restpath/y> . }
  pe:rule 9;
  pe:binding
    [ pe:var "a1"; pe:value <https://eyereasoner.github.io/eye/reasoning/restpath/x> ],
    [ pe:var "a2"; pe:value <https://eyereasoner.github.io/eye/reasoning/restpath/x> ],
…
  pe:uses
    { <https://eyereasoner.github.io/eye/reasoning/restpath/x> ex:rel9 <https://eyereasoner.github.io/eye/reasoning/restpath/y> . },
…
```

Rule 9 needs three `rel9` links; the only one there is, from `x` to `y`, fills
all three places, so `a1`, `a2` and `a3` are all `x`. The same happens at
every level down to rule 1, which uses the starting fact:

```n3
{ <https://eyereasoner.github.io/eye/reasoning/restpath/x> ex:rel1 <https://eyereasoner.github.io/eye/reasoning/restpath/y> . }
  pe:fact "restpath.n3".
```

Ten steps: nine rule steps and one fact.

---

## Checked: what the report says

```n3
# checked: 10 steps, 10 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 10; pe:failed 0 ];
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 27; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 35; pe:failed 0 ].
```

- **C1 resolution**: every step is its rule with the recorded bindings, or
  the starting fact.
- **C2 well-foundedness** and **C3 justification**: the chain is not
  circular, and the starting link is in `restpath.n3`.
- **C4 coverage**: every premise of every call — three per call, even when
  they name the same link — is backed by a step.
- **C7 relevance** and **C10 call fidelity**: nothing is padding, and the
  premises and the query were checked as they are written.

There is nothing to compute, negate or invent. 10 of 10 verified:
**checked**.

---

## Try it

```sh
eyeron examples/restpath.n3
eyeron -p examples/restpath.n3
eyeron -c examples/restpath.n3
```

Change the starting fact to `<x> ex:rel1 <z> .` and run again: the chain now
leads from `x` to `z`, the query about `y` matches nothing, and nothing is
printed.

---

## Takeaway

Describing each call as a rule turns "can I get there through this API?"
into a question with a checked, step-by-step answer.
