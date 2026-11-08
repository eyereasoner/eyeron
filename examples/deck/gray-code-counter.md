# Following a three-bit Gray-code counter

*A small digital circuit, simulated gate by gate with rules.*

[gray-code-counter.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/gray-code-counter.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/gray-code-counter.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/gray-code-counter.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/gray-code-counter.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=gray-code-counter)

---

## The question

A Gray-code counter steps through all eight three-bit values so that only one
bit changes per step. That is handy in hardware: a reading taken mid-change
is never wildly off. This counter is built from AND and OR gates, inverters
and three D flip-flops (one-bit memories that copy their input when the clock
ticks).

**Starting from 000, which states does the circuit go through on nine clock
ticks?**

---

## What we tell Eyeron

The gates are plain truth tables:

```n3
(0 0) :and 0 .
(0 1) :and 0 .
(1 0) :and 0 .
(1 1) :and 1 .
…
0 :inv 1 .
1 :inv 0 .
```

`(0 1)` is a list; `(0 1) :and 0` reads *"0 AND 1 is 0"*.

A flip-flop is two rules written backwards, with `<=`: *the conclusion holds
if the condition does*. `true` means "always":

```n3
{
    (?D 0 ?Q) :dff ?Q
} <= true .

{
    (?D 1 ?Q) :dff ?D
} <= true .
```

With the clock at 0 it keeps its state `Q`; at 1 it takes its input `D`.

One tick of the whole counter wires the next-state logic to the flip-flops:

```n3
{
    (?C (?Qa ?Qb ?Qc)) :gcc (?Za ?Zb ?Zc)
} <= {
    (?Qa ?Qb ?Qc) :netb (?D1 ?D2) .
    (?Qa ?Qb) :neta ?D3 .
    (?D1 ?C ?Qa) :dff ?Za .
    (?D2 ?C ?Qb) :dff ?Zb .
    (?D3 ?C ?Qc) :dff ?Zc .
} .
```

`:neta` and `:netb` are small gate networks, defined the same way from the
truth tables. Finally `:testgcc` walks a list of clock values, using
`list:firstRest` to split a list into its first item and the rest, and one
forward rule asks the question:

```n3
{
    ((1 1 1 1 1 1 1 1 1) (0 0 0)) :testgcc ?Q
} => {
    ((1 1 1 1 1 1 1 1 1) (0 0 0)) :isgcc ?Q
} .
```

---

## What Eyeron concludes

```n3
((1 1 1 1 1 1 1 1 1) (0 0 0)) :isgcc ((0 0 1) (0 1 1) (0 1 0) (1 1 0) (1 1 1) (1 0 1) (1 0 0) (0 0 0) (0 0 1)) .
```

001, 011, 010, 110, 111, 101, 100, 000: all eight values, one bit flipping at
a time, then back to the start. The ninth tick begins the cycle again.

---

## The proof, step by step

The proof runs from the answer down to the gates. Here is the first tick,
from 000 to 001:

```n3
{ (1 (0 0 0)) :gcc (0 0 1) . }
  pe:rule 5;
…
  pe:uses
    { (0 0 0) :netb (0 0) . },
    { (0 0) :neta 1 . },
    { (0 1 0) :dff 0 . },
    { (0 1 0) :dff 0 . },
    { (1 1 0) :dff 1 . }.
```

and below it, the gate network for the first two bits rests on truth-table
facts:

```n3
{ (0 0 0) :netb (0 0) . }
  pe:rule 4;
…
  pe:uses
    { (0 0) :and 0 . },
    { 0 :inv 1 . },
    { (0 1) :and 0 . },
    { 0 :inv 1 . },
    { (1 0) :and 0 . },
    { (0 0) :or 0 . },
    { (0 0) :or 0 . }.
```

There are 62 steps: 35 rule steps, 9 truth-table facts and 18
`list:firstRest` calls. Steps already proved are cited, not repeated, which
keeps nine ticks of a circuit short.

---

## Checked: what the report says

```n3
# checked: 62 steps, 62 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 44; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 18; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 35; pe:failed 0 ].
```

- **C1 resolution**: the 35 rule steps and 9 fact steps match the program.
- **C5 re-decision**: all 18 list splits were recomputed by the checker.
- **C2–C4, C7**: no circular reasoning, every premise covered, nothing
  irrelevant.
- **C10 call fidelity**: 35 times, a conclusion was checked against the call
  that asked for it, so each answer fits the question as it was posed.

Nothing is taken on trust: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/gray-code-counter.n3
eyeron -c examples/gray-code-counter.n3
```

Replace both clock lists `(1 1 1 1 1 1 1 1 1)` with `(1 0 1 0 1)`: the
counter now holds its state on every 0, giving
`((0 0 1) (0 0 1) (0 1 1) (0 1 1) (0 1 0))`.

---

## Takeaway

Truth tables and a few rules are enough to simulate a clocked circuit, and the
proof traces every output bit back to the gates that produced it.
