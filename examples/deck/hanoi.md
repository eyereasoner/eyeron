# Solving a three-disk Towers of Hanoi puzzle

*An old puzzle, solved by a rule that calls itself.*

[hanoi.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/hanoi.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/hanoi.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/hanoi.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/hanoi.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=hanoi)

---

## The question

Three disks sit on the left peg, largest at the bottom. Move them all to the
right peg, one disk at a time, never putting a larger disk on a smaller one.
The centre peg can be used along the way.

**Which moves solve it?**

---

## What we tell Eyeron

The classic recursive idea: to move N disks from X to Y, first move N−1 disks
out of the way to the spare peg Z, then move the largest disk to Y, then move
the N−1 disks from Z onto it.

```n3
{
    (?N ?X ?Y ?Z) :moves ?M
} <= {
    ?N math:greaterThan 1 .
    (?N 1) math:difference ?N1 .
    (?N1 ?X ?Z ?Y) :moves ?M1 .
    (?N1 ?Z ?Y ?X) :moves ?M2 .
    (?M1 ((?X ?Y)) ?M2) list:append ?M .
} .
```

This rule is written with `<=`: *the conclusion on the left holds if the
conditions on the right do*. Eyeron uses such a rule **backward**, only when it
needs a `:moves` fact, which makes the recursion natural. `math:difference`
and `list:append` are built-ins that subtract and join lists.

A single disk just moves (`true` means "always"):

```n3
{
    (1 ?X ?Y ?Z) :moves ((?X ?Y))
} <= true .
```

And one forward rule asks for three disks:

```n3
{
    (3 :left :right :center) :moves ?M
} => {
    3 :answer ?M
} .
```

---

## What Eyeron concludes

```n3
3 :answer ((:left :right) (:left :center) (:right :center) (:left :right) (:center :left) (:center :right) (:left :right)) .
```

Seven moves, each a `(from to)` pair: the shortest solution, 2³ − 1 moves.

---

## The proof, step by step

The top of the proof splits the task exactly as the rule says:

```n3
{ (3 :left :right :center) :moves ((:left :right) (:left :center) (:right :center) (:left :right) (:center :left) (:center :right) (:left :right)) . }
  pe:rule 1;
…
  pe:uses
    { 3 math:greaterThan 1 . },
    { (3 1) math:difference 2 . },
    { (2 :left :center :right) :moves ((:left :right) (:left :center) (:right :center)) . },
    { (2 :center :right :left) :moves ((:center :left) (:center :right) (:left :right)) . },
```

Two disks to the centre, the big one across, two disks on top. The two-disk
tasks split the same way, down to single moves. There are 14 steps: 7 rule
steps and 7 built-in calls. A one-disk move needed twice is proved once and
cited twice.

---

## Checked: what the report says

```n3
# checked: 14 steps, 14 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 7; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 7; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 7; pe:failed 0 ].
```

- **C1 resolution**: each rule step matches its rule.
- **C5 re-decision**: the checker redid every comparison, subtraction and
  list join.
- **C10 call fidelity**: each backward call was answered as it was asked.
- **C2–C4, C7**: no circularity, full coverage, nothing irrelevant.

The verdict is **checked**. It confirms that this sequence follows from the
rules; whether it is legal and shortest follows from the recursive idea, not
from a separate check.

---

## Try it

```sh
eyeron examples/hanoi.n3
eyeron -p examples/hanoi.n3
```

Change both `3`s in the last rule to `4`: the answer becomes 15 moves.

---

## Takeaway

A backward rule that calls itself is a natural way to state a recursive
solution, and its proof is the recursion tree, laid out step by step.
