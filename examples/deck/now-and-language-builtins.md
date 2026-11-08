# Matching a language tag and reading a date tuple

[now-and-language-builtins.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/now-and-language-builtins.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/now-and-language-builtins.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/now-and-language-builtins.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/now-and-language-builtins.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=now-and-language-builtins)

---

## The question

A French-tagged greeting and a fixed date-time tuple supply the data. N3 rules
compare the complete literal and extract the year by list matching.

**Does the greeting match, and what year appears in the supplied timestamp?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The timestamp is a fixed tuple, so this example does not read the clock.
:msg :text "bonjour"@fr .

# Equality includes the language tag, not just the greeting text.
{
    ?msg :text ?text .
    ?text log:equalTo "bonjour"@fr
} => {
    ?msg :sameLanguageAs true
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:msg :sameLanguageAs true .
:clock :eventYear 2026 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :msg :sameLanguageAs true . }
  pe:rule 1;
  pe:binding
    [ pe:var "msg"; pe:value :msg ],
    [ pe:var "text"; pe:value "bonjour"@fr ];
  pe:uses
    { :msg :text "bonjour"@fr . },
    { "bonjour"@fr log:equalTo "bonjour"@fr . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 5 steps, 5 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/now-and-language-builtins.n3
eyeron -p examples/now-and-language-builtins.n3
eyeron -c examples/now-and-language-builtins.n3
```

---

## Takeaway

The date tuple is fixed data, so these results do not depend on the current
clock.
