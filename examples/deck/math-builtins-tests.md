# Checking arithmetic operations

*Thirty-three small sums, each one a test that either passes or leaves no trace.*

[math-builtins-tests.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/math-builtins-tests.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/math-builtins-tests.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/math-builtins-tests.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/math-builtins-tests.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=math-builtins-tests)

---

## The question

N3 has a library of arithmetic *built-ins*: predicates such as `math:sum`,
`math:cos` or `math:rounded` that Eyeron computes rather than looks up. Do
they give the answers you expect, from absolute values to trigonometry?

**Which of these arithmetic tests pass?**

---

## What we tell Eyeron

Each test is one rule. It runs a built-in on a fixed input, compares the
result with the expected value, and only when they agree records the test:

```n3
# math:absoluteValue
{
    -2 math:absoluteValue ?abs .
    ?abs math:equalTo 2 .
} => {
    :test-absoluteValue-1 a :MathBuiltinTest ;
        :builtin math:absoluteValue ;
        :input -2 ;
        :expected 2 ;
        :actual ?abs ;
        :status :pass .
} .
```

The first line computes the absolute value of -2 into `?abs`; the second is a
comparison, which simply holds or fails. A list like `(7 2)` passes several
inputs at once, as in `(7 2) math:difference ?d`.

Some built-ins also run backwards. Here the exponent is the unknown:

```n3
# Inverse mode: (7 ?exp) math:exponentiation 49 => ?exp = 2
{
    (7 ?exp) math:exponentiation 49 .
…
} .
```

Others pin down details, such as how `math:rounded` breaks ties:

```n3
# Tie-breaking towards +infinity: 3.5 -> 4
…
# Negative tie-breaking towards +infinity: -1.5 -> -1
```

---

## What Eyeron concludes

Every one of the 33 tests produces its record, with status `:pass`:

```n3
:test-absoluteValue-1 a :MathBuiltinTest .
:test-absoluteValue-1 :builtin math:absoluteValue .
:test-absoluteValue-1 :input -2 .
:test-absoluteValue-1 :expected 2 .
:test-absoluteValue-1 :actual 2 .
:test-absoluteValue-1 :status :pass .
…
:test-exponentiation-2 :input (7 2) .
:test-exponentiation-2 :actual 2 .
…
:test-atan-1 :actual "0.7853981633974483"^^xsd:decimal .
:test-rounded-3 :input -1.5 .
:test-rounded-3 :actual -1 .
```

In the backward test the recorded input reads `(7 2)`: the variable was
filled in with the exponent Eyeron found. Results with a fractional part,
such as `atan(1)`, come out as decimals.

---

## The proof, step by step

The proof has 239 steps: 192 rule steps (one for each statement of each
record) and 47 built-in steps. The backward exponent looks like this:

```n3
{ :test-exponentiation-2 a :MathBuiltinTest . }
  pe:rule 13;
  pe:binding [ pe:var "exp"; pe:value 2 ];
  pe:uses { (7 2) math:exponentiation 49 . }.
…
{ (7 2) math:exponentiation 49 . }
  pe:builtin math:exponentiation.
```

Rule 13 of the program, with `exp` standing for 2, relies on one built-in
fact: 7 to the power 2 is 49.

---

## Checked: what the report says

```n3
# checked: 239 steps, 239 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 192; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 47; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 192; pe:failed 0 ].
```

- **C5 re-decision** is the heart of it: the checker recomputes all 47
  built-in results itself, so a proof cannot claim that 7 squared is 50.
- **C1 resolution**: all 192 rule steps match their rules with the recorded
  bindings.
- **C10 call fidelity**: the built-ins were checked as the rules called them,
  with the same inputs.
- **C2, C3, C4, C7**: no cycles, every step justified and covered, nothing
  irrelevant.

Nothing is taken on trust. The check confirms the 33 records; a test that
had failed would simply be missing, and no check would point that out.

---

## Try it

```sh
eyeron examples/math-builtins-tests.n3
eyeron -c examples/math-builtins-tests.n3
```

In the first test, change `?abs math:equalTo 2 .` to `?abs math:equalTo 3 .`.
The record for `:test-absoluteValue-1` disappears and 32 passes remain.

---

## Takeaway

Built-ins do the arithmetic, and the checker does it again: a proof full of
calculations is only accepted when every calculation comes out the same.
