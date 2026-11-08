# Extending symbolic number classifications

[transcendental-numbers-stretched.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/transcendental-numbers-stretched.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/transcendental-numbers-stretched.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/transcendental-numbers-stretched.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/transcendental-numbers-stretched.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=transcendental-numbers-stretched)

---

## The question

Symbolic expressions combine known number classes with arithmetic
constructions. N3 rules apply encoded theorem implications and closure
properties to derive further classifications and their supporting reasons.

**Which further classifications follow from the modeled closure properties?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Kinds / tags
:Algebraic a :Kind .

# Theorems as rules
# Lindemann–Weierstrass (slogan): exp(algebraic nonzero) is transcendental
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

An excerpt of the saved text report:

```text
@prefix : <https://example.org/transcendental#> .
:report :concerns :prod_e_pi .
:report :concerns :sum_e_pi .
:report :headline :quadraticTrick .
:report :irrational :e .
:report :irrational :e_div_2 .
:report :irrational :e_plus_1 .
:report :irrational :e_plus_2 .
:report :irrational :exp_minus_pi_over_2 .
:report :irrational :exp_sqrt2 .
:report :irrational :half_times_e .
:report :irrational :half_times_pi .
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
# checked: 316 steps, 316 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 316; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 974; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/transcendental-numbers-stretched.n3
eyeron -p examples/transcendental-numbers-stretched.n3
eyeron -c examples/transcendental-numbers-stretched.n3
```

---

## Takeaway

Each symbolic classification depends on a stated mathematical implication and
its premises.
