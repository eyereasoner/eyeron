use eyeron::proof_check::Report;
use eyeron::proof_check_n3::check_proof;

const PREFIX: &str = "@prefix : <http://example.org/>.\n@prefix pe: <https://eyereasoner.github.io/pe#>.\n@prefix math: <http://www.w3.org/2000/10/swap/math#>.\n@prefix log: <http://www.w3.org/2000/10/swap/log#>.\n";

fn check(source: &str, proof: &str) -> eyeron::Result<Report> {
    check_proof(
        &format!("{PREFIX}{source}"),
        &format!("{PREFIX}{proof}"),
        "test.n3",
    )
}

fn rejects_metadata(proof: &str, message: &str) {
    let error = check("{} => { :a :p :b }.", proof).expect_err("malformed metadata was accepted");
    assert!(error.message.contains(message), "{}", error.message);
}

#[test]
fn every_step_requires_exactly_one_justification() {
    for metadata in [
        "pe:fact \"first\"; pe:unproven \"missing\"",
        "pe:unproven \"missing\"; pe:fact \"last\"",
        "pe:rule 1; pe:rule 1",
        "pe:uses { :a :p :b }",
    ] {
        rejects_metadata(
            &format!("{{ :a :p :b }} {metadata}."),
            "exactly one justification",
        );
    }
}

#[test]
fn malformed_premises_and_step_subjects_cannot_disappear() {
    for used in [":missing", "{}", "{ :a :p :b. :c :p :d }"] {
        rejects_metadata(
            &format!("{{ :a :p :b }} pe:rule 1; pe:uses {used}."),
            "exactly one premise triple",
        );
    }
    for subject in [":a", "{}", "{ :a :p :b. :c :p :d }"] {
        rejects_metadata(&format!("{subject} pe:fact \"source\"."), "step subject");
    }
}

#[test]
fn malformed_bindings_are_rejected_instead_of_ignored_or_overwritten() {
    for binding in [
        "[]",
        "[ pe:var \"x\" ]",
        "[ pe:value :a ]",
        "[ pe:var :x; pe:value :a ]",
        "[ pe:var \"x\", \"y\"; pe:value :a ]",
        "[ pe:var \"x\"; pe:value :a, :b ]",
        "[ pe:var \"x\"; pe:value :a ], [ pe:var \"x\"; pe:value :b ]",
    ] {
        let proof = format!("{{ :a :p :b }} pe:rule 1; pe:binding {binding}.");
        assert!(
            check("{} => { :a :p :b }.", &proof).is_err(),
            "accepted {binding}"
        );
    }
    rejects_metadata("_:b pe:var \"x\"; pe:value :a.", "not referenced");
    rejects_metadata(
        "{ :a :p :b } pe:fact \"source\"; pe:binding [ pe:var \"x\"; pe:value :a ].",
        "only valid on a rule step",
    );
}

#[test]
fn justification_values_and_unknown_metadata_are_validated() {
    for value in [
        "0",
        "-1",
        "\"1\"",
        "\"1\"@en",
        "1.0",
        ":rule",
        "{}",
        "{ :a :p :b }",
    ] {
        rejects_metadata(
            &format!("{{ :a :p :b }} pe:rule {value}."),
            "positive integer",
        );
    }
    rejects_metadata("{ :a :p :b } pe:fact :source.", "string source label");
    rejects_metadata("{ :a :p :b } pe:builtin \"predicate\".", "predicate IRI");
    rejects_metadata("{ :a :p :b } pe:unproven :reason.", "string reason");
    rejects_metadata(
        "{ :a :p :b } pe:typo \"ignored\".",
        "unknown proof predicate",
    );
}

#[test]
fn a_source_fact_cannot_claim_extra_premises() {
    let report = check(
        ":a :p :b. :c :p :d.",
        ":a :p :b. { :a :p :b } pe:fact \"source\"; pe:uses { :c :p :d }.",
    )
    .unwrap();
    assert!(!report.valid());
    assert!(report
        .failures
        .iter()
        .any(|f| f.condition == "C3" && f.detail.contains("must not have premises")));
}

#[test]
fn builtin_labels_cannot_bypass_verification_or_trust_classification() {
    for (value, named) in [("3", "log:equalTo"), ("4", "time:localTime")] {
        let proof = format!("@prefix time: <http://www.w3.org/2000/10/swap/time#>. (1 2) math:sum {value}. {{ (1 2) math:sum {value} }} pe:builtin {named}.");
        let report = check("", &proof).unwrap();
        assert!(!report.valid());
        assert!(report.obligations.is_empty());
        assert!(report
            .failures
            .iter()
            .any(|f| f.condition == "C3" && f.detail.contains("conclusion has predicate")));
    }
    let valid = check(
        "",
        "(1 2) math:sum 3. { (1 2) math:sum 3 } pe:builtin math:sum.",
    )
    .unwrap();
    assert!(valid.valid());
    assert_eq!(valid.verified, 1);
}

