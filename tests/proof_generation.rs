use eyeron::{parse_n3_with_source, proof_to_n3, reason_document, ReasonerOptions};

fn checked_proof(source: &str) -> String {
    let document = parse_n3_with_source(source, None, Some("test.n3")).unwrap();
    let result = reason_document(
        &document,
        &ReasonerOptions {
            proof: true,
            ..ReasonerOptions::default()
        },
    );
    assert!(result.is_complete(), "{:?}", result.errors);
    assert!(
        !result.derived.is_empty(),
        "the program must derive a claim"
    );
    let proof = proof_to_n3(&document.prefixes, &result);
    assert!(!proof.trim().is_empty(), "every selected answer needs a proof");
    let parsed = eyeron::proof_check_n3::N3Proof::read_document(&document, &proof).unwrap();
    assert_eq!(
        eyeron::proof_check::Document::claims(&parsed).len(),
        result.derived.iter().collect::<std::collections::BTreeSet<_>>().len(),
        "a proof must claim every selected answer",
    );
    let report = eyeron::proof_check::check(&parsed);
    assert!(report.valid(), "{:?}\n{proof}", report.failures);
    proof
}

#[test]
fn identity_queries_explain_source_facts_and_backward_only_answers() {
    let prefix = "@prefix : <urn:query:>.\n\
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.\n";
    let proof = checked_proof(&format!("{prefix}\n\
        :alice a :Human.\n\
        {{ ?Who a :Human }} log:query {{ ?Who a :Human }}."));
    assert!(proof.contains(":alice a :Human ."));
    assert!(proof.contains("pe:fact"));
    let proof = checked_proof(&format!("{prefix}\n\
        :alice a :Human.\n\
        {{ ?Who a :Mortal }} <= {{ ?Who a :Human }}.\n\
        {{ ?Who a :Mortal }} log:query {{ ?Who a :Mortal }}."));
    assert!(proof.contains(":alice a :Mortal ."));
    assert!(proof.contains("pe:rule"));
}

