# Checking every subtask

*A project is done when every one of its parts is done.*

[log-for-all-in.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/log-for-all-in.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/log-for-all-in.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/log-for-all-in.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/log-for-all-in.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=log-for-all-in)

---

## The question

A composite task `:c` is made of three subtasks, and each one is marked
completed. Most rules look for *one* matching case. This one has to make a
claim about *all* of them.

**Are all the subtasks of `:c` completed?**

---

## What we tell Eyeron

```n3
:c a :CompositeTask ;
    :subTask :s1, :s2, :s3 .

:s1 :state :Completed .
:s2 :state :Completed .
:s3 :state :Completed .
```

The `;` repeats the subject and the `,` repeats the subject and predicate, so
the first statement says that `:c` is a composite task with three subtasks.

```n3
{
    ?c a :CompositeTask .
    (
        {
            ?c :subTask ?s
        }
        {
            ?s :state :Completed
        }
    ) log:forAllIn _:t .
} => {
    :result :is true .
} .
```

`log:forAllIn` is a built-in: a test Eyeron decides itself. It takes a list of
two quoted formulas, written in braces. It holds when *for every* way the
first one matches (every subtask `?s` of `?c`), the second one matches too
(`?s` is completed). The object `_:t` names the graph to look in; a blank node
there means the current one.

---

## What Eyeron concludes

```n3
:result :is true .
```

All three subtasks are completed, so the test holds and the rule fires once.

---

## The proof, step by step

```n3
{ :result :is true . }
  pe:rule 1;
  pe:binding [ pe:var "c"; pe:value :c ];
  pe:uses
    { :c a :CompositeTask . },
    {
        ({
            :c :subTask ?s .
        } {
            ?s :state :Completed .
        }) log:forAllIn _:forAllIn .
    }.
…
{ :c a :CompositeTask . }
  pe:fact "log-for-all-in.n3".
```

The answer comes from rule 1 with `c` standing for `:c`. It uses one fact and
one built-in step: the `log:forAllIn` test, recorded with `pe:builtin` so a
checker knows to decide it again rather than take it as given.

---

## Checked: what the report says

```n3
# checked: 3 steps, 3 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
```

- **C1, C2, C3, C4, C7**: the rule step matches rule 1, nothing depends on
  itself, every step is justified, every premise is covered, and nothing is
  padding.
- **C5 re-decision**: the checker re-runs the `log:forAllIn` test itself.
- **C9 search closure**: "for all" is a claim about everything in the graph,
  not just what the proof mentions. The checker settles it over the current
  graph, so no subtask can have been overlooked.
- **C6 boundary consistency** and **C10 call fidelity** each looked at the one
  test: nothing in the proof contradicts it, and it was checked as it was
  called.

All 3 steps were verified and nothing was taken on trust.

---

## Try it

```sh
eyeron examples/log-for-all-in.n3
eyeron -c examples/log-for-all-in.n3
```

Change `:s3 :state :Completed .` to `:s3 :state :Pending .` and run again:
there is no output at all, because one subtask is no longer completed.

---

## Takeaway

`log:forAllIn` lets a rule say "every", and the checker makes sure that
"every" really covered everything in the graph.