#[test]
fn formula_subjects_and_rule_statements_are_claims_too() {
    for claim in [
        "{ :a :p :b } :says :c.",
        "{} => { :a :p :b }.",
        "{ :a :p :b } <= {}.",
        "{} => false.",
        "{} log:query { :a :p :b }.",
    ] {
        let missing = check("", claim).unwrap();
        assert!(!missing.valid(), "unjustified claim accepted: {claim}");
        assert!(missing.failures.iter().any(|f| f.condition == "C4"));
        // A source holding `{} => false` forbids everything, and one with a
        // query outputs only its answers, which a rule statement is not.
        let rejected_by = match claim {
            "{} => false." => Some("C6"),
            "{} log:query { :a :p :b }." => Some("C7"),
            _ => None,
        };
        let given = check(claim, claim).unwrap();
        match rejected_by {
            Some(condition) => assert!(
                !given.valid() && given.failures.iter().any(|f| f.condition == condition),
                "{claim}: {:?}",
                given.failures
            ),
            None => assert!(given.valid(), "given claim rejected: {claim}: {:?}", given.failures),
        }
    }
    // A fuse assertion and a query directive cannot be normalized to ordinary rules.
    assert!(!check("{} => {}.", "{} => false.").unwrap().valid());
    assert!(!check("{} => { :a :p :b }.", "{} log:query { :a :p :b }.")
        .unwrap()
        .valid());
}

#[test]
fn carried_rule_provenance_participates_in_cycle_detection() {
    let source = "{ :a :p :b } => { {} => { :a :p :b } }.";
    let proof = "{} => { :a :p :b }. :a :p :b.\n\
        { {} => { :a :p :b } } pe:rule 1; pe:uses { :a :p :b }.\n\
        { :a :p :b } pe:rule { {} => { :a :p :b } }.";
    let report = check(source, proof).unwrap();
    assert_eq!(
        report.verified, 2,
        "the individual rule applications should match"
    );
    assert!(
        report.failures.iter().any(|f| f.condition == "C2"),
        "{:?}",
        report.failures
    );
}

#[test]
fn carried_rules_with_acyclic_provenance_still_check() {
    let source = ":seed :p :o. { :seed :p :o } => { {} => { :a :p :b } }.";
    let proof = "{} => { :a :p :b }. :a :p :b.\n\
        { {} => { :a :p :b } } pe:rule 1; pe:uses { :seed :p :o }.\n\
        { :seed :p :o } pe:fact \"source\".\n\
        { :a :p :b } pe:rule { {} => { :a :p :b } }.";
    let report = check(source, proof).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
    assert_eq!(report.verified, 3);
}

fn rejects(source: &str, proof: &str, message: &str) {
    let report = check(source, proof).expect("proof should parse");
    assert!(!report.valid(), "forged proof was accepted");
    assert!(
        report.failures.iter().any(|failure| failure.detail.contains(message)),
        "{:?}",
        report.failures
    );
}

#[test]
fn a_carried_rule_cannot_be_more_general_than_the_rule_it_claims_to_be() {
    let source = ":Socrates a :Human. { ?S a :Human } => { ?S a :Mortal }.";
    rejects(
        source,
        ":Moon :madeOf :Cheese.\n\
         { :Moon :madeOf :Cheese } pe:rule { { ?X ?Y ?Z } => { ?A ?B ?C } }; pe:uses { :Socrates a :Human }.\n\
         { :Socrates a :Human } pe:fact \"test.n3\".",
        "nothing in the proof derives",
    );
    rejects(source, "{ ?X ?Y ?Z } => { ?A ?B ?C }.", "the source does not give it");
}

#[test]
fn an_existential_is_witnessed_by_a_fresh_blank_for_one_firing_only() {
    let source = ":a a :Human. :b a :Human. { ?S a :Human } => { ?S :hasParent _:p }.";
    let facts = "{ :a a :Human } pe:fact \"test.n3\".\n{ :b a :Human } pe:fact \"test.n3\".\n";
    let firing = |subject: &str, witness: &str| {
        format!("{{ {subject} :hasParent {witness} }} pe:rule 1; pe:binding [ pe:var \"S\"; pe:value {subject} ]; pe:uses {{ {subject} a :Human }}.\n")
    };
    rejects(source, &format!("{facts}{}", firing(":a", ":Zeus")), "not a fresh blank node");
    rejects(source, &format!("{facts}{}", firing(":a", ":a")), "not a fresh blank node");
    rejects(
        source,
        &format!("{facts}{}{}", firing(":a", "_:w"), firing(":b", "_:w")),
        "another firing already introduced",
    );
    let claims = ":a :hasParent _:w1. :b :hasParent _:w2.\n";
    let report = check(source, &format!("{claims}{facts}{}{}", firing(":a", "_:w1"), firing(":b", "_:w2"))).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}

