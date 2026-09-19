# Eyelang language specification 0.1

> This is the normative specification for the Eyelang language as implemented by Eyeron (`src/eye/`). See [`docs/eyelang.md`](eyelang.md) for a task-oriented overview and running instructions.

## 1. Status and terminology

This document specifies Eyelang 0.1 as implemented by the reference
interpreter. The keywords **MUST**, **MUST NOT**, **SHOULD**, and **MAY** are to
be read as normative requirements. The grammar uses ISO-style EBNF:
`[ item ]` is optional, `{ item }` is repetition, and quoted text is literal
syntax. EBNF braces are grammar notation; literal source braces appear as
`"{"` and `"}"`.

An Eyelang processor conforms to this version when it accepts the syntax below,
implements the stated results for completed evaluations, and reports rather
than silently converts syntax, validation, mode, arithmetic, or resource-limit
errors. Answer order is not significant unless this specification explicitly
defines an ordering.

## 2. Characters and lexical elements

Source is Unicode text. Identifiers are restricted to ASCII characters.
Whitespace separates tokens but is otherwise insignificant. A comment begins
with `#` outside a string and continues through the end of the line.

```ebnf
name          = ( ASCII-letter | "_" ),
                { ASCII-letter | ASCII-digit | "_" } ;
variable      = "?", name ;
unsigned-int  = ASCII-digit, { ASCII-digit } ;
unsigned-num  = unsigned-int,
                [ ".", ASCII-digit, { ASCII-digit } ],
                [ ( "e" | "E" ), [ "+" | "-" ],
                  ASCII-digit, { ASCII-digit } ] ;
string        = JSON-string ;
```

`JSON-string` is a double-quoted JSON string without an unescaped line break.
Invalid JSON escapes are syntax errors. An `unsigned-num` containing `.` or an
exponent is a finite binary floating-point number. Otherwise it is an
arbitrary-size integer. One or more leading `-` tokens negate a numeric term or
expression once per token. A non-finite floating-point literal is an error.

The words `ask`, `if`, `not`, `let`, `collect`, and `where` are contextual
keywords. In the grammatical positions shown below they have their keyword
meaning. In particular, `ask` at the beginning of a statement starts a query,
and `not`, `let`, and `collect` at the beginning of a goal start their respective
goal forms.

## 3. Concrete grammar

```ebnf
program       = { statement } ;
statement     = query | clause ;

query         = "ask", [ goal-list ], "." ;
clause        = call, [ "if", [ goal-list ] ], "." ;
goal-list     = goal, { ",", goal } ;

goal          = call
              | term, compare-op, term
              | "not", call
              | "let", term, "=", expression
              | collection ;
compare-op    = "=" | "!=" | "<" | ">" | "<=" | ">=" ;

collection    = "collect", term, "=", term, "where",
                "{", [ goal-list ], "}" ;

call          = name, [ "(", [ term-list ], ")" ] ;
term-list     = term, { ",", term } ;
term          = variable
              | string
              | signed-number
              | "true" | "false"
              | name
              | name, "(", [ term-list ], ")"
              | list ;
signed-number = { "-" }, unsigned-num ;
list          = "[", [ term-list, [ "|", term ] ], "]" ;

expression    = additive ;
additive      = multiplicative, { ( "+" | "-" ), multiplicative } ;
multiplicative = unary, { ( "*" | "/" | "//" | "%" ), unary } ;
unary         = "-", unary | primary ;
primary       = variable | string | unsigned-num | "true" | "false"
              | name | list
              | function-call
              | "(", expression, ")" ;
function-call = name, "(", [ expression,
                { ",", expression } ], ")" ;
```

The parser distinguishes a bare symbol such as `red` from the zero-argument
constructor `red()`. In call position, `ready` and `ready()` both designate the
relation `ready/0`. Lists are surface syntax for `cons/2` and `nil/0`; those
constructor names MUST NOT be invoked as relations.

Literal `{` and `}` occur only in a collection goal, after `where`:

```text
collect ?values = ?value where { reading(?sensor, ?value) }
```

They delimit a nested conjunction. They do not denote an ordinary statement
block, a graph, a set, a map, or a quoted formula. Goals inside the braces are
comma-separated and have no terminating period. The empty body `{}` is valid;
because the empty conjunction succeeds once, it collects one instance of a
ground template.

## 4. Abstract values and variables

The value domain contains:

