# Exploring the four-digit Kaprekar routine

[kaprekar-6174.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/kaprekar-6174.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/kaprekar-6174.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/kaprekar-6174.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/kaprekar-6174.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=kaprekar-6174)

---

## The question

Four-digit strings, including leading zeros, are repeatedly sorted in opposite
orders and subtracted. N3 rules build the resulting sequences and report their
behavior around 6174 and the repeated-digit cases.

**Which four-digit starts reach 6174, and which collapse to zero?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Define the digit list ONCE (avoid repeating a list literal 4 times)
:digitList :items (0 1 2 3 4 5 6 7 8 9) .

# 1 step
{
    ?n log:notEqualTo 6174 .
    ?n kap:step 6174 .

    # exclude repdigits/0 basin:
    ?n log:notEqualTo 0 .
} => {
    ?n :kaprekar (6174) .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
1 :kaprekar (999 8991 8082 8532 6174) .
10 :kaprekar (999 8991 8082 8532 6174) .
9997 :kaprekar (1998 8082 8532 6174) .
9998 :kaprekar (999 8991 8082 8532 6174) .
100 :kaprekar (999 8991 8082 8532 6174) .
1000 :kaprekar (999 8991 8082 8532 6174) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ 1 :kaprekar (999 8991 8082 8532 6174) . }
  pe:rule 6;
  pe:binding
    [ pe:var "n"; pe:value 1 ],
    [ pe:var "s1"; pe:value 999 ],
    [ pe:var "s2"; pe:value 8991 ],
    [ pe:var "s3"; pe:value 8082 ],
    [ pe:var "s4"; pe:value 8532 ];
  pe:uses
    { 1 log:notEqualTo 6174 . },
    { 1 log:notEqualTo 0 . },
    { 1 kap:step 999 . },
    { 999 log:notEqualTo 0 . },
    { 999 log:notEqualTo 6174 . },
    { 999 kap:step 8991 . },
    { 8991 log:notEqualTo 0 . },
    { 8991 log:notEqualTo 6174 . },
    { 8991 kap:step 8082 . },
    { 8082 log:notEqualTo 0 . },
    { 8082 log:notEqualTo 6174 . },
    { 8082 kap:step 8532 . },
    { 8532 log:notEqualTo 0 . },
    { 8532 log:notEqualTo 6174 . },
    { 8532 kap:step 6174 . }.
```

`pe:rule 6` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 61101 steps, 61101 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 19980; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 41121; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 369659; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

The saved proof is large; write the results to files before inspecting them.

```sh
eyeron examples/kaprekar-6174.n3 > /tmp/kaprekar-6174-output.n3
eyeron -p examples/kaprekar-6174.n3 > /tmp/kaprekar-6174-proof.n3
eyeron -c examples/kaprekar-6174.n3 > /tmp/kaprekar-6174-check.n3
```

---

## Takeaway

Leading zeros and repeated digits affect the finite routine; the full result
is larger than a single demonstration chain.
