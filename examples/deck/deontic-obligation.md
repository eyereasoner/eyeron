# Representing obligations across worlds

[deontic-obligation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/deontic-obligation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/deontic-obligation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/deontic-obligation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/deontic-obligation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=deontic-obligation)

---

## The question

Propositions hold in worlds linked by an accessibility relation. N3 rules use
a scoped universal test to derive obligations and related permissions from the
supplied model.

**Which propositions hold in every accessible world?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# accessibility relations between possible worlds
:normativeWorld1 log:hasAccessTo :normativeWorld1, :normativeWorld2 .

# P is obligatory in world W if P holds in all worlds accessible from W
{
    ?W1 log:hasAccessTo ?W .
    ?P log:holdsIn ?W1 .
    (
        {
            ?W1 log:hasAccessTo ?W2
        }
        {
            ?P log:holdsIn ?W2
        }
    ) log:forAllIn ?Sc .
} => {
    ?P log:isObligatoryIn ?W1 .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
{
    {
        :alcoholicBeverage :sellingTo :nonAdult .
    } => false .
} log:isObligatoryIn :normativeWorld1 .
{
    {
        :alcoholicBeverage :sellingTo :nonAdult .
    } => false .
} log:isObligatoryIn :normativeWorld2 .
{
    :alcoholicBeverage :sellingTo :nonAdult .
} log:isForbiddenIn :normativeWorld1 .
{
    :alcoholicBeverage :sellingTo :nonAdult .
} log:isForbiddenIn :normativeWorld2 .
{
    :alcoholicBeverage :sellingTo :adult .
} log:isPermittedIn :normativeWorld1 .
{
    {
        :alcoholicBeverage :sellingTo :nonAdult .
    } => false .
} log:isPermittedIn :normativeWorld1 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :normativeWorld1 log:hasAccessTo :normativeWorld1 . }
  pe:fact "deontic-obligation.n3".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 16 steps, 16 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 14; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 36; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/deontic-obligation.n3
eyeron -p examples/deontic-obligation.n3
eyeron -c examples/deontic-obligation.n3
```

---

## Takeaway

The model defines obligation through a universal condition over accessible
worlds.
