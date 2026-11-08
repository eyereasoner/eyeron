# Proof by Cases

*Water is solid, liquid or gas; we don't know which, but each one is observable.*

[proof-by-cases-2.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/proof-by-cases-2.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/proof-by-cases-2.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/proof-by-cases-2.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/proof-by-cases-2.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=proof-by-cases-2)

---

## The question

Sometimes you know that one of several things is true without knowing which.
Water is an inorganic compound, and such a compound is solid, liquid or gas.
If every one of those states makes a thing observable, then water is
observable, whichever state it is in. Logicians call this *proof by cases*
(or disjunction elimination).

**Can Eyeron conclude that water is observable without ever learning its
state?**

---

## What we tell Eyeron

```n3
:water a :InorganicCompound .
```

One plain fact. The first rule turns "inorganic compound" into a list of
alternatives:

```n3
{
    ?A a :InorganicCompound .
} => {
    (?A) log:allPossibleCases (
        {
            ?A :is :solid
        }
…
    )
} .
```

The braces `{ … }` inside the list are *quoted formulas*: statements that are
talked about, not asserted. So Eyeron records "these are the possible cases"
without claiming water is solid, liquid or gas.

Three small rules say each state is observable, for example:

```n3
{
    ?A :is :solid
} => {
    ?A :is :observable
} .
```

---

## How the case analysis works

```n3
{
    (?A) log:allPossibleCases ?B .
    (
        {
            ?B list:member {
                ?A :is ?C
            }
        }
        {
            {
                ?A :is ?C
            } => {
                ?A :is :observable
            }
        }
    ) log:forAllIn ?SCOPE .
} => {
    ?A :is :observable .
} .
```

`log:forAllIn` is a built-in test: *for every* way the first formula holds
(every case `?A :is ?C` in the list), the second must hold in the program,
here a rule from that case to observability. If the test passes, the rule
concludes `?A :is :observable` directly. None of the three case rules ever
fires: there is no fact `:water :is :solid` for them to use.

---

## What Eyeron concludes

```n3
:water :is :observable .
```

The query at the end of the program asks for every `:is` statement; this is
the only one, because no state of water was ever asserted.

---

## The proof: one rule and a test

```n3
{ :water :is :observable . }
  pe:rule 5;
…
{ :water a :InorganicCompound . }
  pe:fact "proof-by-cases-2.n3".
…
}
  pe:builtin log:forAllIn.
```

The answer comes from rule 5, the proof-by-cases rule. It uses the case list,
derived by rule 1 from the fact that water is an inorganic compound, and a
`log:forAllIn` step marked `pe:builtin`: a test Eyeron ran, not a fact or a
rule. The proof has 4 steps in all.

---

## Checked, with one obligation

```n3
# checked with obligations: 4 steps, 3 verified, 1 trusted
pe:verdict pe:checkedWithObligations;
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
pe:obligation [
pe:kind "collected";
```

- **C1, C2, C3, C4, C7**: the rule steps are really instances of rules 1 and
  5, nothing is circular, every premise is justified and everything serves
  the answer.
- **C5 re-decision**: the checker re-ran the `log:forAllIn` test itself.
- **C9 search closure** and the **collected** obligation: "for all" means
  "for every case there is", which depends on having looked at all of them.
  The checker settles what it can from the proof's search certificate, but
  the complete enumeration is taken on trust. That one step is the trusted
  one, so the verdict is **checked with obligations**.
- **C10 call fidelity**: the query was answered as it was asked.

---

## What this does and doesn't show

The test passes when the case rules are present, and the proof records why.
Be aware of one thing when you experiment: as Eyeron runs this program today,
the `?C` inside the quoted rule is not tied to the case being tested, so one
case rule is enough for the test to pass. Delete the liquid and gas rules and
water is still observable; delete all three and it is not.

---

## Try it

```sh
eyeron examples/proof-by-cases-2.n3      # the answer
eyeron -p examples/proof-by-cases-2.n3   # with its proof
eyeron -c examples/proof-by-cases-2.n3   # the proof, checked
```

Delete all three case rules (solid, liquid, gas) and run again: the output is
empty, because the `log:forAllIn` test finds no rule for any case.

---

## Takeaway

Proof by cases lets a reasoner conclude something from alternatives it cannot
choose between; the check report is honest that "for all cases" rests on a
complete enumeration it trusts.
