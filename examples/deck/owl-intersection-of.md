# Intersection Of

*A working student is a student who works, and a student who works is a working student.*

[owl-intersection-of.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-intersection-of.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-intersection-of.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-intersection-of.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-intersection-of.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-intersection-of)

---

## The question

OWL can define a class as the intersection of others: a *working student*
is exactly someone who is both a student and a worker.

Alice is said to be a working student. Bob is said to be a student and a
worker.

**What else is Alice, and is Bob a working student?**

---

## What we tell Eyeron

```n3
:WorkingStudent owl:intersectionOf (:Student :Worker) .
:alice a :WorkingStudent .
:bob a :Student, :Worker .
```

The classes are given as a list, `(:Student :Worker)`. The first rule goes
from the intersection to its parts, using the built-in `list:in` to visit
each class in the list:

```n3
{
    ?C owl:intersectionOf ?L .
    ?X a ?C .
    ?D list:in ?L
} => {
    ?X a ?D
} .
```

The third rule goes the other way. It takes a candidate from the first class
in the list, then checks that the candidate belongs to *all* of them:

```n3
{
    ?C owl:intersectionOf ?L .
    ?L list:first ?First .
    ?X a ?First .
    (
        {
            ?D list:in ?L
        }
        {
            ?X a ?D
        }
    ) log:forAllIn ?SCOPE
} => {
    ?X a ?C
} .
```

`log:forAllIn` reads: for every `?D` in the list, `?X a ?D` must hold in
the current graph, everything Eyeron knows at that moment. A second rule,
not shown, makes the intersection a subclass of each part.

---

## What Eyeron concludes

```n3
:alice a :Student .
:alice a :Worker .
:bob a :WorkingStudent .
:WorkingStudent rdfs:subClassOf :Student .
:WorkingStudent rdfs:subClassOf :Worker .
```

---

## The proof, step by step

Alice is a student by rule 1, with `list:in` as a built-in step:

```n3
{ :alice a :Student . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :WorkingStudent ],
    [ pe:var "D"; pe:value :Student ],
    [ pe:var "L"; pe:value (:Student :Worker) ],
    [ pe:var "X"; pe:value :alice ];
  pe:uses
    { :WorkingStudent owl:intersectionOf (:Student :Worker) . },
    { :alice a :WorkingStudent . },
    { :Student list:in (:Student :Worker) . }.

{ :Student list:in (:Student :Worker) . }
  pe:builtin list:in.
```

Bob is a working student by rule 3, whose last premise is the universal
test with Bob filled in:

```n3
{ :bob a :WorkingStudent . }
  pe:rule 3;
…
  pe:uses
    { :WorkingStudent owl:intersectionOf (:Student :Worker) . },
    { (:Student :Worker) list:first :Student . },
    { :bob a :Student . },
    {
        ({
            ?D list:in (:Student :Worker) .
        } {
            :bob a ?D .
        }) log:forAllIn _:forAllIn .
    }.
```

The proof has 12 steps: 5 rule steps, 3 given facts and 4 built-in steps.

---

## Checked: what the report says

```n3
# checked with obligations: 12 steps, 11 verified, 1 trusted
pe:verdict pe:checkedWithObligations;
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 4; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
    pe:obligation [
        pe:kind "collected";
```

- **C1–C4**, **C7** and **C10**: each step is what it cites, without
  cycles, every premise resolves, every step serves a claim, and each test
  is the call its rule makes.
- **C5 re-decision** recomputed the built-in steps: `list:in` and
  `list:first` really give those values.
- The `log:forAllIn` test about Bob depends on the whole current graph.
  **C9 search closure** examined it but could not settle it: the rule that
  contains the test itself concludes `a` statements, the very kind the test
  reads, and a certificate cannot settle a test that feeds back into itself.
- So it remains one **obligation** of kind `collected`, and the answers are
  conditional on it. **C6 boundary consistency** confirmed that nothing in
  the proof contradicts it.

Eleven steps are verified; one is taken on trust, and the report says which.

---

## Try it

```sh
eyeron examples/owl-intersection-of.n3      # the conclusions
eyeron -p examples/owl-intersection-of.n3   # with the proof
eyeron -c examples/owl-intersection-of.n3   # the proof, checked
```

Add `:carol a :Student .` and run again: nothing new about Carol appears,
because she is not known to be a worker, so the universal test fails for
her.

---

## Takeaway

An intersection works in both directions, and the direction that needs
"all of them" is the one whose proof keeps an honest obligation.
