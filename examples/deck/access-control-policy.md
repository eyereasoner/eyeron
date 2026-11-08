# Checking an access policy

*A request meets a policy only if it has everything required, something allowed, and nothing forbidden.*

[access-control-policy.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/access-control-policy.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/access-control-policy.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/access-control-policy.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/access-control-policy.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=access-control-policy)

---

## The question

Access policies are often written as three lists. *All of* these must be
present. *Any of* these will do, but at least one must be there. *None of*
these may appear. A request arrives carrying some fields, and the question is
whether it meets the policy it names.

The tricky parts are "all" and "none": they are claims about everything the
request has, not about one fact. A reasoner has to look over the whole set of
facts to decide them.

**Does request test1 satisfy PolicyX, and can Eyeron show why?**

---

## What we tell Eyeron

```n3
:test1 :policy :PolicyX ;
    :has :A, :B, :C .

:PolicyX a :Policy ;
    :allOf :A, :B ;
    :anyOf :C ;
    :noneOf :D .
```

The request has fields A, B and C. The policy requires A and B, accepts C as
an option, and forbids D. A `;` repeats the subject and a `,` repeats subject
and predicate, so `:has :A, :B, :C` is three statements.

Each test is a *backward* rule, written `{ conclusion } <= { conditions }`:
Eyeron uses it only when it needs the conclusion. The "all of" test:

```n3
{
    ?Pol :pass :allOfTest .
} <= {
    ?Test :policy ?Pol .
    ?Pol a :Policy .
    (
        {
            ?Pol :allOf ?Field
        }
        {
            ?Test :has ?Field
        }
    ) log:forAllIn ?X .
} .
```

`log:forAllIn` takes two formulas (statements in braces) and succeeds when
*every* way of matching the first can also match the second: every field the
policy requires is one the request has.

---

## How "any of" and "none of" work

Both use `log:collectAllIn`, which gathers every answer to a pattern into a
list:

```n3
(
    ?Field {
        ?Pol :noneOf ?Field .
        ?Test :has ?Field
    }
    ?List
) log:collectAllIn ?X .
?List list:length ?L .
?L log:equalTo 0 .
```

This collects the forbidden fields the request has, then insists that the list
is empty. The "any of" rule is the same shape with `:anyOf`, and insists that
the length is *not* zero (`log:notEqualTo 0`).

A query at the end asks for every policy that passes all three tests:

```n3
{
    ?Pol a :Policy .
    ?Pol :pass :allOfTest .
    ?Pol :pass :anyOfTest .
    ?Pol :pass :noneOfTest .
} log:query {
    :test :for ?Pol .
    :test :is true .
} .
```

---

## What Eyeron concludes

```n3
:test :for :PolicyX .
:test :is true .
```

Because there is a `log:query`, Eyeron prints only what the query asks for.
PolicyX passes: A and B are present, C is present, and D is absent.

---

## The proof, step by step

The proof has 14 steps. The answer cites the query rule and the three passed
tests. Each test cites its rule, the facts it matched, and the built-ins it
ran. Here is the "none of" test:

```n3
{ :PolicyX :pass :noneOfTest . }
  pe:rule 3;
  pe:binding
    [ pe:var "L"; pe:value 0 ],
    [ pe:var "List"; pe:value () ],
    [ pe:var "Pol"; pe:value :PolicyX ],
    [ pe:var "Test"; pe:value :test1 ];
…
{ () list:length 0 . }
  pe:builtin list:length.

{ 0 log:equalTo 0 . }
  pe:builtin log:equalTo.
```

Rule 3 ran with the collected list empty, `()`, and its length 0. For the
"any of" test the collected list is `(:C)` with length 1. The proof renames
the rule's inner variables (`?__backward_0_2_…__Field`) so they cannot clash
with any other variables.

---

## Checked: what the report says

```n3
# checked: 14 steps, 14 verified, 0 trusted
pe:verdict pe:checked;
pe:builtinSteps 7;
pe:factSteps 2;
pe:ruleSteps 5;
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 7; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 3; pe:failed 0 ];
```

- **C1 resolution**: the rule steps match the rules they cite under the
  recorded bindings.
- **C5 re-decision**: all 7 built-in steps were recomputed, from
  `list:length` to the two collections and the "for all" test.
- **C9 search closure**: the three steps that look over the whole graph (one
  `log:forAllIn`, two `log:collectAllIn`) were settled by the proof's own
  search record, so the checker knows nothing was missed: no forbidden field
  hides outside the list.
- **C6 boundary consistency**: nothing else in the proof contradicts those
  three results.
- C2, C3, C4, C7 and C10 confirm that the steps are well founded, justified,
  cover every premise, all serve the answer, and that each test was checked
  as it was called.

No step was taken on trust and there are no obligations, so the verdict is
**checked**.

---

## Try it

```sh
eyeron examples/access-control-policy.n3      # the answer
eyeron -p examples/access-control-policy.n3   # the answer with its proof
eyeron -c examples/access-control-policy.n3   # the proof, checked
```

Change the request to `:has :A, :B, :C, :D .` and run again: D is forbidden,
the "none of" test fails, and Eyeron prints no answer at all.

---

## Takeaway

"All of" and "none of" are claims about everything in the data; Eyeron decides
them by looking over the whole graph, and the proof records that search so a
checker can confirm nothing was overlooked.