#[test]
fn an_existential_is_not_introduced_where_a_fact_already_satisfies_it() {
    let source = ":c :participant :w. :c :examiner :r. { ?c :participant ?p } => { ?c :examiner _:x }.";
    let forged = ":c :examiner _:e.\n\
        { :c :examiner _:e } pe:rule 1; pe:binding [ pe:var \"c\"; pe:value :c ], [ pe:var \"p\"; pe:value :w ]; pe:uses { :c :participant :w }.\n\
        { :c :participant :w } pe:fact \"test.n3\".";
    rejects_under(source, forged, "C6", "already satisfies it");

    // What the firing itself leads to does not count against it.
    let source = ":a a :Human. { ?S a :Human } => { ?S :hasParent _:p }. { ?S :hasParent ?P } => { ?S :hasParent :Somebody }.";
    let proof = ":a :hasParent :Somebody.\n\
        { :a :hasParent :Somebody } pe:rule 2; pe:binding [ pe:var \"S\"; pe:value :a ], [ pe:var \"P\"; pe:value _:w ]; pe:uses { :a :hasParent _:w }.\n\
        { :a :hasParent _:w } pe:rule 1; pe:binding [ pe:var \"S\"; pe:value :a ]; pe:uses { :a a :Human }.\n\
        { :a a :Human } pe:fact \"test.n3\".";
    let report = check(source, proof).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
    assert!(report.obligations.iter().any(|obligation| obligation.kind == "unsatisfied"), "{:?}", report.obligations);
}

#[test]
fn a_builtin_step_must_state_its_values() {
    rejects(
        ":x :vals (1 2). { ?x :vals (?a ?b). (?a ?b) math:sum ?c } => { ?x :total ?c }.",
        ":x :total ?z.\n\
         { :x :total ?z } pe:rule 1;\n\
           pe:binding [ pe:var \"a\"; pe:value 1 ], [ pe:var \"b\"; pe:value 2 ], [ pe:var \"c\"; pe:value ?z ], [ pe:var \"x\"; pe:value :x ];\n\
           pe:uses { :x :vals (1 2) }, { (1 2) math:sum ?z }.\n\
         { :x :vals (1 2) } pe:fact \"test.n3\".\n\
         { (1 2) math:sum ?z } pe:builtin math:sum.",
        "unbound",
    );
}

#[test]
fn a_query_answer_is_output_and_never_a_premise() {
    let source = ":s a :Human. { ?x a :Human } log:query { ?x a :Answer }. { ?x a :Answer } => { ?x :bad true }.";
    let answer = "{ :s a :Answer } pe:rule { { ?x a :Human } => { ?x a :Answer } }; pe:binding [ pe:var \"x\"; pe:value :s ]; pe:uses { :s a :Human }.\n\
                  { :s a :Human } pe:fact \"test.n3\".\n";
    rejects(
        source,
        &format!(":s :bad true.\n{{ :s :bad true }} pe:rule 1; pe:binding [ pe:var \"x\"; pe:value :s ]; pe:uses {{ :s a :Answer }}.\n{answer}"),
        "the query answer",
    );
    let report = check(source, &format!(":s a :Answer.\n{answer}")).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}

fn rejects_under(source: &str, proof: &str, condition: &str, message: &str) {
    let report = check(source, proof).expect("proof should parse");
    assert!(
        report.failures.iter().any(|failure| failure.condition == condition && failure.detail.contains(message)),
        "expected {condition} \"{message}\": {:?}",
        report.failures
    );
}

#[test]
fn a_test_on_a_quoted_graph_is_re_decided_rather_than_trusted() {
    let source = "{ { :a :p :b } log:includes { :c :p :d } } => { :x :y :z }.";
    let step = |verb: &str| format!(
        ":x :y :z.\n{{ :x :y :z }} pe:rule 1; pe:uses {{ {{ :a :p :b }} log:{verb} {{ :c :p :d }} }}.\n\
         {{ {{ :a :p :b }} log:{verb} {{ :c :p :d }} }} pe:builtin log:{verb}."
    );
    rejects_under(source, &step("includes"), "C5", "did not hold");
    let report = check("{ { :a :p :b } log:notIncludes { :c :p :d } } => { :x :y :z }.", &step("notIncludes")).unwrap();
    assert!(report.valid() && report.obligations.is_empty(), "{:?}", report);
}

#[test]
fn a_rule_cannot_conclude_a_built_in_statement_that_does_not_hold() {
    let source = "{} => { { :a :b :c } log:includes { :d :e :f } }.";
    let proof = "{ :a :b :c } log:includes { :d :e :f }.\n\
        { { :a :b :c } log:includes { :d :e :f } } pe:rule 1.";
    rejects_under(source, proof, "C5", "re-evaluation rejects");
    let source = ":n :value 4. { :n :value ?v } => { (1 2) math:sum ?v }.";
    let proof = "(1 2) math:sum 4.\n\
        { (1 2) math:sum 4 } pe:rule 1; pe:binding [ pe:var \"v\"; pe:value 4 ]; pe:uses { :n :value 4 }.\n\
        { :n :value 4 } pe:fact \"test.n3\".";
    rejects_under(source, proof, "C5", "re-evaluation rejects");
    // The same rule deriving a statement that holds checks.
    let report = check(":n :value 3. { :n :value ?v } => { (1 2) math:sum ?v }.", &proof.replace('4', "3")).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}