- symbols;
- strings;
- arbitrary-size integers;
- finite binary floating-point numbers;
- booleans;
- constructor terms with a name and zero or more arguments; and
- logic variables.

Kinds are distinct. For example, `1`, `1.0`, `"1"`, `true`, `red`, and `red()`
are different terms. Lists are constructor terms and may have an open tail.

A named variable has statement scope. Every occurrence of the same named
variable in one statement denotes the same variable. Each occurrence of `?_`
denotes a fresh anonymous variable. Variables in different statements are
distinct. Clause variables MUST be standardized apart for each clause use.

Unification is structural and includes the occurs check. Equality `=` performs
unification and may bind either operand. It is not numeric coercion: `1 = 1.0`
fails.

## 5. Programs, relations, and rules

A relation is identified by its name and arity. A clause

```text
head if goal1, goal2.
```

means that `head` holds for every substitution under which the ordered body
conjunction succeeds. A clause without `if`, or with an empty body, succeeds
without premises. Multiple clauses are alternatives. Source clause order MUST
NOT be used as logical priority.

For the positive relational fragment, the declarative meaning is the least
fixed point of the clauses. The reference evaluator computes demanded answers
with variant tables: new answers cause dependent tables to be reconsidered.
Answers are deduplicated modulo variable renaming. This supports positive
left recursion, mutual recursion, and cycles for finite demanded computations.

## 6. Goal evaluation

Goals in a body are selected from left to right. A processor MUST report a mode
error when a selected operation requires ground inputs that are not yet ground;
it MUST NOT silently reorder goals.

### 6.1 Relation calls

A user relation call unifies with fresh instances of clauses having the same
name and arity. A built-in relation has the behavior in section 9.

### 6.2 Comparison

`=` is structural unification. `!=` requires two ground terms and succeeds when
they are structurally different. `<`, `>`, `<=`, and `>=` require ground numeric
operands. They compare integers and floats by numeric value without changing
the stored term kinds.

### 6.3 Calculation

`let Target = Expression` evaluates a ground expression once and unifies its
value with `Target`. It is not a reversible arithmetic constraint.

### 6.4 Negation

`not Call` requires a ground call. It succeeds exactly when complete evaluation
of that call against the immutable program has no answer. This is stratified
closed-world negation, not classical negation. Resource exhaustion MUST NOT be
interpreted as absence.

### 6.5 Collection

For

```text
collect Target = Template where { Body }
```

the processor evaluates `Body` to completion, instantiates `Template` for each
answer, removes structurally duplicate values, orders the remaining values by
canonical term key, constructs a closed list, and unifies it with `Target`.
Every collected template instance MUST be ground. No answers produce `[]`.

Bindings established before the collection are visible inside it. Variables
that remain unbound on entry and occur in its template or body are local to the
nested evaluation; their bindings do not escape through any channel other than
the collected target. Consequently, a desired correlation variable must be
bound before the `collect` goal is selected.

Collection has set semantics, not proof-bag semantics. To preserve the identity
of equal measurements from different sources, the template can contain a tagged
constructor such as `reading(?sensor, ?value)`.

## 7. Queries

`ask Body.` evaluates `Body` as an ordered conjunction. Its answer projection
contains each named variable occurring outside a collection's nested template
and body, in first-occurrence order. Anonymous variables are never projected.
Collection targets are part of the outer query and therefore are projected when
named.

A successful ground query has one answer with no bindings. A completed query
with no answer represents logical failure for that query, not an evaluation
error. Residual variables are permitted; shared identity within an answer MUST
be preserved. Answer order is unspecified.

## 8. Arithmetic expressions

`*`, `/`, `//`, and `%` bind more tightly than `+` and `-`; operators at the
same precedence associate left to right. Unary `-` has higher precedence.

- Integer-only `+`, `-`, `*`, `//`, and `%` produce integers.
- `/` produces a float.
- A mixed integer/float operation converts the integer only when it is within
  the JavaScript safe-integer range; otherwise it is an error.
- `//` requires integers and truncates toward zero.
- `%` requires a nonzero divisor and has the sign of the dividend.
- Division by zero and a non-finite result are errors.

The defined one-argument functions are:

- `abs(Number)`: absolute value, preserving integer or float kind;
- `sqrt(Number)`: floating-point square root;
- `round(Number)`: floating-point nearest integer, with ties toward positive
  infinity, returned as a float;
