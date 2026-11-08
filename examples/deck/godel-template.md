# Substituting tokens into a Godel-style template

[godel-template.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/godel-template.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/godel-template.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/godel-template.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/godel-template.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=godel-template)

---

## The question

A sentence template contains a place for a numeral. N3 list and arithmetic
rules substitute encoded numeral tokens and calculate the example's finite
token representation.

**Which tokens result when the numeral is inserted into the sentence template?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 0) Token alphabet + codes (toy)
:NOT :code 1 .

# 2) Decimal numeral tokens via backward rules (demand-driven)
# Base case: n < 10  => digits(n) = ( d(n) )
{
    ?n :digits (?d) .
} <= {
    ?n math:lessThan 10 .
    ?d :digitValue ?n .
} .

# Compute godelNumber from the factors (p^c) and their product
{
    :Demo :godelPairs ?pairs .

    (
        ?factor {
            ?pairs list:member ?pair .
            ?pair math:exponentiation ?factor .
        }
        ?factors
    ) log:collectAllIn _:scope .

    ?factors math:product ?g .
…
    :outTokens :is ?tokens .
    :outPairs :is ?pairs .
    :outG :is ?g .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called. The ellipsis omits part of the source; the
linked file contains the full program.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:Demo :digits (:d4 :d2) .
:Demo :tokens (:NOT :PROVABLE :IN :S :LP :d4 :d2 :RP) .
:outPairs :is ((2 1) (3 2) (5 3) (7 4) (11 5) (13 14) (17 12) (19 6)) .
:outG :is 93897428453934743498383922339000952994095115872750 .
:Demo :godelPairs ((2 1) (3 2) (5 3) (7 4) (11 5) (13 14) (17 12) (19 6)) .
:Demo :godelNumber 93897428453934743498383922339000952994095115872750 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Demo :digits (:d4 :d2) . }
  pe:rule 3;
  pe:binding
    [ pe:var "digits"; pe:value (:d4 :d2) ],
    [ pe:var "n"; pe:value 42 ],
    [ pe:var "pre"; pe:value (:NOT :PROVABLE :IN :S :LP) ],
    [ pe:var "suf"; pe:value (:RP) ],
    [ pe:var "tmp"; pe:value (:NOT :PROVABLE :IN :S :LP :d4 :d2) ],
    [ pe:var "tokens"; pe:value (:NOT :PROVABLE :IN :S :LP :d4 :d2 :RP) ];
  pe:uses
    { :Demo :n 42 . },
    { 42 :digits (:d4 :d2) . },
    { :GSchema :prefixTokens (:NOT :PROVABLE :IN :S :LP) . },
    { :GSchema :suffixTokens (:RP) . },
    { ((:NOT :PROVABLE :IN :S :LP) (:d4 :d2)) list:append (:NOT :PROVABLE :IN :S :LP :d4 :d2) . },
    { ((:NOT :PROVABLE :IN :S :LP :d4 :d2) (:RP)) list:append (:NOT :PROVABLE :IN :S :LP :d4 :d2 :RP) . }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 25 steps, 25 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 14; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 11; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 8; pe:failed 0 ].
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
eyeron examples/godel-template.n3
eyeron -p examples/godel-template.n3
eyeron -c examples/godel-template.n3
```

---

## Takeaway

A finite token substitution models a piece of syntax, not the full
incompleteness argument.
