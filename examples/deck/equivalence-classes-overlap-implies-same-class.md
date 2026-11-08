# Recognizing overlapping equivalence classes

[equivalence-classes-overlap-implies-same-class.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/equivalence-classes-overlap-implies-same-class.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/equivalence-classes-overlap-implies-same-class.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/equivalence-classes-overlap-implies-same-class.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/equivalence-classes-overlap-implies-same-class.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=equivalence-classes-overlap-implies-same-class)

---

## The question

A finite relation is closed under reflexivity, symmetry, and transitivity. N3
rules derive class membership and show when overlapping classes in the
supplied model represent the same class.

**Which classes overlap after the finite relation is closed?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Tiny example data
# Here :b belongs to both the class of :a and the class of :c,
# because we assert:
#
# b ~ a
# b ~ c
#
# From the axioms, the reasoner should conclude that
# the classes of :a and :c are the same.
:a :inX true .

# Carrier membership
# We use:
#
# ?x :inX true.
#
# to indicate that ?x belongs to the underlying set X.
# Axioms of an equivalence relation
# Reflexive:
# every element is related to itself
{
    ?x :inX true .
} => {
    ?x :sim ?x .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:result :sameClassBecauseOfSharedMember (:a :b :b) .
:result :sameClassBecauseOfSharedMember (:b :a :b) .
:result :sameClassBecauseOfSharedMember (:b :a :a) .
:result :sameClassBecauseOfSharedMember (:c :b :b) .
:result :sameClassBecauseOfSharedMember (:c :a :c) .
:result :sameClassBecauseOfSharedMember (:c :a :b) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :sameClassBecauseOfSharedMember (:a :b :b) . }
  pe:rule
    {
        {
            (?x ?y ?z) :sharedMemberShowsSameClass true .
            ?x log:notEqualTo ?y .
        } => {
            :result :sameClassBecauseOfSharedMember (?x ?y ?z) .
        } .
    };
  pe:binding
    [ pe:var "x"; pe:value :a ],
    [ pe:var "y"; pe:value :b ],
    [ pe:var "z"; pe:value :b ];
  pe:uses
    { (:a :b :b) :sharedMemberShowsSameClass true . },
    { :a log:notEqualTo :b . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 69 steps, 69 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 63; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 208; pe:failed 0 ].
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
eyeron examples/equivalence-classes-overlap-implies-same-class.n3
eyeron -p examples/equivalence-classes-overlap-implies-same-class.n3
eyeron -c examples/equivalence-classes-overlap-implies-same-class.n3
```

---

## Takeaway

Reflexivity, symmetry and transitivity determine the memberships used by the
overlap rules.
