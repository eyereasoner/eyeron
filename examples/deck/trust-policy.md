# Following a constrained trust delegation

[trust-policy.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/trust-policy.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/trust-policy.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/trust-policy.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/trust-policy.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=trust-policy)

---

## The question

Delegation links connect an administrator to internal and external parties. N3
rules follow the links and apply the model's explicit trust conditions to
derive supported access judgments.

**Which delegated access judgments meet the stated trust conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Delegation certificates
:admin :delegates :dept_head .

# change to “true” to activate
# Derived trust (transitive, revocation-aware)
{
    :admin :delegates ?X .
    ?SCOPE log:notIncludes {
        ?X :revoked true
    } .
    # ¬revoked(X)
} => {
    ?X :trusted true
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:dept_head :auth true .
:mgr_alice :auth true .
:bob :auth false .
:eve :auth false .
:alice :auth true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :dept_head :auth true . }
  pe:rule
    {
        {
            ?P :allow :read_secret_data .
        } => {
            ?P :auth true .
        } .
    };
  pe:binding [ pe:var "P"; pe:value :dept_head ];
  pe:uses { :dept_head :allow :read_secret_data . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 34 steps, 34 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 27; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 7; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 55; pe:failed 0 ].
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
eyeron examples/trust-policy.n3
eyeron -p examples/trust-policy.n3
eyeron -c examples/trust-policy.n3
```

---

## Takeaway

Delegation links authorize a result only when the accompanying constraints are
supported.
