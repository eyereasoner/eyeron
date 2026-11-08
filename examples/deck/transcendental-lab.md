# Classifying symbolic number expressions

[transcendental-lab.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/transcendental-lab.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/transcendental-lab.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/transcendental-lab.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/transcendental-lab.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=transcendental-lab)

---

## The question

Expression nodes describe algebraic and transcendental constructions. N3 rules
apply explicitly encoded theorem implications to derive supported
classifications and leave unsupported cases without such a proof.

**Which expressions can be classified by the supplied theorem rules?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Tags / kinds
:Algebraic a :Kind .

# Expression vocabulary (structure only)
# exp(x) means e^x
# :E :expArg :x
# pow(a,b) means a^b
# :E :powBase :a; :powExp :b
# plus(x,a), times(x,a), div(x,a) are binary constructors
# Core theorem rules
# Lindemann–Weierstrass (slogan form): exp(algebraic nonzero) transcendental
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
:report :irrational :e .
:report :irrational :e_div_2 .
:report :unknown :prod_e_pi .
:report :unknown :sum_e_pi .
:report :irrational :e_plus_2 .
:report :irrational :exp_sqrt2 .
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
# checked: 134 steps, 134 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 134; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 405; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/transcendental-lab.n3
eyeron -p examples/transcendental-lab.n3
eyeron -c examples/transcendental-lab.n3
```

---

## Takeaway

A missing classification records the limits of this rulebook, rather than a
mathematical refutation.
