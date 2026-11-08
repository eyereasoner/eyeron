# Smoke Arithmetic

*Six times seven, worked out by a rule and printed as a little report.*

[smoke-arithmetic.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/smoke-arithmetic.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/smoke-arithmetic.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/smoke-arithmetic.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/smoke-arithmetic.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=smoke-arithmetic)

---

## The question

A *smoke test* is the smallest test that shows a machine works at all. Here
it is: two numbers arrive in a separate data file, and the answer must be
computed from them, not copied from anywhere.

**What is their product, and can Eyeron write it up as a readable report?**

---

## What we tell Eyeron

The numbers come from a companion file in TriG, a format for RDF data:

```n3
:Input :x 6 .
:Input :y 7 .
```

The first rule multiplies them and keeps the product only when it is
positive:

```n3
{
    :Input :x ?X ;
        :y ?Y .
    (?X ?Y) math:product ?Product .
    ?Product math:greaterThan 0 .
} => {
    :Case :product ?Product .
} .
```

`math:product` and `math:greaterThan` are *built-ins*: Eyeron computes them
instead of looking them up. The `;` repeats the subject `:Input` for a second
statement.

The second rule fills a Markdown template with the product:

```n3
:Case :product ?Product .
…
) string:format ?Block .
} => {
:out01 log:outputString ?Block .
```

`string:format` puts the value where the template says `%s`. A program that
uses `log:outputString` prints those strings, in order of their subjects,
instead of triples.

---

## What Eyeron concludes

The output is Markdown:

```markdown
# smoke-arithmetic
## Answer
product = 42
## Explanation
The compiled rule multiplies :x and :y using math:product.
```

---

## The proof, step by step

The proof records the triples behind the report, starting with the product:

```n3
{ :Case :product 42 . }
  pe:rule 1;
  pe:binding
    [ pe:var "Product"; pe:value 42 ],
    [ pe:var "X"; pe:value 6 ],
    [ pe:var "Y"; pe:value 7 ];
…
{ (6 7) math:product 42 . }
  pe:builtin math:product.

{ 42 math:greaterThan 0 . }
  pe:builtin math:greaterThan.
```

Then rule 2 turns 42 into the report string, citing a `string:format` step.
The two input facts are cited as facts; the proof labels their source
`"<unknown>"`, though the check report lists the TriG file among its sources.

---

## Checked: what the report says

```n3
# checked: 7 steps, 7 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
```

- **C1 resolution**: the two rule steps are rules 1 and 2 under their
  bindings, and the two facts are in the input.
- **C5 re-decision**: the checker recomputes the three built-ins itself:
  6 × 7 is 42, 42 is greater than 0, and the template filled with 42 gives
  exactly the recorded report.
- **C2**, **C3**, **C4** and **C7**: a proper, fully covered tree with
  nothing extra; **C10** confirms the two answers as derived.

All 7 steps are verified; the verdict is **checked**.

---

## Try it

```sh
eyeron examples/smoke-arithmetic.n3 examples/input/smoke-arithmetic.trig      # the report
eyeron -p examples/smoke-arithmetic.n3 examples/input/smoke-arithmetic.trig   # with its proof
eyeron -c examples/smoke-arithmetic.n3 examples/input/smoke-arithmetic.trig   # the proof, checked
```

In a copy of the input, change `:Input :y 7 .` to `:Input :y 8 .`: the report
says `product = 48`. Make it `-7` instead: the product is not positive, the
first rule does not fire, and nothing is printed.

---

## Takeaway

Even a one-line calculation can carry its proof: the checker multiplies 6 by
7 again rather than taking the report's word for it.
