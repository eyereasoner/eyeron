# Following a classification chain 100,000 levels deep

[deep-taxonomy-100000.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/deep-taxonomy-100000.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/deep-taxonomy-100000.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/deep-taxonomy-100000.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/deep-taxonomy-100000.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=deep-taxonomy-100000)

---

## The question

One individual starts in class N0. Forward N3 rules move it through 100,000
classification levels and add side labels; reaching N100000 derives A2 and a
final test result. This provides a deep rule-chain workload.

**Can the individual reach the end of the hundred-thousand-level classification chain?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Start the individual in the first class of the chain.
:ind a :N0 .

# The final test depends on reaching A2 at the far end of the chain.
{
    :ind a :A2
} => {
    :test :is true
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:test :is true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :test :is true . }
  pe:rule 1;
  pe:uses { :ind a :A2 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 100003 steps, 100003 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 100003; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 200005; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

The saved proof is large; write the results to files before inspecting them.

```sh
eyeron examples/deep-taxonomy-100000.n3 > /tmp/deep-taxonomy-100000-output.n3
eyeron -p examples/deep-taxonomy-100000.n3 > /tmp/deep-taxonomy-100000-proof.n3
eyeron -c examples/deep-taxonomy-100000.n3 > /tmp/deep-taxonomy-100000-check.n3
```

---

## References

[Source reference 1](https://web.archive.org/web/20220119222608/http://responder.ruleml.org/WellnessRules/files/WellnessRulesN3-2009-11-10.pdf)

---

## Takeaway

A tiny final answer can have a very large derivation and proof.
