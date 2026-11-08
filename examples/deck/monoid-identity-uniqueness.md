# Comparing identity elements in a monoid

[monoid-identity-uniqueness.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/monoid-identity-uniqueness.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/monoid-identity-uniqueness.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/monoid-identity-uniqueness.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/monoid-identity-uniqueness.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=monoid-identity-uniqueness)

---

## The question

The monoid laws are written as N3 rules: associativity, an identity :e on both
sides, and a candidate ?e2 that acts as a left identity, together with the
classic argument that e2 = e2 * e = e. The program states no elements, so none
of these rules fires. The query asks which ?e2 is log:equalTo :e, and that
built-in, which holds only for identical terms, answers :e itself. Adding
elements and a candidate :e2 makes the uniqueness rule conclude :e2
log:equalTo :e, which eyeron rejects as a false built-in statement, because
two different names are not identical terms.

**What does the identity query actually establish without any supplied elements?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Carrier membership
# We use:
#
# ?x :inG true.
#
# to indicate that ?x belongs to the underlying set G.
# Monoid axioms
# Associativity:
# if
# (a * b) = ab
# (ab * c) = left
# (b * c) = bc
# (a * bc) = right
# then
# left = right
{
    (?a ?b) :mul ?ab .
    (?ab ?c) :mul ?left .
    (?b ?c) :mul ?bc .
    (?a ?bc) :mul ?right .
} => {
    ?left log:equalTo ?right .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:result :uniqueIdentity :e .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :uniqueIdentity :e . }
  pe:rule
    {
        {
            ?e2 log:equalTo :e .
        } => {
            :result :uniqueIdentity ?e2 .
        } .
    };
  pe:binding [ pe:var "e2"; pe:value :e ];
  pe:uses { :e log:equalTo :e . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 2 steps, 2 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
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
eyeron examples/monoid-identity-uniqueness.n3
eyeron -p examples/monoid-identity-uniqueness.n3
eyeron -c examples/monoid-identity-uniqueness.n3
```

---

## Takeaway

The answer is the identical term e; the printed monoid rules do not establish
equality of two different names here.
