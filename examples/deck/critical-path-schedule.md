# Finding a project's critical tasks

[critical-path-schedule.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/critical-path-schedule.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/critical-path-schedule.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/critical-path-schedule.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/critical-path-schedule.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=critical-path-schedule)

---

## The question

Tasks have durations and dependencies. Backward N3 rules enumerate dependency
paths, and scoped collection selects the longest completion time and the tasks
that lie on critical paths.

**When can the project finish, and which tasks lie on its longest paths?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Task durations use the same arbitrary time unit; staffing is unlimited.
:requirements :duration 2 .

# Collect all path durations for a task; its longest path gives its finish.
{
    ?task :duration ?_ .
    (
        ?candidate {
            ?task :durationPath (?p ?candidate)
        }
        ?candidates
    ) log:collectAllIn ?SCOPE .
    ?candidates list:sort ?sorted .
    ?sorted list:last ?maxFinish .
} => {
    ?task :finish ?maxFinish
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:requirements :finish 2 .
:architecture :finish 5 .
:test :projectFinish 23 .
:load_test :schedule (19 21) .
:launch :schedule (22 23) .
:api_design :finish 4 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :requirements :finish 2 . }
  pe:rule 3;
  pe:binding
    [ pe:var "_"; pe:value 2 ],
    [ pe:var "candidates"; pe:value (2) ],
    [ pe:var "maxFinish"; pe:value 2 ],
    [ pe:var "sorted"; pe:value (2) ],
    [ pe:var "task"; pe:value :requirements ];
  pe:uses
    { :requirements :duration 2 . },
    {
        (?candidate {
            :requirements :durationPath (?p ?candidate) .
        } (2)) log:collectAllIn ?SCOPE .
    },
    { (2) list:sort (2) . },
    { (2) list:last 2 . }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 119 steps, 107 verified, 12 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 54; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 65; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 13; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 37; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `collected`.

---

## Try it

```sh
eyeron examples/critical-path-schedule.n3
eyeron -p examples/critical-path-schedule.n3
eyeron -c examples/critical-path-schedule.n3
```

---

## Takeaway

The longest dependency path sets the finish time under the example's
unlimited-staff assumption.
