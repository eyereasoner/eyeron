# Cliron: CLIF port of Eyeron

**Cliron** is the working name for a Common Logic Interchange Format (CLIF) front-end to Eyeron's Rust reasoning engine. The name combines **CL** with **iron**, preserving the strength/metal motif behind Eyeron while removing the N3-specific “Eye” association from the syntax layer.

## Why this is an additive port

Eyeron's matcher and materializer operate on a compact `Triple`/`Rule` internal model. CLIF is not an RDF syntax: atomic sentences are n-ary, terms may be functional, variables are introduced by quantifiers, and full Common Logic includes classical Boolean structure that cannot be represented faithfully as forward Horn rules.

The first Cliron port therefore keeps Eyeron's optimized rule engine and adds an explicit lowering layer for the executable Horn/core fragment of CLIF. It does **not** claim full ISO/IEC 24707 conformance.

## Supported CLIF core

- `cl:text` containers and multiple top-level sentences;
- atomic sentences of arbitrary arity;
- functional terms, represented structurally for unification;
- `forall` around Horn rules;
- `exists` for top-level witnesses and existential rule conclusions;
- guarded quantifier bindings such as `((x Human))`;
- `and` in texts, antecedents, and consequents;
- `if` Horn implications;
- Horn-compatible `iff`, lowered to two implications;
- equality tests with `=` in rule antecedents;
- quoted strings, enclosed names, integers, decimals, and scientific notation;
- CLIF rendering of derived atomic sentences.

## Deliberately rejected for now

Cliron reports an error instead of changing the meaning of constructs that need a stronger logical engine:

- classical `or` and `not`;
- equations as materialized conclusions or equality axioms;
- unrestricted universal conclusions that require enumeration of the domain;
- sequence markers;
- `cl:imports`, domain restrictions, discourse declarations, and prefix processing;
- full CLIF module/comment/text metadata;
- proof output in CLIF.

These are the main steps between this initial executable CLIF fragment and a full Common Logic reasoner.

## Example

```clif
(cl:text
  (Human Socrates)
  (forall (x)
    (if (Human x)
        (Mortal x))))
```

Run it with:

```bash
cargo run --release --bin cliron -- examples/socrates.clif
```

Expected derived output:

```clif
(cl:text
  (Mortal Socrates)
)
```

## Architecture

CLIF atoms are lowered to ordinary Eyeron triples using an internal tagged argument vector. The predicate remains in the triple predicate position, so Eyeron's predicate indexes and agenda machinery continue to work. This also preserves arbitrary CLIF arity without pretending an n-ary relation is an RDF binary predicate.

Quantified CLIF names are lowered to Eyeron variables. Existential witnesses are lowered to blank terms; in rule conclusions they benefit from Eyeron's existing deterministic blank generation per firing. Functional CLIF terms are represented as tagged nested term vectors and are unified structurally by the existing recursive term matcher.

A future full port should replace the triple-only logical AST with a Common Logic sentence AST and either add a first-order proof procedure or connect the parser to an established FOL/CL backend. The lowering used here can remain as a fast path for the Horn fragment.
