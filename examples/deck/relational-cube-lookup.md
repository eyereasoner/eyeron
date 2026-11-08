# Looking up values by multiple tuple members

[relational-cube-lookup.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/relational-cube-lookup.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/relational-cube-lookup.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/relational-cube-lookup.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/relational-cube-lookup.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=relational-cube-lookup)

---

## The question

A relation contains 3,375 tuple facts and supplies 2,000 lookups. N3 rules use
bound tuple members to select the matching values, providing a repeated
relational-matching workload.

**Can all 2,000 lookups find values using two bound tuple keys?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Each tuple has three keys and one value; this table contains 3,375 facts.
(:a0 :b0 :c0) :relation :v0_0 .

# A backward answer requires all 2,000 lookups below to succeed.
# Each lookup fixes its first and third key and binds the second and the value.
{
    :case :lookupResult :passed .
} <= {
    (:a0 ?b0 :c0) :relation ?v0 .
    (:a44 ?b1 :c5) :relation ?v1 .
    (:a88 ?b2 :c10) :relation ?v2 .
    (:a132 ?b3 :c0) :relation ?v3 .
    (:a176 ?b4 :c5) :relation ?v4 .
    (:a220 ?b5 :c10) :relation ?v5 .
    (:a39 ?b6 :c1) :relation ?v6 .
    (:a83 ?b7 :c6) :relation ?v7 .
    (:a127 ?b8 :c11) :relation ?v8 .
    (:a171 ?b9 :c1) :relation ?v9 .
    (:a215 ?b10 :c6) :relation ?v10 .
    (:a34 ?b11 :c12) :relation ?v11 .
    (:a78 ?b12 :c2) :relation ?v12 .
    (:a122 ?b13 :c7) :relation ?v13 .
…
    (:a118 ?b1997 :c10) :relation ?v1997 .
    (:a162 ?b1998 :c0) :relation ?v1998 .
    (:a206 ?b1999 :c5) :relation ?v1999 .
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
:case :lookupResult :passed .
:case :reason "2000 two-key lookups over 3375 facts" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :case :reason "2000 two-key lookups over 3375 facts" . }
  pe:rule
    {
        {
            :case :lookupResult ?result .
        } => {
            :case :lookupResult ?result .
            :case :reason "2000 two-key lookups over 3375 facts" .
        } .
    };
  pe:binding [ pe:var "result"; pe:value :passed ];
  pe:uses { :case :lookupResult :passed . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 2002 steps, 2002 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2002; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2006; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

The saved proof is large; write the results to files before inspecting them.

```sh
eyeron examples/relational-cube-lookup.n3 > /tmp/relational-cube-lookup-output.n3
eyeron -p examples/relational-cube-lookup.n3 > /tmp/relational-cube-lookup-proof.n3
eyeron -c examples/relational-cube-lookup.n3 > /tmp/relational-cube-lookup-check.n3
```

---

## Takeaway

A small result can depend on thousands of independently supported tuple
matches.
