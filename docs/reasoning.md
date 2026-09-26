# How Eyeron reasons

Eyeron reads Notation3 (N3) and SPARQL 1.2 RL (SRL). Each has its own parser and evaluator; changing a file extension does not translate a program.

## Forward reasoning

Both formats start with facts, apply matching rules, add new conclusions, and repeat until no more facts can be derived. The resulting fact set is the **closure**.

- **N3** uses an agenda and fact indexes to activate matching rules. Backward rules (`<=`) are proved on demand when a forward rule needs them; `log:query` asks a goal against the closure.
- **SRL** stratifies rules into layers so `NOT` clauses run only after rules that could produce the negated pattern have finished. Each layer reaches a fixpoint. With `--query-mode backward`, SRL proves a query pattern directly without materializing the closure.

## Output and proofs

N3 prints newly derived facts. SRL prints its inference graph: the rule set's own `DATA` facts not already in the immutable `--data` base graph, plus derived facts.

```bash
eyeron examples/socrates.n3
eyeron examples/socrates.srl
```

Both formats can write a proof with `--proof`. A proof records each conclusion, the rule or fact that supports it, its bindings, and its premises. An N3 proof is an N3 document; an SRL proof is an `.srl` rule set. See [the guide](guide.md#proofs) for examples and [proof checking](proof-checking.md) for the validity rules.
