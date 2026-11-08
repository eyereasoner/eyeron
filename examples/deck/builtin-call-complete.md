# Combining arithmetic and list operations

*One rule, four built-in calls, four answers.*

[builtin-call-complete.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/builtin-call-complete.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/builtin-call-complete.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/builtin-call-complete.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/builtin-call-complete.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=builtin-call-complete)

---

## The question

We have a short list of numbers, `-3.7`, `7` and `2`. We want four small
facts about it, computed rather than typed in: an absolute value, a square
root, how many numbers there are, and the numbers in sorted order.

**Can one rule gather all four, and can Eyeron show where each came from?**

---

## What we tell Eyeron

```n3
:numbers :values (-3.7 7 2) .
```

`( … )` is a list: an ordered sequence of values, written as one term.

```n3
{
    :numbers :values ?values .
    -3.7 math:absoluteValue ?absolute .
    (9 0.5) math:exponentiation ?root .
    ?values list:length ?count .
    ?values list:sort ?sorted .
} => {
    :summary :absolute ?absolute ;
    :root ?root ;
    :count ?count ;
    :sorted ?sorted
} .
```

The first premise looks up the list. The other four are *built-ins*:
predicates such as `math:absoluteValue` or `list:sort` that Eyeron does not
look up among the facts but computes. Given their subject, they bind the
variable in the object position. `(9 0.5) math:exponentiation ?root` raises 9
to the power 0.5, which is a square root.

`;` repeats the subject, so the conclusion is four statements about
`:summary`.

---

## What Eyeron concludes

```n3
:summary :absolute 3.7 .
:summary :root "3"^^xsd:decimal .
:summary :count 3 .
:summary :sorted (-3.7 2 7) .
```

The root comes out as the exact decimal `3`, because the exponent `0.5` is a
decimal. The sort uses numeric order, so `-3.7` comes first.

---

## The proof, step by step

The proof gives each of the four conclusions its own rule step. They all
cite the same five premises:

```n3
{ :summary :absolute 3.7 . }
  pe:rule 1;
  pe:binding
    [ pe:var "absolute"; pe:value 3.7 ],
    [ pe:var "count"; pe:value 3 ],
    [ pe:var "root"; pe:value "3"^^xsd:decimal ],
    [ pe:var "sorted"; pe:value (-3.7 2 7) ],
    [ pe:var "values"; pe:value (-3.7 7 2) ];
  pe:uses
    { :numbers :values (-3.7 7 2) . },
    { -3.7 math:absoluteValue 3.7 . },
    { (9 0.5) math:exponentiation "3"^^xsd:decimal . },
    { (-3.7 7 2) list:length 3 . },
    { (-3.7 7 2) list:sort (-3.7 2 7) . }.
```

The list is a fact of the program, and each built-in result is its own step:

```n3
{ :numbers :values (-3.7 7 2) . }
  pe:fact "builtin-call-complete.n3".

{ (-3.7 7 2) list:sort (-3.7 2 7) . }
  pe:builtin list:sort.
```

A `pe:builtin` step makes no claim to be looked up anywhere: it says "this
is what the built-in answers", and leaves it to the checker to ask again.

---

## Checked: what the report says

```n3
# checked: 9 steps, 9 verified, 0 trusted
pe:builtinSteps 4;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 4; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
```

- **C1 resolution**: the four rule steps really are rule 1 with the recorded
  values, and the fact really is in the program.
- **C5 re-decision**: the checker computes each of the four built-in results
  again and gets the same answers.
- **C10 call fidelity**: each built-in step is the call the rule makes, with
  the inputs the rule gives it.
- C2, C3, C4 and C7 confirm that nothing depends on itself, every premise is
  supported, and every step serves an answer.

All 9 steps are verified and none is trusted, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/builtin-call-complete.n3
eyeron -p examples/builtin-call-complete.n3
eyeron -c examples/builtin-call-complete.n3
```

Change the list to `(-3.7 7 2 0)`: the count becomes `4` and the sorted list
`(-3.7 0 2 7)`.

---

## Takeaway

Built-ins let a rule compute, and the proof records each computed result as
its own step, which the checker then recomputes instead of believing.
