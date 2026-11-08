# Composing one-to-one functions

[composition-of-injective-functions-is-injective.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/composition-of-injective-functions-is-injective.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/composition-of-injective-functions-is-injective.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/composition-of-injective-functions-is-injective.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/composition-of-injective-functions-is-injective.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=composition-of-injective-functions-is-injective)

---

## The question

Functions are represented by input-output relations, with explicit injectivity
and composition facts. N3 rules propagate equality consequences and
demonstrate injectivity for the supplied composition.

**How do the supplied injectivity and composition facts constrain equal outputs?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Tiny example data
# We declare two injective functions f and g, and their
# composition h = g ∘ f.
#
# The data below says:
…
#
# So h sends a and b to the same value only because
# the framework forces a = b.
:a :inX true .

# Carrier membership
# We use:
#
# ?x :inX true.
# ?y :inY true.
# ?z :inZ true.
#
# for the three sets involved.
# Basic facts about provable sameness
# Reflexivity on each carrier
{
    ?x :inX true .
} => {
    (?x ?x) :sameTerm true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The ellipsis omits part of the source; the linked file
contains the full program.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:result :sameInputByCompositeInjectivity (:h :a :b) .
:result :sameInputByCompositeInjectivity (:h :b :a) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :sameInputByCompositeInjectivity (:h :a :b) . }
  pe:rule
    {
        {
            (?h ?x ?y) :sameInputUnderEqualCompositeOutput true .
            ?x log:notEqualTo ?y .
        } => {
            :result :sameInputByCompositeInjectivity (?h ?x ?y) .
        } .
    };
  pe:binding
    [ pe:var "h"; pe:value :h ],
    [ pe:var "x"; pe:value :a ],
    [ pe:var "y"; pe:value :b ];
  pe:uses
    { (:h :a :b) :sameInputUnderEqualCompositeOutput true . },
    { :a log:notEqualTo :b . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 19 steps, 19 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 17; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 52; pe:failed 0 ].
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
eyeron examples/composition-of-injective-functions-is-injective.n3
eyeron -p examples/composition-of-injective-functions-is-injective.n3
eyeron -c examples/composition-of-injective-functions-is-injective.n3
```

---

## Takeaway

The encoded function laws expose the intermediate equality steps behind the
composition argument.
