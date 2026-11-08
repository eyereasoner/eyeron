# Collecting values from a scoped graph pattern

*Gathering every answer to a question into one list.*

[log-collect-all-in.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/log-collect-all-in.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/log-collect-all-in.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/log-collect-all-in.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/log-collect-all-in.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=log-collect-all-in)

---

## The question

A rule usually fires once per answer: three names, three firings. Sometimes
you want all the answers at once, as one list: *the* names, not *a* name.

**Can Eyeron gather all the names into a list, wrap each one, and keep only
some of them?**

---

## What we tell Eyeron

```n3
:Let :param "Huey" .
:Let :param "Dewey" .
:Let :param "Louie" .
```

`log:collectAllIn` takes three things in a list: what to collect, a pattern
between braces (a quoted graph), and the list of results. Its object, `_:x`,
says where to look: here, the current graph of facts.

```n3
    (
        ?param {
            :Let :param ?param
        }
        ?allParams
    ) log:collectAllIn _:x .
```

*Collect every `param` such that `:Let :param param`, into `allParams`.*
The same rule makes two more collections: one where what is collected is a
small list, `(?param)`, and one with an extra condition in the pattern:

```n3
            :Let :param ?param .
            ?param string:lessThan "Louie" .
```

`string:lessThan` compares strings in alphabetical order. The rule concludes:

```n3
    :result1 :is ?allParams .
    :result2 :is ?nestedParams .
    :result3 :is ?filteredParams .
```

---

## What Eyeron concludes

```n3
:result1 :is ("Huey" "Dewey" "Louie") .
:result2 :is (("Huey") ("Dewey") ("Louie")) .
:result3 :is ("Huey" "Dewey") .
```

The names come in the order the facts were given. "Louie" is not less than
itself, so the filtered list leaves it out.

---

## The proof: three collections, one firing

```n3
{ :result3 :is ("Huey" "Dewey") . }
  pe:rule 1;
  …
{
  (?param {
      :Let :param ?param .
      ?param string:lessThan "Louie" .
  } ("Huey" "Dewey")) log:collectAllIn ?_:x .
}
  pe:builtin log:collectAllIn.
```

Each result is a step of rule 1 that uses the three collections; each
collection is a built-in step. A collection is a claim about *everything*
that matches, which a list of examples cannot prove: it also needs that
nothing else matches.

---

## Checked: what the report says

```n3
# checked: 6 steps, 6 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 3; pe:failed 0 ];
```

- **C9 search closure**: the three collections are settled against the
  program: the checker confirms that the patterns have exactly these
  solutions over the current graph, so none is missing.
- **C6 boundary consistency**: nothing else in the proof contradicts the
  collected lists.
- **C5 re-decision**: the built-in results are recomputed, including the
  `string:lessThan` filter.
- **C1–C4, C7, C10**: the rule steps match rule 1 and serve the answers.

All 6 steps were verified, with no obligations: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/log-collect-all-in.n3      # the answers
eyeron -p examples/log-collect-all-in.n3   # with the proof
eyeron -c examples/log-collect-all-in.n3   # the proof, checked
```

Add `:Let :param "Daisy" .` after Louie: all three lists grow, and the
filtered one becomes `("Huey" "Dewey" "Daisy")`, since "Daisy" sorts before
"Louie".

---

## Takeaway

`log:collectAllIn` turns all the answers to a pattern into one list, and a
checker can confirm that the list is complete, not just correct.