#[test]
fn a_negation_over_the_current_graph_is_held_to_the_proofs_own_evidence() {
    let source = ":a :source :x. :a a :Blocked. { ?x :source :x. ?S log:notIncludes { ?x a :Blocked } } => { ?x a :Free }.";
    let proof = ":a a :Free.\n\
        { :a a :Free } pe:rule 1; pe:binding [ pe:var \"x\"; pe:value :a ];\n\
          pe:uses { :a :source :x }, { ?S log:notIncludes { :a a :Blocked } }.\n\
        { :a :source :x } pe:fact \"test.n3\".\n\
        { ?S log:notIncludes { :a a :Blocked } } pe:builtin log:notIncludes.";
    rejects_under(source, proof, "C6", "evidence includes it");
    // Without the contrary fact the same test stays an `absent` obligation.
    let report = check(":a :source :x. { ?x :source :x. ?S log:notIncludes { ?x a :Blocked } } => { ?x a :Free }.", proof).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
    assert_eq!(report.obligations.iter().map(|o| o.kind).collect::<Vec<_>>(), ["absent"]);
}

#[test]
fn a_collection_over_the_current_graph_cannot_omit_what_the_proof_shows() {
    let source = ":p :dog :d1, :d2. { (?d { :p :dog ?d } ?all) log:collectAllIn ?S } => { :p :dogs ?all }.";
    let proof = |all: &str| format!(
        ":p :dogs {all}.\n\
         {{ :p :dogs {all} }} pe:rule 1; pe:binding [ pe:var \"all\"; pe:value {all} ];\n\
           pe:uses {{ (?d {{ :p :dog ?d }} {all}) log:collectAllIn ?S }}.\n\
         {{ (?d {{ :p :dog ?d }} {all}) log:collectAllIn ?S }} pe:builtin log:collectAllIn."
    );
    rejects_under(source, &proof("(:d1)"), "C6", "omits");
    let report = check(source, &proof("(:d1 :d2)")).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}

#[test]
fn a_current_graph_check_cannot_succeed_when_its_search_budget_is_exhausted() {
    // Every combination collects the same member. A partial search would
    // therefore appear consistent, even though the check did not finish.
    let condition = (0..18).map(|i| format!(":seed :value ?v{i} . ")).collect::<String>();
    let source = format!(":seed :value 0, 1. {{ (:constant {{ {condition} }} ?all) log:collectAllIn ?S }} => {{ :result :all ?all }}.");
    let test = format!("(:constant {{ {condition} }} (:constant)) log:collectAllIn ?S");
    let proof = format!(":result :all (:constant).\n\
        {{ :result :all (:constant) }} pe:rule 1; pe:binding [ pe:var \"all\"; pe:value (:constant) ]; pe:uses {{ {test} }}.\n\
        {{ {test} }} pe:builtin log:collectAllIn.");
    rejects_under(&source, &proof, "C6", "could not finish checking");
}

#[test]
fn evidence_that_trips_an_inference_fuse_is_rejected() {
    let source = ":a a :Cat. { ?x a :Cat } => { ?x a :Dog }. { ?x a :Cat, :Dog } => false.";
    let proof = ":a a :Dog.\n\
        { :a a :Dog } pe:rule 1; pe:binding [ pe:var \"x\"; pe:value :a ]; pe:uses { :a a :Cat }.\n\
        { :a a :Cat } pe:fact \"test.n3\".";
    rejects_under(source, proof, "C6", "inference fuse");
}

#[test]
fn every_step_serves_a_claim_and_every_claim_answers_a_query() {
    let source = ":a :p :b. :c :p :d.";
    rejects_under(source, ":a :p :b.\n{ :a :p :b } pe:fact \"test.n3\".\n{ :c :p :d } pe:fact \"test.n3\".", "C7", "serves no claim");
    let query = ":a :p :b. :c :q :d. { ?x :p ?y } log:query { ?x :p ?y }.";
    rejects_under(query, ":c :q :d.\n{ :c :q :d } pe:fact \"test.n3\".", "C7", "answers none");
    let report = check(query, ":a :p :b.\n{ :a :p :b } pe:rule { { ?x :p ?y } => { ?x :p ?y } }; pe:uses { :a :p :b }.").unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}

