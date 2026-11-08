# Adding sensor readings

*Collect every reading, count them, add them up — duplicates included.*

[aggregation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/aggregation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/aggregation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/aggregation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/aggregation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=aggregation)

---

## The question

Three sensors each report a reading: 10, 15 and 10. Two of them happen to
report the same number, and both should count.

**How many readings are there, and what is their total?**

Rules usually look at one fact at a time. Counting and summing need all the
facts at once, so this example shows how N3 gathers them.

---

## What we tell Eyeron

```n3
:sensor_a :reading 10 .
:sensor_b :reading 15 .
:sensor_c :reading 10 .
```

Then a way to add up a list, as two backward rules (`<=`, used when something
asks for `:total`):

```n3
{
    () :total 0
} <= true .

{
    ?list :total ?total
} <= {
    ?list list:firstRest (?first ?rest) .
    ?rest :total ?tail .
    (?first ?tail) math:sum ?total .
} .
```

`()` is the empty list, whose total is 0. Any other list is split by the
built-in `list:firstRest` into its first value and the rest; the total is the
first value plus the total of the rest. The rule calls itself on shorter and
shorter lists until it reaches `()`.

Finally the rule that asks the question:

```n3
    (
        ?value {
            ?sensor :reading ?value
        }
        ?allValues
    ) log:collectAllIn ?SCOPE .
    ?allValues list:length ?count .
    ?allValues :total ?total .
…
    :query :count ?count .
    :query :total ?total .
```

`log:collectAllIn` reads *collect every `?value` for which `?sensor :reading
?value` holds, into the list `?allValues`*. The curly braces hold a pattern,
not a fact. `?SCOPE` leaves the scope open, so Eyeron searches the current
graph. Every match adds an entry, so the two 10s both appear.

---

## What Eyeron concludes

```n3
:query :count 3 .
:query :total 35 .
```

Three readings, totalling 10 + 15 + 10 = 35. Had duplicates been dropped, the
answer would have been two readings and 25.

---

## The proof, step by step

The proof has 14 steps: 6 rule applications and 8 built-in calculations.
The count rests on three things:

```n3
{ :query :count 3 . }
  pe:rule 3;
  pe:binding
    [ pe:var "allValues"; pe:value (10 15 10) ],
    [ pe:var "count"; pe:value 3 ],
    [ pe:var "total"; pe:value 35 ];
  pe:uses
    {
        (?value {
            ?sensor :reading ?value .
        } (10 15 10)) log:collectAllIn ?SCOPE .
    },
    { (10 15 10) list:length 3 . },
    { (10 15 10) :total 35 . }.
```

The collected list `(10 15 10)`, its length, and its total. The total then
unfolds one list element at a time, each step by rule 2:

```n3
{ (10 15 10) :total 35 . }
…
{ (15 10) :total 25 . }
…
{ (10) :total 10 . }
…
{ () :total 0 . }
  pe:rule 1.
```

and every addition is its own built-in step, such as
`{ (10 25) math:sum 35 . }`.

---

## Checked: what the report says

```n3
# checked: 14 steps, 14 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 8; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
```

- **C1 resolution**, **C2 well-foundedness**, **C3 justification** and
  **C4 coverage**: the 6 rule steps match their rules, nothing argues in a
  circle, and every premise is proved or given.
- **C5 re-decision**: the checker recomputes all 8 built-ins itself: the list
  splits, the length and the sums.
- **C9 search closure**: the collection is the interesting part. A list of
  "all" readings is only right if no reading was left out. The checker
  settles that by looking at the program's facts itself: the readings are
  exactly 10, 15 and 10.
- **C6 boundary consistency**: nothing in the proof contradicts that
  collection.
- **C7 relevance** and **C10 call fidelity**: every step serves an answer,
  and the collection is the call the rule really makes.

Nothing was taken on trust, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/aggregation.n3      # the answer
eyeron -p examples/aggregation.n3   # with its proof
eyeron -c examples/aggregation.n3   # the proof, checked
```

Add `:sensor_d :reading 5 .` and run again: the count becomes 4 and the total
40.

---

## Takeaway

`log:collectAllIn` gathers all matching values into one list, and a short
recursive rule adds them up; the check confirms both the sums and that the
list really holds every reading.
