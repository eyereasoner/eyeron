# Counting Backward

*To count to ten, first count to nine.*

[backward-counting.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/backward-counting.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/backward-counting.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/backward-counting.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/backward-counting.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=backward-counting)

---

## The question

Alice can count to one. Anyone who can count to a number can also count to
the next one. We do not want to list every number she can reach; we want to
ask about one and have the reasoner work it out.

**Can Alice count to ten?**

---

## What we tell Eyeron

```n3
:alice :canCountTo 1 .
```

The one fact.

```n3
{
    ?x :canCountTo ?s .
} <= {
    ?s math:greaterThan 1 .
    (?s 1) math:difference ?n .
    ?x :canCountTo ?n .
} .
```

A **backward rule** (`<=`: conclusion above, condition below), used only
when a question is asked. It reads: *x can count to s if s is greater than 1,
n is s minus 1, and x can count to n.* `math:greaterThan` and
`math:difference` are **built-ins**: Eyeron calculates them. The last line
asks the same kind of question for a smaller number, so the rule is
**recursive**, and the check `s > 1` lets it stop at the fact for 1.

```n3
{
    :alice :canCountTo 10
} => {
    :TEST :PASS 1
} .
```

A forward rule asks about ten and records a passing test.

---

## What Eyeron concludes

```n3
:TEST :PASS 1 .
```

---

## The proof, step by step

The proof has 29 steps: one for the passing test, ten for *Alice can count
to 10, 9, …, 1*, and two calculations for each of the nine numbers above one.
The first rungs:

```n3
{ :alice :canCountTo 10 . }
  pe:rule 1;
  pe:binding
    [ pe:var "n"; pe:value 9 ],
    [ pe:var "s"; pe:value 10 ],
    [ pe:var "x"; pe:value :alice ];
  pe:uses
    { 10 math:greaterThan 1 . },
    { (10 1) math:difference 9 . },
    { :alice :canCountTo 9 . }.

{ 10 math:greaterThan 1 . }
  pe:builtin math:greaterThan.

{ (10 1) math:difference 9 . }
  pe:builtin math:difference.
…
{ :alice :canCountTo 1 . }
  pe:fact "backward-counting.n3".
```

Each rung uses the rule once: 10 is above 1, 10 minus 1 is 9, and Alice can
count to 9. The ladder ends at the one fact we gave.

---

## Checked: what the report says

```n3
# checked: 29 steps, 29 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 11; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 18; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 10; pe:failed 0 ].
```

- **C1 resolution**: the ten rule steps re-perform their rules, and the
  starting fact is in the file.
- **C5 re-decision**: all 18 calculations are redone by the checker; a proof
  claiming `(10 1) math:difference 8` would fail here.
- **C10 call fidelity**: the calls each rule step uses are the ones its rule
  makes.
- **C2 well-foundedness**: the recursion really does bottom out; no step
  depends on itself.

Verdict: **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/backward-counting.n3      # the answer
eyeron -p examples/backward-counting.n3   # the answer with its proof
eyeron -c examples/backward-counting.n3   # the proof, checked
```

Change `10` to `40` in the forward rule. Eyeron now stops with *reasoning
incomplete (limits reached: backward-depth limit)*, because recursion is
limited to a depth of 32 by default. `eyeron --max-backward-depth 64` with
the changed file prints the passing test again.

---

## Takeaway

A recursive rule with a stopping condition replaces an endless list of facts,
and every rung of the climb is recorded and recomputed by the checker.