#[test]
fn a_report_names_all_validity_conditions() {
    let report = check(":a :p :b.", ":a :p :b.\n{ :a :p :b } pe:fact \"test.n3\".").unwrap();
    let names: Vec<_> = report.conditions().into_iter().map(|(id, name, _, failed)| {
        assert_eq!(failed, 0);
        format!("{id} {name}")
    }).collect();
    assert_eq!(names, [
        "C1 resolution", "C2 well-foundedness", "C3 justification", "C4 coverage",
        "C5 re-decision", "C6 boundary consistency", "C7 relevance",
        "C8 witness integrity", "C9 query isolation",
    ]);
}

#[test]
fn outer_existentials_are_individuals_rather_than_rule_variables() {
    let source = "@forSome :parent. {} => { :child :hasParent :parent }.";
    rejects_under(source, ":child :hasParent :Zeus. { :child :hasParent :Zeus } pe:rule 1.", "C1", "does not follow");
    let report = check(source, ":child :hasParent _:__q1. { :child :hasParent _:__q1 } pe:rule 1.").unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}

#[test]
fn dependent_source_existentials_cannot_be_instantiated_as_named_individuals() {
    rejects_under(
        "@forAll :person. @forSome :parent. :person :hasParent :parent.",
        ":alice :hasParent :Zeus. { :alice :hasParent :Zeus } pe:fact \"test.n3\".",
        "C8", "blank node",
    );
}

#[test]
fn different_existentials_cannot_be_collapsed_into_one_witness() {
    rejects_under(
        "{} => { _:a :p :x. _:b :q :x }.",
        "_:w :p :x; :q :x. { _:w :p :x } pe:rule 1. { _:w :q :x } pe:rule 1.",
        "C8", "another existential",
    );
}

#[test]
fn one_existential_has_one_witness_across_all_heads_of_a_firing() {
    rejects_under(
        "{} => { _:a :p :x; :q :x }.",
        "_:w1 :p :x. _:w2 :q :x. { _:w1 :p :x } pe:rule 1. { _:w2 :q :x } pe:rule 1.",
        "C8", "different witness",
    );
    let valid = check(
        "{} => { _:a :p :x; :q :x }.",
        "_:w :p :x; :q :x. { _:w :p :x } pe:rule 1. { _:w :q :x } pe:rule 1.",
    ).unwrap();
    assert!(valid.valid(), "{:?}", valid.failures);
}

#[test]
fn bindings_must_name_variables_of_the_cited_rule() {
    rejects_under(
        "{} => { :a :p :b }.",
        ":a :p :b. { :a :p :b } pe:rule 1; pe:binding [ pe:var \"invented\"; pe:value :x ].",
        "C3", "not a variable",
    );
}

#[test]
fn builtin_steps_cannot_carry_arbitrary_premises() {
    rejects_under(
        ":a :p :b.",
        "(1 2) math:sum 3. { (1 2) math:sum 3 } pe:builtin math:sum; pe:uses { :a :p :b }.",
        "C3", "must not have premises",
    );
}

#[test]
fn quoted_values_cannot_hide_unbound_builtin_arguments() {
    rejects_under(
        "",
        "{ ?x :p :b } log:equalTo { :a :p :b }.\n\
         { { ?x :p :b } log:equalTo { :a :p :b } } pe:builtin log:equalTo.",
        "C5", "unbound",
    );
}

#[test]
fn a_proof_cannot_spell_the_checkers_rigid_variable_placeholder() {
    rejects_under(
        "?who :says { <urn:eyeron:proof-check:frozen:x> :p :b }.",
        ":speaker :says { ?x :p :b }. { :speaker :says { ?x :p :b } } pe:fact \"test.n3\".",
        "C1", "source does not give",
    );
}

#[test]
fn a_query_answer_cannot_be_used_as_carried_rule_provenance() {
    rejects_under(
        "{} log:query { {} => { :a :p :b } }. { :a :p :b } log:query { :answer :p :b }.",
        ":answer :p :b.\n\
         { :answer :p :b } pe:rule { { :a :p :b } => { :answer :p :b } }; pe:uses { :a :p :b }.\n\
         { :a :p :b } pe:rule { {} => { :a :p :b } }.\n\
         { {} => { :a :p :b } } pe:rule { {} => { {} => { :a :p :b } } }.",
        "C9", "query answer",
    );
}

#[test]
fn a_claim_matching_a_query_head_still_needs_a_query_application() {
    rejects_under(
        ":a :p :b. { :missing :p :b } log:query { :a :p :b }.",
        ":a :p :b. { :a :p :b } pe:fact \"test.n3\".",
        "C9", "query application",
    );
}

#[test]
fn query_answers_do_not_trip_source_inference_fuses() {
    let report = check(
        "{} log:query { :answer :p :b }. { :answer :p :b } => false.",
        ":answer :p :b. { :answer :p :b } pe:rule { {} => { :answer :p :b } }.",
    ).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}

