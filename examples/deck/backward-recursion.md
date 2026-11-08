# Ancestors on Demand

*A recursive backward rule walks a family line one generation at a time.*

[backward-recursion.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/backward-recursion.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/backward-recursion.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/backward-recursion.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/backward-recursion.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=backward-recursion)

---

## The question

Four people form a line: b is a's parent, c is b's, and d is c's. An
ancestor is a parent, or a parent's ancestor. (Here `:parent` links a person
to their parent, so following it leads up the line.)

**Who are a's ancestors?**

---

## What we tell Eyeron

```n3
:a :parent :b .
:b :parent :c .
:c :parent :d .
```

Three facts, one per link.

```n3
{
    ?x :ancestor ?y
} <= {
    ?x :parent ?y
} .

{
    ?x :ancestor ?z
} <= {
    ?x :parent ?y .
    ?y :ancestor ?z
} .
```

Two **backward rules** (`<=`: conclusion above, condition below). The first
says *a parent is an ancestor*. The second says *x's ancestor z can be found
by going to x's parent y and finding y's ancestor z*. That second rule asks
an ancestor question again, one generation further on: it is **recursive**.
It stops because the line ends at d, who has no parent.

```n3
{
    :a :ancestor ?who
} => {
    :a :reaches ?who
} .
```

A forward rule asks the open question *who are a's ancestors?* and records
each answer.

---

## What Eyeron concludes

```n3
:a :reaches :b .
:a :reaches :c .
:a :reaches :d .
```

One question with an open variable gave three answers.

---

## The proof, step by step

The proof has 12 steps: three answers, each with its own chain. The deepest
is d:

```n3
{ :a :reaches :d . }
  pe:rule 3;
  pe:binding [ pe:var "who"; pe:value :d ];
  pe:uses { :a :ancestor :d . }.

{ :a :ancestor :d . }
  pe:rule 2;
  pe:binding
    [ pe:var "x"; pe:value :a ],
    [ pe:var "y"; pe:value :b ],
    [ pe:var "z"; pe:value :d ];
  pe:uses
    { :a :parent :b . },
    { :b :ancestor :d . }.
…
{ :c :ancestor :d . }
  pe:rule 1;
  pe:binding
    [ pe:var "x"; pe:value :c ],
    [ pe:var "y"; pe:value :d ];
  pe:uses { :c :parent :d . }.
```

Read it down the line: d is a's ancestor because b is a's parent and d is
b's ancestor (rule 2); d is b's ancestor because c is b's parent and d is c's
ancestor (rule 2 again); and d is c's ancestor because d is c's parent
(rule 1). The three parent links are facts from the file, and the
intermediate statements are shared between the answers.

---

## Checked: what the report says

```n3
# checked: 12 steps, 12 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 12; pe:failed 0 ];
pe:condition [ pe:id "C2"; pe:name "well-foundedness"; pe:checked 12; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 9; pe:failed 0 ].
```

- **C1 resolution**: each of the nine rule steps re-performs its rule with the
  recorded values, and the three facts are in the file.
- **C2 well-foundedness**: with a recursive rule it matters that no statement
  is used to prove itself; every chain bottoms out in a parent fact.
- **C10 call fidelity**: the calls each rule step uses are the ones its rule
  makes.
- C3, C4 and C7 confirm the steps are well formed, nothing is missing and
  nothing is padding.

Verdict: **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/backward-recursion.n3      # the answer
eyeron -p examples/backward-recursion.n3   # the answer with its proof
eyeron -c examples/backward-recursion.n3   # the proof, checked
```

Add `:d :parent :e .` and run again: the recursion goes one step further and
a now reaches e as well.

---

## Takeaway

Two short rules describe a whole line of ancestors, however long, and the
proof shows the exact path to each one.
