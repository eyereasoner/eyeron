# <img src="assets/eye.png" alt="" width="48" height="48" align="absmiddle"> Eyeron specification

**Status of this document.** This document specifies the Notation3 (N3)
language as Eyeron implements it: its terms, rules, and quantifier scopes, how
a program is evaluated, its built-ins, the N3 proofs Eyeron writes, and the
validity conditions C1–C9 its proof checker applies. It describes the current
implementation. Sections and paragraphs marked *informative* explain or
illustrate and add no requirements. The [guide](GUIDE.md) describes the
command line, browser playground, Rust library, and development, and is
informative.

**Abstract.** Eyeron derives conclusions from N3 facts and rules over N3 and
RDF input. Rules run forward to a fixpoint or backward on demand; scoped
negation and collection read the saturated graph; a blank node in a rule
conclusion introduces an existential witness only when no known fact already
satisfies it. A run can write an N3 proof of exactly what it outputs, and a
separate checker re-performs that proof's recorded inferences against the
source program, reporting what it verified and which assumptions it accepted.

## Table of Contents

1. [Introduction](#1-introduction)
   1. [Scope](#11-scope)
   2. [Requirements Language](#12-requirements-language)
   3. [Terminology](#13-terminology)
   4. [Conformance](#14-conformance)
2. [Documents and Terms](#2-documents-and-terms)
   1. [Terms and Rules](#21-terms-and-rules)
   2. [Explicit Quantification](#22-explicit-quantification)
   3. [Graph Terms](#23-graph-terms)
   4. [Multiple Inputs](#24-multiple-inputs)
   5. [RDF Syntaxes](#25-rdf-syntaxes)
3. [Graph Inclusion and Negation](#3-graph-inclusion-and-negation)
4. [Existential Conclusions](#4-existential-conclusions)
   1. [Pieces](#41-pieces)
   2. [Restricted Introduction](#42-restricted-introduction)
   3. [Witness Identity](#43-witness-identity)
   4. [Data with Blank Nodes](#44-data-with-blank-nodes)
5. [Inference Fuses](#5-inference-fuses)
6. [Evaluation](#6-evaluation)
   1. [Forward and Backward Rules](#61-forward-and-backward-rules)
   2. [Deferred Tests and Introductions](#62-deferred-tests-and-introductions)
   3. [Queries and Output](#63-queries-and-output)
   4. [Resource Limits](#64-resource-limits)
7. [Built-ins](#7-built-ins)
8. [RDF Messages](#8-rdf-messages)
9. [Proofs and Verification](#9-proofs-and-verification)
   1. [Purpose](#91-purpose)
   2. [Checking and its Scope](#92-checking-and-its-scope)
   3. [Model](#93-model)
   4. [Validity Conditions](#94-validity-conditions)
   5. [Verified Justifications](#95-verified-justifications)
   6. [Trust Obligations](#96-trust-obligations)
   7. [Unproven Steps](#97-unproven-steps)
   8. [N3 Proof Syntax and Reading](#98-n3-proof-syntax-and-reading)
   9. [Reporting](#99-reporting)
   10. [Implementation Coverage](#910-implementation-coverage)
10. [Compatibility and Limitations](#10-compatibility-and-limitations)
11. [Security Considerations](#11-security-considerations)
12. [References](#12-references)
    1. [Normative References](#121-normative-references)
    2. [Informative References](#122-informative-references)

## 1. Introduction

### 1.1 Scope

This specification defines:

- N3 documents, terms, rules, quantifier scopes, graph terms, and how separate
  inputs combine (Section 2);
- graph inclusion and scoped negation (Section 3), existential conclusions
  (Section 4), and inference fuses (Section 5);
- how a program is evaluated and what it outputs (Section 6);
- the built-ins (Section 7) and RDF Message Log processing (Section 8);
- N3 proofs and the conditions under which a proof checks (Section 9).

*Informative.* Eyeron is an N3 reasoner. RDF syntaxes supply data to N3 rules;
choosing one does not make Eyeron an OWL reasoner, a SPARQL engine, or a graph
store (Section 10).

### 1.2 Requirements Language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this
document are to be interpreted as described in BCP 14 [RFC2119] [RFC8174]
when, and only when, they appear in all capitals, as shown here.

### 1.3 Terminology

Fact
: A triple asserted by a source document.

Rule
: An implication `{ premise } => { conclusion }` (forward) or
  `{ conclusion } <= { premise }` (backward).

Universal, existential
: A variable bound by `@forAll` or written `?x` (universal), or bound by
  `@forSome` or written as a blank node (existential).

Graph term
: A quoted graph `{ ... }` used as a value, with its own binders (Section 2.3).

Current graph
: The facts known to the run: the input facts and everything derived so far.

Closure
: The facts materialized by forward reasoning, including the input facts.

Existential piece
: The conclusion triples of one rule that share existentials; its *frontier*
  is the universal variables those triples mention (Section 4.1).

Witness
: The fresh blank node introduced for an existential (Section 4.3).

Proof, step, claim
: An N3 document recording derived statements (claims) and the steps that
  support them (Section 9.3).

Obligation
: A justification the checker accepts without re-establishing it
  (Section 9.6).

### 1.4 Conformance

Eyeron is the implementation this specification describes. Its reasoner
satisfies Sections 2–8, its proof writer produces documents in the syntax of
Section 9.8, and its proof checker applies Sections 9.2–9.9. A proof checks
only when no condition of Section 9.4 fails. The test suites listed in
Section 9.10 are informative evidence of that behavior, not part of the
contract.

## 2. Documents and Terms

### 2.1 Terms and Rules

```n3
@prefix : <http://example.org/>.
:Socrates a :Human.
{ ?x a :Human } => { ?x a :Mortal }.
```

The syntax is that of [N3]. The parser supports prefixes, bases, IRIs, variables, blank nodes, literals,
lists, and quoted graph terms. N3 keeps its conventional prefixes. `=>` names
`log:implies`; `<=` names `log:impliedBy` and registers a backward rule. A
rule's conclusion MAY generate rules, which then run like source rules, or MAY
unquote a graph supplied by its bindings. `=`, the syntax for `owl:sameAs`,
asserts a relation; substitutions through opaque quoted graphs require
explicit rules, as in [graph-term-opacity.n3](examples/graph-term-opacity.n3).

*Informative.* Lists remain `Term::List` values; they can also be inspected
through virtual `rdf:first`/`rdf:rest` matching and list built-ins. Quoted
graphs and rule sides are `Graph` values with `universals`, `existentials`,
and `triples`. `Term::formula` and `Rule::new` accept triple vectors too.

### 2.2 Explicit Quantification

```n3
@prefix : <http://example.org/>.
@forAll :x.
@forSome :y.
:x :loves :y.
```

This means "everybody loves somebody." Declarations MUST precede the graph's
first triple, with `@forAll` before `@forSome`. Each IRI MAY be declared once
per graph; comma-separated IRI lists are accepted. Prefix and base resolution
happens before binding lookup. Quantified IRIs work in every triple position
and remain accessible in nested graphs; an inner declaration shadows an outer
one.

Implicit `?x` variables belong to the outermost graph. Blank nodes belong to
their innermost graph. `?x` and `_:x` are distinct variables. To put an
existential outside a universal, nest the universal:

```n3
@prefix : <http://example.org/>.
@forSome :beloved.
{} => { @forAll :person. :person :loves :beloved }.
```

Universal assertions are instantiated on demand rather than by enumerating an
infinite closure. Existential witnesses depend on the universal assignment
within their scope.

### 2.3 Graph Terms

Graph terms retain their binders and are compared as sets, up to bijective
renaming of locally bound variables of the same quantifier kind. Duplicate
triples and unused declarations do not change identity. Substitution reaches
free variables inside nested graphs while preserving local binders. A graph
with locally quantified variables can therefore be ground; a graph referring
to an outer universal remains open.

Graph terms are opaque and keep literal lexical identity: inside a quoted
graph `"01"^^xsd:integer` is not `1`, while `()` is `rdf:nil`. Numeric
matching outside graph terms compares values.

Examples: [graph terms and unquoting](examples/graph-terms.n3), [explicit
quantification and shadowing](examples/explicit-quantification.n3),
[existential rule](examples/explicit-existential-rule.n3), [universal
instances](examples/universal-instances.n3), [graph
inclusion](examples/graph-includes.n3), and [shared
existential](examples/shared-existential.n3).

### 2.4 Multiple Inputs

Files given together are parsed separately and merged with their blank-node
and quantifier scopes kept apart: the same blank-node label in two inputs
denotes two individuals. Rule-only variables keep their names, so proofs show
the names the source used. To refer to one individual across inputs, use one
resolved IRI.

### 2.5 RDF Syntaxes

Turtle, TriG, N-Triples, N-Quads, and RDF Message Logs supply RDF 1.2 data
[RDF12-CONCEPTS] and follow their grammars strictly: an undeclared prefix, a prefixed name in N-Triples or N-Quads, and a
misplaced dot after `@version` or `VERSION` are errors. N-Triples and N-Quads
accept an uppercase `VERSION "1.2"` announcement on its own line, using a
double-quoted short string and no trailing period; prefix, base, and
Turtle-style `@version` directives remain invalid in these line syntaxes.

## 3. Graph Inclusion and Negation

`log:includes` tests existential consequence without instantiating the subject
graph's universally quantified variables.

With a quoted subject, `log:notIncludes` is the complement of `log:includes`:
both match the object as quoted statements without executing their
predicates, and compare literals by lexical form, so `{ :a :p
"01"^^xsd:integer }` does not include `{ :a :p 1 }`.

Over the current graph, `log:includes` matches facts by value, as ordinary
premises do, and `log:notIncludes` tests whether its object clause has no
solution, using goal matching and evaluating built-ins in that clause. Any
subject other than a quoted graph names the current graph. Locally bound blank
patterns do not inherit bindings from outside the clause.

Scoped tests over the current graph are deferred (Section 6.2): they read the
graph once ordinary reasoning is saturated, and are reconsidered when more
facts are derived.

## 4. Existential Conclusions

A blank node, or an `@forSome` variable, in the conclusion of a forward rule
is an existential: the conclusion says that *some* individual stands in those
relations. Eyeron introduces such an individual only where no known one
already fits. This is the restricted, or lean, introduction described in
[STRATNEG].

### 4.1 Pieces

The conclusion triples of a rule that share existentials, directly or through
other conclusion triples, form a *piece*. The piece's *frontier* is the
universal variables it mentions. Conclusion triples without an existential
belong to no piece and are derived as usual. An existential inside a quoted
graph in the conclusion belongs to that graph, not to the conclusion.

### 4.2 Restricted Introduction

When a forward rule with premises fires, each of its pieces is introduced only
if no fact of the current graph satisfies it: no facts match the piece's
triples with the frontier bound to the firing's values and the existentials
matching any values. A blank node that the frontier is bound to is an
individual in that test, not a pattern. A satisfied piece derives nothing.

Because whether a piece is satisfied depends on the whole current graph, a
rule that introduces existentials MUST NOT decide before ordinary reasoning is
saturated; it is deferred like a scoped test (Section 6.2). The piece's own
conclusions do not count against it: its first introduction satisfies it, so a
piece is introduced at most once per frontier assignment.

```n3
@prefix : <https://example.org/course#> .
@prefix log: <http://www.w3.org/2000/10/swap/log#> .

:philosophy :teacher :russell .
:philosophy :participant :wittgenstein .
{ ?course :participant ?person . } => { ?person a :Student . } .
{
    ?course :teacher ?person .
    ?scope log:notIncludes { ?person a :Student . } .
} => {
    ?course :examiner ?person .
} .
{ ?course :participant ?person . } => { ?course :examiner _:examiner . } .
```

*Informative.* Russell is a teacher who is not a student, so he is an
examiner, and the course's piece `?course :examiner _:examiner` is satisfied:
no fresh examiner is introduced. [examiners.n3](examples/examiners.n3) counts
the result.

### 4.3 Witness Identity

An introduced existential gets a fresh blank node, its witness, shared by every
triple of its piece in that firing. Distinct existentials and distinct
frontier assignments get distinct witnesses. Witness labels are derived from
the firing and are output labels, not portable identifiers.

### 4.4 Data with Blank Nodes

A blank node in a fact, or in the conclusion of a rule without premises
(`{} => { ... }`), states data and is always introduced. Instances of
universal source assertions with dependent existentials (Section 2.2) are
likewise taken as given. Existentials in backward-rule and query conclusions
are not tested for satisfaction.

## 5. Inference Fuses

A rule with conclusion `false` forbids its premise. If the premise succeeds,
reasoning stops and sets `ReasonerResult.fuse`. The CLI prints the fired rule
and its matched instance and exits with status 65. This does not implement
general classical reasoning from a contradiction.

A built-in's statements are exactly those it holds for, so a forward rule that
derives a closed statement a pure built-in rejects, such as `(1 2) math:sum 4`
or `{ :a :b :c } log:includes { :d :e :f }`, derives a contradiction. It trips
a fuse in the same way, and the CLI prints the rejected statement and the rule
that derived it. Statements with a free variable or blank node,
`rdf:first`/`rdf:rest`, built-ins that read outside their arguments, and scoped
tests over the current graph remain ordinary data.

## 6. Evaluation

### 6.1 Forward and Backward Rules

Explicit facts seed the closure. Forward rules add unseen conclusions until
saturation, a fuse, or a reported limit or error. Fact indexes and an agenda
accelerate eligible rules; other rules use general premise matching. Backward
rules are standardized apart and searched on demand with cycle and depth
controls. Universal assertions also supply answers on demand, so the closure
does not enumerate every universal instance.

### 6.2 Deferred Tests and Introductions

Rules with a scoped collection or negative test over the current graph
(`log:notIncludes`, `log:collectAllIn`, `log:forAllIn`), and rules that
introduce existentials (Section 4.2), are deferred: they run once ordinary
forward reasoning is saturated, and are reconsidered whenever more facts are
derived. Deferred rules without existential introductions run before
introductions whose positive premises they can enable. A deferred rule whose
conclusion or ordinary forward consequences could satisfy another rule's
existential piece also runs before it. Completing a piece using both existing
premise facts and a rule's conclusion takes precedence over introducing the
whole piece: the support
must match under one consistent substitution, so separate individuals do not
form one reusable graph. Otherwise deferred rules keep source order, including
unresolved dependency cycles. Ordinary forward consequences of earlier
deferred rules MUST saturate before a later existential introduction decides.

Current-graph tests used by firings that add conclusions are retained. Before
returning results, the reasoner MUST reject a run whose inference facts
contradict a retained absence, collection, or universal test under the finite
evidence checks in Section 9.6. Such a contradiction trips an inference fuse
and suppresses conclusions, regardless of whether proof capture is enabled.
Query answers do not enter this evidence. External reads are not re-executed.

*Informative.* The order lets a negation name an existing individual before an
existential that individual satisfies, and lets a rule introduce a larger
piece before a smaller one it covers. A program whose deferred rules depend on
each other's results in a cycle can still depend on that order; invalidated
current-graph tests stop the run rather than produce a successful result.

### 6.3 Queries and Output

`log:query` rules run after deferred reasoning, selecting answers without
feeding them back into the closure. `ReasonerResult` separates input facts,
derived results, and the closure. Normal output serializes derived results,
or query answers when queries are present. `log:outputString` results
override triple serialization with concatenated text. `--proof` instead writes
a proof of the output (Section 9).

### 6.4 Resource Limits

`ReasonerOptions` supplies these default budgets. The CLI exposes
`--max-backward-depth`; the other fields are library settings.

| Field | Default | Scope |
| --- | --- | --- |
| `max_iterations` | 1,000,000 | Forward outer passes plus agenda steps |
| `max_match_steps` | 200,000 | Steps in one premise search |
| `max_backward_depth` | 32 | Recursive backward search depth |
| `max_backward_solutions_per_goal` | 1,024 | Retained substitutions for one backward goal |
| `max_term_bytes` | 16 MiB | Term text in one derived fact |

Reaching a reasoning budget MUST be reported through `limits_reached`,
completion status, and `incomplete_summary()`. These are operation and term
budgets, not a whole-process memory or wall-clock limit. A single firing can
produce several facts, so `max_iterations` is not a closure-size cap.

Term nesting is capped at 64 levels: deeper input is a parse error; deeper
derived terms report `ReasonerLimit::TermDepth`. `string:format` refuses field
widths larger than the default term-byte bound and yields no binding. Exact
integer exponentiation has a fixed size guard. Invalid built-in arguments
usually produce no match rather than an incomplete run.

## 7. Built-ins

These names are dispatched in [reasoner.rs](src/reasoner.rs). Supported
argument directions depend on the built-in; an unbound input is not generally
an invitation to enumerate values.

| Namespace | Names |
| --- | --- |
| `log:` | `equalTo`, `notEqualTo`, `collectAllIn`, `forAllIn`, `conclusion`, `conjunction`, `includes`, `notIncludes`, `uri`, `rawType`, `dtlit`, `langlit`, `content`, `semantics`, `semanticsOrError`, `parsedAsN3`, `skolem`, `uuid` |
| `math:` | `sum`, `difference`, `product`, `quotient`, `integerQuotient`, `remainder`, `exponentiation`, `negation`, `absoluteValue`, `rounded`, `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `sinh`, `cosh`, `tanh`, `degrees`, `greaterThan`, `lessThan`, `notGreaterThan`, `notLessThan`, `equalTo`, `notEqualTo` |
| `list:` | `first`, `rest`, `firstRest`, `last`, `length`, `member`, `memberAt`, `in`, `notMember`, `remove`, `append`, `reverse`, `sort`, `iterate`, `map` |
| `string:` | `lessThan`, `greaterThan`, `notLessThan`, `notGreaterThan`, `concatenation`, `contains`, `containsIgnoringCase`, `startsWith`, `endsWith`, `equalIgnoringCase`, `notEqualIgnoringCase`, `format`, `matches`, `notMatches`, `replace`, `scrape` |
| `time:` | `year`, `month`, `day`, `hour`, `minute`, `second`, `timeZone`, `localTime` |
| `crypto:` | `sha` |

Namespace prefixes above use `http://www.w3.org/2000/10/swap/` plus the
namespace name and `#`, the namespaces of [SWAP]. Additional datatype inspection predicates are
`datatype` and `lexicalForm` under
`https://eyereasoner.github.io/eyeron/datatype#`, with the corresponding
`eyeling` namespace aliases. The nonstandard
`https://eyereasoner.github.io/eyeling/vocab/sudoku#solve` solves an
81-character Sudoku string.

Behavior to account for:

- The six math comparison predicates also compare `xsd:date` and
  `xsd:dateTime` by parsed instants; dates use midnight and absent time zones
  use UTC. Durations keep their own comparison conversion.
- Regular expressions use Rust's Unicode-aware engine, with compatibility
  handling for specific look-around forms covered by the tests.
- `log:collectAllIn` returns one list for its scoped clause. A blank node
  already supplied by an outer binding is a fixed value; a syntactic blank in
  the clause is an existential pattern.
- `log:uuid` returns a deterministic UUID-shaped string based on SHA-1 of a
  term's text, with version and variant bits. It does not include a UUID
  namespace. Different literal datatypes can share a result when their
  lexical text is the same. `log:skolem` instead returns an IRI.
- `log:content` and `log:semantics` recognize the bundled `HELLO` fixtures.
  They do not fetch arbitrary resources. `log:semanticsOrError` returns a
  resource-error string for other IRIs. CLI URL input is fetched by the CLI
  separately.

## 8. RDF Messages

Normal replay parses a whole RDF Message Log into `eymsg:` envelopes and
quoted message payloads, which rules can inspect with `log:includes`. See
[rdf-messages.n3](examples/rdf-messages.n3) and its
[input](examples/input/rdf-messages.trig).

For independent message processing:

```bash
eyeron --rdf --stream-messages \
  examples/alma-rdf-messages.n3 \
  tests/input/alma-rdf-messages-small.nt
```

The streaming path incrementally reads local files or HTTP(S), reasons over
each payload with a prepared N3 program, and flushes its RDF output. It
retains no derived facts between payloads. It requires `--rdf` and rejects
stdin message logs, `--proof`, `--prove-and-check`, `--check-proof`, `--ast`,
and `--stream`.

## 9. Proofs and Verification

This section is the validity contract implemented by
[proof_check.rs](src/proof_check.rs) and its [N3
reader](src/proof_check_n3.rs). Code comments refer to its numbered
subsections. The [guide](GUIDE.md#proofs-and-their-limits) covers commands and
a decision-and-audit example.

### 9.1 Purpose

A proof records derived claims and the steps supporting them. Checking asks
whether those recorded steps establish their claims from the supplied source
program.

### 9.2 Checking and its Scope

The checker MUST check the recorded inferences rather than search for
replacement derivations. It assumes source assertions. It establishes neither
their real-world truth nor completeness of the reasoner's output. Trusted
justifications remain explicit obligations.

`--check-proof` reads a saved proof. `-c` first generates a proof, then invokes
the same checker on that document. Generation and checking are separate stages
even within that command.

### 9.3 Model

A step has a conclusion triple, one justification, bindings, and an ordered
list of premises (`uses`). A proof also has claims: what the run outputs, which
for a program with `log:query` rules is their answers alone. A proof claims
exactly what the run outputs. The source supplies facts and rules, numbered
from 1 in source order after excluding query rules. Written rules are also
available as statements. Universally quantified source assertions can justify
their instances. Inference evidence consists of source assertions and
non-query step conclusions. Query-only answers belong to the output and do not
enlarge that evidence.

### 9.4 Validity Conditions

| Condition | Requirement |
| --- | --- |
| **C1: resolution** | Each rule step MUST re-perform one application of the cited source rule, or of a justified carried rule, under consistent bindings (9.5.1). Each fact step MUST state a source assertion or a permitted instance of one (9.5.2). |
| **C2: well-foundedness** | The resolved step dependencies, including carried-rule provenance, MUST be acyclic. |
| **C3: justification** | Each step MUST have exactly one supported justification of a well-formed kind. Only rule steps may have premises or bindings. Bindings MUST identify variables of that rule, without aliases assigning the same variable twice. `unproven` and a built-in named for another predicate fail. No statement may be claimed twice. |
| **C4: coverage** | Every premise, carried rule, and claim MUST resolve to a step conclusion or a source assertion. |
| **C5: re-decision** | Each built-in step MUST hold when re-evaluated on its recorded arguments (9.5.3), unless it is a trust obligation (9.6). A rule step MUST NOT conclude a closed statement of a pure built-in that re-evaluation rejects. |
| **C6: boundary consistency** | The proof's evidence MUST NOT contradict what its obligations assume (9.6), and MUST NOT satisfy the premise of a source inference fuse. |
| **C7: relevance** | Every step MUST serve a claim: some claim depends on it. With `log:query` rules in the source, every claim MUST be an instance of a query's conclusion. |
| **C8: witness integrity** | Each introduced existential MUST have a fresh blank witness under a concrete universal assignment. One existential in one firing MUST keep one witness across all its conclusions; distinct existentials or firings MUST NOT share it. This also applies to instances of universal source assertions, including direct premise and claim resolution. |
| **C9: query isolation** | A query-only answer MUST NOT supply an inference premise or carried rule, or enter consistency-checking evidence. Every output claim in a program with queries MUST have a supported query application: matching a query head alone is insufficient. |

*Informative.* C1 and C5 re-perform what the proof records; C2 and C4 check
its structure; C3 its form; C6 looks inside the proof for evidence against its
assumptions; C7 keeps the steps relevant. C8 checks quantified individuals
across applications, and C9 checks the boundary between inference and output.
Malformed proof metadata (9.8) is a reader error rather than a C3 failure,
because no report can attribute it to a step.

The report records failures with their condition, affected conclusion, and
detail, and lists every condition with how many items it examined and how many
failures it found. `checked` means no failures or obligations; `checked with
obligations` means no failures but some justifications are trusted. `invalid`
means at least one condition failed. Empty proofs can check with zero steps;
this does not demonstrate that a source program derived anything.

### 9.5 Verified Justifications

#### 9.5.1 Rules

For `pe:rule N`, the checker MUST take rule N from the supplied program, not an
unverified copy in the proof. It checks that recorded bindings, premises, and
conclusion form one application of that rule:

1. Map source variable names to the rule's internal names and initialize a
   fresh binding environment.
2. Require the number of `uses` entries to match the rule's premises.
3. Match corresponding premises in order, sharing that environment.
4. Require at least one rule-head triple to match the claimed conclusion under
   the same environment. For unquoting conclusions, resolve the graph supplied
   by the bindings first.

Bindings MAY be partial; matching extends them consistently, including
obtaining an unquoted conclusion from a recorded premise. Matching is one-way:
only the rule's variables bind, and variables in the recorded step stay rigid.
Local graph binders keep their scopes; equal blank labels in the two rule
sides do not merge those scopes. A blank quantified outside the rule is one
fixed individual for every firing, including when the rule is cited as a
statement or carried rule.

C8 checks introductions across the whole proof. A blank node scoped to the
head is an existential. Its witness MUST be a blank node that neither the
source's existing individuals nor the application's premises and bound values
mention. Its universal assignment MUST be concrete; a proof cannot turn
"everyone has some parent" into one fixed parent for everyone by leaving the
person unbound. A firing is identified by its rule and recorded variable
assignment, including blank patterns in its premises. Each existential of that
firing keeps one witness across all its head triples, and no other existential
or firing may introduce it. If several head triples are indistinguishable, the
checker tries their possible correspondences and requires one consistent
assignment, independently of step order. Dependent existentials in universal
source assertions obey the same checks.

A step that introduces an existential of a forward rule with premises also
assumes that no fact already satisfied its piece (Section 4.2). That
assumption is an `unsatisfied` obligation (9.6): the application is
re-performed under C1, and the step is counted as trusted.

Generated rules and query rules can be carried as `pe:rule { { ... } => { ...
} }`, or with `<=`. Their rule statement MUST be an instance of an available
source statement or a proof-step conclusion, up to the reader's renaming
rules, before the application is checked. When a proof step supplies that
rule, it adds a dependency subject to C1 and C2; a rule cannot justify its own
derivation through a cycle. The reader recognizes reversed
`log:implies`/`log:impliedBy` representations of the same rule. Carried
backward rules can use an original variable name as a binding alias when it
uniquely identifies one of their standardized variables; the binding is
applied and checked, rather than ignored.

C9 distinguishes query-only answers from ordinary assertions. Such an answer
MAY be claimed, but MUST NOT supply another step's premise or carried-rule
provenance. If the source also supplies the same assertion or an equivalent
ordinary rule, that independent inference support remains available. Query
answers do not trip inference fuses or contradict absence tests merely by
being printed.

A query selecting an already proved fact can omit a separate query step. The
checker then matches one complete query application against source assertions
and non-query recorded steps, sharing bindings across every condition. It MAY
re-decide pure built-ins, but MUST NOT invent external reads or current-graph
obligations. Every recorded step used by the selection becomes a dependency of
the claim for C7. No replacement derivation is searched for: this checks
selection over the evidence already present.

#### 9.5.2 Facts

For `pe:fact`, the checker MUST find the conclusion among the source
assertions, their permitted instances, or equivalent rule statements. A fact
step MUST have no premises. Its file label is descriptive; source membership
is what the checker verifies, not authentication of a document or authority.

#### 9.5.3 Built-ins

For `pe:builtin`, the named relation MUST agree with the conclusion's predicate
(C3) and hold when re-evaluated on its arguments (C5). It has no `uses` or
bindings of its own. Value arguments MUST NOT leave universals unbound,
including inside quoted values. Scoped graph tests and `log:conjunction` MAY
carry symbolic graphs, templates, and conditions, but re-evaluation MUST NOT
assign their recorded value variables to make the relation hold. Local graph
quantifiers remain local. A collection's result MUST be a list; its template
and condition MAY be open. Graph inclusion and exclusion require a quoted
object, and a universal test requires two quoted clauses. These shape checks
also apply when the result is an obligation; external relations MUST also have
compatible input and output types.

Scoped built-ins whose scope is a quoted graph (`log:includes`,
`log:notIncludes`, `log:collectAllIn`, `log:forAllIn`) and `log:conjunction`
are re-decided. Built-ins that read outside the proof, and scoped tests over
the current graph, are obligations instead (9.6). An unsupported built-in
fails C5; its name cannot make it a trust obligation.

### 9.6 Trust Obligations

An obligation is a justification the checker accepts without re-establishing
it. Each is listed with its kind and conclusion:

- `impure built-in`: `time:localTime`, `log:content`, `log:semantics`,
  `log:semanticsOrError`, `list:map`, and `log:conclusion`, which obtain a
  clock value, external document, fact-set lookup, or result from running the
  reasoner itself. An external read nested in a clause that is executed (a
  negative test over the current graph, a collection, or a universal test) is
  also an obligation; quoting the clause does not make that read pure. A
  negative test over a quoted graph only matches quoted statements, so a read
  nested there is not executed.
- `absent`: `log:notIncludes` over the current graph. Its scope is anything but
  a quoted graph, or the stand-in graph `{ <http://example.org/a>
  <http://example.org/b> <http://example.org/c> }` an unbound subject is bound
  to after the current graph has been tested.
- `collected`: `log:collectAllIn` and `log:forAllIn` over the current graph.
- `current graph`: `log:includes` over the current graph.
- `unsatisfied`: a rule step that introduces an existential (9.5.1), which
  assumes that no fact of the current graph satisfied its piece.

Whether a test over the current graph held depends on everything the run
derived, which a proof does not record, so its truth is assumed. Its
consistency is not (C6): the checker re-evaluates the test over the proof's
evidence alone and fails when that evidence contradicts it. A negation fails
when the evidence includes what it says is absent. A collection fails when the
evidence supplies a member its recorded list omits. A universal test fails
when the evidence has a counterexample whose conclusion consists of built-ins,
since only those can be refuted without inference. An introduction fails when
the evidence satisfies its piece under the firing's frontier values, except
through the firing's own consequences: a statement that mentions one of the
firing's witnesses, or that depends on such a statement, does not count. The
evidence is only what the proof records, so C6 can find a contradiction but
cannot establish that a negation, collection, or introduction was right.

An inference fuse is tripped only by supported conditions. Matching MAY replay
pure built-ins, but missing evidence cannot establish a negative premise or an
external observation. A recorded obligation can supply such a condition and
thereby trip a fuse. Clauses that execute external reads remain impure; C6
does not re-read the clock or a document to contradict a previously recorded
value. An implicit query selection that needs a dependent existential instance
requires its recorded fact step, so witness checking cannot be bypassed by
hiding the instance in a filter.

Acceptance records an assumption; it does not establish that the trusted
relation holds. Consumers can reject reports with nonempty `obligations` even
when `Report::valid()` is true. The CLI returns success for both successful
verdicts.

### 9.7 Unproven Steps

`pe:unproven` means the proof writer could not supply support. The checker
MUST report it as a C3 failure. It is not a trusted assumption.

### 9.8 N3 Proof Syntax and Reading

The proof vocabulary is `https://eyereasoner.github.io/pe#`.

| Meaning | Syntax |
| --- | --- |
| Claim | A top-level statement with a non-`pe:` predicate, including formula subjects and rule assertions |
| Step conclusion | `{ s p o }` as the subject of its `pe:` statements |
| Numbered rule | `pe:rule N` |
| Carried rule | `pe:rule { { premises } => { conclusions } }` (or `<=`) |
| Source assertion | `pe:fact "label"` |
| Built-in relation | `pe:builtin predicate` |
| Missing support | `pe:unproven "reason"` |
| Binding | `pe:binding [ pe:var "name"; pe:value value ]` |
| Premise | `pe:uses { s p o }`, repeated for multiple premises |

The reader groups step metadata by its quoted subject, which MUST contain one
triple. Uses also wrap one triple. It resolves recorded conclusions directly,
allowing consistent local renaming in closed graph terms. Source facts
containing free universals and written rule statements are matched as
instances. Free variables on the recorded side stay rigid even if an input
spells an IRI resembling an internal placeholder.

The `pe:` namespace is reserved for proof metadata. Every step MUST have
exactly one recognized justification, and each premise MUST wrap exactly one
triple. Rule numbers MUST be positive `xsd:integer` values; fact labels and
unproven reasons MUST be strings; built-in names MUST be IRIs. Bindings require
one nonempty string name and one value, MAY occur only on rule steps, and MUST
NOT repeat a variable name. Unknown predicates, malformed metadata, and
unreferenced binding records are reader errors.

Both CLI checking modes use the same parsed source `Document`, preserving
input formats, base IRIs, and file scopes; see [input
handling](GUIDE.md#proofs-and-their-limits).

### 9.9 Reporting

Reports contain step totals, verified-justification counts, counts by kind,
obligations, and failures. An invalid proof can have verified justifications
while failing premise resolution, cycle checking, or claim coverage. Failure
counts are counts of diagnostics, not necessarily distinct steps.

```console
$ eyeron -p examples/socrates.n3 > socrates.proof.n3
$ eyeron --check-proof socrates.proof.n3 examples/socrates.n3
Proof: socrates.proof.n3
Source program: examples/socrates.n3
checked: 3 steps, 3 verified, 0 trusted
Step kinds:
  source facts: 2
  rule applications: 1
Conditions:
  C1 resolution: 3 checked, 0 failed
  C2 well-foundedness: 3 checked, 0 failed
  C3 justification: 3 checked, 0 failed
  C4 coverage: 3 checked, 0 failed
  C5 re-decision: 0 checked, 0 failed
  C6 boundary consistency: 0 checked, 0 failed
  C7 relevance: 4 checked, 0 failed
  C8 witness integrity: 0 checked, 0 failed
  C9 query isolation: 0 checked, 0 failed
```

Trusted conclusions are listed under "Trust obligations (accepted without
verifying their truth)"; failures name their condition, such as `[C6: boundary
consistency]`. Invalid proofs return status 1. Parsing errors occur before a
checking report exists.

Witness correspondence, each implicit query selection, and each
inference-fuse check have a budget of 200,000 match attempts. Exhaustion MUST
be reported as a verification failure under C8, C9, or C6, with a specific
budget diagnostic; it never produces `checked`. This failure means the checker
did not establish validity within its budget, rather than demonstrating that
the claim is false. Rechecking the same parsed proof starts with fresh checking
state.

### 9.10 Implementation Coverage

*Informative.* [tests/proof_validation.rs](tests/proof_validation.rs) covers
malformed metadata, mislabeled and unsupported built-ins, unsupported formula
and rule claims, cycles through carried-rule provenance, over-general carried
rules, rigid outer existentials, fresh and consistent witnesses across rule
heads and source instances, existentials introduced although a fact already
satisfied them, symbolic witness generalization, open built-in values, query
answers used as premises or carried rules, incomplete query selections,
external reads hidden in collections, re-decided quoted-graph tests, negations
and collections contradicted by the proof's evidence, tripped inference fuses,
and irrelevant steps or claims. It also checks ambiguous head correspondence,
separate blank scopes, partial unquoting bindings, and repeated checking. [CLI
tests](tests/cli_proof_check.rs) cover saved and generated proofs, source
bases, separate input scopes, RDF formats, and stdin. Malformed proof metadata
returns a reader error before a report is constructed; semantic C1–C9 failures
produce an invalid report.

[tests/proof_checking.rs](tests/proof_checking.rs) generates the proof of
every packaged example that derives anything and requires it to be nonempty
and check. `variable-predicate-dependency` is an intentional negative cycle
that assumes `:a a :Blocked` is absent and then derives it; it trips an
inference fuse and has no conclusions to prove.
[Generation regressions](tests/proof_generation.rs) also check fresh
proofs, including source-only and backward-only identity queries, long
query-selected chains on a small stack, quoted closures with overlapping
variable names, backward premise ordering, and backtracking past incomplete or
circular explanations.

## 10. Compatibility and Limitations

The RDF parser profiles are exercised against the vendored RDF 1.1 and 1.2
manifests. That coverage does not imply implementation of every historical N3
extension or a complete OWL reasoner. Eyeron has no persistent graph store,
query service, or custom external built-in loader. Compatibility-only CLI
flags are listed in [the guide](GUIDE.md#cli-options).

Deferred rules follow the order of Section 6.2 rather than a computed
stratification, so a program whose negations, collections, and existentials
depend on each other in a cycle has no single intended result.

The N3 conformance harness explicitly expects no wildcard conclusion for two
vendored cases: `static/success-literal-22.n3` treats a quoted blank as a
wildcard, and `generated/log/forAllIn/success-objectNotInstantiated-2.n3`
treats a blank supplied by an outer binding as a wildcard. The vendored files
are unchanged; the harness checks Eyeron's scoping behavior instead of those
two upstream success expectations.

## 11. Security Considerations

Rules can derive without bound: recursive arithmetic, growing terms, and
generated rules. The budgets of Section 6.4 stop such runs and report them as
incomplete; they are not a memory or wall-clock limit, so a host that runs
untrusted programs SHOULD also bound the process.

The CLI reads local files and HTTP(S) URLs named on its command line, and
`--stream-messages` reads remote message logs incrementally. A host that
passes untrusted names to the CLI SHOULD restrict them. `log:content` and
`log:semantics` do not fetch arbitrary resources, and no built-in writes files
or runs programs. The browser playground runs in a WebAssembly worker; URL
loading there is subject to the browser's cross-origin rules, and Gist
sharing keeps its token in session storage, excluded from shared links.

A proof that checks establishes only what Section 9.2 says: its recorded
inferences follow from the supplied sources, under the listed obligations. It
does not authenticate the sources, their authors, or fact labels, and it does
not establish that the sources are true or that the run found every
conclusion. A consumer that relies on a proof SHOULD verify the provenance of
the source documents separately and SHOULD review every obligation.

Regular expressions in `string:` built-ins run on Rust's linear-time engine.
`string:format` and exact exponentiation have size guards (Section 6.4).

## 12. References

### 12.1 Normative References

[N3]
: "Notation3 Language", W3C Notation 3 Community Group report,
  <https://w3c.github.io/N3/spec/>.

[RDF12-CONCEPTS]
: "RDF 1.2 Concepts and Abstract Data Model", W3C,
  <https://www.w3.org/TR/rdf12-concepts/>.

[RFC2119]
: Bradner, S., "Key words for use in RFCs to Indicate Requirement Levels",
  BCP 14, RFC 2119, March 1997, <https://www.rfc-editor.org/rfc/rfc2119>.

[RFC8174]
: Leiba, B., "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words",
  BCP 14, RFC 8174, May 2017, <https://www.rfc-editor.org/rfc/rfc8174>.

### 12.2 Informative References

[STRATNEG]
: Küchenmeister, L., Ivliev, A., Arndt, D., and Krötzsch, M., "Stratified
  Negation in RDF Rules: A Correct Approach", arXiv:2607.28778,
  <https://arxiv.org/abs/2607.28778>.

[SWAP]
: "CWM built-in functions", <https://www.w3.org/2000/10/swap/doc/CwmBuiltins>.