#[test]
fn witness_checks_also_cover_source_instances_without_explicit_fact_steps() {
    let source = "@forAll :person. @forSome :parent. :person :hasParent :parent.";
    rejects_under(source, ":alice :hasParent :Zeus.", "C8", "blank node");
    rejects_under(
        "@forAll :person. @forSome :parent. :person :hasParent :parent; :knows :parent.",
        ":alice :hasParent _:w1; :knows _:w2.",
        "C8", "different witness",
    );
}

#[test]
fn dependent_witnesses_cannot_be_generalized_as_one_constant_for_everyone() {
    rejects_under(
        "?who a :Human. { ?who a :Human } => { ?who :hasParent _:parent }.",
        "?person :hasParent _:w. { ?person :hasParent _:w } pe:rule 1; pe:uses { ?person a :Human }.",
        "C8", "unbound universal assignment",
    );
    rejects_under(
        "@forAll :person. @forSome :parent. :person :hasParent :parent.",
        ":alice :hasParent _:__q2.\n{ ?__q1 :hasParent _:__q2 } pe:fact \"test.n3\".",
        "C8", "unbound universal assignment",
    );
}

#[test]
fn source_rule_assertions_keep_outer_blank_identities() {
    rejects_under(
        "@forSome :parent. {} => { :child :hasParent :parent }.",
        "{} => { :child :hasParent :Zeus }.\n{ {} => { :child :hasParent :Zeus } } pe:fact \"test.n3\".",
        "C1", "source does not give",
    );
}

#[test]
fn equal_blank_labels_in_a_rules_two_sides_have_separate_scopes() {
    let report = check(
        ":alice :p :x. { _:b :p :x } => { _:b :q :x }.",
        "_:fresh :q :x. { _:fresh :q :x } pe:rule 1; pe:uses { :alice :p :x }.",
    ).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}

#[test]
fn indistinguishable_heads_are_matched_consistently_regardless_of_step_order() {
    let source = "{} => { _:a a :Person; :name :Alice. _:b a :Person; :name :Bob }.";
    for steps in [
        "{ _:bob a :Person } pe:rule 1. { _:alice a :Person } pe:rule 1. { _:alice :name :Alice } pe:rule 1. { _:bob :name :Bob } pe:rule 1.",
        "{ _:bob :name :Bob } pe:rule 1. { _:alice :name :Alice } pe:rule 1. { _:alice a :Person } pe:rule 1. { _:bob a :Person } pe:rule 1.",
    ] {
        let report = check(source, &format!("_:alice a :Person; :name :Alice. _:bob a :Person; :name :Bob. {steps}")).unwrap();
        assert!(report.valid(), "{:?}", report.failures);
    }
}

#[test]
fn unquoting_can_obtain_its_graph_from_a_premise_without_redundant_bindings() {
    let report = check(
        ":alice :says { :alice a :Human }. { :alice :says ?graph } => ?graph.",
        ":alice a :Human. { :alice a :Human } pe:rule 1; pe:uses { :alice :says { :alice a :Human } }.",
    ).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}

#[test]
fn query_selection_checks_filters_and_accounts_for_their_dependencies() {
    let source = ":alice a :Human. :bob a :Human. :seed :p :x.\n\
        { :seed :p :x } => { :alice :allowed true }.\n\
        { ?who a :Human; :allowed true } log:query { ?who a :Human }.";
    let proof = ":alice a :Human. { :alice a :Human } pe:fact \"test.n3\".\n\
        { :alice :allowed true } pe:rule 1; pe:uses { :seed :p :x }.\n\
        { :seed :p :x } pe:fact \"test.n3\".";
    let report = check(source, proof).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
    rejects_under(source, ":bob a :Human. { :bob a :Human } pe:fact \"test.n3\".", "C9", "query application");
}

#[test]
fn query_selection_replays_pure_tests_but_never_assumes_external_reads() {
    let source = ":alice :number 3. :bob :number 1.\n\
        { ?who :number ?number. ?number math:greaterThan 2 } log:query { ?who :number ?number }.";
    let report = check(source, ":alice :number 3. { :alice :number 3 } pe:fact \"test.n3\".").unwrap();
    assert!(report.valid() && report.obligations.is_empty(), "{:?}", report);
    rejects_under(source, ":bob :number 1. { :bob :number 1 } pe:fact \"test.n3\".", "C9", "query application");
    rejects_under(
        ":alice :p :b. { :alice :p :b. :document log:content ?text } log:query { :alice :p :b }.",
        ":alice :p :b. { :alice :p :b } pe:fact \"test.n3\".",
        "C9", "query application",
    );
}

#[test]
fn an_external_read_nested_in_a_quoted_collection_is_still_an_obligation() {
    let report = check(
        "",
        "(?text { :document log:content ?text } ()) log:collectAllIn {}.\n\
         { (?text { :document log:content ?text } ()) log:collectAllIn {} } pe:builtin log:collectAllIn.",
    ).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
    assert_eq!(report.obligations.iter().map(|obligation| obligation.kind).collect::<Vec<_>>(), ["impure built-in"]);
    assert!(report.verdict().starts_with("checked with obligations:"));
}

