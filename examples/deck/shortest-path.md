# Shortest Path

*Searching a small road map with a queue, a visited list and a final sort.*

[shortest-path.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/shortest-path.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/shortest-path.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/shortest-path.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/shortest-path.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=shortest-path)

---

## The question

Four places, `a` to `d`, are joined by six one-way roads, each with a cost.
One road even leads from `c` back to `a`, so a careless search could go round
in circles forever.

**What is the cheapest way from `a` to `d`, and what does it cost?**

---

## What we tell Eyeron

The roads are facts. A pair `(from to)` is the subject, and the cost is the
object:

```n3
(:a :b) :edge 2 .
(:a :c) :edge 5 .
(:b :c) :edge 1 .
(:b :d) :edge 7 .
(:c :d) :edge 2 .
(:c :a) :edge 1 .
```

The search is written as *backward* rules, `{ head } <= { body }`: to prove
the head, Eyeron proves the body. The entry point starts a queue with one
entry, cost 0 at the start, and an empty visited list:

```n3
{
    (?Start ?Goal) :shortest (?Path ?Cost)
} <= {
    (((0 ?Start)) ?Goal ()) :shortest2 (?RevPath ?Cost) .
    ?RevPath list:reverse ?Path .
} .
```

Each queue entry is a list `(Cost Node ...earlier nodes)`, so the path is
kept backwards and reversed at the end.

---

## How the search works

`:shortest2` has two rules. The first answers when the cheapest entry in the
queue already stands at the goal. The second takes the first entry and
expands it:

```n3
(
    ?L4 {
        ?L4 list:firstRest (?NewCost ?L5) .
        ?L5 list:firstRest (?Neighbor ?L6) .
        ?L6 list:firstRest (?Node ?Path) .
        (?Node ?Neighbor) :edge ?Weight .
        ?Visited list:notMember ?Neighbor .
        (?Cost ?Weight) math:sum ?NewCost .
    }
    ?Neighbors
) log:collectAllIn ?SCOPE .
(?Queue ?Neighbors) list:append ?NewQueue .
?NewQueue list:sort ?SortedQueue .
```

`log:collectAllIn` gathers, in one list, a new entry for every road out of
the node to a place not yet visited. These join the rest of the queue,
`list:sort` puts the cheapest first, the node is added to the visited list,
and the search goes on. The visited list is what stops the `c` to `a` road
from sending the search round the loop.

Both rules can apply to the same queue, so the search does not stop at the
first arrival: it finds every way to `d` that it reaches, which here costs 5,
7 or 9. A forward rule collects those costs, sorts them, and keeps the first:

```n3
?costs list:sort ?sorted .
?sorted list:firstRest (?best ?rest) .
(:a :d) :shortest (?bestPath ?best) .
```

---

## What Eyeron concludes

```n3
:test :bestCost 5 .
:test :bestPath (:a :b :c :d) .
```

Going `a`, `b`, `c`, `d` costs 2 + 1 + 2 = 5, cheaper than `a`, `c`, `d`
(5 + 2 = 7) or `a`, `b`, `d` (2 + 7 = 9).

---

## The proof: the search, step by step

The proof has 40 steps: 8 rule steps and 32 built-in steps (list operations,
sums and the sorts). It begins with the final rule, which cites the
collected costs and the winning path:

```n3
{ :test :bestCost 5 . }
  pe:rule 4;
  pe:binding
    [ pe:var "best"; pe:value 5 ],
    [ pe:var "bestPath"; pe:value (:a :b :c :d) ],
    [ pe:var "costs"; pe:value (5 7 9) ],
…
```

and then follows the search one queue at a time. The first expansion, from
`a`, shows the new entries for `b` (cost 2) and `c` (cost 5):

```n3
{ (((0 :a)) :d ()) :shortest2 ((:d :c :b :a) 5) . }
  pe:rule 3;
…
    [ pe:var "Neighbors"; pe:value ((2 :b :a) (5 :c :a)) ],
…
    { ((2 :b :a) (5 :c :a)) list:sort ((2 :b :a) (5 :c :a)) . },
```

---

## Checked, with one obligation

```n3
# checked with obligations: 40 steps, 39 verified, 1 trusted
pe:verdict pe:checkedWithObligations;
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 32; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 5; pe:failed 0 ];
```

- **C1 resolution** checked the 8 rule steps against the program's rules, and
  **C2**, **C3**, **C4** and **C7** confirmed that the steps are well-founded,
  justified, complete and all needed.
- **C5 re-decision** recomputed all 32 built-in steps: every sum, sort,
  append, reversal and list split.
- **C9 search closure** examined the 5 collections. The 4 lists of new queue
  entries read only the road facts given in the program, so the checker can
  settle them: each list is known to be complete. **C6** found nothing in the
  proof that contradicts any of the 5.
- **C10 call fidelity** confirmed that the 8 backward calls were checked as
  the program made them.

One step is trusted: the outer collection, *the costs of all paths from `a`
to `d` are exactly 5, 7 and 9*. It collects over `:shortest`, which backward
rules give, and a search certificate cannot settle that. It stays an
obligation of kind `collected`:

```n3
pe:kind "collected";
```

The checker confirms the path of cost 5 exists, but taking it as the
*cheapest* relies on that list being complete. So the verdict is
**checked with obligations**: the answer holds if that collection holds.

---

## Try it

```sh
eyeron examples/shortest-path.n3      # the answer
eyeron -p examples/shortest-path.n3   # the answer with its proof
eyeron -c examples/shortest-path.n3   # the proof, checked
```

Add a direct road `(:a :d) :edge 4 .` and run again: the best cost becomes 4,
along the path `(:a :d)`.

---

## Takeaway

Rules can run a real search algorithm, queue and all, and the proof records
each expansion; the checker re-does the arithmetic and sorting, and says
plainly which completeness claim it had to take on trust.
