# Bounding a capacitor's discharge

[rc-discharge-envelope.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rc-discharge-envelope.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/rc-discharge-envelope.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rc-discharge-envelope.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rc-discharge-envelope.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rc-discharge-envelope.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rc-discharge-envelope)

---

## The question

A sampled capacitor model supplies an initial voltage and an upper decay
factor. N3 arithmetic rules derive voltage bounds at candidate steps and check
when the tolerance is met.

**Which candidate step first has a supplied upper-voltage envelope below tolerance?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The companion input supplies the decay bound. At each candidate index,
# raise that bound to the index and multiply by the initial voltage.
{
    :case :initialVoltage ?Initial ;
        :decayUpper ?DecayUpper ;
        :candidateStep ?Step .
    ?Step :index ?Index .
    (?DecayUpper ?Index) math:exponentiation ?Factor .
    (?Initial ?Factor) math:product ?Voltage .
} => {
    ?Step :upperVoltage ?Voltage .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The companion input supplies additional facts; load it
together with the rules in the commands below.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
exact decay symbol : exp(-1/4)
certified decay interval : [0.7788007830, 0.7788007831]
first below tolerance step : 13
first below tolerance time : 0.325 s
upper voltage at step 13 : 0.930581 V
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :step12 :upperVoltage 1.1948896413552061 . }
  pe:rule 1;
  pe:binding
    [ pe:var "DecayUpper"; pe:value 0.7788007831 ],
    [ pe:var "Factor"; pe:value 0.04978706838980025 ],
    [ pe:var "Index"; pe:value 12 ],
    [ pe:var "Initial"; pe:value 24 ],
    [ pe:var "Step"; pe:value :step12 ],
    [ pe:var "Voltage"; pe:value 1.1948896413552061 ];
  pe:uses
    { :case :initialVoltage 24 . },
    { :case :decayUpper 0.7788007831 . },
    { :case :candidateStep :step12 . },
    { :step12 :index 12 . },
    { (0.7788007831 12) math:exponentiation 0.04978706838980025 . },
    { (24 0.04978706838980025) math:product 1.1948896413552061 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 28 steps, 28 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 19; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 7; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/rc-discharge-envelope.n3 examples/input/rc-discharge-envelope.trig
eyeron -p examples/rc-discharge-envelope.n3 examples/input/rc-discharge-envelope.trig
eyeron -c examples/rc-discharge-envelope.n3 examples/input/rc-discharge-envelope.trig
```

---

## Takeaway

The finite crossing check uses the supplied decay bound and predecessor
records.
