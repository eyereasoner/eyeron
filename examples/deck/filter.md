# Collecting names that pass a text filter

[filter.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/filter.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/filter.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/filter.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/filter.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=filter)

---

## The question

Three names are compared with a text threshold. Scoped N3 collection gathers
the matching names into a list, and the query checks its length before
returning it.

**Which names pass the text threshold, and how many are collected?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Three candidate names; the query compares them in text order.
:Let :param "Huey" .

{
    (
        ?param {
            :Let :param ?param .
            ?param string:lessThan "Louie" .
        }
        ?filteredParams
    ) log:collectAllIn ?scope .
    ?filteredParams list:length 2 .
} log:query {
    :result :is ?filteredParams .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:result :is ("Huey" "Dewey") .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :is ("Huey" "Dewey") . }
  pe:rule
    {
        {
            (?param {
                :Let :param ?param .
                ?param string:lessThan "Louie" .
            } ?filteredParams) log:collectAllIn ?scope .
            ?filteredParams list:length 2 .
        } => {
            :result :is ?filteredParams .
        } .
    };
  pe:binding [ pe:var "filteredParams"; pe:value ("Huey" "Dewey") ];
  pe:uses
    {
        (?param {
            :Let :param ?param .
            ?param string:lessThan "Louie" .
        } ("Huey" "Dewey")) log:collectAllIn ?scope .
    },
    { ("Huey" "Dewey") list:length 2 . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/filter.n3
eyeron -p examples/filter.n3
eyeron -c examples/filter.n3
```

---

## Takeaway

The query can check a collected list as well as return it.