- `str(Value)`: lexical text for a ground value, returned as a string;
- `count(List)`: number of elements in a closed list, as an integer;
- `sum(List)`: arithmetic sum, with `sum([]) = 0`;
- `min(List)` and `max(List)`: numeric extrema of a nonempty closed list.

`concat(Arguments...)` accepts zero or more ground values and returns the
concatenation of their lexical text as a string. Strings contribute their
contents without quotes, symbols contribute their names, scalars use their
ordinary lexical forms, and structured terms use Eyelang term syntax.

An unknown function, wrong arity, wrong kind, open list, or invalid domain is an
evaluation error.

## 9. Built-in relations

The following signatures are reserved and MUST NOT be redefined:

- `range/3`: `range(Low, High, Value)` requires integer ground bounds and
  enumerates every integer from `Low` through `High`, inclusive. Reversed bounds
  have no answers.
- `length/2`: requires a ground closed list as its first argument and unifies
  the second with its integer length.
- `sort/2`: requires a ground closed list, removes structural duplicates, and
  unifies the second argument with a closed sorted list. Numbers precede other
  kinds and are ordered numerically. Remaining order is lexicographic order of
  the canonical structural term encoding.
- `sudoku/2`: requires a ground 9 by 9 list of integer rows. Zero denotes an
  empty cell. It enumerates grids respecting all givens and the row, column, and
  3 by 3 box constraints. Malformed input is an error; inconsistent givens have
  no answers.

No other relation is implicit. Relations such as `member/2` and `append/3` must
be defined by the program.

## 10. Static validation and stratification

Every called relation signature MUST be defined by at least one clause or be a
built-in. Defining a built-in signature is an error.

Let a positive dependency have weight 0 and a dependency beneath `not` or inside
a collection body have weight 1. There MUST be an assignment of nonnegative
integer strata such that, for every edge from a rule head `H` to dependency `D`:

```text
stratum(H) >= stratum(D) + weight
```

Programs with recursion through `not` or `collect` therefore fail validation.
The analysis is conservative by relation signature and does not inspect argument
values. Input modes, value kinds, function names, and groundness are checked at
evaluation time rather than by the static validator.

## 11. Completion, limits, and errors

Constructors and arithmetic can create an infinite number of calls or answers.
The language does not require every valid program to terminate. The reference
processor exposes positive limits for steps, tables, and answers. Reaching a
limit produces an explicit incomplete-evaluation error; partial answers MUST NOT
be presented as a complete result.

Syntax errors carry a source line and column. Validation, mode, arithmetic,
malformed built-in input, and incomplete-evaluation errors are distinct from a
completed query with no answers.

## 12. Explanations and interchange

For each newly tabled answer, the reference processor records one derivation
containing the applied clause, its explicit substitution, conclusion, and
premises. Positive proof references are acyclic even when the logical program
is recursive. Built-ins, calculations, completed absence, and completed
collection are trusted proof steps. Alternative derivations of an already
known answer need not be retained.

### 12.1 Result documents

A completed evaluation serializes as an Eyelang program. Format 2 starts with
the comment `# Eyelang result format 2`. Every other line is an ordinary fact
and can be loaded and queried by another Eyelang invocation. Loading a result
document asserts records; it does not execute the recorded questions or
recreate the source program. Format 1 documents remain valid Eyelang data.

The answer vocabulary is:

- `query(Id, Goals, Projection)` records a question template. Goals use the
  encodings in section 12.3.
  Projection is a list of `binding("name", Variable)` terms.
- `result(Id, complete, Count)` states that evaluation completed and gives the
  number of distinct answers. Count zero is logical failure, not an error.
- `answer(Id, Bindings)` records one solution as a list of
  `binding("name", Value)` terms. A successful ground query uses `answer(Id, [])`.
- `why(QueryId, Bindings, ProofId)` links an answer to its query proof and is
  present only when proofs are requested.

Query IDs start at one and are local to the document. Exact integers, floats,
strings, and constructor terms retain their kinds. A residual variable remains
a live variable in the output fact. Variable identity is preserved within one
fact, but variables in different facts have independent statement scope.

### 12.2 Proof records

When proofs are requested, the document additionally contains:

- `clause(Number, HeadTemplate, BodyTemplate)` once for each used source clause;
- `substitution(ProofId, Bindings)` for every proof step; and
- `proof(Id, Conclusion, Source, Premises)` for every recorded derivation.

