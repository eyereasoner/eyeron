# Trying several built-in operations

*A rule that asks too much: one unknown built-in, and nothing fires.*

[builtin-coverage.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/builtin-coverage.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/builtin-coverage.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/builtin-coverage.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/builtin-coverage.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=builtin-coverage)

---

## The question

A single rule calls many built-ins at once: sums and products, string
formatting, list operations, a hash, the year of a timestamp, and joining two
formulas. If every call succeeds, the rule reports all the results together.

**Does every call succeed? And what does Eyeron do when one does not?**

---

## What we tell Eyeron

The rule's premises are a long run of built-in calls. A few of them:

```n3
{
    (2 3 4) math:sum ?sum .
    (9 4) math:remainder ?rem .
    "abc" string:length ?len .
    ("item %s %d" "x" 7) string:format ?fmt .
    "hello" crypto:sha256 ?sha .
    (("a") ("b" "c")) list:append ?appended .
    "2024-01-02T03:04:05Z" time:year ?year .
…
} => {
    :assurance :sum ?sum ;
…
} .
```

A built-in is a predicate Eyeron computes instead of looking it up. A rule's
premises must all hold together, so the rule fires only if every one of
these calls has an answer.

Two queries decide what is printed. `log:query` works like a rule whose
conclusions are the program's output:

```n3
{
    :assurance ?p ?o
} log:query {
    :assurance ?p ?o
} .
```

and a second query writes a short Markdown note with `log:outputString`.
When a program produces such text, Eyeron prints the text as its output.

---

## What Eyeron concludes

Only the Markdown note:

```markdown
# builtin-coverage
## Source files
- [N3 rules](../builtin-coverage.n3)
- [Input TriG](../input/builtin-coverage.trig)
```

No `:assurance` result appears, and not because it was hidden: the rule
never fired. Four of its calls, `string:length`, `string:charAt`,
`string:setCharAt` and `crypto:sha256`, are not built-ins Eyeron provides.
Eyeron's hash built-in is `crypto:sha`. An unknown predicate is an ordinary
one, looked up among the facts, and no fact matches, so the premises fail
as a whole.

---

## The proof, step by step

The proof covers the one thing that was produced, the note. Its rule is the
`log:query`, which the proof quotes in full:

```n3
{ :__md_output log:outputString "# builtin-coverage\n\n## Source files\n\n- [N3 rules](../builtin-coverage.n3)\n- [Input TriG](../input/builtin-coverage.trig)\n\n" . }
  pe:rule
…
  pe:binding [ pe:var "text"; pe:value "# builtin-coverage\n\n## Source files\n\n- [N3 rules](../builtin-coverage.n3)\n- [Input TriG](../input/builtin-coverage.trig)\n\n" ];
```

The text itself is a fact of the program, so the proof has 2 steps.

---

## Checked: what the report says

```n3
# checked: 2 steps, 2 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
```

- **C1 resolution**: the query step and the fact are what they say.
- **C10 call fidelity**: the printed text comes from a real application of
  the program's query.
- C2, C3, C4 and C7 find no cycle, no unsupported premise, and no padding.

The verdict is **checked**, for the note. The check confirms what was
produced; it says nothing about the rule that produced nothing.

---

## Try it

```sh
eyeron examples/builtin-coverage.n3 examples/input/builtin-coverage.trig
eyeron -c examples/builtin-coverage.n3 examples/input/builtin-coverage.trig
```

To see the built-ins work, make a copy, delete the Markdown query at the end,
the three calls `string:length`, `string:charAt` and `string:setCharAt` with
their three `:assurance` lines, and write `crypto:sha` for `crypto:sha256`.
The rule then fires and reports 26 results, such as `:assurance :sum 9` and
`:assurance :year 2024`, with `"hello"` hashed to
`"aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d"` (SHA-1).

---

## Takeaway

A rule is all or nothing: one premise that cannot hold, here a built-in that
does not exist, silently keeps every other result from being derived.
