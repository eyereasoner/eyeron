# Selecting an adult with an English name

*A name carries its language with it; one rule reads that tag and an age.*

[base-and-literals.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/base-and-literals.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/base-and-literals.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/base-and-literals.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/base-and-literals.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=base-and-literals)

---

## The question

In RDF a piece of text can say which language it is in: `"Alice Smith"@en`
is English, `"Bob"@nl` is Dutch. Numbers such as `22` are values of their
own, not text.

We know two people, each with a name and an age.

**Who is an adult (18 or older) with a name tagged as English?**

---

## What we tell Eyeron

```n3
:alice :name "Alice Smith"@en ;
    :age 22 .
:bob :name "Bob"@nl ;
    :age 17 .
```

The `;` continues with the same subject, so Alice has both a name and an age.

```n3
{
    ?person :name ?name .
    ?person :age ?age .
    ?pair log:langlit ?name .
    ?pair list:firstRest (?value ?rest) .
    ?rest list:firstRest (?lang ?rest2) .
    ?lang log:equalTo "en" .
    ?age math:notLessThan 18
} => {
    ?person :adult true
} .
```

The rule uses *built-ins*: predicates that Eyeron computes instead of looking
up.

- `log:langlit` takes a tagged name apart into a list of its text and its tag:
  for Alice, `("Alice Smith" "en")`.
- `list:firstRest` splits a list into its first item and the rest; used twice,
  it picks out the tag `"en"`.
- `log:equalTo` requires the tag to be `"en"`, and `math:notLessThan` the age
  to be at least 18.

---

## What Eyeron concludes

```n3
:alice :adult true .
```

Alice qualifies. Bob fails on both counts: his name is Dutch and he is 17.
The rule needs both conditions, so fixing only one of them is not enough.

---

## The proof, step by step

The proof records the one rule step with every variable's value, and the
seven statements it uses:

```n3
{ :alice :adult true . }
  pe:rule 1;
  pe:binding
    [ pe:var "age"; pe:value 22 ],
    [ pe:var "lang"; pe:value "en" ],
    [ pe:var "name"; pe:value "Alice Smith"@en ],
    [ pe:var "pair"; pe:value ("Alice Smith" "en") ],
    …
  pe:uses
    { :alice :name "Alice Smith"@en . },
    { :alice :age 22 . },
    { ("Alice Smith" "en") log:langlit "Alice Smith"@en . },
    …
    { 22 math:notLessThan 18 . }.
```

Two of them are facts from the file:

```n3
{ :alice :age 22 . }
  pe:fact "base-and-literals.n3".
```

The other five are built-in results, each marked as such:

```n3
{ ("Alice Smith" "en") log:langlit "Alice Smith"@en . }
  pe:builtin log:langlit.
```

---

## Checked: what the report says

```n3
# checked: 8 steps, 8 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
```

- **C1 resolution**: the two facts are in the file, and rule 1 with the
  recorded bindings gives exactly the answer.
- **C5 re-decision**: the checker recomputes all 5 built-in results itself:
  it takes the tagged name apart again, compares the tag and compares 22
  with 18. A proof claiming Bob's name were English would fail here.
- **C2, C3, C4, C7**: no step depends on itself, each has one valid
  justification, every premise is covered and nothing is superfluous.
- **C10 call fidelity**: the answer is checked as the program states it.

All 8 steps were verified, none taken on trust: the verdict is **checked**.
It confirms Alice; it does not by itself show that Bob is excluded.

---

## Try it

```sh
eyeron examples/base-and-literals.n3      # the answer
eyeron -p examples/base-and-literals.n3   # with its proof
eyeron -c examples/base-and-literals.n3   # the proof, checked
```

Change Bob's name to `"Bob"@en` *and* his age to `19`: he becomes an adult
too. Change only one of the two and he stays out.

---

## Takeaway

Language tags are part of a literal's value, and built-ins let a rule read
them as easily as a number; the checker recomputes every such reading.