`Source` is `rule(ClauseNumber)` for a clause step and `query` for a
query-projection step. Clause numbers identify the corresponding `clause/3`
record and are independent of whitespace and physical source position. A query
conclusion is `solution(Values)`. Proof IDs are local to the document. Positive
proof references MUST point to earlier proof records, making the recorded
derivation graph acyclic.

Clause variables are reified as `var("name")` so their identity can be compared
across separate facts. Repeated names in one clause template denote the same
source variable. Anonymous source variables are represented as locally numbered
`anonymous(N)` terms and MUST NOT occur as substitution keys. A substitution is
a list of `binding("name", Value)` terms. Residual substitution values remain
live variables, with sharing preserved within that substitution fact.

The premise vocabulary is:

- `uses(ProofId, Call)` for a positive relation answer;
- `builtin(Call)` for a successful built-in relation;
- `compared("operator", Left, Right)` for comparison or unification;
- `calculated(Value, Expression)` for `let` evaluation;
- `absent(Call, complete)` for completed ground negation; and
- `collected(Values, Template, Goals, ProofIds, complete)` for collection.

Built-ins, calculation, absence, and collection completion are trusted records.
The format is an inspectable explanation graph, not a fully independently
verified proof certificate.

### 12.3 Reified syntax

Goal templates are data terms:

- `call(Term)`;
- `absent(Term)`;
- `compare("operator", Left, Right)`;
- `calculate(Target, Expression)`; and
- `collect(Target, Template, Goals)`.

Expression templates are `value(Term)`, `unary("-", Expression)`,
`binary("operator", Left, Right)`, and `function("name", Arguments)`.
These constructors describe syntax; they are not executable goal syntax.

### 12.4 Check and JSON representations

Check-only Eyelang output consists of `checked(rules(N), queries(M))` and
`stratum("name/arity", Level)` facts. JSON is an explicitly selected API/CLI
representation rather than Eyelang syntax. Integer values in JSON use tagged
decimal strings because JSON has no arbitrary-size integer kind.

Result serialization MUST occur only after complete evaluation. Syntax,
validation, runtime, and resource-limit errors MUST NOT be serialized as empty
or complete answer documents.

## 13. RDF 1.2 N-Quads adapter

The reference implementation provides a lossless boundary mapping between an
RDF 1.2 dataset in N-Quads syntax and ground Eyelang `rdf/4` terms. This adapter
is not part of core goal evaluation and does not imply an entailment regime.

An RDF quad `(S, P, O, G)` maps to `rdf(S, P, O, G)`. Terms map as follows:

| RDF value | Eyelang term |
| --- | --- |
| IRI `u` | `iri("u")` |
| blank node with document-local label `b` | `blank("b")` |
| simple or typed literal `(lexical, datatype)` | `literal("lexical", datatype(iri("datatype")))` |
| language-tagged literal `(lexical, language)` | `literal("lexical", language("language"))` |
| directional literal `(lexical, language, direction)` | `literal("lexical", language("language", direction))` |
| triple term `(S, P, O)` | `triple(S, P, O)` |
| default graph | `default_graph` |
| named graph | its mapped IRI or blank node |

Language tags MUST be normalized to lowercase. A simple literal MUST map to the
`http://www.w3.org/2001/XMLSchema#string` datatype. Lexical forms MUST otherwise
be preserved. Blank-node identity MUST be preserved within one input document
and kept distinct between documents loaded by one CLI invocation.

`--rdf-input FILE` MUST parse RDF 1.2 N-Quads and prepend the resulting ground
facts to the Eyelang program. It may be repeated. `--rdf-output` MUST query the
complete `rdf/4` relation after evaluation and serialize its distinct ground
answers as deterministic N-Quads with a `VERSION "1.2"` announcement. Invalid
RDF positions, malformed terms, non-ground output, and unsupported version
announcements MUST be errors. The adapter follows [RDF 1.2 Concepts and Abstract
Data Model](https://www.w3.org/TR/rdf12-concepts/) and [RDF 1.2
N-Quads](https://www.w3.org/TR/rdf12-n-quads/).

## Appendix A. Complete collection example

```text
reading(sensor_a, 10).
reading(sensor_b, 15).
reading(sensor_c, 10).

summary(?readings, ?count) if
    collect ?readings = reading(?sensor, ?value) where {
        reading(?sensor, ?value)
    },
    let ?count = count(?readings).

ask summary(?readings, ?count).
```

The braces belong to `collect`. The result contains three tagged readings;
collecting only `?value` would instead produce the distinct set `[10, 15]` in
canonical collection order.
