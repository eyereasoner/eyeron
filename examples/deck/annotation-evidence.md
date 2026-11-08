# Who Said That?

*A statement, quoted inside another statement, with its author and date.*

[annotation-evidence.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/annotation-evidence.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/annotation-evidence.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/annotation-evidence.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/annotation-evidence.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=annotation-evidence)

---

## The question

Alice's name is "Alice". Separately, someone has recorded a claim: Bob stated,
on 7 July 2021, that Alice's name is "Alice". Knowing a fact is one thing;
knowing who said it and when is another, and matters when you have to decide
whom to believe.

**Does the statement hold, which claim records it, and who stated it when?**

---

## What we tell Eyeron

```n3
:alice :name "Alice" .

:claim :statement {
    :alice :name "Alice"
} ;
    :statedBy :bob ;
    :recorded "2021-07-07"^^xsd:date .
```

The first line is the statement itself. The second describes a claim. Its
`:statement` is a **quoted graph**: the braces `{ … }` hold a statement as a
value, without asserting it. That is what lets the claim carry metadata about
it: `;` continues with the same subject, so the claim also has an author and a
recording date (typed as an `xsd:date`).

```n3
{
    ?claim :statement {
        :alice :name "Alice"
    } .
    ?claim :statedBy ?who
} => {
    :test :statementAuthor ?who
} .
```

One of four rules. It finds a claim whose quoted statement is exactly *Alice's
name is "Alice"*, and reports who stated it. The others report that the
statement holds, which claim quotes it, and when it was recorded.

---

## What Eyeron concludes

```n3
:test :hasStatement true .
:test :hasNamedStatement :claim .
:test :statementAuthor :bob .
:test :statementDate "2021-07-07"^^xsd:date .
```

---

## The proof, step by step

```n3
{ :test :statementAuthor :bob . }
  pe:rule 3;
  pe:binding
    [ pe:var "claim"; pe:value :claim ],
    [ pe:var "who"; pe:value :bob ];
  pe:uses
    {
        :claim :statement {
            :alice :name "Alice" .
        } .
    },
    { :claim :statedBy :bob . }.

{ :claim :statedBy :bob . }
  pe:fact "annotation-evidence.n3".
```

Eight steps: one rule step per answer, and four facts from the file. The
author comes from rule 3, which used the claim's quoted statement (a quoted
graph inside the proof's own braces) and the claim's author.

Note that the first answer, `:hasStatement`, rests on the plain fact
`:alice :name "Alice"`, not on the quote: quoting a statement does not assert
it.

---

## Checked: what the report says

```n3
# checked: 8 steps, 8 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 8; pe:failed 0 ];
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 10; pe:failed 0 ];
```

- **C1 resolution**: each rule step re-performs its rule, matching the quoted
  graph exactly, and each fact is in the file.
- **C4 coverage**: every statement used and every answer claimed is backed by
  a step.
- C2, C3, C7 and C10 confirm there are no loops, malformed steps, unneeded
  steps or altered calls.

Verdict: **checked**, with nothing taken on trust. The checker confirms that
the file says Bob stated it; whether Bob is right is a different question.

---

## Try it

```sh
eyeron examples/annotation-evidence.n3      # the answer
eyeron -p examples/annotation-evidence.n3   # the answer with its proof
eyeron -c examples/annotation-evidence.n3   # the proof, checked
```

Add a second claim, `:claim2 :statement { :alice :name "Alice" } ; :statedBy
:carol .`, and run again: Eyeron now reports both claims and both authors.

---

## Takeaway

Quoted graphs let a statement carry its own provenance, so rules can reason
about who said what, and when, as well as about what is true.