#[test]
fn mixed_queries_keep_source_answers_alongside_recorded_derivations() {
    let proof = checked_proof(r#"
        @prefix : <urn:query:>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        :alice a :Human. :bob a :Human.
        { :alice a :Human } => { :alice a :Mortal }.
        { ?Who a :Human } log:query { ?Who a :Human }.
        { ?Who a :Mortal } log:query { ?Who a :Mortal }.
    "#);
    assert!(proof.contains(":alice a :Human ."));
    assert!(proof.contains(":bob a :Human ."));
    assert!(proof.contains(":alice a :Mortal ."));
}

#[test]
fn a_query_at_the_end_of_a_long_chain_has_a_complete_proof_on_a_small_stack() {
    std::thread::Builder::new()
        .stack_size(512 * 1024)
        .spawn(|| {
            let mut source = String::from(
                "@prefix : <urn:chain:>.\n\
                 @prefix log: <http://www.w3.org/2000/10/swap/log#>.\n\
                 :node a :N0.\n",
            );
            for level in 0..10_000 {
                source.push_str(&format!(
                    "{{ ?Node a :N{level} }} => {{ ?Node a :N{} }}.\n", level + 1,
                ));
            }
            source.push_str("{ :node a :N10000 } log:query { :node :answer 10000 }.\n");
            let proof = checked_proof(&source);
            assert!(proof.contains(":node a :N0"));
            assert!(proof.contains(":node :answer 10000 ."));
        })
        .unwrap()
        .join()
        .unwrap();
}

#[test]
fn an_open_closure_instance_has_its_own_complete_derivation() {
    let proof = checked_proof(
        r#"
        @prefix : <http://example.org/>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        :case :theory { :alice :p :b. { ?User :p :b } => { ?User :q :b } }.
        { :case :theory ?Theory. ?Theory log:conclusion ?Closure }
            => { :case :closure ?Closure }.
        { :case :closure ?C. ?C log:includes { ?User :q :b } }
            => { :case :witness ?User; :copied ?C }.
    "#,
    );
    let parsed = parse_n3_with_source(&proof, None, Some("proof.n3")).unwrap();
    let closure = parsed
        .facts
        .iter()
        .find(|t| t.p == eyeron::Term::iri("http://example.org/closure"))
        .unwrap();
    let copied = parsed
        .facts
        .iter()
        .find(|t| t.p == eyeron::Term::iri("http://example.org/copied"))
        .unwrap();
    assert_ne!(
        closure.o, copied.o,
        "the outer binding instantiates the open graph"
    );
    assert!(proof.contains("pe:var \"User\"; pe:value :alice"));
}

#[test]
fn a_prebound_outer_variable_can_use_an_open_closure_instance() {
    checked_proof(
        r#"
        @prefix : <http://example.org/>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        :alice :enabled true.
        :case :theory { :alice :p :b. { ?User :p :b } => { ?User :q :b } }.
        { :case :theory ?Theory. ?Theory log:conclusion ?Closure }
            => { :case :closure ?Closure }.
        { ?User :enabled true. :case :closure ?C. ?C log:includes { ?User :q :b } }
            => { :case :witness ?User }.
    "#,
    );
}

#[test]
fn backward_explanations_use_the_reasoners_premise_order() {
    checked_proof(
        r#"
        @prefix : <urn:test:>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        @prefix list: <http://www.w3.org/2000/10/swap/list#>.
        { ?Input :prepare ?Output } <= { ?Input log:equalTo ?Input. ?Input log:equalTo ?Output }.
        () :copy ().
        { ?Input :copy ?Output } <= {
            ((?Head) ?Tail) list:append ?Input.
            ?Tail :prepare ?Prepared.
            ?Prepared :copy ?Rest.
            ((?Head) ?Rest) list:append ?Output.
        }.
        { (2 3) :copy ?Output } => { :answer :value ?Output }.
    "#,
    );
}

// The completed closure can contain a matching premise whose derivation is
// unavailable to backward explanation. That match must not commit partial
// steps, cache them as done, or prevent another support from being tried.
fn checked_with_closure(source: &str, extra: &str) -> String {
    let prefix = "@prefix : <urn:test:>.\n";
    let document =
        parse_n3_with_source(&format!("{prefix}{source}"), None, Some("test.n3")).unwrap();
    let mut result = reason_document(
        &document,
        &ReasonerOptions {
            proof: true,
            ..ReasonerOptions::default()
        },
    );
    assert!(result.is_complete());
    assert!(!result.derived.is_empty());
    result.closure.extend(
        parse_n3_with_source(&format!("{prefix}{extra}"), None, Some("closure.n3"))
            .unwrap()
            .facts,
    );
    let proof = proof_to_n3(&document.prefixes, &result);
    let report = eyeron::proof_check_n3::check_proof_document(&document, &proof).unwrap();
    assert!(report.valid(), "{:?}\n{proof}", report.failures);
    proof
}

#[test]
fn a_cyclic_backward_candidate_does_not_hide_a_later_valid_rule() {
    checked_with_closure(
        r#"
        :seed :p :ok.
        { :answer :p :ok } <= { :middle :p :ok }.
        { :middle :p :ok } <= { :answer :p :ok }.
        { :middle :p :ok } <= { :seed :p :ok }.
        { :answer :p :ok } => { :result :p :ok }.
    "#,
        ":answer :p :ok. :middle :p :ok.",
    );
}

#[test]
fn an_incomplete_body_match_is_rolled_back_before_trying_the_next() {
    checked_with_closure(
        r#"
        :seed :p :ok. :candidate :p :bad, :good. :good :p :ok.
        { :shared :p :ok } <= { :seed :p :ok }.
        { :answer :p :ok } <= {
            :shared :p :ok. :candidate :p ?Candidate. ?Candidate :p :ok.
        }.
        { :answer :p :ok } => { :result :p :ok }.
    "#,
        ":bad :p :ok. :shared :p :ok.",
    );
}

#[test]
fn the_four_previously_invalid_example_proofs_check_when_generated() {
    std::thread::Builder::new()
        .stack_size(16 * 1024 * 1024)
        .spawn(|| {
            for name in [
                "odrl-dpv-campaign-audit",
                "odrl-dpv-conflict-audit",
                "odrl-policy-audit",
                "polynomial",
            ] {
                let source = std::fs::read_to_string(format!(
                    "{}/examples/{name}.n3",
                    env!("CARGO_MANIFEST_DIR")
                ))
                .unwrap();
                checked_proof(&source);
            }
        })
        .unwrap()
        .join()
        .unwrap();
}

#[test]
fn proofs_settle_negations_over_derived_facts_with_a_search_certificate() {
    let source = r#"
        @prefix : <urn:pacifists:>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        :nixon a :Republican. :ada a :Quaker.
        { ?x a :Republican } => { ?x a :NonPacifist }.
        { ?x a :Quaker. ?g log:notIncludes { ?x a :NonPacifist } } => { ?x a :Pacifist }.
        { ?x :likes :war } => { ?x :hawk true }.
        { ?x a :Quaker. ?g log:notIncludes { ?x :hawk true } } => { ?x :dove true }.
    "#;
    let proof = checked_proof(source);
    // Listed with every fact derived with it, and listed empty when none.
    assert!(proof.contains("rdf:type pe:derived"), "{proof}");
    assert!(proof.contains(":hawk pe:derived {}."), "{proof}");
    let document = parse_n3_with_source(source, None, Some("test.n3")).unwrap();
    let parsed = eyeron::proof_check_n3::N3Proof::read_document(&document, &proof).unwrap();
    let report = eyeron::proof_check::check(&parsed);
    assert!(report.obligations.is_empty(), "{:?}\n{proof}", report.obligations);
}

#[test]
fn a_certificate_too_large_to_list_leaves_the_negation_an_obligation() {
    let mut source = String::from("@prefix : <urn:items:>.\n@prefix log: <http://www.w3.org/2000/10/swap/log#>.\n:q a :Quaker.\n");
    for item in 0..=10_000 {
        source.push_str(&format!(":n{item} a :Item.\n"));
    }
    source.push_str("{ ?x a :Item } => { ?x :seen true }.\n");
    source.push_str("{ ?x a :Quaker. ?g log:notIncludes { ?x :seen true } } => { ?x a :Pacifist }.\n");
    // The query keeps the claim to the pacifist, whose proof needs no
    // listing of the ten thousand items seen.
    source.push_str("{ ?x a :Pacifist } log:query { ?x a :Pacifist }.\n");
    let proof = checked_proof(&source);
    assert!(!proof.contains("pe:derived"), "{proof}");
}
