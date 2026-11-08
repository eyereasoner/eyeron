# Completed Tasks

*A task is done when every one of its subtasks is done.*

[task-completion.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/task-completion.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/task-completion.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/task-completion.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/task-completion.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=task-completion)

---

## The question

Two composite tasks are broken into subtasks. A status document lists the
subtasks of each and marks the completed ones. Task 1 has three subtasks, all
completed. Task 2 has two, and the second is not marked completed.

**Which composite tasks are completed?** That needs a rule that says "for
every subtask", not just "for some subtask".

---

## What we tell Eyeron

```n3
:subtasks :graph {
    :task1 :subTask :subtask1 .
    :subtask1 a :Completed .
…
    :task2 :subTask :subtask4 .
    :subtask4 a :Completed .
    :task2 :subTask :subtask5 .
    # :subtask5 a :Completed.
} .
```

The status document is a **quoted graph** in braces: a document held as a
value, not facts of the main graph. The commented-out line is there to try.

```n3
{
    ?Task a :CompositeTask .
    :subtasks :graph ?Graph .
    (
        {
            ?Task :subTask ?Subtask
        }
        {
            ?Subtask a :Completed
        }
    ) log:forAllIn ?Graph .
} => {
    ?Task a :AllTasksCompleted
} .
```

`log:forAllIn` takes a pair of patterns and a graph. It holds when, inside
that graph, *every* match of the first pattern (each subtask of the task) also
satisfies the second (that subtask is completed). This is a universal test,
scoped to one fixed document.

---

## What Eyeron concludes

```n3
:task1 a :AllTasksCompleted .
```

Task 2 is not concluded: subtask 5 is not marked completed.

---

## The proof: a universal test recorded once

```n3
{ :task1 a :AllTasksCompleted . }
  pe:rule 1;
…
{
  ({
      :task1 :subTask ?Subtask .
  } {
      ?Subtask a :Completed .
  }) log:forAllIn {
      :task1 :subTask :subtask1 .
      :subtask1 a :Completed .
…
  } .
}
  pe:builtin log:forAllIn.
```

The "for every subtask" check is a single built-in step that carries the
whole document it ran over.

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
```

Four steps: the rule step, two facts and the built-in step. **C1–C4** confirm
the rule step matches and the argument is complete and not circular; **C7**
that nothing is padding; **C10** that the test was checked as called. **C5
re-decision** re-runs the `log:forAllIn` test over the quoted document, so
the "every subtask" claim is recomputed, not taken on trust.

---

## Try it

```sh
eyeron examples/task-completion.n3
eyeron -c examples/task-completion.n3
```

Uncomment `:subtask5 a :Completed.` (and add a space before the final `.`):
now both tasks are completed.

---

## Takeaway

"Every subtask is done" is a universal claim; scoped to a fixed document it
becomes a test anyone can recompute.
