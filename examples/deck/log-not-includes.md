# Testing absence after generated rules run

*A rule can make new rules, and "not there" has to wait for them.*

[log-not-includes.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/log-not-includes.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/log-not-includes.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/log-not-includes.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/log-not-includes.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=log-not-includes)

---

## The question

In N3 a rule can conclude another rule. Here one rule adds a fact and a new
rule, and the new rule derives `:a :b :c`. A third rule wants to conclude
`:test :is false` only when `:a :b :c` is *missing*.

If the absence test were asked too early, before the generated rule had run,
it would wrongly succeed.

**Does `:test :is false` follow?**

---

## What we tell Eyeron

```n3
{
    1 math:equalTo 1 .
} => {
    :x :y 1 .

    {
        :x :y 1
    } => {
        :a :b :c
    } .
} .
```

`1 math:equalTo 1` always holds, so this rule fires and concludes two things:
the fact `:x :y 1` and a whole new rule, *if `:x :y 1` then `:a :b :c`*.

```n3
{
    ?SCOPE log:notIncludes {
        :a :b :c
    } .
} => {
    :test :is false
} .
```

`log:notIncludes` holds when the quoted formula is *not* in the graph. With a
variable as the scope it looks at the current graph: everything known so far,
including what rules derived.

---

## What Eyeron concludes

```n3
:x :y 1 .

{
    :x :y 1 .
} => {
    :a :b :c .
} .

:a :b :c .
```

The generated rule appears in the output as a conclusion, and it fired:
`:a :b :c` is there. So the absence test fails and `:test :is false` is
**not** derived. Eyeron evaluates negation only after the rules that could
change its answer have run.

---

## The proof, step by step

```n3
{ :a :b :c . }
  pe:rule
    {
        {
            :x :y 1 .
        } => {
            :a :b :c .
        } .
    };
  pe:uses { :x :y 1 . }.
```

Most steps cite a rule by its number in the program. This one cites the
generated rule itself, quoted, because it is not in the source text. The
proof also shows where that rule came from: rule 1, using the built-in
`1 math:equalTo 1`.

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ].
```

- **C1 resolution**: the three rule steps match their rules, including the
  generated one, which is itself a checked conclusion.
- **C5 re-decision**: the checker recomputes `1 math:equalTo 1`.
- **C2, C3, C4, C7**: no cycles, every step justified and covered, nothing
  irrelevant.

The failed absence test produced nothing, so there is no negation to settle
and C9 examined nothing. All 4 steps were verified.

---

## Try it

```sh
eyeron examples/log-not-includes.n3
eyeron -p examples/log-not-includes.n3
```

Change the condition of the generated rule from `:x :y 1` to `:x :y 2`. The
generated rule no longer fires, `:a :b :c` stays absent, and
`:test :is false .` appears in the output.

---

## Takeaway

Asking "is this missing?" only makes sense once everything that could add it
has had its turn; Eyeron waits for generated rules before deciding.
