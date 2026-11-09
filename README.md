# <img src="assets/eye.png" alt="" width="48" height="48" align="absmiddle"> Eyeron

[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.23746168-blue.svg)](https://doi.org/10.5281/zenodo.23746168)
[![crates.io](https://img.shields.io/crates/v/eyeron.svg)](https://crates.io/crates/eyeron)

Eyeron is a Rust reasoner for **Notation3 (N3)**. It derives conclusions from facts and rules, writes N3 proofs, and checks those proofs. It runs as a command-line program, a Rust library, and a browser application. RDF formats can supply data to its N3 rules.

[Playground](https://eyereasoner.github.io/eyeron/playground#example=socrates) · [Specification](SPEC.md) · [Examples](https://eyereasoner.github.io/eyeron/examples/)

The specification defines how Eyeron reads and evaluates N3, what a run outputs, and the C1–C10 proof contract; the language itself is the W3C N3 Community Group's [Notation3 Language](https://w3c-cg.github.io/N3/spec/).

![A curious learner and a small robot welcome a philosopher to a workshop, combining a blue fact card and a yellow rule card into a green conclusion.](docs/images/guide-welcome.webp)

*A curious learner and a small robot welcome a philosopher to a workshop, combining a blue fact card and a yellow rule card into a green conclusion.*

## Contents

- [Why Eyeron?](#why-eyeron)
- [Build and run](#build-and-run)
- [Your first N3 program](#your-first-n3-program)
  - [Built-ins and backward rules](#built-ins-and-backward-rules)
- [Pick your answer with a query](#pick-your-answer-with-a-query)
- [Proofs and their limits](#proofs-and-their-limits)
  - [Read the verdict](#read-the-verdict)
  - [Meet C1–C10](#meet-c1c10)
  - [Example: audit a decision](#example-audit-a-decision)
- [Inputs and output](#inputs-and-output)
  - [Keep document scopes straight](#keep-document-scopes-straight)
  - [Process an RDF Message Log](#process-an-rdf-message-log)
  - [Stop on a forbidden combination](#stop-on-a-forbidden-combination)
- [Examples and the playground](#examples-and-the-playground)
- [CLI options](#cli-options)
- [Troubleshooting](#troubleshooting)
- [Rust library](#rust-library)
- [Development](#development)
  - [Releases](#releases)

## Why Eyeron?

- **N3 as it is written.** Facts, forward and backward rules, quoted graphs, scoped negation and collection, existential conclusions and queries, with RDF 1.2 formats as data.
- **Every answer can carry a checkable proof.** A proof is itself N3; a separate checker re-performs each recorded step against the source program under ten conditions, C1–C10, and a forged proof must never pass. What it cannot establish stays an explicit obligation.
- **One engine everywhere.** The same Rust code runs as a command, as a library, and as WebAssembly in the browser.

## Build and run

With Rust and Cargo available, run from the repository root:

```bash
cargo build --release
./target/release/eyeron examples/socrates.n3
```

Your first conclusion is `:Socrates a :Mortal .`. Open [socrates.n3](examples/socrates.n3) beside its [expected answer](examples/output/socrates.n3): Socrates is human, humans are a subclass of mortals, and a rule carries class membership to a superclass. Now check the explanation:

```bash
./target/release/eyeron -c examples/socrates.n3
```

Look for `checked: 3 steps, 3 verified, 0 trusted`. The commands below use `eyeron`; install it with `cargo install --path . --locked --bin eyeron`, or substitute `./target/release/eyeron`.

## Your first N3 program

Save this as `/tmp/people.n3`, or paste it into the playground:

```n3
@prefix : <http://example.org/people#> .

# Facts
:Socrates a :Human .
:Hypatia a :Human .

# Every human in this model is mortal.
{
    ?Person a :Human .
} => {
    ?Person a :Mortal .
} .
```

`eyeron /tmp/people.n3` derives that both are mortal.

| Piece | How to read it |
| --- | --- |
| `@prefix : <http://example.org/people#> .` | Give names such as `:Socrates` a shared IRI prefix. |
| `:Socrates a :Human .` | A fact: Socrates has type Human. `a` abbreviates `rdf:type`. |
| `?Person` | A variable; it keeps one value throughout a rule application. |
| `{ … } => { … } .` | When the left side matches, derive the statements on the right. |

Output contains the derived statements; input facts stay available to reasoning without being printed. Add `:Plato a :Human .` and Plato becomes a third mortal; add `:Fido a :Dog .` and nothing changes, since no rule connects Dog to Mortal. Names are exact: `:Human` and `:human` are different IRIs.

### Built-ins and backward rules

Built-ins provide arithmetic, lists, strings, dates and more. `{ (2 3) math:sum ?Total } => { :answer :value ?Total } .` concludes `:answer :value 5 .`. A built-in needs its inputs bound; the [built-in reference](SPEC.md#7-built-ins) lists them all.

`=>` adds conclusions whenever its premises match. A backward rule, written `<=`, answers a goal only when something asks for it:

```n3
@prefix : <http://example.org/backward#> .
@prefix log: <http://www.w3.org/2000/10/swap/log#> .

:Socrates a :Human .

{
    ?Person a :Mortal .
} <= {
    ?Person a :Human .
} .

{
    ?Person a :Mortal .
} log:query {
    ?Person a :Mortal .
} .
```

The query asks the goal, the backward rule finds the human fact, and Socrates is returned as mortal. See [backward.n3](examples/backward.n3) for more.

## Pick your answer with a query

![The robot shines a spotlight on one green answer card while other connected fact cards remain on the shelves; the learner receives the selected card.](docs/images/guide-query.webp)

*The robot shines a spotlight on one green answer card while other connected fact cards remain on the shelves; the learner receives the selected card.*

Append this to `/tmp/people.n3` and run it again:

```n3
# Ask specifically about Socrates.
{
    :Socrates a :Mortal .
} log:query {
    :Socrates a :Mortal .
} .
```

Only Socrates's answer is printed. A query has a matching side and an output side; variables select several answers and the output side shapes them. Queries run after inference, and their answers are output only: they never feed further inference. Results with `log:outputString` print those strings instead of triples, which some examples use to produce Markdown. See [evaluation](SPEC.md#6-evaluation).

## Proofs and their limits

![A detective robot retraces a blue paper trail with a magnifying glass beside a green answer card and a yellow checking clipboard with a check mark and reminder tab.](docs/images/guide-proof.webp)

*A detective robot retraces a blue paper trail with a magnifying glass beside a green answer card and a yellow checking clipboard with a check mark and reminder tab.*

Keep the answer, its proof, and the check of that proof:

```bash
eyeron examples/socrates.n3 > /tmp/socrates.answer.n3
eyeron -p examples/socrates.n3 > /tmp/socrates.proof.n3
eyeron --check-proof /tmp/socrates.proof.n3 examples/socrates.n3
```

`eyeron -c` generates a proof in memory and prints its check in one go. The check report is itself N3: the checked answers as statements, then a `pe:Check` resource with the verdict, each condition, and every obligation and failure, so another program can reason over it. To check a saved proof, give the original inputs in the same order and with the same base IRI; `-` reads the proof from stdin.

### Read the verdict

| Verdict | What it establishes |
| --- | --- |
| `checked` | The proof passes every condition, with nothing taken on trust. |
| `checked with obligations` | The conditions pass, with explicitly listed justifications accepted as assumptions. |
| `invalid` | At least one condition fails; the report names the condition, conclusion, and detail. |

The checker assumes the source assertions. A valid proof supports its claims; it does not establish the real-world truth of the inputs or that every possible conclusion was found.

Try `eyeron -c examples/examiner-diploma.n3`: `checked with obligations: 11 steps, 8 verified, 3 trusted`. Its negation over the current graph is settled by a **search certificate**: the proof lists every fact the run derived with the predicates the negation depends on, and the checker confirms that the forward rules derive nothing more and that the tested statement is not among them. What stays trusted is a collection over derived facts, whose order a certificate cannot establish, and two existential introductions.

### Meet C1–C10

| Condition | What the checker asks |
| --- | --- |
| C1 · Resolution | Does each rule or source-fact justification hold? |
| C2 · Well-foundedness | Are the supporting steps free of dependency cycles? |
| C3 · Justification | Is each step's justification well formed and supported? |
| C4 · Coverage | Can every premise, carried rule, and claim be resolved? |
| C5 · Re-decision | Do recorded built-ins hold on their arguments, or have explicit obligations? |
| C6 · Boundary consistency | Does the proof's own evidence contradict an assumption or trip a source inference fuse? |
| C7 · Relevance | Does every step support a claim, and does each claim answer a query when queries are present? |
| C8 · Witness integrity | Are existential witnesses fresh and consistent across the applications that introduce them? |
| C9 · Search closure | Does the search certificate settle the tests over the current graph: are its listed facts supported, its listings closed under the forward rules, and the tests true over them? |
| C10 · Call fidelity | Is each negative test the call its rule makes, and is each query answer kept out of inference evidence and supported by a complete query application? |

The [proof-checking contract](SPEC.md#9-proofs-and-verification) gives the exact requirements, report format, trust obligations and budgets.

### Example: audit a decision

[verifiable-decision.n3](examples/verifiable-decision.n3) derives an ODRL Agreement from an ODRL Request, using DPV descriptions of consent and safeguards; its [slide deck](examples/deck/verifiable-decision.md) walks through it.

```bash
eyeron -p examples/verifiable-decision.n3 > /tmp/decision.proof.n3
eyeron --check-proof /tmp/decision.proof.n3 examples/verifiable-decision.n3
eyeron examples/verifiable-decision-audit.n3 /tmp/decision.proof.n3
```

The check reports `checked: 30 steps, 30 verified, 0 trusted`. Because a proof is N3 data, the audit program then follows its `pe:uses` links to the authorities supporting the decision.

## Inputs and output

| Input | How it is selected |
| --- | --- |
| Notation3 | `.n3`, or the default for stdin and unrecognized extensions |
| Turtle / TriG | `.ttl` / `.trig` |
| N-Triples / N-Quads | `.nt` / `.nq` |
| RDF Message Log | A `VERSION` or `@version` directive naming a `*-messages` version, or a line holding only `MESSAGE` or `@message .` |

```bash
eyeron rules.n3 data.ttl
eyeron --rdf - < data.ttl
eyeron --base-iri https://example.org/ - < rules.n3
```

Local files and HTTP(S) URLs are accepted, and `-` reads stdin. Relative IRIs use each file's location unless `--base-iri` overrides it. Examples with a companion input take both files, as in `eyeron examples/annotation.n3 examples/input/annotation.trig`; the playground loads companions automatically.

### Keep document scopes straight

![The robot helps a learner keep blank tags in separate blue and red folders while ordinary cards from both folders join one shared board.](docs/images/guide-scopes.webp)

*The robot helps a learner keep blank tags in separate blue and red folders while ordinary cards from both folders join one shared board.*

Files are parsed separately and merged: `_:contact` in two files names two individuals, and quantifier scopes stay apart. Use the same IRI to refer to one thing across files. A triple quoted in `{ … }` is a value, not a fact, and inside quoted graphs literals keep their lexical identity: `"01"^^xsd:integer` is not `1`. RDF triple terms such as `<<( :s :p :o )>>` belong in RDF input, not N3. See [documents and terms](SPEC.md#2-documents-and-terms).

### Process an RDF Message Log

Normal replay parses a whole log into `eymsg:` envelopes with quoted payloads that rules can inspect; start with [rdf-messages.n3](examples/rdf-messages.n3). To reason over each payload independently and flush output as it goes:

```bash
eyeron --rdf --stream-messages examples/alma-rdf-messages.n3 tests/input/alma-rdf-messages-small.nt
```

Derived facts are not kept between payloads. See [RDF Messages](SPEC.md#8-rdf-messages).

### Stop on a forbidden combination

An inference fuse, `{ … } => false .`, stops reasoning when its premise matches: `eyeron examples/fuse.n3` reports the rule and instance and exits with status **65**. Reasoning also stops with 65 when later facts contradict a current-graph absence, collection or universal test that a conclusion used. See [inference fuses](SPEC.md#5-inference-fuses).

## Examples and the playground

| Example (deck) | Source | What to look for |
| --- | --- | --- |
| [Socrates](https://eyereasoner.github.io/eyeron/examples/deck/socrates) | [socrates.n3](examples/socrates.n3) | A short chain from facts to a conclusion. |
| [Control system](https://eyereasoner.github.io/eyeron/examples/deck/control-system) | [control-system.n3](examples/control-system.n3) | Arithmetic and backward helpers producing two actuator commands. |
| [Dog license](https://eyereasoner.github.io/eyeron/examples/deck/dog-license) | [dog-license.n3](examples/dog-license.n3) | A scoped collection and a count, which the proof settles. |
| [Explicit existential rule](https://eyereasoner.github.io/eyeron/examples/deck/explicit-existential-rule) | [explicit-existential-rule.n3](examples/explicit-existential-rule.n3) | A fresh unnamed witness rather than an invented named individual. |
| [Examiners](https://eyereasoner.github.io/eyeron/examples/deck/examiners) | [examiners.n3](examples/examiners.n3) | An existential that a known examiner already satisfies, so none is invented. |
| [Graph terms](https://eyereasoner.github.io/eyeron/examples/deck/graph-terms) | [graph-terms.n3](examples/graph-terms.n3) | Quoted statements used as values. |
| [Zebra puzzle](https://eyereasoner.github.io/eyeron/examples/deck/zebra) | [zebra.n3](examples/zebra.n3) | A larger constraint problem. |

Every example has a card deck that explains it for a wide audience, and the [catalog](https://eyereasoner.github.io/eyeron/examples/) lists them all. Each example also keeps its [expected output](examples/output/), its [proof](examples/proof/) and its [check report](examples/check/); compare them with a run of your own. The `deep-taxonomy-*` and `kaprekar-6174` examples are large workloads; redirect their proofs to a file.

The [playground](https://eyereasoner.github.io/eyeron/playground#example=socrates) runs the same engine as WebAssembly. Choose an example, edit it, pick an **Output** (conclusions, proof, generate-and-check, or check a saved proof pasted into **Proof to check**) and press **Run**; **Stop** cancels. RDF data goes in **RDF 1.2 input** with its format. **Share link** copies the experiment into the URL, and **Create Gist share** uploads it to an unlisted GitHub Gist with a token you supply. To build it locally, install `wasm-pack` and the `wasm32-unknown-unknown` target, run `cargo playground`, and serve the checkout over HTTP; the build updates the committed `pkg/`.

## CLI options

| Option | Behavior |
| --- | --- |
| `-a`, `--ast` | Print the parsed document and exit |
| `-p`, `--proof` | Write an N3 proof document |
| `-c`, `--prove-and-check` | Generate a proof in memory and print its checking report |
| `--check-proof FILE` | Check a saved proof against the source inputs; `-` reads it from stdin |
| `-r`, `--rdf` | Select RDF output and Turtle parsing for stdin |
| `--base-iri IRI`, `--base IRI` | Override the base IRI |
| `--max-backward-depth N` | Set backward search depth; default 32 |
| `--stream-messages` | Process RDF Message Log payloads independently; requires `--rdf` |
| `-s`, `--stream` | Compatibility flag; output still waits for reasoning to finish |
| `-h`, `--help`; `-v`, `--version` | Print help or the version |

Exit status: 0 for successful reasoning and valid proofs, including those with obligations; 1 for parse errors, reasoning limits and invalid proofs; 65 for a fired inference fuse. `--proof-comments` aliases `--proof`; `--builtin`, `--store`, `--store-path`, `--store-clear` and `--enforce-https` are accepted with a warning and do nothing.

## Troubleshooting

| What you see | What to try |
| --- | --- |
| No output, with a successful exit | Check whether anything new was derived or a query selected an answer; `-a` shows the parsed program. |
| A rule does not fire | Check resolved IRIs, capitalization, variables, and the arguments each built-in requires. |
| An expected blank node is missing | A known fact may already satisfy the existential; see [existential conclusions](SPEC.md#4-existential-conclusions). |
| Input facts are missing from the output | Output is derived results; add a query that selects the facts you want. |
| A saved proof does not check | Use the original inputs, order and base IRI, and read the first named condition. |
| The program exits with 65 | Inspect the fired fuse and its matched instance. |
| A URL loads in the CLI but not the browser | The server must allow cross-origin requests; or paste the input. |
| A run reports a search limit | See which budget was reached; see [resource limits](SPEC.md#64-resource-limits). |

## Rust library

```rust
fn main() -> eyeron::Result<()> {
    let program = eyeron::parse_n3(r#"
        @prefix : <http://example.org/> .
        :Socrates a :Human .
        { ?Person a :Human } => { ?Person a :Mortal } .
    "#, None)?;
    let options = eyeron::ReasonerOptions { proof: true, ..Default::default() };
    let result = eyeron::reason_document(&program, &options);
    if let Some(fuse) = &result.fuse {
        return Err(eyeron::EyeronError::new(eyeron::fuse_report(&program.prefixes, fuse)));
    }
    if let Some(summary) = result.incomplete_summary() {
        return Err(eyeron::EyeronError::new(summary));
    }
    let proof = eyeron::proof_to_n3(&program.prefixes, &result);
    let report = eyeron::proof_check_n3::check_proof_document(&program, &proof)?;
    println!("{}", report.verdict());
    Ok(())
}
```

`eyeron::reason(&str)` is the shortcut: it returns serialized output, and an error for incomplete reasoning or a fired fuse. `ReasonerResult` exposes `status`, `limits_reached`, `errors`, `statistics`, `derived`, `closure`, `proofs` and `fuse`; a report lists `obligations` and `failures`. Parse with `parse_n3`, `parse_n3_with_source`, `parse_rdf12` or `parse_rdf_message_log`, and combine separately parsed documents with `Document::merge`, which keeps their scopes apart. `PreparedReasoner` prepares a program once for independent data batches. See [lib.rs](src/lib.rs) and `cargo doc --no-deps`.

## Development

```bash
cargo test --release
./scripts/test-all
cargo test --release --test examples
cargo test --release --test proof_checking
cargo test --release --test artifacts
cargo test --release --test decks
cargo clippy --release --all-targets
node --experimental-vm-modules --test tests/playground_loading.mjs tests/playground_sharing.mjs
```

On Unix, `cargo test --release` prints a cumulative `Tests: N run; P% OK; Ts total`
after each suite and after the doctests. On Linux the elapsed time starts with
Cargo, including compilation; on other Unix hosts it starts with the first
suite. The counters belong to that Cargo process, so separate invocations have
separate totals. `cargo run` and `cargo bench` keep their normal output.

A full `cargo test --release` (optionally with `--no-fail-fast` or `--quiet`)
also writes `REPORT.md`: a table with each suite's cases, result (✅ ok or
❌ FAILED), and time, and the total, timed from the first suite so compilation
is left out; and a table of the ten slowest single cases the example, proof,
and artifact harnesses time. It is rewritten after each suite, so it always describes the
latest run. Runs that select suites or tests, and debug runs, leave it alone.
Use `--release`: a plain `cargo test` builds the reasoner unoptimized and runs
the example and proof suites far more slowly.

`scripts/test-all` runs every suite with the optimized `test-fast` profile and ends with `Tests: N run; P% OK; Ts total`; `EYERON_TEST_JOBS` sets how many example proofs it checks at once, and `EYERON_TEST_JOBS=1 ./scripts/test-all --release` is the setting for performance measurements. The example harness compares each example's output with its golden in `examples/output/`; the proof-checking harness generates every example's proof and requires it to be the saved proof in `examples/proof/`, checking only the proofs that keep no golden; with `EYERON_UPDATE_GOLDENS=1` it rewrites changed proofs, checks them, and rewrites their reports in `examples/check/`. The artifact harness is where every saved proof is checked: it reads each one without running the reasoner, checks it under C1–C10 against its source, rejects an unsupported extra claim in proofs under 1 MB, reproduces the saved check report, and compares the report's answers with the output golden. It also requires both artifact directories to cover exactly the examples that keep proofs. The deck harness checks every program, conclusion, proof and report excerpt, the stated verdict, the documented command arguments and input files, and the catalog. After an intentional change, run `EYERON_UPDATE_GOLDENS=1 cargo test --release --test examples` and `EYERON_UPDATE_GOLDENS=1 cargo test --release --test proof_checking`, and review the diff. A new example needs an output golden and a place in the playground's bundled lists; see [AGENTS.md](AGENTS.md) for the working conventions.

### Releases

`./release patch "message"` (or `minor`, `major`) pulls `main`, bumps the version, rebuilds the playground, commits every change, and pushes `main` with an annotated tag; run the tests first, since the script does not. The tag creates the GitHub release and publishes the crate through `.github/workflows/publish-crates.yml`, using crates.io trusted publishing with no stored token. To publish an existing tag again, use **Actions → Publish to crates.io → Run workflow**.

MIT licensed; see [LICENSE.md](LICENSE.md).
