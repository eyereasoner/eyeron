# Collecting a workflow's completed tasks

[completed-subtasks-typed.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/completed-subtasks-typed.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/completed-subtasks-typed.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/completed-subtasks-typed.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/completed-subtasks-typed.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=completed-subtasks-typed)

---

## The question

A workflow includes two completed tasks. An N3 rule collects their names into
a list, showing how a type condition and a scoped collection work together.

**Which completed tasks belong in this workflow's result list?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The workflow and its two completed members are supplied facts.
:workflowA a :Workflow ;
    :includes :taskA, :taskB .

# Bind one workflow first, then collect just its completed members.
# The resulting list belongs to that workflow.
{
    ?workflow a :Workflow .
    (
        ?task {
            ?workflow :includes ?task .
            ?task a :Completed
        }
        ?completed
    ) log:collectAllIn ?SCOPE .
} => {
    ?workflow :completed ?completed
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:workflowA :completed (:taskA :taskB) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :workflowA :completed (:taskA :taskB) . }
  pe:rule 1;
  pe:binding
    [ pe:var "completed"; pe:value (:taskA :taskB) ],
    [ pe:var "workflow"; pe:value :workflowA ];
  pe:uses
    { :workflowA a :Workflow . },
    {
        (?task {
            :workflowA :includes ?task .
            ?task a :Completed .
        } (:taskA :taskB)) log:collectAllIn ?SCOPE .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
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
eyeron examples/completed-subtasks-typed.n3
eyeron -p examples/completed-subtasks-typed.n3
eyeron -c examples/completed-subtasks-typed.n3
```

---

## Takeaway

Binding the workflow before collection keeps the list tied to the right
workflow.
