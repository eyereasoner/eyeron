# Calculating triangle area with Heron's formula

[heron-theorem.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/heron-theorem.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/heron-theorem.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/heron-theorem.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/heron-theorem.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=heron-theorem)

---

## The question

Triangle side lengths supply the input to Heron's formula. N3 arithmetic rules
derive the semiperimeter and area. Queries return each triangle's area and
whether its sides form a proper, degenerate, or invalid triangle.

**Which sample triangles have an area, and which fail the side conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Heron's theorem:  A = sqrt(s(s-a)(s-b)(s-c)) with s=(a+b+c)/2
# Vocabulary
:Triangle a rdfs:Class .

# Common prelude: compute s, (s-a),(s-b),(s-c), radicand
{
    ?t a :Triangle ;
        :a ?a ;
        :b ?b ;
        :c ?c .
    (?a ?b ?c) math:sum ?perim .
    (?perim 2) math:quotient ?s .
    (?s ?a) math:difference ?sa .
    (?s ?b) math:difference ?sb .
    (?s ?c) math:difference ?sc .
    (?s ?sa) math:product ?p1 .
    (?p1 ?sb) math:product ?p2 .
    (?p2 ?sc) math:product ?rad .
    # rad = s(s-a)(s-b)(s-c)
} => {
    ?t :why [ :s ?s ; :sMinusA ?sa ; :sMinusB ?sb ; :sMinusC ?sc ; :radicand ?rad ] .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:T1 :answer _:b2_d1895b619c710c4c .
_:b2_d1895b619c710c4c a :Area .
:T2 :answer _:b2_f00ed8195d58f09b .
:T3 :answer _:b2_ea67d051e3e10ed0 .
:T4 :answer _:b2_7a9bc048e235baf0 .
:T5 :status "degenerate" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :T1 :answer _:b2_d1895b619c710c4c . }
  pe:rule 2;
  pe:binding
    [ pe:var "A"; pe:value "6"^^xsd:decimal ],
    [ pe:var "rad"; pe:value 36 ],
    [ pe:var "t"; pe:value :T1 ],
    [ pe:var "w"; pe:value _:b1_fc4fc0ba838e96c2 ];
  pe:uses
    { :T1 a :Triangle . },
    { :T1 :why _:b1_fc4fc0ba838e96c2 . },
    { _:b1_fc4fc0ba838e96c2 :radicand 36 . },
    { 36 math:greaterThan 0 . },
    { (36 0.5) math:exponentiation "6"^^xsd:decimal . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 116 steps, 86 verified, 30 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 60; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 56; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 30; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 320; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `unsatisfied`.

---

## Try it

```sh
eyeron examples/heron-theorem.n3
eyeron -p examples/heron-theorem.n3
eyeron -c examples/heron-theorem.n3
```

---

## Takeaway

Geometric preconditions distinguish a valid area calculation from a degenerate
or invalid triangle.
