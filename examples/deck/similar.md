# Similar

*Two things are similar when something true of one is true of the other.*

[similar.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/similar.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/similar.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/similar.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/similar.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=similar)

---

## The question

Alice is a human, and so is Bob. Call two things *similar* when they share a
property: the same relation to the same thing.

**Are Alice and Bob similar?**

---

## What we tell Eyeron

```n3
:Alice a :Human .
:Bob a :Human .
```

A forward rule states the test: if Alice is similar to Bob, the test passed.

```n3
{
    :Alice :similar :Bob .
} => {
    :test :is true .
} .
```

Nothing says directly that anyone is similar. That is defined by a
*backward* rule, written with `<=`: to show the head, show the body.

```n3
{
    ?A :similar ?B .
} <= {
    ?A ?Pred ?Obj .
    ?B ?Pred ?Obj .
} .
```

The predicate here is a variable, `?Pred`, so the rule does not care which
property is shared: being a human, living in the same city, anything.

---

## What Eyeron concludes

```n3
:test :is true .
```

`:Alice :similar :Bob` itself is not printed. A backward rule is only used
when something asks for it, here the forward rule's premise; its answer
serves that question and is not added to the output.

---

## The proof, step by step

```n3
{ :test :is true . }
  pe:rule 1;
  pe:uses { :Alice :similar :Bob . }.

{ :Alice :similar :Bob . }
  pe:rule 2;
  pe:binding
    [ pe:var "A"; pe:value :Alice ],
    [ pe:var "B"; pe:value :Bob ],
    [ pe:var "Obj"; pe:value :Human ],
    [ pe:var "Pred"; pe:value rdf:type ];
```

1. *The test passed*, by rule 1, because Alice is similar to Bob.
2. *Alice is similar to Bob*, by rule 2, the backward rule, with `Pred`
   standing for `rdf:type` (what `a` abbreviates) and `Obj` for `:Human`.
3. and 4. The two facts given in `similar.n3`.

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

- **C1 resolution**: each step is an instance of the rule or fact it cites.
- **C2 well-foundedness**, **C3 justification** and **C4 coverage**: the
  steps form a proper tree, each in the right form, and every premise they
  use has a step of its own.
- **C7 relevance**: every step serves the answer.
- **C10 call fidelity**: the backward rule was checked as it was called, with
  Alice and Bob, not with some other pair.

Nothing is computed, negated or invented, so the other conditions examined
nothing. All 4 steps are verified: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/similar.n3      # the answer
eyeron -p examples/similar.n3   # the answer with its proof
eyeron -c examples/similar.n3   # the proof, checked
```

Change `:Bob a :Human .` into `:Bob a :Robot .`: Alice and Bob no longer share
anything, and Eyeron concludes nothing. Then add `:Alice :livesIn :Ghent .`
and `:Bob :livesIn :Ghent .`: they are similar again, through a different
property.

---

## Takeaway

A backward rule with a variable predicate defines "similar" once for every
kind of property, and the proof says exactly which shared property was used.
