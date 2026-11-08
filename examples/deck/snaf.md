# Scoped Negation as Failure

*Concluding something from what the graph does not say.*

[snaf.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/snaf.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/snaf.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/snaf.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/snaf.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=snaf)

---

## The question

Alice loves Bob, and Bob is a person. Nothing anywhere says that Alice hates
anyone. Logic on the Web usually cannot conclude anything from silence: a
missing statement may simply not have been written yet. N3 allows it in a
careful form, *scoped negation as failure* (SNAF): "this statement is absent
from this particular graph".

**Is there a person Alice is not said to hate, and what does the rule
conclude from that?**

---

## What we tell Eyeron

```n3
:Alice :loves :Bob .
:Bob a :Person .

{
    ?SCOPE log:notIncludes {
        :Alice :hates ?X
    } .
    ?X a :Person .
} => {
    :Alice :hates :Nobody .
} .
```

`log:notIncludes` succeeds when the graph does not contain the quoted
statement. The scope `?SCOPE` is left open, so the test is about the
reasoner's current graph: everything given and derived. Eyeron runs the test
once `?X` is known, so the rule reads: *if X is a person and the graph does
not say that Alice hates X, conclude* `:Alice :hates :Nobody`.

---

## What Eyeron concludes

```n3
:Alice :hates :Nobody .
```

Bob is a person and nothing says Alice hates him. (The conclusion is itself
a `:hates` statement, but about `:Nobody`, not about Bob, so it does not
undo the test that produced it.)

---

## The proof, step by step

```n3
{ :Alice :hates :Nobody . }
  pe:rule 1;
  pe:binding
    [ pe:var "SCOPE"; pe:value {
        :a :b :c .
    } ],
    [ pe:var "X"; pe:value :Bob ];
…
{
  {
      :a :b :c .
  } log:notIncludes {
      :Alice :hates :Bob .
  } .
}
  pe:builtin log:notIncludes.
…
:hates pe:derived
    { :Alice :hates :Nobody . }.
```

The open scope is written down as a fixed stand-in graph, `{ :a :b :c . }`,
that marks "the current graph". The last statement is a *search
certificate*: it lists every `:hates` statement the run derived, which is
just the conclusion itself. With it, the checker can see the whole current
graph for that predicate.

---

## Checked: what the report says

```n3
# checked: 3 steps, 3 verified, 0 trusted
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
```

- **C1 resolution**: the rule step is rule 1 under its bindings, and Bob being
  a person is a fact of the program.
- **C5 re-decision** re-decides the `log:notIncludes` step.
- **C6 boundary consistency**: nothing the proof records says Alice hates
  Bob.
- **C9 search closure**: the certificate is checked: its listed `:hates`
  statement is supported by a step, no rule could add another, and over the
  given facts plus that list, Alice indeed does not hate Bob. So the absence
  is settled, not assumed.
- **C2**, **C3**, **C4**, **C7** and **C10**: the steps form a proper,
  covered, relevant tree, and the conclusion is what was derived.

Nothing is taken on trust: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/snaf.n3      # the answer
eyeron -p examples/snaf.n3   # the answer with its proof
eyeron -c examples/snaf.n3   # the proof, checked
```

Add `:Alice :hates :Bob .` and run again: the only person is now hated, and
nothing is concluded. Add `:Alice :hates :Carol .` instead: Carol is not
said to be a person, so Bob still makes the rule fire.

---

## Takeaway

Negation over the current graph is useful but fragile; here the proof
carries a certificate of everything relevant the run derived, so even the
absence is checked rather than believed.
