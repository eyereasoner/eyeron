# Completing a composite task

[completed-subtasks.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/completed-subtasks.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/completed-subtasks.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/completed-subtasks.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/completed-subtasks.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=completed-subtasks)

---

## The question

A task has two subtasks, both marked completed. An N3 rule uses a scoped
universal test to derive that the composite task is also completed.

**Are all of this composite task's subtasks completed?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The two subtask links define which completions the parent needs.
:taskA a :CompositeTask ;
    :subtask :taskA1 ;
    :subtask :taskA2 .

# For every subtask of this task, require a Completed fact in this scope.
# This is a universal test; it does not count the subtasks.
{
    ?task a :CompositeTask .
    (
        {
            ?task :subtask ?subtask
        }
        {
            ?subtask a :Completed
        }
    ) log:forAllIn ?SCOPE .
} => {
    ?task a :Completed
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:taskA a :Completed .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :taskA a :Completed . }
  pe:rule 1;
  pe:binding
    [ pe:var "SCOPE"; pe:value _:forAllIn ],
    [ pe:var "task"; pe:value :taskA ];
  pe:uses
    { :taskA a :CompositeTask . },
    {
        ({
            :taskA :subtask ?subtask .
        } {
            ?subtask a :Completed .
        }) log:forAllIn _:forAllIn .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 3 steps, 2 verified, 1 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ];
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
eyeron examples/completed-subtasks.n3
eyeron -p examples/completed-subtasks.n3
eyeron -c examples/completed-subtasks.n3
```

---

## Takeaway

A scoped universal test expresses a condition over every linked subtask.
