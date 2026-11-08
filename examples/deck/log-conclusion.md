# Reasoning inside a quoted graph

*A small knowledge base, reasoned about from the outside.*

[log-conclusion.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/log-conclusion.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/log-conclusion.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/log-conclusion.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/log-conclusion.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=log-conclusion)

---

## The question

Sometimes you want to know what a set of statements *would* imply, without
adopting them yourself: what a document claims, what a hypothesis entails.

**Given a little knowledge base about a cat, can Eyeron compute everything
that follows from it, and hand back the result as one piece of data?**

---

## What we tell Eyeron

```n3
:let :param {
    :Felix a :Cat .
    {
        ?X a :Cat .
    } => {
        ?X :says "Meow" .
    } .
} .
```

Braces make a *quoted graph*: statements held as a value, not asserted. So
Eyeron does not believe that Felix is a cat; it only knows that `:let :param`
is this graph of a fact and a rule.

```n3
{
    :let :param ?param .
    ?param log:conclusion ?conclusion .
} => {
    :result :is ?conclusion .
} .
```

`log:conclusion` is a built-in that reasons inside a graph, on its own, and
gives back the graph together with everything that follows from it.

---

## What Eyeron concludes

```n3
:result :is {
    :Felix a :Cat .
    {
        ?X a :Cat .
    } => {
        ?X :says "Meow" .
    } .
    :Felix :says "Meow" .
} .
```

Inside the result, the rule has fired: Felix says "Meow". Outside it, nothing
changed: `:Felix :says "Meow"` is not a conclusion of the program, only part
of the quoted result.

---

## The proof: a fact and a built-in

```n3
{
  :let :param {
      :Felix a :Cat .
      …
  } .
}
  pe:fact "log-conclusion.n3".
```

The answer is one rule step using two things: the fact that holds the
quoted graph, and a `log:conclusion` step (`pe:builtin log:conclusion`)
relating that graph to its closure. The proof does not spell out the
reasoning inside the graph.

---

## Checked: what the report says

```n3
# checked with obligations: 3 steps, 2 verified, 1 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:kind "impure built-in";
```

The fact and the rule step are verified (**C1**, with C2, C3, C4, C7 and
C10). The `log:conclusion` step is examined (**C5**) but its result is not
recomputed by the checker: it is listed as an obligation of kind `impure
built-in` and taken on trust. The verdict is therefore **checked with
obligations**: everything around the closure is verified, and the closure
itself is where the trust lies.

---

## Try it

```sh
eyeron examples/log-conclusion.n3      # the answer
eyeron -p examples/log-conclusion.n3   # with the proof
eyeron -c examples/log-conclusion.n3   # the proof, checked
```

Add `:Tom a :Cat .` inside the quoted graph, under Felix: the result now also
contains `:Tom a :Cat` and `:Tom :says "Meow"`.

---

## Takeaway

Quoted graphs let a program reason *about* a set of statements without
believing them; `log:conclusion` computes what they imply and returns it as
data.
