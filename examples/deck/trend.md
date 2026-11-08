# Detecting a trend in successive readings

[trend.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/trend.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/trend.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/trend.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/trend.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=trend)

---

## The question

A sequence of daily values is linked in time and paired with configuration
thresholds. N3 arithmetic rules inspect consecutive changes and derive the
example's trend judgments.

**Which consecutive readings meet the configured trend conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Raw data (7 consecutive days, generic units)
:day1 :value 10.0 ;
    :next :day2 .

# Declare an upward 7-day trend when slope > 0 and all deltas > 0
{
    :day1 :value ?v1 .
    :day7 :value ?v7 .
    :config :steps ?n .

    ((?v1 ?v7) ?n) :slope ?m .
    ?m math:greaterThan 0 .

    :day1 :next :day2 .
    (:day1 :day2) :delta ?d12 .
    ?d12 math:greaterThan 0 .
    :day2 :next :day3 .
    (:day2 :day3) :delta ?d23 .
    ?d23 math:greaterThan 0 .
    :day3 :next :day4 .
    (:day3 :day4) :delta ?d34 .
    ?d34 math:greaterThan 0 .
    :day4 :next :day5 .
…
        :slope ?m ;
        :start ?v1 ;
        :end ?v7 .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called. The ellipsis omits part of the source; the
linked file contains the full program.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:answer :text "Upward 7-day trend detected." .
:answer :slope 0.6666666666666666 .
:answer :start 10.0 .
:answer :end 14.0 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :answer :text "Upward 7-day trend detected." . }
  pe:rule 3;
  pe:binding
    [ pe:var "d12"; pe:value 0.8000000000000007 ],
    [ pe:var "d23"; pe:value 0.6999999999999993 ],
    [ pe:var "d34"; pe:value 0.5999999999999996 ],
    [ pe:var "d45"; pe:value 0.8000000000000007 ],
    [ pe:var "d56"; pe:value 0.5 ],
    [ pe:var "d67"; pe:value 0.5999999999999996 ],
    [ pe:var "m"; pe:value 0.6666666666666666 ],
    [ pe:var "n"; pe:value 6 ],
    [ pe:var "v1"; pe:value 10.0 ],
    [ pe:var "v7"; pe:value 14.0 ];
  pe:uses
    { :day1 :value 10.0 . },
    { :day7 :value 14.0 . },
    { :config :steps 6 . },
    { ((10.0 14.0) 6) :slope 0.6666666666666666 . },
    { 0.6666666666666666 math:greaterThan 0 . },
    { :day1 :next :day2 . },
    { (:day1 :day2) :delta 0.8000000000000007 . },
…
    { 0.5 math:greaterThan 0 . },
    { :day6 :next :day7 . },
    { (:day6 :day7) :delta 0.5999999999999996 . },
    { 0.5999999999999996 math:greaterThan 0 . }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 38 steps, 38 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 25; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 13; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 127; pe:failed 0 ].
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
eyeron examples/trend.n3
eyeron -p examples/trend.n3
eyeron -c examples/trend.n3
```

---

## Takeaway

A trend label depends on both the time links and the supplied thresholds.
