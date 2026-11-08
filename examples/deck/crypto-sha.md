# Hashing text with SHA-1

[crypto-sha.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/crypto-sha.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/crypto-sha.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/crypto-sha.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/crypto-sha.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=crypto-sha)

---

## The question

A list supplies three text samples, including the empty string. N3 rules
enumerate the samples and use the SHA-1 built-in to derive a digest for each
one.

**Which SHA-1 digest belongs to each of the three sample texts?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Enumerate the three samples and record each SHA-1 digest alongside its text.
{
    ("" "abc" "blargh") list:member ?Text .
    ?Text crypto:sha ?Digest
} => {
    :hashes :sha1 (?Text ?Digest)
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:hashes :sha1 ("" "da39a3ee5e6b4b0d3255bfef95601890afd80709") .
:hashes :sha1 ("abc" "a9993e364706816aba3e25717850c26c9cd0d89d") .
:hashes :sha1 ("blargh" "d1e670385f40ee942a059f949c761214872ac35f") .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :hashes :sha1 ("" "da39a3ee5e6b4b0d3255bfef95601890afd80709") . }
  pe:rule 1;
  pe:binding
    [ pe:var "Digest"; pe:value "da39a3ee5e6b4b0d3255bfef95601890afd80709" ],
    [ pe:var "Text"; pe:value "" ];
  pe:uses
    { ("" "abc" "blargh") list:member "" . },
    { "" crypto:sha "da39a3ee5e6b4b0d3255bfef95601890afd80709" . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 9 steps, 9 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ].
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
eyeron examples/crypto-sha.n3
eyeron -p examples/crypto-sha.n3
eyeron -c examples/crypto-sha.n3
```

---

## Takeaway

A built-in can be applied to every member of a finite input list.
