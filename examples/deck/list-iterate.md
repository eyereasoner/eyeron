# Enumerating a list with positions

*Huey, Dewey and Louie, each with a number.*

[list-iterate.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/list-iterate.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/list-iterate.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/list-iterate.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/list-iterate.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=list-iterate)

---

## The question

A list has an order: the first item, the second, and so on. Sometimes you
need that position, not just the item: which seat, which line, which step.

**Given the list Huey, Dewey, Louie, can Eyeron pair each name with its
position, and tell where Dewey is?**

---

## What we tell Eyeron

```n3
:Let :param ("Huey" "Dewey" "Louie") .
```

The built-in `list:iterate` relates a list to `(index value)` pairs, counting
from 0. One rule uses it three ways:

```n3
{
    :Let :param ?X .
    ?X list:iterate ?Y .
    …
    ?X list:iterate (1 "Dewey") .
    …
    ?X list:iterate (?Z "Dewey") .
} => {
    ?X :iterate ?Y .
    "Dewey" :hasIndex ?Z .
} .
```

- With `?Y` unknown, it succeeds once per pair: `(0 "Huey")`, `(1 "Dewey")`,
  `(2 "Louie")`.
- With both parts given, `(1 "Dewey")`, it only checks.
- With the index unknown, `(?Z "Dewey")`, it finds Dewey's position.

A second rule turns the result into a test:

```n3
{
    ?X :iterate ?Y .
    "Dewey" :hasIndex 1 .
} => {
    :test :is true .
} .
```

---

## What Eyeron concludes

```n3
("Huey" "Dewey" "Louie") :iterate (0 "Huey") .
"Dewey" :hasIndex 1 .
("Huey" "Dewey" "Louie") :iterate (1 "Dewey") .
("Huey" "Dewey" "Louie") :iterate (2 "Louie") .
:test :is true .
```

The first rule fires three times, once per pair; each firing also concludes
`"Dewey" :hasIndex 1`, which is stated once.

---

## The proof: one firing per pair

```n3
{ ("Huey" "Dewey" "Louie") :iterate (2 "Louie") . }
  pe:rule 1;
  pe:binding
    [ pe:var "X"; pe:value ("Huey" "Dewey" "Louie") ],
    [ pe:var "Y"; pe:value (2 "Louie") ],
    [ pe:var "Z"; pe:value 1 ];
  pe:uses
    { :Let :param ("Huey" "Dewey" "Louie") . },
    { ("Huey" "Dewey" "Louie") list:iterate (2 "Louie") . },
    { ("Huey" "Dewey" "Louie") list:iterate (1 "Dewey") . },
    { ("Huey" "Dewey" "Louie") list:iterate (1 "Dewey") . }.

{ ("Huey" "Dewey" "Louie") list:iterate (2 "Louie") . }
  pe:builtin list:iterate.
```

The step lists the four premises of rule 1 in order: the fact, then the three
`list:iterate` calls. The last two are the same statement, because the check
`(1 "Dewey")` and the search `(?Z "Dewey")` with `Z` = 1 end up identical.
The test step rests on `:iterate (0 "Huey")` and `"Dewey" :hasIndex 1`.

---

## Checked: what the report says

```n3
# checked: 9 steps, 9 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
```

- **C1 resolution**: the fact and the 5 rule steps match the program.
- **C5 re-decision**: the checker recomputes the 3 distinct `list:iterate`
  results itself.
- **C2, C3, C4, C7**: no step depends on itself, each is justified, every
  premise is covered, and nothing is padding.
- **C10 call fidelity**: the premises hold as they were called, for example
  `(1 "Dewey")` as a check, not as a search.

All 9 steps were verified, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/list-iterate.n3      # the answers
eyeron -p examples/list-iterate.n3   # with the proof
eyeron -c examples/list-iterate.n3   # the proof, checked
```

Swap the first two names, `("Dewey" "Huey" "Louie")`, and Eyeron concludes
nothing at all: the check `?X list:iterate (1 "Dewey")` now fails, and with it
the whole first rule.

---

## Takeaway

One built-in can enumerate, check or search, depending on which parts you
leave open; positions in a list become ordinary facts you can reason with.
