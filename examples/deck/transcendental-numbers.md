# Applying encoded transcendence theorems

[transcendental-numbers.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/transcendental-numbers.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/transcendental-numbers.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/transcendental-numbers.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/transcendental-numbers.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=transcendental-numbers)

---

## The question

A small symbolic model records number properties and selected theorem
implications. N3 rules derive supported transcendental classifications and
associate each result with its encoded mathematical justification.

**Which expressions meet the encoded transcendence conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# A link to the essay
:source a :WebPage ;
    rdfs:label "Transcendental Numbers: When a Number Refuses to Be “the Solution of an Equation”" ;
    :url <https://josd.github.io/temp/transcendental-numbers/> .

# Inference rules
# Lindemann–Weierstrass (friendly slogan form)
{
    ?X :expArg ?A .
    ?A :kind :Algebraic .
    ?A :kind :NonZero .
} => {
    ?X :kind :Transcendental .
    ?X :provedBy :LindemannWeierstrass .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:report :concerns :prod_e_pi .
:report :concerns :sum_e_pi .
:report :unknown :prod_e_pi .
:report :unknown :sum_e_pi .
:report :headline :quadraticTrick .
:report :proof {
    :e :provedBy :Hermite1873 .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :report :transcendental :e . }
  pe:rule
    {
        {
            ?X :kind :Transcendental .
        } => {
            :report :transcendental ?X .
        } .
    };
  pe:binding [ pe:var "X"; pe:value :e ];
  pe:uses { :e :kind :Transcendental . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 68 steps, 68 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 68; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 170; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/transcendental-numbers.n3
eyeron -p examples/transcendental-numbers.n3
eyeron -c examples/transcendental-numbers.n3
```

---

## Takeaway

The result identifies the theorem facts used by the model; those facts are its
assumptions.
