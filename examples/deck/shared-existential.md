# One witness shared by universal statements

*Everybody loves somebody — the same somebody.*

[shared-existential.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/shared-existential.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/shared-existential.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/shared-existential.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/shared-existential.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=shared-existential)

---

## The question

"There is someone whom everyone loves" is different from "everyone loves
someone": in the first, it is one and the same person. Logic makes the
difference with the order of the quantifiers *there is* and *for all*.

**If there is someone everyone loves, whom do Bob and Liz love?**

---

## What we tell Eyeron

```n3
@forSome :y .
{} => {
    @forAll :x .
    :x :loves :y
} .
```

N3 lets you write quantifiers explicitly. `@forSome :y` says *there is some
y*; it stands at the top of the document, outside everything else. Inside,
`@forAll :x` says *for every x*, and the statement reads *x loves y*. The
rule has an empty premise `{}`, so its conclusion holds without conditions.
Because `@forSome` comes first, one `y` serves every `x`.

Then two rules ask about Bob and Liz:

```n3
{
    :bob :loves ?beloved
} => {
    :bob :beloved ?beloved
} .
```

and the same for `:liz`.

---

## What Eyeron concludes

```n3
:bob :beloved _:__q1 .
:liz :beloved _:__q1 .
```

`_:__q1` is a *blank node*: an individual that exists but has no name. It is
the `y` of the first statement. Both conclusions use the same label, so they
speak of the same unnamed person, just as the quantifiers promised.

---

## The proof: two instances of one statement

```n3
{ :bob :beloved _:__q1 . }
  pe:rule 2;
  pe:binding [ pe:var "beloved"; pe:value _:__q1 ];
  pe:uses { :bob :loves _:__q1 . }.

{ :bob :loves _:__q1 . }
  pe:rule 1.
```

*Bob loves y* comes from rule 1, the universal statement, with Bob in the
place of `x`; it has no premises to cite, since the rule's premise is empty.
The steps for Liz are the same with Liz in that place. Four steps in all, all
rule steps.

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
```

- **C1 resolution**: *Bob loves y* and *Liz loves y* are instances of rule 1's
  conclusion, and the two `beloved` steps are rules 2 and 3 with the recorded
  binding.
- **C2–C4, C7, C10**: nothing rests on itself, every premise has a step,
  nothing is padding, and each premise was checked as its rule asks it.

The `y` here was introduced by the document itself, not invented by a rule
firing, so C8 (witness integrity) has nothing to examine. 4 of 4 steps
verified: **checked**.

---

## Try it

```sh
eyeron examples/shared-existential.n3
eyeron -p examples/shared-existential.n3
eyeron -c examples/shared-existential.n3
```

Delete the line `@forSome :y .` and run again: `:y` is then an ordinary
name, and the answers become `:bob :beloved :y` and `:liz :beloved :y`.

---

## Takeaway

Explicit quantifiers say exactly how far an unknown individual is shared, and
Eyeron keeps that sharing: both answers point at one blank node.
