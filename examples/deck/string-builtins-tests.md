# Checking text operations

[string-builtins-tests.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/string-builtins-tests.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/string-builtins-tests.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/string-builtins-tests.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/string-builtins-tests.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=string-builtins-tests)

---

## The question

Small N3 rules exercise concatenation, search, comparison, formatting, and
other text operations. Eyeron derives a pass marker when a built-in call
matches its expected result.

**Which text-operation calls match their stated expected results?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Each rule checks one builtin and, if it behaves as specified,
# derives a single marker triple:
# :ok_string_<name>_1 a :Pass .
# string:concatenation
{
    ("hello" " " "world!") string:concatenation "hello world!" .
} => {
    :ok_string_concatenation_1 a :Pass .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:ok_string_concatenation_1 a :Pass .
:ok_string_contains_1 a :Pass .
:ok_string_scrape_1 a :Pass .
:ok_string_startsWith_1 a :Pass .
:ok_string_containsIgnoringCase_1 a :Pass .
:ok_string_endsWith_1 a :Pass .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :ok_string_concatenation_1 a :Pass . }
  pe:rule 1;
  pe:uses { ("hello" " " "world!") string:concatenation "hello world!" . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 42 steps, 42 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 21; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 21; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 21; pe:failed 0 ].
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
eyeron examples/string-builtins-tests.n3
eyeron -p examples/string-builtins-tests.n3
eyeron -c examples/string-builtins-tests.n3
```

---

## Takeaway

A pass marker records a concrete built-in check on the supplied strings.