#[test]
fn malformed_scoped_tests_cannot_become_trust_obligations() {
    for triple in ["1 log:includes :anything", "1 log:notIncludes :anything", "(:anything) log:collectAllIn 1", "(:anything :else) log:forAllIn 1"] {
        let report = check("", &format!("{triple}. {{ {triple} }} pe:builtin {}.", triple.split_whitespace().find(|part| part.starts_with("log:")).unwrap())).unwrap();
        assert!(!report.valid() && report.obligations.is_empty(), "{:?}", report);
        assert!(report.failures.iter().any(|failure| failure.condition == "C5"));
    }
}

#[test]
fn rechecking_the_same_document_does_not_retain_witness_state() {
    let source = eyeron::parse_n3_with_source(&format!("{PREFIX}{{}} => {{ _:a :p :x; :q :x }}."), None, Some("test.n3")).unwrap();
    let proof = format!("{PREFIX}_:w :p :x; :q :x. {{ _:w :p :x }} pe:rule 1. {{ _:w :q :x }} pe:rule 1.");
    let document = eyeron::proof_check_n3::N3Proof::read_document(&source, &proof).unwrap();
    for _ in 0..3 {
        let report = eyeron::proof_check::check(&document);
        assert!(report.valid(), "{:?}", report.failures);
    }
}

#[test]
fn unsupported_builtins_are_not_accepted_as_trusted_relations() {
    for predicate in ["math:random", "<http://www.w3.org/2000/10/swap/time#currentTime>", "<http://www.w3.org/2000/10/swap/time#gmTime>"] {
        let report = check("", &format!("() {predicate} :anything. {{ () {predicate} :anything }} pe:builtin {predicate}.")).unwrap();
        assert!(!report.valid() && report.obligations.is_empty(), "{:?}", report);
        assert!(report.failures.iter().any(|failure| failure.condition == "C5"));
    }
}

#[test]
fn quoted_graph_quantifiers_cannot_be_counterfeited_with_internal_iris() {
    rejects_under(
        "",
        "{ @forAll :x. :x :p :b } log:includes { <urn:eyeron:includes-rigid:u:__q2> :p :b }.\n\
         { { @forAll :x. :x :p :b } log:includes { <urn:eyeron:includes-rigid:u:__q2> :p :b } } pe:builtin log:includes.",
        "C5", "did not hold",
    );
}

#[test]
fn missing_proof_evidence_does_not_establish_a_negative_fuse_premise() {
    let source = "{} => { :blocked :p :b }. {} => { :answer :p :b }.\n\
        { 1 log:notIncludes { :blocked :p :b } } => false.";
    let report = check(source, ":answer :p :b. { :answer :p :b } pe:rule 2.").unwrap();
    assert!(report.valid(), "{:?}", report.failures);
    // A recorded absence obligation does supply that forbidden condition.
    rejects_under(
        source,
        "1 log:notIncludes { :blocked :p :b }.\n\
         { 1 log:notIncludes { :blocked :p :b } } pe:builtin log:notIncludes.",
        "C6", "inference fuse",
    );
}

#[test]
fn query_selection_cannot_invent_a_named_existential_for_an_unrecorded_filter() {
    rejects_under(
        "@forAll :person. @forSome :parent. :person :hasParent :parent.\n\
         :alice :p :b. { :alice :p :b; :hasParent :Zeus } log:query { :alice :p :b }.",
        ":alice :p :b. { :alice :p :b } pe:fact \"test.n3\".",
        "C9", "query application",
    );
}

#[test]
fn external_obligations_still_require_well_formed_recorded_values() {
    for (triple, predicate) in [
        ("5 log:content :anything", "log:content"),
        (":document log:semantics 7", "log:semantics"),
        (":document log:semanticsOrError :anything", "log:semanticsOrError"),
        ("5 log:conclusion :anything", "log:conclusion"),
        ("() <http://www.w3.org/2000/10/swap/time#localTime> \"not a date\"", "<http://www.w3.org/2000/10/swap/time#localTime>"),
        ("((1 2) 5) <http://www.w3.org/2000/10/swap/list#map> (3)", "<http://www.w3.org/2000/10/swap/list#map>"),
    ] {
        let report = check("", &format!("{triple}. {{ {triple} }} pe:builtin {predicate}.")).unwrap();
        assert!(!report.valid() && report.obligations.is_empty(), "{:?}", report);
        assert!(report.failures.iter().any(|failure| failure.condition == "C5" && failure.detail.contains("incompatible argument")));
    }
}

