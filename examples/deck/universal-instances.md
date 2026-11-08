# Universal Instances

*"Everyone has a mother" — but not the same one.*

[universal-instances.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/universal-instances.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/universal-instances.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/universal-instances.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/universal-instances.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=universal-instances)

---

## The question

Some statements are about everything at once: *everything has property p*,
or *everyone has a mother*. From such a general statement you can read off
a particular case: *s has property p*, *Bob has a mother*.

The second statement hides a subtlety. "Everyone has a mother" does not say
that one person is everyone's mother. Bob's mother and Liz's mother need not
be the same.

**Can Eyeron read off particular cases, and keep Bob's and Liz's mothers
apart?**

---

## What we tell Eyeron

```n3
@forAll :x .
@forSome :y .
:x :p :o .
:x :hasMother :y .
```

`@forAll :x` says that `:x` in what follows stands for *anything*;
`@forSome :y` that `:y` stands for *some* individual, unnamed. Because the
`@forSome` comes inside the `@forAll`, the two statements read *for every x
there is some y such that x has p o and y is x's mother*. Which y it is may
depend on x.

```n3
{
    :s :p :o
} => {
    :universalInstance :holds true
} .

{
    :bob :hasMother ?mother
} => {
    :bob :mother ?mother
} .
```

The rules ask about particular cases. A third rule does the same for Liz.

---

## What Eyeron concludes

```n3
:universalInstance :holds true .
:bob :mother _:__q2_30797a27509bec94 .
:liz :mother _:__q2_2745a2109baeb890 .
```

`:s :p :o` holds, as an instance of the statement about everything. Bob and
Liz each have a mother, written as a **blank node** (`_:…`): an individual
that exists but has no name. The two labels differ, so the two mothers are
kept apart, exactly as "everyone has *some* mother" requires.

---

## The proof, step by step

```n3
{ :universalInstance :holds true . }
  pe:rule 1;
  pe:uses { :s :p :o . }.

{ :s :p :o . }
  pe:fact "universal-instances.n3".

{ :bob :mother _:__q2_30797a27509bec94 . }
  pe:rule 2;
  pe:binding [ pe:var "mother"; pe:value _:__q2_30797a27509bec94 ];
  pe:uses { :bob :hasMother _:__q2_30797a27509bec94 . }.

{ :bob :hasMother _:__q2_30797a27509bec94 . }
  pe:fact "universal-instances.n3".
```

The general statements count as facts of the file: `:s :p :o` and
`:bob :hasMother _:…` are both cited as `pe:fact`, being instances of what
the file says about everything. Liz's steps look the same, with her own
witness.

---

## Checked: what the report says

```n3
# checked: 6 steps, 6 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 2; pe:failed 0 ];
```

- **C1 resolution**: the three rule steps match their rules, and the three
  fact steps are instances of the file's quantified statements.
- **C8 witness integrity**: the two mothers are *witnesses*, individuals
  standing in for "some y". The checker confirmed that each is the right one
  for its x: Bob's witness is tied to Bob, Liz's to Liz.
- **C2–C4, C7, C10**: no cycles, every condition covered, every step
  relevant, every condition proved as called.

All 6 steps were verified: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/universal-instances.n3
eyeron -c examples/universal-instances.n3
```

Add `{ :ann :hasMother ?m } => { :ann :mother ?m } .`: Ann gets a mother
too, with a third, different blank-node label.

---

## Takeaway

A "some" inside an "all" gives each thing its own witness; Eyeron keeps
those witnesses apart, and the checker verifies whose each one is.
