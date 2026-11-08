# Type Inference

*Working out the type of a tiny program, the way a compiler would.*

[type-inference.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/type-inference.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/type-inference.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/type-inference.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/type-inference.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=type-inference)

---

## The question

Programming languages check that values are used sensibly: you can add two
numbers, but not a number and a function. A compiler does this by assigning
each piece of a program a **type**.

Take the smallest interesting program: the identity function (it returns
whatever it is given), applied to the number 42. In lambda-calculus notation,
`(λx. x) 42`.

**What type does that expression have?**

---

## What we tell Eyeron

Expressions are written as lists: `(:intLit 42)` is the number 42,
`(:var :x)` the variable x, `(:lam :x body)` a function of x, and
`(:app fn arg)` applies a function to an argument. An environment is a list
of `(name type)` pairs saying what each variable stands for.

The typing rules are **backward rules**, written `{ goal } <= { conditions }`:
to establish the goal, Eyeron sets out to prove the conditions.

```n3
{
    (?env (:intLit ?n)) :typeOf :int
} <= true .
```

A number has type `:int`, always.

```n3
{
    (?env (:lam ?name ?body)) :typeOf (:fun ?arg ?result)
} <= {
    ?newEnv list:firstRest ((?name ?arg) ?env) .
    (?newEnv ?body) :typeOf ?result .
} .
```

A function has type `(:fun arg result)` when its body has type `result`,
once the environment is extended with the parameter's type `arg`.
`list:firstRest` builds the new environment with `(?name ?arg)` in front.

```n3
{
    (?env (:app ?fn ?arg)) :typeOf ?result
} <= {
    (?env ?fn) :typeOf (:fun ?input ?result) .
    (?env ?arg) :typeOf ?input .
} .
```

Applying a function of type `(:fun input result)` to an argument of type
`input` gives `result`. Two further rules look a variable up in the
environment, and a variable's type is whatever the lookup finds.

Finally the question, as a forward rule:

```n3
{
    (() (:app (:lam :x (:var :x)) (:intLit 42))) :typeOf ?t
} => {
    :query :type ?t
} .
```

---

## How the types flow

Nobody tells Eyeron the type of `x`. It starts as an unknown, `?arg`, and is
settled by matching:

1. To type the application, Eyeron needs the function's type
   `(:fun ?input ?result)` and the argument's type `?input`.
2. Typing the function puts `(:x ?arg)` into the environment and types the
   body `(:var :x)`, which looks `x` up and finds `?arg`. So the function has
   type `(:fun ?arg ?arg)`.
3. The argument `(:intLit 42)` has type `:int`, so `?input`, and with it
   `?arg` and `?result`, become `:int`.

This is the heart of type inference: unknown types are variables, and the
rules fit them together until everything is known.

---

## What Eyeron concludes

```n3
:query :type :int .
```

The identity function applied to 42 is an integer.

---

## The proof, step by step

The proof has seven steps, from the answer down to a built-in. The key one
is the application:

```n3
{ (() (:app (:lam :x (:var :x)) (:intLit 42))) :typeOf :int . }
  pe:rule 6;
  pe:binding
    [ pe:var "arg"; pe:value (:intLit 42) ],
    [ pe:var "env"; pe:value () ],
    [ pe:var "fn"; pe:value (:lam :x (:var :x)) ],
    [ pe:var "input"; pe:value :int ],
    [ pe:var "result"; pe:value :int ];
  pe:uses
    { (() (:lam :x (:var :x))) :typeOf (:fun :int :int) . },
    { (() (:intLit 42)) :typeOf :int . }.
```

It rests on the function having type `(:fun :int :int)` (rule 5, which in
turn uses a lookup of `x` in `((:x :int))`) and on 42 having type `:int`
(rule 3, which needs nothing further). The environment construction is a
`pe:builtin list:firstRest` step.

---

## Checked: what the report says

```n3
# checked: 7 steps, 7 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
```

- **C1 resolution**: the six rule steps each match the rule they cite under
  the bindings shown.
- **C2–C4**: the steps form a tree with no cycles, and every condition of
  every rule is covered by a step.
- **C5 re-decision**: the checker recomputed the `list:firstRest` step.
- **C7 relevance** and **C10 call fidelity**: every step serves the answer,
  and each goal was proved as the rule called it.

All 7 steps were verified, none trusted: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/type-inference.n3
eyeron -p examples/type-inference.n3
eyeron -c examples/type-inference.n3
```

Replace `(:intLit 42)` in the question with `(:var :y)`, a variable the
empty environment does not know: the lookup fails, no type is found, and
Eyeron derives nothing.

---

## Takeaway

A handful of backward rules over list terms is enough to infer types, and
the proof records exactly how the unknown type of `x` became `:int`.
