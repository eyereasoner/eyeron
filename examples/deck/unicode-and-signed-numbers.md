# Unicode and Signed Numbers

*An escaped letter and a minus sign, read as what they mean.*

[unicode-and-signed-numbers.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/unicode-and-signed-numbers.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/unicode-and-signed-numbers.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/unicode-and-signed-numbers.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/unicode-and-signed-numbers.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=unicode-and-signed-numbers)

---

## The question

Text in a file is sometimes written with escapes: `\U00000043` is a way of
writing the letter `C` by its Unicode number. Numbers can carry a sign, like
`-12`.

**Does Eyeron treat `"AB\U00000043"` as the text `"ABC"`, and `-12` as a
number below zero?**

---

## What we tell Eyeron

```n3
:sample :text "AB\U00000043" .
:thermo :delta -12 .
```

A sample's text, written with an escape, and a thermometer's change of
temperature.

```n3
{
    :sample :text "ABC"
} => {
    :sample a :UnicodeDecoded
} .
```

This rule has no variables: it fires only if the statement
`:sample :text "ABC"` holds exactly.

```n3
{
    :thermo :delta ?d .
    ?d math:lessThan 0 .
} => {
    :thermo a :BelowZero
} .
```

This one takes the change `?d` and asks the built-in `math:lessThan` whether
it is below 0.

---

## What Eyeron concludes

```n3
:sample a :UnicodeDecoded .
:thermo a :BelowZero .
```

Both rules fired. The escape was decoded when the file was read, so the
stored text is `"ABC"` and matches the rule. And `-12` is the number minus
twelve, not a word starting with a dash.

---

## The proof, step by step

```n3
{ :sample a :UnicodeDecoded . }
  pe:rule 1;
  pe:uses { :sample :text "ABC" . }.

{ :sample :text "ABC" . }
  pe:fact "unicode-and-signed-numbers.n3".
…
{ -12 math:lessThan 0 . }
  pe:builtin math:lessThan.
```

The proof cites the fact as `:sample :text "ABC"`: it records the value, not
the way it was spelled in the file. The comparison is a built-in step.

---

## Checked: what the report says

```n3
# checked: 5 steps, 5 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
```

The checker matched both rule steps against the program (C1), found the two
facts in the source file (C3), and recomputed `-12 math:lessThan 0` itself
(C5). The steps have no cycles (C2), cover every condition (C4), all serve
the answers (C7) and were proved as called (C10). All 5 steps were verified:
the verdict is **checked**.

---

## Try it

```sh
eyeron examples/unicode-and-signed-numbers.n3
eyeron -c examples/unicode-and-signed-numbers.n3
```

Change `-12` to `12`: the comparison fails and only
`:sample a :UnicodeDecoded` remains.

---

## Takeaway

Escapes and signs belong to how a value is written; Eyeron reasons about the
value itself.
