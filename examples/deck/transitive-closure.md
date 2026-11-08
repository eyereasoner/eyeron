# Finding every reachable pair in a generated chain

[transitive-closure.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/transitive-closure.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/transitive-closure.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/transitive-closure.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/transitive-closure.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=transitive-closure)

---

## The question

A finite node count generates a chain of links. Recursive forward N3 rules
derive its transitive closure and summarize the resulting reachability
workload.

**How many reachable pairs follow from the generated chain?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# C-core transitive-closure demonstration, translated to N3.
#
# Generate a chain of nodes, derive direct links, then materialize
# all transitive reachability pairs.
:report :nodes 70 .

{
    :range :has ?N .
    :report :nodes ?Max .
    ?N math:lessThan ?Max .
    (?N 1) math:sum ?Next .
} => {
    :range :has ?Next .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:range :has 2 .
1 :nextNumber 2 .
:n1 :reaches :n70 .
:test :is true .
2 :nextNumber 3 .
:report :directLinks 69 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :range :has 2 . }
  pe:rule 1;
  pe:binding
    [ pe:var "Max"; pe:value 70 ],
    [ pe:var "N"; pe:value 1 ],
    [ pe:var "Next"; pe:value 2 ];
  pe:uses
    { :range :has 1 . },
    { :report :nodes 70 . },
    { 1 math:lessThan 70 . },
    { (1 1) math:sum 2 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 2982 steps, 2982 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2699; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 283; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2697; pe:failed 0 ].
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
eyeron examples/transitive-closure.n3
eyeron -p examples/transitive-closure.n3
eyeron -c examples/transitive-closure.n3
```

---

## Takeaway

A finite chain can produce many more reachable pairs than direct links.
