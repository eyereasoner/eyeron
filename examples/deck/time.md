# Parts of a Date and Time

*Taking one timestamp apart into year, month, day, minute, second and zone.*

[time.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/time.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/time.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/time.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/time.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=time)

---

## The question

A timestamp such as `2023-04-01T18:06:04Z` packs a whole moment into one
string: 1 April 2023, six minutes and four seconds past six in the evening,
in UTC (the `Z`). Programs often need just one piece of it.

**Can a rule read the year, month, day, minute, second and time zone out of
that one value?**

---

## What we tell Eyeron

```n3
:Let :dt "2023-04-01T18:06:04Z"^^xsd:dateTime .
```

One fact. The `^^xsd:dateTime` says the string is a date-time in the XML
Schema format, not just text.

```n3
{
    :Let :dt ?d .
    ?d time:year ?y ;
        time:month ?m ;
        time:day ?day ;
        time:minute ?min ;
        time:second ?sec ;
        time:timeZone ?tz .
} => {
    :out :year ?y ;
        :month ?m ;
        :day ?day ;
        :minute ?min ;
        :second ?sec ;
        :tz ?tz .
} .
```

The `time:` predicates are **built-ins**: Eyeron does not look them up among
the facts, it computes them. `?d time:year ?y` holds when `?y` is the year of
the date-time `?d`. The `;` repeats the same subject, so all six built-ins
read the same value. The hour is not asked for, so it is not reported.

---

## What Eyeron concludes

```n3
:out :year 2023 .
:out :month 4 .
:out :day 1 .
:out :minute 6 .
:out :second 4 .
:out :tz "Z" .
```

The numbers come out as plain integers; the zone comes out as the text it was
written with.

---

## The proof: one rule, six calculations

Each of the six answers is a firing of rule 1 that uses the given fact and the
six built-in results. The calculations are recorded as built-in steps:

```n3
{ :out :year 2023 . }
  pe:rule 1;
  pe:binding
    [ pe:var "d"; pe:value "2023-04-01T18:06:04Z"^^xsd:dateTime ],
…
    [ pe:var "y"; pe:value 2023 ];
  pe:uses
    { :Let :dt "2023-04-01T18:06:04Z"^^xsd:dateTime . },
    { "2023-04-01T18:06:04Z"^^xsd:dateTime time:year 2023 . },
…
{ "2023-04-01T18:06:04Z"^^xsd:dateTime time:year 2023 . }
  pe:builtin time:year.
```

The steps are shared: the fact and the six built-in results appear once, and
all six answers point to them.

---

## Checked: what the report says

```n3
# checked: 13 steps, 13 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
```

The 13 steps are 6 rule steps, 1 fact and 6 built-in steps. **C1
resolution** confirms each rule step matches rule 1 under its bindings; **C2
well-foundedness**, **C3 justification** and **C4 coverage** confirm the steps
form a finished, non-circular argument whose every premise is accounted for.
**C5 re-decision** is the interesting one here: the checker does not trust
the proof's word that the year is 2023; it recomputes all six built-ins
itself. **C7 relevance** confirms nothing is padding, and **C10 call
fidelity** that each built-in was checked as the rule called it. Nothing is
taken on trust, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/time.n3
eyeron -p examples/time.n3
eyeron -c examples/time.n3
```

Change the `Z` in the timestamp to `+02:00`: every number stays the same and
the zone comes out as `"+02:00"`.

---

## Takeaway

Built-ins let rules compute with values, not only match them, and the checker
recomputes every such result instead of taking it on faith.
