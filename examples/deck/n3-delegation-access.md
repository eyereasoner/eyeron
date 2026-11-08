# Following delegated access authority

[n3-delegation-access.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/n3-delegation-access.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/n3-delegation-access.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/n3-delegation-access.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/n3-delegation-access.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=n3-delegation-access)

---

## The question

Quoted documents delegate authority and state access permissions. N3 rules
start from a trusted root, follow the delegation chain, and derive which
people may read the selected resources.

**Which read permissions follow from the trusted root and delegated documents?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Trust root
:policy :trusts <https://root.example/policy.n3> .

# Trust can be delegated (forward)
{
    :policy :trusts ?Doc .
    ?Doc :says ?F .
    ?F log:includes {
        :policy :delegatesTo ?Other .
    } .
} => {
    :policy :trusts ?Other .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:report :entails {
    id:alice :canRead :buildReport .
} .
:report :entails {
    id:alice :canRead :roadmap .
} .
{
    id:alice :memberOf :eng .
} :assertedBy <https://team.example/members.n3> .
{
    id:eve :memberOf :eng .
} :assertedBy <https://interns.example/members.n3> .
:report :entails {
    id:eve :canRead :buildReport .
} .
:report :entails {
    id:eve :canRead :roadmap .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :report :trusts <https://root.example/policy.n3> . }
  pe:rule
    {
        {
            :policy :trusts ?Doc .
        } => {
            :report :trusts ?Doc .
        } .
    };
  pe:binding [ pe:var "Doc"; pe:value <https://root.example/policy.n3> ];
  pe:uses { :policy :trusts <https://root.example/policy.n3> . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 35 steps, 35 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 28; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 7; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 120; pe:failed 0 ].
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
eyeron examples/n3-delegation-access.n3
eyeron -p examples/n3-delegation-access.n3
eyeron -c examples/n3-delegation-access.n3
```

---

## Takeaway

Authority flows through explicitly supported document and delegation links.
