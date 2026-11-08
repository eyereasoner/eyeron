# Fresh witnesses in generated rules

*Rules that write rules, and two unnamed animals that must not be confused.*

[cat-koko.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/cat-koko.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/cat-koko.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/cat-koko.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/cat-koko.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=cat-koko)

---

## The question

Koko is an animal. From that, one rule produces two more rules: one says
that *some* cat exists, the other that *some* British shorthair exists.
Neither names the animal it is about.

**Does Eyeron keep these two unnamed individuals apart, and can it prove
that they are different?**

---

## What we tell Eyeron

```n3
:Koko a :Animal .

{
    :Koko a :Animal
} => {
    {
        :Koko a :Animal
    } => {
        _:x a :Cat
    } .
    {
        :Koko a :Animal
    } => {
        _:x a :BritishShortHair
    } .
} .
```

The conclusion of this rule is itself two rules, each in its own
`{ … }` formula. `_:x` is a blank node: in a conclusion it means *some
individual*, without saying which. The two `_:x` sit in different formulas,
so they are two different blank nodes that happen to share a label.

```n3
{
    ?X a :Cat .
    ?Y a :BritishShortHair .
    ?X log:notEqualTo ?Y .
} => {
    :test :is true .
} .
```

The last rule succeeds only if the cat and the shorthair are different
terms; `log:notEqualTo` is a built-in that compares them.

---

## What Eyeron concludes

First the two generated rules, then what they produce:

```n3
{
    :Koko a :Animal .
} => {
    _:x_44d5add673004d27 a :Cat .
} .
…
_:x_44d5add673004d27_14650fb0739d0383 a :Cat .
_:x_64f1352a2f72e196_14650fb0739d0383 a :BritishShortHair .
:test :is true .
```

Each rule keeps its own blank node (the long labels are generated), and each
firing introduces its own fresh individual. The two are different, so
`:test :is true` follows.

---

## The proof, step by step

The proof has 7 steps. The generated rules cite rule 1 and Koko's fact. The
cat is produced by a rule that is not in the source at all; the proof quotes
that generated rule in full:

```n3
{ _:x_44d5add673004d27_14650fb0739d0383 a :Cat . }
  pe:rule
    {
        {
            :Koko a :Animal .
        } => {
            _:x_44d5add673004d27 a :Cat .
        } .
    };
  pe:uses { :Koko a :Animal . }.
```

The final step uses both individuals and the built-in comparison:

```n3
{ :test :is true . }
  pe:rule 2;
  pe:binding
    [ pe:var "X"; pe:value _:x_44d5add673004d27_14650fb0739d0383 ],
    [ pe:var "Y"; pe:value _:x_64f1352a2f72e196_14650fb0739d0383 ];
```

---

## Checked: what the report says

```n3
# checked with obligations: 7 steps, 5 verified, 2 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 2; pe:failed 0 ];
pe:kind "unsatisfied";
```

- **C1 resolution** checks the 6 rule and fact steps, including that the
  generated rules really are what rule 1 concludes.
- **C5 re-decision** compares the two individuals again: they differ.
- **C8 witness integrity** checks that each introduced individual is fresh
  and belongs to one firing only, so one cannot pose as the other.
- **C6 boundary consistency** finds nothing in the proof that contradicts
  the two obligations below.

The two introductions are taken on trust as `unsatisfied` obligations.
Eyeron introduces an individual only when no known one already fits, so
each introduction assumes that no cat, and no British shorthair, was already
known. Here that is plainly true, but it is a claim about everything the
program knows, which the proof states rather than proves. Hence **checked
with obligations**: 5 steps verified, 2 trusted.

---

## Try it

```sh
eyeron examples/cat-koko.n3
eyeron -c examples/cat-koko.n3
```

Make both generated rules say `_:x a :Cat`. They become one and the same
rule, a single cat is introduced, and `:test :is true` is no longer
derived: there is no shorthair left to compare with.

---

## Takeaway

A blank node in a conclusion means *some* individual; Eyeron gives each
firing its own fresh one, and the checker makes sure no two are confused.
