# Reports

The aggregate W3C RDF custom-harness check `w3c_rdf_13_all_manifests_1175_earl_report` writes the EARL report here by default. The test resources live under `tests/w3c_rdf/rdf-tests/`; the runner is local-only by default so repeat runs stay fast:

```bash
cargo test
```

To run only the W3C RDF sweep:

```bash
cargo test --test w3c_rdf
```

```text
reports/w3c-rdf-earl.ttl
```

The target milestone for this report is 1175/1175 tests passed across the 12 default RDF 1.1 / RDF 1.2 manifest roots.

## SPARQL 1.2 RL

The `cargo test` W3C SPARQL-RL check (`w3c_sparql_rl_01_all_manifests_203_earl_report`) also writes `reports/w3c-sparql-rl-earl.ttl`. The test resources live under `tests/w3c_sparql_rl/data-shapes/`; like the RDF runner above, it is local-only by default:

```bash
cargo test --test w3c_sparql_rl
```

`src/bin/w3c_sparql_rl.rs` writes the same report but always fetches the live manifest, with no local mirror:

```bash
cargo run --release --bin w3c_sparql_rl
```

The target milestone for this report is 203/203 tests passed.
