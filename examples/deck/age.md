# Age check

*Is someone older than 80? The answer depends on today's date.*

[age.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/age.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/age.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=age)

---

## The question

We know when a person was born: 21 August 1944. Whether they are older than
80 years is not a fixed fact: it depends on when you ask. To answer, Eyeron
has to look at the clock.

**Is this person older than 80 years today?**

---

## What we tell Eyeron

```n3
:patH :birthDay "1944-08-21"^^xsd:date .
```

A typed value: `"1944-08-21"^^xsd:date` is the text `1944-08-21` read as an
XML Schema date, so Eyeron can calculate with it.

```n3
{
    ?S :ageAbove ?A
} <= {
    ?S :birthDay ?B .
    "" time:localTime ?D .
    (?D ?B) math:difference ?F .
    ?F math:greaterThan ?A .
} .
```

This rule points backwards, `<=`: it is not run on its own, but used when
something asks for `:ageAbove`. It reads *S's age is above A if S was born on
B, the time now is D, the difference between D and B is F, and F is greater
than A.* Three of its lines are built-ins, statements Eyeron computes instead
of looking up:

- `time:localTime` gives the current date and time;
- `math:difference` subtracts the birth date from it, giving a duration;
- `math:greaterThan` compares that duration with the one asked about.

```n3
{
    ?S :ageAbove "P80Y"^^xsd:duration .
} => {
    :test :is true .
} .
```

A forward rule asks the question: `"P80Y"^^xsd:duration` is the standard way
to write *a period of 80 years*. If someone's age is above it, Eyeron records
`:test :is true`.

---

## What Eyeron concludes

```n3
:test :is true .
```

Born in August 1944, the person is past 80 on any date after August 2024, so
the test succeeds. Before that date the same program would have printed
nothing at all: in N3, a question with no answer simply yields no conclusion.

---

## Why there is no saved proof

Eyeron can still write a proof for this example with `eyeron -p`, and check
it with `eyeron -c`. But the proof records the exact moment `time:localTime`
returned, down to the millisecond, so it is different on every run. That is
why the repository keeps the output, which stays the same, but no proof or
check report to compare against.

The check is also honest about the clock. It recomputes the subtraction and
the comparison, but it cannot recompute "now": by the time it checks, the
time has moved on. So it reports *checked with obligations*: 6 steps, 5
verified and 1 trusted. The trusted step is the clock reading, listed as an
`impure built-in` obligation. The answer holds *if* the recorded time was
the real time when the proof was made.

---

## Try it

```sh
eyeron examples/age.n3      # the answer
eyeron -p examples/age.n3   # a proof, with today's time in it
eyeron -c examples/age.n3   # checked, with the clock as an obligation
```

Change `"P80Y"` to `"P90Y"` and run again: the person is not yet 90, so
Eyeron concludes nothing.

---

## Takeaway

A rule can depend on the outside world, here the clock. Eyeron still
explains its answer, and its check says plainly which part it had to take on
trust.
