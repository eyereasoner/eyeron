# Tasks Not Discarded

*Asking what a document does not say, without the answer shifting later.*

[task-not-discarded.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/task-not-discarded.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/task-not-discarded.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/task-not-discarded.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/task-not-discarded.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=task-not-discarded)

---

## The question

A project has two composite tasks. A separate document, the task list, records
facts about them, and would say so if a task had been discarded. It says no
such thing.

**Which tasks are not discarded, according to that document?**

Asking about something *absent* is tricky for a reasoner: if more facts can
still be derived, "not found yet" might not mean "not there". This example
avoids the problem by asking about one fixed, quoted document.

---

## What we tell Eyeron

```n3
:task1 a :CompositeTask .
:task2 a :CompositeTask .
:tasks :graph {
    :task1 a :CompositeTask .
    :task2 a :CompositeTask .
} .
```

The braces `{ … }` make a **quoted graph**: a document held as a value. Its
statements are not asserted as facts of the main graph; they are the content
of `:tasks :graph`.

```n3
{
    ?Task a :CompositeTask .
    :tasks :graph ?Graph .
    ?Graph log:notIncludes {
        ?Task a :DiscardedTask
    }
} => {
    ?Task a :NotDiscardedTask
} .
```

`log:notIncludes` is a built-in test: it holds when the first graph does not
contain the pattern in the second. Since the quoted document never changes,
the answer is settled once and for all.

---

## What Eyeron concludes

```n3
:task1 a :NotDiscardedTask .
:task2 a :NotDiscardedTask .
```

---

## The proof: an absence decided as a calculation

```n3
{ :task1 a :NotDiscardedTask . }
  pe:rule 1;
  pe:binding
    [ pe:var "Graph"; pe:value {
        :task1 a :CompositeTask .
        :task2 a :CompositeTask .
    } ],
    [ pe:var "Task"; pe:value :task1 ];
…
{
  {
      :task1 a :CompositeTask .
      :task2 a :CompositeTask .
  } log:notIncludes {
      :task1 a :DiscardedTask .
  } .
}
  pe:builtin log:notIncludes.
```

The absence is recorded as a built-in step over the quoted document itself,
with the whole document in view, so there is nothing to assume about facts
that might turn up later.

---

## Checked: what the report says

```n3
# checked: 7 steps, 7 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
```

The 7 steps are 2 rule steps, 3 facts and 2 built-in steps. **C1** confirms
each rule step matches the rule, **C2–C4** that the argument is complete and
not circular, **C7** that every step serves an answer. **C5 re-decision**
looks inside each quoted document again and confirms that it really lacks
the discarded statement; **C10** confirms each test was checked as called.
Nothing is taken on trust: no obligation about missing facts is needed,
because the question was about a fixed document.

---

## Try it

```sh
eyeron examples/task-not-discarded.n3
eyeron -c examples/task-not-discarded.n3
```

Add `:task1 a :DiscardedTask .` inside the braces of `:tasks :graph`: only
`:task2 a :NotDiscardedTask .` remains.

---

## Takeaway

Asking what a fixed, quoted document does not contain is an ordinary,
recomputable test, so even a "no" can be checked without trust.