#[test]
fn carried_rule_binding_aliases_are_applied_and_cannot_be_duplicated() {
    let source = ":bob :parent :alice. { ?x :child ?y } <= { ?y :parent ?x }.";
    let step = |bindings: &str| format!(
        ":alice :child :bob. {{ :alice :child :bob }} pe:rule {{\n\
         {{ ?__backward_0_1_ab__x :child ?__backward_0_1_ab__y }} <=\n\
         {{ ?__backward_0_1_ab__y :parent ?__backward_0_1_ab__x }} }};\n\
         pe:uses {{ :bob :parent :alice }}; pe:binding {bindings}."
    );
    let bindings = "[ pe:var \"x\"; pe:value :alice ], [ pe:var \"y\"; pe:value :bob ]";
    let report = check(source, &step(bindings)).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
    rejects_under(source, &step(&bindings.replace("pe:value :alice", "pe:value :eve")), "C1", "premise 1");
    rejects_under(source, &step(&format!("{bindings}, [ pe:var \"__backward_0_1_ab__x\"; pe:value :alice ]")), "C3", "more than one binding");
}

#[test]
fn exhausting_witness_correspondence_never_reports_checked() {
    let heads = (0..10).map(|index| format!("_:e{index} a :Person.")).collect::<Vec<_>>().join(" ");
    let claims = (0..11).map(|index| format!("_:w{index} a :Person.")).collect::<Vec<_>>().join(" ");
    let steps = (0..11).map(|index| format!("{{ _:w{index} a :Person }} pe:rule 1.")).collect::<Vec<_>>().join(" ");
    rejects_under(&format!("{{}} => {{ {heads} }}."), &format!("{claims} {steps}"), "C8", "match budget");
}

#[test]
fn exhausting_query_selection_never_reports_checked() {
    let mut source = ":answer :p :b.\n".to_string();
    for index in 0..100 {
        source.push_str(&format!(":choice{index} :first :x; :second :y.\n"));
    }
    source.push_str("{ :answer :p :b. ?a :first :x. ?b :second :y. :missing :p :b } log:query { :answer :p :b }.");
    rejects_under(&source, ":answer :p :b. { :answer :p :b } pe:fact \"test.n3\".", "C9", "match budget");
}

#[test]
fn quoted_negative_tests_respect_local_existentials_and_match_quoted_statements() {
    rejects_under(
        "",
        "{ :alice :p :b } log:notIncludes { _:who :p :b }.\n\
         { { :alice :p :b } log:notIncludes { _:who :p :b } } pe:builtin log:notIncludes.",
        "C5", "did not hold",
    );
    // A quoted clause is matched as quoted statements, never executed.
    for clause in ["{ 3 math:lessThan 2 }", "{ 1 math:lessThan 2 }", "{ :document log:content ?text }"] {
        let report = check("", &format!("{{}} log:notIncludes {clause}.\n\
            {{ {{}} log:notIncludes {clause} }} pe:builtin log:notIncludes.")).unwrap();
        assert!(report.valid() && report.obligations.is_empty(), "{clause}: {:?}", report);
    }
    rejects_under("", "{ 1 math:lessThan 2 } log:notIncludes { 1 math:lessThan 2 }.\n\
        { { 1 math:lessThan 2 } log:notIncludes { 1 math:lessThan 2 } } pe:builtin log:notIncludes.", "C5", "did not hold");
}

#[test]
fn quoted_inclusion_cannot_equate_numbers_written_differently() {
    let quoted = "{ :a :p \"01\"^^<http://www.w3.org/2001/XMLSchema#integer> }";
    rejects_under("", &format!("{quoted} log:includes {{ :a :p 1 }}.\n\
        {{ {quoted} log:includes {{ :a :p 1 }} }} pe:builtin log:includes."), "C5", "did not hold");
    rejects_under("", &format!("{quoted} log:notIncludes {{ :a :p {quoted_value} }}.\n\
        {{ {quoted} log:notIncludes {{ :a :p {quoted_value} }} }} pe:builtin log:notIncludes.",
        quoted_value = "\"01\"^^<http://www.w3.org/2001/XMLSchema#integer>"), "C5", "did not hold");
}

#[test]
fn rdf_nil_keeps_empty_list_identity_in_builtin_validation_and_boundaries() {
    let nil = "<http://www.w3.org/1999/02/22-rdf-syntax-ns#nil>";
    let source = ":alice :p :b.";
    let proof = format!("(?x {{ ?x :p :b }} {nil}) log:collectAllIn 1.\n\
        {{ (?x {{ ?x :p :b }} {nil}) log:collectAllIn 1 }} pe:builtin log:collectAllIn.");
    rejects_under(source, &proof, "C6", "omits");
    let report = check("", &proof).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
    let report = check("", &format!("({nil} :map) <http://www.w3.org/2000/10/swap/list#map> {nil}.\n\
        {{ ({nil} :map) <http://www.w3.org/2000/10/swap/list#map> {nil} }} pe:builtin <http://www.w3.org/2000/10/swap/list#map>.")).unwrap();
    assert!(report.valid(), "{:?}", report.failures);
}
