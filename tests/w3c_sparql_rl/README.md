# W3C SPARQL 1.2 RL manifest sweep

This directory contains Eyeron's Rust-only W3C SPARQL 1.2 RL manifest runner.

It is part of the normal `cargo test` suite. By default this test is **local-only**: it reads `tests/w3c_sparql_rl/data-shapes/` and fails fast if the mirror is missing. This keeps repeat runs comparable to `tests/w3c_rdf/` instead of silently spending time on HTTP fetches.

```bash
cargo test
```

The integration test uses a custom harness and prints one libtest-style line, `w3c_sparql_rl_01_all_manifests_203_earl_report`. The status word is colored when Cargo colors are enabled.

To run only the W3C SPARQL-RL sweep:

```bash
cargo test --test w3c_sparql_rl
```

To force colors:

```bash
cargo test --test w3c_sparql_rl -- --color always
```

To bootstrap or refresh the local mirror, run one explicit online pass:

```bash
EYERON_W3C_SPARQL_RL_REFRESH=1 cargo test --test w3c_sparql_rl
```

After that, commit `tests/w3c_sparql_rl/data-shapes/`. Normal runs are then local. You can run a subset with a substring filter over test name/type/ruleset path, for example `EYERON_W3C_SPARQL_RL_FILTER=eval-negation cargo test --test w3c_sparql_rl`.

The runner loads the manifest root at `runner::DEFAULT_MANIFEST`, follows `mf:include`, executes syntax/well-formedness/stratification/eval cases through Eyeron's SPARQL-RL parser and forward reasoner, and writes:

```text
reports/w3c-sparql-rl-earl.ttl
```

Useful environment variables:

```bash
EYERON_W3C_SPARQL_RL_EARL=reports/w3c-sparql-rl-earl.ttl
EYERON_W3C_SPARQL_RL_FILTER=eval-negation
EYERON_W3C_SPARQL_RL_QUIET=1
EYERON_W3C_SPARQL_RL_VERBOSE=1
EYERON_W3C_SPARQL_RL_REFRESH=1       # explicit online bootstrap/refresh
EYERON_W3C_SPARQL_RL_ONLINE=1        # allow network for cache misses without forcing refresh
EYERON_W3C_SPARQL_RL_OFFLINE=1       # redundant default; documents intent
EYERON_W3C_SPARQL_RL_CACHE_DIR=tests/w3c_sparql_rl/data-shapes
```

Current milestone target: 203/203 tests passed. Keep the populated `tests/w3c_sparql_rl/data-shapes/` directory under version control for fast, reproducible local runs.

`src/bin/w3c_sparql_rl.rs` (`cargo run --release --bin w3c_sparql_rl`) runs the same suite but always fetches the manifest live, with no local mirror.
