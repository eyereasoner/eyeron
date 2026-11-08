# Approximating the square root of two by iteration

[sqrt2-cauchy.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/sqrt2-cauchy.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/sqrt2-cauchy.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/sqrt2-cauchy.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/sqrt2-cauchy.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=sqrt2-cauchy)

---

## The question

A finite recurrence generates rational approximations to the square root of
two. N3 arithmetic rules derive successive values and inspect the differences
used by the example's convergence checks.

**Which finite approximations and successive differences does the recurrence produce?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:000_md_title log:outputString "# sqrt2-cauchy\n\n## Source files\n\n- [N3 rules](../sqrt2-cauchy.n3)\n\n" .

# 1) Generate the sequence terms: x_{n+1} = (x_n + 2/x_n)/2
{
    :sqrt2Seq :term (?n ?x) .
    :sqrt2Seq :limit ?limit .
    ?n math:lessThan ?limit .

    (?n 1) math:sum ?n1 .

    (2 ?x) math:quotient ?twoOverX .
    (?x ?twoOverX) math:sum ?sum .
    (?sum 2) math:quotient ?x1 .
} => {
    :sqrt2Seq :term (?n1 ?x1) .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
Approximation (at limit): sqrt2 ≈ 1.414213562373095
n=0  x=1.0  delta=seed  err=1
n=1  x=1.5  delta=0.5  err=0.25
n=2  x=1.4166666666666665  delta=0.08333333333333348  err=0.006944444444444198
n=3  x=1.4142156862745097  delta=0.002450980392156854  err=0.000006007304882427178
n=4  x=1.4142135623746899  delta=0.0000021238998197947723  err=4.510614104447086e-12
n=5  x=1.414213562373095  delta=1.5949463971764999e-12  err=4.440892098500626e-16
n=6  x=1.414213562373095  delta=0  err=4.440892098500626e-16
n=7  x=1.414213562373095  delta=0  err=4.440892098500626e-16
n=8  x=1.414213562373095  delta=0  err=4.440892098500626e-16
n=9  x=1.414213562373095  delta=0  err=4.440892098500626e-16
n=10  x=1.414213562373095  delta=0  err=4.440892098500626e-16
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :sqrt2Seq :term (1 1.5) . }
  pe:rule 1;
  pe:binding
    [ pe:var "limit"; pe:value 10 ],
    [ pe:var "n"; pe:value 0 ],
    [ pe:var "n1"; pe:value 1 ],
    [ pe:var "sum"; pe:value "3"^^xsd:decimal ],
    [ pe:var "twoOverX"; pe:value "2"^^xsd:decimal ],
    [ pe:var "x"; pe:value 1.0 ],
    [ pe:var "x1"; pe:value 1.5 ];
  pe:uses
    { :sqrt2Seq :term (0 1.0) . },
    { :sqrt2Seq :limit 10 . },
    { 0 math:lessThan 10 . },
    { (0 1) math:sum 1 . },
    { (2 1.0) math:quotient "2"^^xsd:decimal . },
    { (1.0 "2"^^xsd:decimal) math:sum "3"^^xsd:decimal . },
    { ("3"^^xsd:decimal 2) math:quotient 1.5 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 162 steps, 162 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 57; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 105; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 53; pe:failed 0 ].
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
eyeron examples/sqrt2-cauchy.n3
eyeron -p examples/sqrt2-cauchy.n3
eyeron -c examples/sqrt2-cauchy.n3
```

---

## Takeaway

A finite recurrence illustrates an approximation process without proving every
convergence claim.
