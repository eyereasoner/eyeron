# Solving triangle sides with the law of cosines

[law-of-cosines.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/law-of-cosines.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/law-of-cosines.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/law-of-cosines.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/law-of-cosines.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=law-of-cosines)

---

## The question

Six triangles each come with two sides and the angle between them, in radians.
One rule per side applies the law of cosines with N3 math built-ins to compute
the third side, and two log:query statements print each answer (which side,
and its length) and which formula was used.

**Which missing side is calculated for each of the six sample triangles?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Law of cosines, with the angle A opposite side a, and so on:
# a^2 = b^2 + c^2 - 2 b c cos(A)
# b^2 = c^2 + a^2 - 2 c a cos(B)
# c^2 = a^2 + b^2 - 2 a b cos(C)

# Vocabulary
:Triangle a rdfs:Class .

# Solve side c from a, b, C. The answer and the intermediate values are new
# blank nodes; a negative c^2 (an impossible triangle) gives no answer.
{
    ?t a :Triangle ;
        :a ?a ;
        :b ?b ;
        :C ?C .
    (?a 2) math:exponentiation ?a2 .
    (?b 2) math:exponentiation ?b2 .
    ?C math:cos ?cosC .

    (?a2 ?b2) math:sum ?sumab .
    (2 ?a) math:product ?tw_a .
    (?tw_a ?b) math:product ?tw_ab .
    (?tw_ab ?cosC) math:product ?twabcos .

    (?sumab ?twabcos) math:difference ?c2 .
    ?c2 math:notLessThan 0 .
    (?c2 0.5) math:exponentiation ?c .
} => {
    ?t :answer [ a :Side ; :which "c" ; :value ?c ] ;
        :why [ :a2 ?a2 ; :b2 ?b2 ; :cosAngle ?cosC ; :rhs ?c2 ] ;
        :status "solve-c" .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:T1 :answer _:b1_54721846418c41f3 .
_:b1_54721846418c41f3 a :Side .
:T2 :answer _:b1_21f18ac81e6a18e2 .
:T3 :answer _:b3_9dd1c3061358bb8b .
:T4 :answer _:b5_72a3a4d41342fcef .
:T5 :status "solve-c" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :T1 :answer _:b1_54721846418c41f3 . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value 1.5707963267948966 ],
    [ pe:var "a"; pe:value 3 ],
    [ pe:var "a2"; pe:value 9 ],
    [ pe:var "b"; pe:value 4 ],
    [ pe:var "b2"; pe:value 16 ],
    [ pe:var "c"; pe:value "5"^^xsd:decimal ],
    [ pe:var "c2"; pe:value "25"^^xsd:decimal ],
    [ pe:var "cosC"; pe:value 6.123233995736766e-17 ],
    [ pe:var "sumab"; pe:value 25 ],
    [ pe:var "t"; pe:value :T1 ],
    [ pe:var "tw_a"; pe:value 6 ],
    [ pe:var "tw_ab"; pe:value 24 ],
    [ pe:var "twabcos"; pe:value 1.4695761589768238e-15 ];
  pe:uses
    { :T1 a :Triangle . },
    { :T1 :a 3 . },
    { :T1 :b 4 . },
    { :T1 :C 1.5707963267948966 . },
…
    { (24 6.123233995736766e-17) math:product 1.4695761589768238e-15 . },
    { (25 1.4695761589768238e-15) math:difference "25"^^xsd:decimal . },
    { "25"^^xsd:decimal math:notLessThan 0 . },
    { ("25"^^xsd:decimal 0.5) math:exponentiation "5"^^xsd:decimal . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 106 steps, 82 verified, 24 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 54; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 52; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 24; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 480; pe:failed 0 ];
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
eyeron examples/law-of-cosines.n3
eyeron -p examples/law-of-cosines.n3
eyeron -c examples/law-of-cosines.n3
```

---

## Takeaway

The rule and formula attached to each answer show how its side length was
computed.
