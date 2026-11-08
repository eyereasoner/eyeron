# Following a comic chain of classifications

[witch.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/witch.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/witch.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/witch.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/witch.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=witch)

---

## The question

A deliberately fanciful argument links floating, wood, burning, and a witch
classification. N3 rules propagate the supplied premises to demonstrate a
multistep forward derivation.

**Which classification follows from the deliberately fanciful premises?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# [2]    WOMAN(GIRL)
:GIRL a :WOMAN .

# [1]     BURNS(x) /\ WOMAN(x)         =>    WITCH(x)
{
    ?x a :BURNS .
    ?x a :WOMAN
} => {
    ?x a :WITCH
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:DUCK a :ISMADEOFWOOD .
:GIRL a :FLOATS .
:GIRL a :BURNS .
:GIRL a :WITCH .
:DUCK a :BURNS .
:GIRL a :ISMADEOFWOOD .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :DUCK a :ISMADEOFWOOD . }
  pe:rule 3;
  pe:binding [ pe:var "x"; pe:value :DUCK ];
  pe:uses { :DUCK a :FLOATS . }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 9 steps, 9 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/witch.n3
eyeron -p examples/witch.n3
eyeron -c examples/witch.n3
```

---

## References

[Source reference 1](http://clarkparsia.com/weblog/2007/01/02/burn-the-witch/)

[Source reference 2](http://www.netfunny.com/rhf/jokes/90q4/burnher.html)

[Source reference 3](http://www.w3.org/2000/10/swap/test/reason/witch.n3)

---

## Takeaway

A valid derivation shows what follows from the premises, not whether those
premises describe reality.
