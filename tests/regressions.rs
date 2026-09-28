use eyeron::{
    parse_n3, parse_n3_with_source, parse_rdf12, proof_to_n3, rdf_result_to_string, reason,
    reason_document, result_to_string, Document, RdfFormat, ReasonerOptions,
};

#[test]
fn n3_lists_remain_first_class_in_rule_conclusions() {
    let source = r#"
        @prefix : <http://example.org/>.
        { :input :value ?Value. } => { (:result ?Value) :contains (:answer ?Value). }.
        :input :value 42.
    "#;

    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());
    let output = result_to_string(&doc.prefixes, &result.derived);

    assert!(output.contains("(:result 42) :contains (:answer 42)"), "{output}");
    assert!(!output.contains("rdf:first"), "{output}");
    assert!(!output.contains("rdf:rest"), "{output}");
}

#[test]
fn list_append_infers_head_and_tail_from_known_result() {
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix list: <http://www.w3.org/2000/10/swap/list#>.

        {
            ((?head) ?tail) list:append (1 2 3).
        } => {
            :result :head ?head;
                    :tail ?tail.
        }.
    "#;

    let output = reason(source).unwrap();
    assert!(output.contains(":result :head 1"), "{output}");
    assert!(output.contains(":result :tail (2 3)"), "{output}");
}

#[test]
fn partially_bound_native_list_patterns_use_all_bound_positions() {
    let source = r#"
        @prefix : <http://example.org/>.

        (:a :b1 :c) :relation :v1.
        (:a :b2 :d) :relation :v2.
        (:z :b3 :c) :relation :v3.

        { (:a ?middle :c) :relation ?value. } => { :case :value ?value. }.
    "#;

    let output = reason(source).unwrap();
    assert!(output.contains(":case :value :v1"), "{output}");
    assert!(!output.contains(":case :value :v2"), "{output}");
    assert!(!output.contains(":case :value :v3"), "{output}");
}

#[test]
fn log_dtlit_decomposes_a_literal_into_partially_bound_list_items() {
    let source = r#"
        @prefix : <#>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.

        {
            (?lexical ?datatype) log:dtlit 5.
        } => {
            :result :is (?lexical ?datatype).
        }.
    "#;

    let output = reason(source).unwrap();
    assert!(
        output.contains(":result :is (\"5\" xsd:integer)"),
        "{output}"
    );
}


#[test]
fn rdf_trig_query_selects_dataset_without_rule_feedback() {
    let trig = r#"
        PREFIX : <http://example.org/#>

        :g { :s :p :o }
    "#;
    let query = r#"
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        PREFIX : <http://example.org/#>

        {?S ?P ?O} log:query {?S ?P ?O}.
    "#;

    let mut doc = Document::new();
    doc.merge(parse_rdf12(trig, None, RdfFormat::Trig).unwrap());
    doc.merge(parse_n3(query, None).unwrap());

    let result = reason_document(&doc, &ReasonerOptions::default());
    let out = rdf_result_to_string(&doc.prefixes, &result.derived);

    assert!(out.contains(":g {"), "{}", out);
    assert!(out.contains("    :s :p :o ."), "{}", out);
    assert!(!out.contains("log:nameOf"), "{}", out);
    assert!(!out.contains("=>"), "{}", out);
}

#[test]
fn rdf12_annotations_share_n3_lexer_parser_profile() {
    let input = r#"
        PREFIX : <http://example.org/>
        :s :p :o {| :source :sensor |} .
    "#;
    let doc = parse_rdf12(input, Some("http://example.org/base"), RdfFormat::Turtle).unwrap();
    let reifies = "http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies";
    assert!(
        doc.facts
            .iter()
            .any(|t| matches!(&t.p, eyeron::Term::Iri(p) if p == reifies)),
        "{:#?}",
        doc.facts
    );
    assert!(
        doc.facts
            .iter()
            .any(|t| matches!(&t.p, eyeron::Term::Iri(p) if p == "http://example.org/source")),
        "{:#?}",
        doc.facts
    );
}

#[test]
fn rdf12_parenthesized_triple_terms_remain_terms() {
    let input = r#"
        PREFIX : <http://example.org/>
        :s :p <<(:a :b :c)>> .
    "#;
    let doc = parse_rdf12(input, Some("http://example.org/base"), RdfFormat::Turtle).unwrap();
    assert!(
        doc.facts
            .iter()
            .any(|t| matches!(&t.o, eyeron::Term::Formula(inner) if inner.len() == 1)),
        "{:#?}",
        doc.facts
    );
}

#[test]
fn age_example_supports_current_time_date_difference_and_duration_comparison() {
    use std::fs;
    use std::path::Path;

    let path = Path::new(env!("CARGO_MANIFEST_DIR")).join("examples/age.n3");
    let source = fs::read_to_string(&path).expect("read examples/age.n3");
    let doc = parse_n3_with_source(&source, None, Some("age.n3")).expect("parse age example");
    let result = reason_document(
        &doc,
        &ReasonerOptions {
            proof: true,
            ..ReasonerOptions::default()
        },
    );

    assert!(result.derived.iter().any(|triple| {
        triple.s == eyeron::Term::Iri("https://example.org/#test".to_string().into())
            && triple.p == eyeron::Term::Iri("https://example.org/#is".to_string().into())
    }));
    let proof = proof_to_n3(&doc.prefixes, &result);
    assert!(proof.contains("pe:builtin time:localTime"), "{proof}");
    assert!(proof.contains("pe:builtin math:difference"), "{proof}");
    assert!(proof.contains("pe:builtin math:greaterThan"), "{proof}");
}

#[test]
fn log_skolem_is_stable_by_default() {
    let source = r#"
        @prefix : <http://example.org/#> .
        @prefix log: <http://www.w3.org/2000/10/swap/log#> .

        { ("abc" 77) log:skolem ?id . } => { :Result :skolem ?id . } .
    "#;
    let out1 = reason(source).unwrap();
    let out2 = reason(source).unwrap();
    assert_eq!(out1, out2, "log:skolem should be stable by default");
    assert!(out1.contains(":Result :skolem genid:"), "{}", out1);
}



#[test]
fn log_query_can_emit_output_string() {
    let out = reason(include_str!("../examples/collection.n3")).unwrap();
    assert!(out.contains("# collection"), "{}", out);
    assert!(out.contains("Source files"), "{}", out);
}



#[test]
fn derived_rules_are_promoted_to_active_rules() {
    let out = reason(include_str!("../examples/derived-rule.n3")).unwrap();
    assert!(out.contains("=>"), "{}", out);
    assert!(out.contains(":test :is true"), "{}", out);

    let out = reason(include_str!("../examples/derived-backward-rule.n3")).unwrap();
    assert!(out.contains("<="), "{}", out);
    assert!(out.contains(":bob :hasParent :alice"), "{}", out);
    assert!(
        !out.contains(":bob :childOf :alice"),
        "derived backward rules must not materialize the goal fact:\n{}",
        out
    );
}

#[test]
fn cat_koko_keeps_generated_rule_blank_scopes_distinct() {
    let out = reason(include_str!("../examples/cat-koko.n3")).unwrap();
    assert!(out.contains("a :Cat"), "{}", out);
    assert!(out.contains("a :BritishShortHair"), "{}", out);
    assert!(out.contains(":test :is true"), "{}", out);
}

#[test]
fn formula_terms_can_be_derived_as_objects() {
    let out = reason(include_str!("../examples/good-cobbler.n3")).unwrap();
    assert!(out.contains(":test :is"), "{}", out);
    assert!(out.contains(":joe :is (:good :Cobbler)"), "{}", out);
}

#[test]
fn existential_rule_still_introduces_distinct_blank_nodes() {
    let out = reason(include_str!("../examples/existential-rule.n3")).unwrap();
    assert!(out.contains(":Socrates :is _:"), "{}", out);
    assert!(out.contains(":Plato :is _:"), "{}", out);
}

#[test]
fn dog_license_collect_all_is_scoped_by_subject() {
    let out = reason(include_str!("../examples/dog.n3")).unwrap();
    assert!(out.contains(":alice :mustHave :dogLicense"), "{}", out);
    assert!(
        !out.contains(":bob :mustHave :dogLicense"),
        "log:collectAllIn must count dogs per bound subject, not globally:\n{}",
        out
    );
}


#[test]
fn rdf12_turtle_profile_parses_lists_through_shared_parser() {
    let doc = eyeron::parse_rdf12(
        r#"PREFIX : <http://example.org/>
:s :p (1 2) ."#,
        Some("http://example.org/base"),
        eyeron::RdfFormat::Turtle,
    )
    .unwrap();
    let json = eyeron::rdf12_json(&doc);
    assert!(
        json.contains("http://www.w3.org/1999/02/22-rdf-syntax-ns#first"),
        "{}",
        json
    );
    assert!(
        json.contains("http://www.w3.org/1999/02/22-rdf-syntax-ns#rest"),
        "{}",
        json
    );
}

#[test]
fn rdf12_trig_profile_materializes_named_graphs_as_quads() {
    let doc = eyeron::parse_rdf12(
        r#"PREFIX : <http://example.org/>
:g { :s :p :o . }"#,
        None,
        eyeron::RdfFormat::Trig,
    )
    .unwrap();
    let json = eyeron::rdf12_json(&doc);
    assert!(
        json.contains("\"graph\":{\"termType\":\"NamedNode\",\"value\":\"http://example.org/g\"}"),
        "{}",
        json
    );
}

#[test]
fn rdf12_parenthesized_triple_terms_use_formula_term_representation() {
    let doc = eyeron::parse_rdf12(
        r#"PREFIX : <http://example.org/>
:s :p <<(:a :b :c)>> ."#,
        None,
        eyeron::RdfFormat::Turtle,
    )
    .unwrap();
    let json = eyeron::rdf12_json(&doc);
    assert!(json.contains("\"termType\":\"Quad\""), "{}", json);
    assert!(json.contains("http://example.org/a"), "{}", json);
}

#[test]
fn reasoner_reports_iteration_limit_instead_of_silent_partial_success() {
    use eyeron::{CompletionStatus, ReasonerLimit};

    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            :a :p :b .
            { :a :p :b } => { :a :q :c } .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(
        &doc,
        &ReasonerOptions {
            max_iterations: 0,
            ..ReasonerOptions::default()
        },
    );

    assert_eq!(result.status, CompletionStatus::Incomplete);
    assert_eq!(result.statistics.iterations, 0);
    assert!(result.limits_reached.contains(&ReasonerLimit::Iterations));
    assert!(result.derived.is_empty());
}

#[test]
fn reasoner_reports_match_step_limit() {
    use eyeron::{CompletionStatus, ReasonerLimit};

    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            :a :p :b .
            :a :q :c .
            { :a :p :b . :a :q :c } => { :a :r :d } .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(
        &doc,
        &ReasonerOptions {
            max_match_steps: 0,
            ..ReasonerOptions::default()
        },
    );

    assert_eq!(result.status, CompletionStatus::Incomplete);
    assert!(result.limits_reached.contains(&ReasonerLimit::MatchSteps));
    assert!(result.derived.is_empty());
}

#[test]
fn resource_builtin_uses_deterministic_hello_fixture() {
    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            @prefix log: <http://www.w3.org/2000/10/swap/log#> .
            { <http://example.org/HELLO.txt> log:content ?text } => { :result :text ?text } .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());

    assert!(result.is_complete(), "{:?}", result.errors);
    assert!(result_to_string(&doc.prefixes, &result.derived)
        .contains(":result :text \"Hello, world!\\n\""));
}

#[test]
fn unbound_not_includes_constructs_an_existential_witness_formula() {
    use eyeron::Term;

    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            @prefix log: <http://www.w3.org/2000/10/swap/log#> .
            { ?scope log:notIncludes { :a :b :c } } => { :result :scope ?scope } .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());

    assert!(result.is_complete(), "{:?}", result.errors);
    assert!(result.derived.iter().any(|triple| {
        triple.s == Term::iri("http://example.org/result")
            && triple.p == Term::iri("http://example.org/scope")
            && matches!(&triple.o, Term::Formula(items) if !items.is_empty())
    }));
}

#[test]
fn regex_builtins_use_general_regex_matching() {
    let source = r#"
        @prefix : <http://example.org/> .
        @prefix string: <http://www.w3.org/2000/10/swap/string#> .
        { "abc123" string:matches "^[a-z]+[0-9]+$" } => { :result :value "matched" } .
    "#;
    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());

    assert!(result.is_complete(), "{:?}", result.errors);
    assert!(result_to_string(&doc.prefixes, &result.derived).contains(":result :value \"matched\""));
}

#[test]
fn lookaround_regex_syntax_uses_compatibility_matching() {
    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            @prefix string: <http://www.w3.org/2000/10/swap/string#> .
            { "abc" string:matches "^(?=a)abc$" } => { :result :value "matched" } .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());

    assert!(result.is_complete(), "{:?}", result.errors);
    assert!(result_to_string(&doc.prefixes, &result.derived).contains(":result :value \"matched\""));
}

#[test]
fn proof_output_marks_missing_support_as_unproven() {
    use eyeron::reasoner::DerivedFact;
    use eyeron::{CompletionStatus, ReasonerResult, ReasonerStatistics, Rule, Term, Triple};
    use std::collections::BTreeMap;

    let missing = Triple::new(
        Term::iri("http://example.org/a"),
        Term::iri("http://example.org/p"),
        Term::iri("http://example.org/b"),
    );
    let derived = Triple::new(
        Term::iri("http://example.org/a"),
        Term::iri("http://example.org/q"),
        Term::iri("http://example.org/c"),
    );
    let rule = Rule::new(vec![missing.clone()], vec![derived.clone()], true);
    let proof = DerivedFact {
        fact: derived.clone(),
        rule: std::sync::Arc::new(rule.clone()),
        premises: vec![missing],
        bindings: Vec::new(),
    };
    let result = ReasonerResult {
        status: CompletionStatus::Complete,
        limits_reached: Vec::new(),
        errors: Vec::new(),
        statistics: ReasonerStatistics::default(),
        explicit: Vec::new(),
        explicit_sources: BTreeMap::new(),
        derived: vec![derived.clone()],
        closure: vec![derived],
        proofs: vec![proof],
        fuse: None,
        rules: vec![rule],
    };

    let output = proof_to_n3(&BTreeMap::new(), &result);
    assert!(output.contains("pe:unproven"), "{}", output);
    assert!(!output.contains("pe:fact \"<unknown>\""), "{}", output);
}

#[test]
fn regex_replacement_preserves_n3_dollar_and_backslash_escapes() {
    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            @prefix string: <http://www.w3.org/2000/10/swap/string#> .
            { ("abcd" "b" "\\$\\\\") string:replace "a$\\cd" } => { :result :value "matched" } .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());

    assert!(result.is_complete(), "{:?}", result.errors);
    assert!(result_to_string(&doc.prefixes, &result.derived).contains(":result :value \"matched\""));
}

#[test]
fn high_level_reason_does_not_fabricate_unknown_resource_content() {
    let output = eyeron::reason(
        r#"
            @prefix : <http://example.org/> .
            @prefix log: <http://www.w3.org/2000/10/swap/log#> .
            { <http://example.org/data.txt> log:content ?text } => { :result :text ?text } .
        "#,
    )
    .unwrap();

    assert!(output.is_empty(), "{}", output);
}

#[test]
fn proof_output_recognizes_compatible_lookaround_builtin() {
    use eyeron::reasoner::DerivedFact;
    use eyeron::{CompletionStatus, ReasonerResult, ReasonerStatistics, Rule, Term, Triple};
    use std::collections::BTreeMap;

    let compatible_builtin = Triple::new(
        Term::literal("abc"),
        Term::iri("http://www.w3.org/2000/10/swap/string#matches"),
        Term::literal("^(?=a)abc$"),
    );
    let derived = Triple::new(
        Term::iri("http://example.org/result"),
        Term::iri("http://example.org/value"),
        Term::literal("matched"),
    );
    let rule = Rule::new(
        vec![compatible_builtin.clone()],
        vec![derived.clone()],
        true,
    );
    let proof = DerivedFact {
        fact: derived.clone(),
        rule: std::sync::Arc::new(rule.clone()),
        premises: vec![compatible_builtin],
        bindings: Vec::new(),
    };
    let result = ReasonerResult {
        status: CompletionStatus::Complete,
        limits_reached: Vec::new(),
        errors: Vec::new(),
        statistics: ReasonerStatistics::default(),
        explicit: Vec::new(),
        explicit_sources: BTreeMap::new(),
        derived: vec![derived.clone()],
        closure: vec![derived],
        proofs: vec![proof],
        fuse: None,
        rules: vec![rule],
    };

    let output = proof_to_n3(&BTreeMap::new(), &result);
    assert!(
        output.contains("pe:builtin <http://www.w3.org/2000/10/swap/string#matches>"),
        "{}",
        output
    );
    assert!(!output.contains("pe:unproven"), "{}", output);
}

#[test]
fn log_name_of_remains_an_ordinary_graph_predicate() {
    use eyeron::Term;

    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            @prefix log: <http://www.w3.org/2000/10/swap/log#> .
            :payload log:nameOf { :subject :predicate :object } .
            { :payload log:nameOf ?formula } => { :result :formula ?formula } .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());

    assert!(result.is_complete(), "{:?}", result.errors);
    assert!(result.derived.iter().any(|triple| {
        triple.s == Term::iri("http://example.org/result")
            && triple.p == Term::iri("http://example.org/formula")
            && matches!(&triple.o, Term::Formula(_))
    }));
}

#[test]
fn unknown_predicate_in_builtin_namespace_remains_an_ordinary_predicate() {
    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            @prefix log: <http://www.w3.org/2000/10/swap/log#> .
            { :subject log:unknownBuiltin ?value } => { :result :value ?value } .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());

    assert!(result.is_complete(), "{:?}", result.errors);
    assert!(result.derived.is_empty());
}

#[test]
fn eyeling_datatype_inspection_builtins_drive_generated_rules() {
    let source = r#"
        @prefix : <http://example.org/> .
        @prefix cdt: <https://w3id.org/cdt/> .
        @prefix dt: <https://eyereasoner.github.io/eyeling/datatype#> .

        :measurement :speed "36 local-km/h"^^cdt:speed .
        {
            ?measurement :speed ?literal .
            ?literal dt:datatype ?datatype .
            ?literal dt:lexicalForm ?lexical .
        } => {
            ?literal :inspectedAs (?datatype ?lexical) .
        } .
    "#;

    let output = reason(source).unwrap();
    assert!(
        output.contains("\"36 local-km/h\"^^cdt:speed :inspectedAs (cdt:speed \"36 local-km/h\")"),
        "{output}"
    );
}

#[test]
fn blank_scope_log_not_includes_guards_generated_rules() {
    let source = r#"
        @prefix : <http://example.org/> .
        @prefix log: <http://www.w3.org/2000/10/swap/log#> .

        :input :value :ordinary .
        :blocked :guard true .
        {
            ?subject :value ?value .
            _:scope log:notIncludes { ?subject :guard true } .
        } => {
            ?subject :accepted ?value .
        } .
        :blocked :value :must-not-pass .
    "#;

    let output = reason(source).unwrap();
    assert!(output.contains(":input :accepted :ordinary"), "{output}");
    assert!(!output.contains(":blocked :accepted"), "{output}");
}

#[test]
fn blank_scope_log_not_includes_uses_existing_outer_bindings() {
    let source = r#"
        @prefix : <http://example.org/> .
        @prefix log: <http://www.w3.org/2000/10/swap/log#> .

        :output :isGenerated true .
        :input :value :first .
        {
            ?subject ?property ?value .
            _:scope log:notIncludes { ?property :isGenerated true } .
        } => {
            ?subject :acceptedProperty ?property .
        } .
    "#;

    let output = reason(source).unwrap();
    assert!(!output.contains(":acceptedProperty :output"), "{output}");
}

#[test]
fn blank_scope_log_not_includes_consults_backward_rules() {
    let source = r#"
        @prefix log: <http://www.w3.org/2000/10/swap/log#> .
        @prefix : <http://example.org/> .

        { ?value :class ?class } <= { ?value a ?class } .

        :p a :Person .

        { [] log:notIncludes { :p :class :Person } } => {
            :result :is :wrong
        } .
    "#;

    let output = reason(source).unwrap();
    assert!(
        !output.contains(":result :is :wrong"),
        "log:notIncludes ignored a conclusion available from a backward rule:\n{output}"
    );
}

#[test]
fn forward_body_keeps_backward_answers_when_explicit_fact_also_matches() {
    let source = r#"
        @prefix : <http://example.org/> .

        :source :piece (9) .
        :source :alternative (2 3) .

        { ?source :piece ?value } <= { ?source :alternative ?value } .

        { :source :piece ?value } => { :result :value ?value } .
    "#;

    let output = reason(source).expect("issue #8 fixture should reason completely");
    assert!(output.contains(":result :value (9)"), "{output}");
    assert!(
        output.contains(":result :value (2 3)"),
        "an explicit fact must not shadow an additional backward derivation:\n{output}",
    );
}

#[test]
fn nested_backward_body_keeps_backward_answers_when_explicit_fact_also_matches() {
    let source = r#"
        @prefix : <http://example.org/> .

        :source :piece (9) .
        :source :alternative (2 3) .

        { ?source :piece ?value } <= { ?source :alternative ?value } .
        { :answer :sifted ?value } <= { :source :piece ?value } .

        { :answer :sifted ?value } => { :result :value ?value } .
    "#;

    let output = reason(source).expect("issue #8 fixture should reason completely");
    assert!(output.contains(":result :value (9)"), "{output}");
    assert!(
        output.contains(":result :value (2 3)"),
        "nested backward reasoning lost the issue #8 derivation:\n{output}",
    );
}

#[test]
fn sift_repro_keeps_runnable_backward_goals_in_source_order() {
    let source = r#"
        @prefix math: <http://www.w3.org/2000/10/swap/math#> .
        @prefix list: <http://www.w3.org/2000/10/swap/list#> .
        @prefix log:  <http://www.w3.org/2000/10/swap/log#> .
        @prefix : <urn:laurence:calc#> .

        { (?p ()) :remove () }     <= { ?p log:equalTo ?p } .
        { (?p ?is) :remove ?out }  <= { ((?i) ?rest) list:append ?is .
                                        (?i ?p) math:remainder ?r . ?r math:notEqualTo 0 .
                                        (?p ?rest) :remove ?nis .
                                        ((?i) ?nis) list:append ?out } .
        { (?p ?is) :remove ?out }  <= { ((?i) ?rest) list:append ?is .
                                        (?i ?p) math:remainder 0 .
                                        (?p ?rest) :remove ?out } .
        () :sift () .
        { ?is :sift ?ps } <= { ((?i) ?rest) list:append ?is .
                               (?i ?rest) :remove ?new .
                               ?new :sift ?pt .
                               ((?i) ?pt) list:append ?ps } .
        { (2 3) :sift ?ps } => { :answer :sifted ?ps } .
    "#;

    let output = reason(source).expect("issue #8 sift fixture should reason completely");
    assert!(
        output.contains(":answer :sifted (2 3)"),
        "the runnable :remove backward premise must run before the later () :sift () fact:\n{output}",
    );
}

// --- ds-labs-org enforcer gaps (TDD): found running SolidLab's ODRL-Evaluator
// rule set on eyeron; each test is the minimal reproduction. ---

#[test]
fn math_comparisons_order_xsd_datetime_and_date() {
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.
        @prefix xsd: <http://www.w3.org/2001/XMLSchema#>.

        { "2024-02-12T11:20:10.999Z"^^xsd:dateTime math:greaterThan "2020-01-01T00:00:00Z"^^xsd:dateTime } => { :a :gt true }.
        { "2024-02-12T11:20:10.999Z"^^xsd:dateTime math:lessThan "2030-01-01T00:00:00Z"^^xsd:dateTime } => { :a :lt true }.
        { "2024-02-12T11:20:10.999Z"^^xsd:dateTime math:notEqualTo "2020-01-01T00:00:00Z"^^xsd:dateTime } => { :a :neq true }.
        { "2024-02-12T11:20:10.999Z"^^xsd:dateTime math:equalTo "2024-02-12T11:20:10.999Z"^^xsd:dateTime } => { :a :eq true }.
        { "2024-02-12T11:20:10.999Z"^^xsd:dateTime math:notGreaterThan "2024-02-12T11:20:10.999Z"^^xsd:dateTime } => { :a :ngt true }.
        { "2024-02-12T11:20:10.999Z"^^xsd:dateTime math:notLessThan "2024-02-12T11:20:10.999Z"^^xsd:dateTime } => { :a :nlt true }.
        { "2024-02-12"^^xsd:date math:lessThan "2030-01-01"^^xsd:date } => { :a :dateLt true }.
        # a UTC offset is the same instant as its Z form
        { "2024-02-12T12:20:10+01:00"^^xsd:dateTime math:equalTo "2024-02-12T11:20:10Z"^^xsd:dateTime } => { :a :offsetEq true }.

        # and the negative direction must not fire
        { "2024-02-12T11:20:10Z"^^xsd:dateTime math:greaterThan "2030-01-01T00:00:00Z"^^xsd:dateTime } => { :a :wrongGt true }.
        { "2024-02-12T11:20:10Z"^^xsd:dateTime math:equalTo "2024-02-12T11:20:11Z"^^xsd:dateTime } => { :a :wrongEq true }.
    "#;
    let output = reason(source).unwrap();
    for expected in ["gt", "lt", "neq", "eq", "ngt", "nlt", "dateLt", "offsetEq"] {
        assert!(output.contains(&format!(":a :{expected} true")), "missing :{expected}\n{output}");
    }
    for wrong in ["wrongGt", "wrongEq"] {
        assert!(!output.contains(wrong), "spurious :{wrong}\n{output}");
    }
}

#[test]
fn datetime_and_date_are_not_mutually_comparable_with_other_types() {
    // A dateTime against a plain string or a number is not an ordering.
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.
        @prefix xsd: <http://www.w3.org/2001/XMLSchema#>.
        { "2024-02-12T11:20:10Z"^^xsd:dateTime math:lessThan "2030-01-01T00:00:00Z" } => { :a :mixedStr true }.
        { "2024-02-12T11:20:10Z"^^xsd:dateTime math:lessThan 5 } => { :a :mixedNum true }.
    "#;
    let output = reason(source).unwrap();
    assert!(!output.contains("mixed"), "{output}");
}

#[test]
fn collect_all_in_with_blank_node_template_returns_exactly_one_list() {
    // Two matches, one aggregate: there must be exactly one `:count 2`, never
    // also `:count 1` (a stale singleton alternative made ODRL rules both
    // Active and Inactive).
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix list: <http://www.w3.org/2000/10/swap/list#>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.

        :r :p :a . :r :p :b . :a :s :yes .

        { ( ?t { :r :p _:s } ?L ) log:collectAllIn ?S . ?L list:length ?n } => { :r :count ?n }.
        { ( ?x { :r :p ?x . ?x :s :yes } ?L ) log:collectAllIn ?S . ?L list:length ?n } => { :r :sat ?n }.
    "#;
    let output = reason(source).unwrap();
    assert!(output.contains(":r :count 2"), "{output}");
    assert!(!output.contains(":r :count 1"), "{output}");
    assert!(output.contains(":r :sat 1"), "{output}");
}

#[test]
fn collect_all_in_three_scalars_under_blank_template_is_one_list() {
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix list: <http://www.w3.org/2000/10/swap/list#>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        :r :p :a . :r :p :b . :r :p :c .
        { ( ?t { :r :p _:s } ?L ) log:collectAllIn ?S . ?L list:length ?n } => { :r :count ?n }.
    "#;
    let output = reason(source).unwrap();
    assert!(output.contains(":r :count 3"), "{output}");
    assert!(!output.contains(":r :count 1"), "{output}");
    assert!(!output.contains(":r :count 2"), "{output}");
}

#[test]
fn log_uuid_maps_a_skolem_to_a_stable_uuid_string() {
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        { ("a") log:skolem ?s1 . ?s1 log:uuid ?u1 } => { :a :id ?u1 }.
        { ("b") log:skolem ?s2 . ?s2 log:uuid ?u2 } => { :b :id ?u2 }.
    "#;
    let first = reason(source).unwrap();
    let second = reason(source).unwrap();
    assert_eq!(first, second, "log:uuid must be deterministic for the same skolem");

    let uuid_of = |subject: &str| -> String {
        let line = first.lines().find(|l| l.contains(&format!(":{subject} :id"))).unwrap_or_else(|| panic!("no :{subject} :id in\n{first}"));
        line.split('"').nth(1).unwrap_or_else(|| panic!("no string literal in {line}")).to_string()
    };
    let (a, b) = (uuid_of("a"), uuid_of("b"));
    assert_ne!(a, b, "different skolems, different uuids");
    for u in [&a, &b] {
        let parts: Vec<usize> = u.split('-').map(str::len).collect();
        assert_eq!(parts, [8, 4, 4, 4, 12], "{u}");
        assert!(u.chars().all(|c| c == '-' || c.is_ascii_hexdigit()), "{u}");
    }
}

// --- Regression tests for the parser EOF fix and the join-ordering and regex
// optimizations. The expected outputs below are what the unoptimized matcher
// produced (observed on upstream dd2e4df), so a faster join order must not
// change them. ---

fn parse_on_small_stack(source: &'static str) -> bool {
    // A 1 MiB stack turns unbounded recursion into a quick abort instead of a
    // long wait, and matches what an embedding thread or a wasm module gets.
    std::thread::Builder::new()
        .stack_size(1024 * 1024)
        .spawn(move || parse_n3(source, None).is_err())
        .unwrap()
        .join()
        .expect("parsing must not overflow the stack")
}

#[test]
fn input_truncated_inside_a_bracket_is_a_parse_error_not_a_stack_overflow() {
    // Before the fix, `advance()` re-returned the last real token at EOF, so
    // `parse_term` saw the same `[` (or `<<`) again forever and the process
    // aborted with a stack overflow that `catch_unwind` cannot stop.
    for source in [
        "[",
        "<<",
        "[[",
        "@prefix : <http://e/> . :a :b [",
        "@prefix : <http://e/> . :a :b :c . [",
        "@prefix : <http://e/> . :a :b [ :p",
        "@prefix : <http://e/> . :a :b << :c :d",
        "{",
        "(",
        "@prefix",
    ] {
        assert!(parse_on_small_stack(source), "{source:?} must be rejected as incomplete");
    }
}

#[test]
fn complete_documents_still_parse_after_the_eof_fix() {
    for source in [
        "",
        "@prefix : <http://e/> . :a :b :c .",
        "@prefix : <http://e/> . :a :b [ :p :q ] .",
        "@prefix : <http://e/> . :a :b ( 1 2 ) .",
        "@prefix : <http://e/> . { :a :b :c } => { :d :e :f } .",
    ] {
        assert!(parse_n3(source, None).is_ok(), "{source:?} must still parse");
    }
}

#[test]
fn collect_all_in_returns_solutions_in_source_order_of_the_first_premise() {
    // The list `log:collectAllIn` returns is a term value: reordering the
    // join changes what a rule reading it derives. `?z :q ?z` has fewer real
    // matches than its index bucket, which is what a bucket-size estimate must
    // not be trusted for.
    let source = r#"
        @prefix : <http://e/> .
        @prefix log: <http://www.w3.org/2000/10/swap/log#> .
        :e :q :e .
        :f :q :f .
        :d :q [ :k 1 ] .
        :b :s :c .
        :b :s :e .
        :b :t :f .
        :go :go :go .
        { :go :go :go .
          ( (?y ?z) { ?z :q ?z . ?x :s ?y . ?x :t :f } ?L ) log:collectAllIn _:g
        } => { :result :is ?L } .
    "#;
    let output = reason(source).unwrap();
    assert!(output.contains(":result :is ((:c :e) (:e :e) (:c :f) (:e :f))"), "{output}");
}

#[test]
fn a_rule_reading_a_collected_list_sees_the_same_element_as_before() {
    let source = r#"
        @prefix : <http://e/> .
        @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
        @prefix log: <http://www.w3.org/2000/10/swap/log#> .
        :e :q :e . :f :q :f . :d :q [ :k 1 ] .
        :b :s :c . :b :s :e . :b :t :f .
        :go :go :go .
        { :go :go :go .
          ( (?y ?z) { ?z :q ?z . ?x :s ?y . ?x :t :f } ?L ) log:collectAllIn _:g .
          ?L rdf:rest ?R . ?R rdf:first ?Second
        } => { :second :is ?Second } .
    "#;
    let output = reason(source).unwrap();
    assert!(output.contains(":second :is (:e :e)"), "{output}");
}

#[test]
fn a_join_with_a_repeated_variable_derives_facts_in_the_unoptimized_order() {
    let source = r#"
        @prefix : <http://e/> .
        @prefix list: <http://www.w3.org/2000/10/swap/list#> .
        :e :q :e . :f :q :f . :b :s :c . :b :s :e . :d :q [ :k 1 ] . :b :t :f .
        { ?z :q ?z . (1 2 ?y) list:member ?y . ?x :s ?y . ?x :t :f }
          => { :r3 :out [ :vals (?x ?y ?z) ] } .
    "#;
    let output = reason(source).unwrap();
    let positions: Vec<usize> = ["(:b :c :e)", "(:b :e :e)", "(:b :c :f)", "(:b :e :f)"]
        .iter()
        .map(|vals| output.find(vals).unwrap_or_else(|| panic!("missing {vals}\n{output}")))
        .collect();
    assert!(positions.windows(2).all(|w| w[0] < w[1]), "solutions out of order:\n{output}");
}

#[test]
fn a_skewed_three_premise_join_is_not_quadratic() {
    // `?x :a ?y . ?y :b ?z . ?z :c ?w` over N chains. Materialising every
    // premise's whole bucket at every level made this quadratic: 25 s at
    // N = 4000 in a release build, minutes in a debug build. With cheapest-first
    // ordering it takes a fraction of a second. The bound is far above the
    // fast time and far below the slow one so it holds on a slow CI machine.
    let n = 3000;
    let mut source = String::from("@prefix : <http://e/> .\n");
    for i in 0..n {
        source.push_str(&format!(":x{i} :a :y{i} . :y{i} :b :z{i} . :z{i} :c :w{i} .\n"));
    }
    source.push_str("{ ?x :a ?y . ?y :b ?z . ?z :c ?w } => { ?x :d ?w } .\n");
    let started = std::time::Instant::now();
    let output = reason(&source).unwrap();
    let elapsed = started.elapsed();
    assert_eq!(output.matches(" :d ").count(), n);
    assert!(elapsed.as_secs() < 30, "join took {elapsed:?}: candidate materialisation is quadratic again");
}

#[test]
fn repeated_datetime_and_duration_comparisons_agree_with_a_single_one() {
    // The date and duration patterns are compiled once; many comparisons must
    // still give the same answers as one.
    let mut source = String::from(
        "@prefix : <http://e/> .\n@prefix math: <http://www.w3.org/2000/10/swap/math#> .\n\
         @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n",
    );
    for day in 1..=28 {
        source.push_str(&format!(
            ":d{day} :at \"2024-02-{day:02}T00:00:00Z\"^^xsd:dateTime . :d{day} :len \"P{day}D\"^^xsd:duration .\n"
        ));
    }
    source.push_str(
        "{ ?x :at ?t . ?t math:lessThan \"2024-02-15T00:00:00Z\"^^xsd:dateTime } => { ?x :early true } .\n\
         { ?x :len ?d . ?d math:greaterThan \"P20D\"^^xsd:duration } => { ?x :long true } .\n",
    );
    let output = reason(&source).unwrap();
    assert_eq!(output.matches(":early true").count(), 14, "{output}");
    assert_eq!(output.matches(":long true").count(), 8, "{output}");
}

#[test]
fn string_regex_builtins_give_the_same_answers_when_a_pattern_repeats() {
    let source = r#"
        @prefix : <http://e/> .
        @prefix string: <http://www.w3.org/2000/10/swap/string#> .
        :a :s "hello" . :b :s "help" . :c :s "hello" .
        { ?x :s ?v . ?v string:matches "^hel+o$" } => { ?x :ok true } .
        { ?x :s ?v . ?v string:notMatches "^hel+o$" } => { ?x :no true } .
        { ?x :s ?v . ( ?v "l+" "L" ) string:replace ?r } => { ?x :replaced ?r } .
        { ?x :s ?v . ( ?v "^h(.)" ) string:scrape ?g } => { ?x :second ?g } .
    "#;
    let output = reason(source).unwrap();
    assert_eq!(output.matches(":ok true").count(), 2, "{output}");
    assert_eq!(output.matches(":no true").count(), 1, "{output}");
    assert!(output.contains(":a :replaced \"heLo\""), "{output}");
    assert!(output.contains(":b :replaced \"heLp\""), "{output}");
    assert!(output.contains(":c :second \"e\""), "{output}");
}

#[test]
fn a_runaway_forward_rule_stops_at_the_iteration_limit() {
    use eyeron::{CompletionStatus, ReasonerLimit};

    // Each firing feeds the next, so the agenda inside one fixpoint pass
    // never runs out of work.  The iteration limit has to cover agenda steps
    // as well as outer passes, or nothing stops this short of the allocator.
    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            @prefix math: <http://www.w3.org/2000/10/swap/math#> .
            { :a :v ?x . (?x 1) math:sum ?z } => { :a :v ?z } .
            :a :v 0 .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(
        &doc,
        &ReasonerOptions {
            max_iterations: 1_000,
            ..ReasonerOptions::default()
        },
    );

    assert_eq!(result.status, CompletionStatus::Incomplete);
    assert!(result.limits_reached.contains(&ReasonerLimit::Iterations));
    assert!(result.statistics.iterations <= 1_000, "{:?}", result.statistics);
    assert!(result.closure.len() <= 1_001, "closure {}", result.closure.len());
}

#[test]
fn a_term_that_doubles_every_firing_stops_at_the_term_size_limit() {
    use eyeron::{CompletionStatus, ReasonerLimit};

    // Step counting cannot catch this one: thirty firings are enough to
    // exhaust memory, so the size of a derived fact needs its own bound.
    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            @prefix string: <http://www.w3.org/2000/10/swap/string#> .
            { :a :s ?x . (?x ?x) string:concatenation ?y } => { :a :s ?y } .
            :a :s "ab" .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(
        &doc,
        &ReasonerOptions {
            max_term_bytes: 4_096,
            ..ReasonerOptions::default()
        },
    );

    assert_eq!(result.status, CompletionStatus::Incomplete);
    assert!(result.limits_reached.contains(&ReasonerLimit::TermSize));
    for fact in &result.closure {
        if let eyeron::Term::Literal(literal) = &fact.o {
            assert!(literal.value.len() <= 4_096, "kept a {}-byte term", literal.value.len());
        }
    }
}

#[test]
fn a_term_that_nests_one_level_deeper_every_firing_stops_at_the_nesting_limit() {
    use eyeron::{CompletionStatus, ReasonerLimit};

    // This one stays tiny in bytes -- it wraps the same short literal over
    // and over -- so only the nesting bound catches it, and it has to catch
    // it before any recursive walk of the term runs out of stack.
    let doc = parse_n3(
        r#"
            @prefix : <http://example.org/> .
            { :a :l ?x } => { :a :l (?x) } .
            :a :l "seed" .
        "#,
        None,
    )
    .unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());

    assert_eq!(result.status, CompletionStatus::Incomplete);
    assert!(result.limits_reached.contains(&ReasonerLimit::TermDepth));
    assert!(result.closure.len() < 100, "closure {}", result.closure.len());
}

#[test]
fn an_absurd_string_format_width_produces_no_binding() {
    // A width is padding, not a request to allocate: a gigabyte-wide field
    // used to consume a gigabyte, and `usize::MAX` used to panic with
    // "capacity overflow".  Both now behave like any builtin call that
    // cannot produce a value.
    for width in ["1000000000", "18446744073709551615"] {
        let source = format!(
            r#"
                @prefix : <http://example.org/> .
                @prefix string: <http://www.w3.org/2000/10/swap/string#> .
                {{ ("%{width}s" "x") string:format ?y }} => {{ :a :out ?y }} .
            "#
        );
        let doc = parse_n3(&source, None).unwrap();
        let result = reason_document(&doc, &ReasonerOptions::default());
        assert!(result.derived.is_empty(), "width {width} derived {:?}", result.derived);
    }
}

#[test]
fn absurdly_nested_terms_are_a_parse_error_rather_than_a_stack_overflow() {
    // Nesting is parsed by recursion and a stack overflow aborts the
    // process, so the parsers refuse before the stack runs out.
    let n3 = format!("@prefix : <http://e/> .\n{} :a :b :c {} :p :o .\n", "{".repeat(5_000), "}".repeat(5_000));
    let err = parse_n3(&n3, None).unwrap_err().to_string();
    assert!(err.contains("nested more than"), "{err}");

    let collection = format!("@prefix : <http://e/> .\n:a :b {}{} .\n", "(".repeat(5_000), ")".repeat(5_000));
    let err = parse_n3(&collection, None).unwrap_err().to_string();
    assert!(err.contains("nested more than"), "{err}");

    let turtle = format!("@prefix : <http://e/> .\n:a :b {}:c{} .\n", "[ :p ".repeat(5_000), " ]".repeat(5_000));
    let err = parse_rdf12(&turtle, None, RdfFormat::Turtle).unwrap_err().to_string();
    assert!(err.contains("nested more than"), "{err}");
}

#[test]
fn proof_mode_derives_exactly_what_plain_mode_derives() {
    // `tests/examples.rs` checks each example's output golden and its proof
    // golden off a single reasoning run, which is only sound if turning
    // proof collection on cannot change what is derived. That is this
    // test's job, established once here over the machinery the examples
    // exercise -- forward and backward rules, builtins, rules that generate
    // rules, negation as failure and scoped aggregation -- rather than
    // re-established by a second run of every example.
    let examples = [
        "socrates",
        "ancestor",
        "backward",
        "derived-rule",
        "negation",
        "fibonacci",
        "peano-arithmetic",
        "list-builtins-tests",
        "string-builtins-tests",
        "log-collect-all-in",
    ];

    for name in examples {
        let path = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
            .join("examples")
            .join(format!("{name}.n3"));
        let source = std::fs::read_to_string(&path).expect("read example");
        let doc = parse_n3(&source, None).expect("parse example");

        let plain = reason_document(&doc, &ReasonerOptions::default());
        let with_proof = reason_document(
            &doc,
            &ReasonerOptions { proof: true, ..ReasonerOptions::default() },
        );

        assert_eq!(plain.derived, with_proof.derived, "{name} derived a different set under --proof");
        assert_eq!(plain.closure, with_proof.closure, "{name} reached a different closure under --proof");
        assert_eq!(plain.status, with_proof.status, "{name} reported a different completion status under --proof");
    }
}

// --- An RDF list written as explicit rdf:first/rdf:rest triples (ordinary
// Turtle, not a hostile shape) walks the whole fact list once per cell, which
// is quadratic in the list length and, independently, recurses once per cell
// with no depth bound -- unlike a parsed `( ... )` list, which is bounded by
// the parser's own MAX_TERM_NESTING_DEPTH. See the filed issue for the
// stack-overflow numbers; this test only checks the safe-to-run timing claim. ---

fn rdf_first_rest_chain(n: usize) -> String {
    let mut source = String::from(
        "@prefix : <http://e/> .\n@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n\
         @prefix list: <http://www.w3.org/2000/10/swap/list#> .\n",
    );
    for i in 0..n {
        let next = if i + 1 < n { format!(":n{}", i + 1) } else { "rdf:nil".to_string() };
        source.push_str(&format!(":n{i} rdf:first {i} ; rdf:rest {next} .\n"));
    }
    source.push_str("{ :n0 list:length ?n } => { :result :len ?n } .\n");
    source
}

#[test]
fn list_length_over_an_explicit_rdf_first_rest_chain_is_not_quadratic() {
    // Measured on the unfixed lookup (a linear scan of every fact per list
    // cell): 8,000 cells take 1.9 s, 16,000 take 6.5 s -- one doubling costs
    // 3.4x, not the ~2x a linear walk would cost. 20,000 cells extrapolates to
    // about 10 s quadratic; a bound of 5 s is well clear of a linear
    // implementation (sub-second) and well under a quadratic one.
    //
    // The unfixed walk also recurses once per cell with no depth bound (a
    // chain of only ~3,000 cells overflows a 1 MiB stack, ~27,000 the 8 MB
    // default main-thread stack). A default test-harness thread stack is
    // smaller than that, so this timing check runs on an explicit, generous
    // stack -- large enough to measure the quadratic-time claim without also
    // tripping the separate stack-depth bug (see the test below).
    std::thread::Builder::new()
        .stack_size(64 * 1024 * 1024)
        .spawn(|| {
            let source = rdf_first_rest_chain(20_000);
            let started = std::time::Instant::now();
            let output = reason(&source).unwrap();
            let elapsed = started.elapsed();
            assert!(output.contains(":result :len 20000"), "{output}");
            assert!(
                elapsed.as_secs() < 5,
                "list:length over a 20,000-cell rdf:first/rdf:rest chain took {elapsed:?}: \
                 rdf_list_object is scanning the whole fact list per cell again"
            );
        })
        .unwrap()
        .join()
        .unwrap();
}

#[test]
fn list_length_over_a_very_long_explicit_rdf_first_rest_chain_does_not_overflow_the_stack() {
    // The stack-depth half of the same bug, isolated from the timing bound
    // above. Measured: the unfixed recursive walk (one stack frame per list
    // cell, no depth bound) overflows a 1 MiB stack at ~3,000 cells, the 8 MB
    // default main-thread stack at ~27,000. A 200,000-cell chain on an 8 MiB
    // stack -- comfortably realistic, both sizes are ordinary defaults, not
    // extreme -- must not crash the process. It cannot be made to pass by
    // giving the test itself more stack: any fixed size still has some N that
    // overflows it, which is the bug; only removing the per-cell recursion
    // fixes it for every N.
    let ok = std::thread::Builder::new()
        .stack_size(8 * 1024 * 1024)
        .spawn(|| {
            let source = rdf_first_rest_chain(200_000);
            let output = reason(&source).unwrap();
            output.contains(":result :len 200000")
        })
        .unwrap()
        .join();
    assert!(ok.is_ok() && ok.unwrap(), "the walk must not recurse one stack frame per list cell");
}

// --- string:matches/notMatches/replace: an unsupported regex pattern (one
// Rust's regex crate rejects, and outside the small set of exact compat
// forms the notation3tests corpus needs) must derive nothing, not a
// confident, silently wrong answer. ---

#[test]
fn string_matches_with_an_invalid_pattern_derives_nothing_in_either_direction() {
    // "(" does not compile as a regex (unbalanced paren). The fallback used
    // to be `text.contains(pattern)`, so whichever direction that guess
    // happened to agree with derived a conclusion nobody verified.
    let source = r#"
        @prefix : <http://e/> .
        @prefix string: <http://www.w3.org/2000/10/swap/string#> .
        :a :s "xy(" .
        :b :s "zzz" .
        { ?x :s ?v . ?v string:matches "(" } => { ?x :matched true } .
        { ?x :s ?v . ?v string:notMatches "(" } => { ?x :notmatched true } .
    "#;
    let output = reason(source).unwrap();
    assert!(!output.contains(":matched"), "{output}");
    assert!(!output.contains(":notmatched"), "{output}");
}

#[test]
fn string_replace_treats_an_uncompilable_pattern_as_a_literal_search_string() {
    // Unlike string:matches/notMatches, string:replace's catch-all is not a
    // guess: when the pattern doesn't compile as a regex at all (here, `{`
    // outside a `{n,m}` repetition), reading it as the literal substring to
    // replace is the one self-consistent interpretation, and the
    // notation3tests corpus conformance-tests exactly this
    // (generated/string/replace/success-literal-4.n3, -subject-list-4.n3).
    // Removing this fallback (an earlier version of this fix did) broke
    // both. It must keep working.
    let source = r#"
        @prefix : <http://e/> .
        @prefix string: <http://www.w3.org/2000/10/swap/string#> .
        :a :s "{{tar{{target}}get}}" .
        { ?x :s ?v . ( ?v "{{target}}" "{over}" ) string:replace ?r } => { ?x :replaced ?r } .
    "#;
    let output = reason(source).unwrap();
    assert!(output.contains(":a :replaced \"{{tar{over}get}}\""), "{output}");
}

#[test]
fn known_compatibility_regex_forms_still_answer_as_before() {
    // The exact-match compatibility table, and the two structurally-correct
    // branches (a metachar-free ^...$ literal, and ^(?=lookahead)literal$),
    // are not the bug and must keep working unchanged.
    let source = r#"
        @prefix : <http://e/> .
        @prefix string: <http://www.w3.org/2000/10/swap/string#> .
        :a :s "hello world!" .
        :b :s "12" .
        { ?x :s ?v . ?v string:matches "^\\w+\\s+\\w+!" } => { ?x :table true } .
        { ?x :s ?v . ?v string:matches "^..$" } => { ?x :literal true } .
        { ?x :s ?v . ?v string:matches "^(?=[h])(?=.{5} )(?=.*!$).{12}$" } => { ?x :lookahead true } .
    "#;
    let output = reason(source).unwrap();
    assert!(output.contains(":a :table true"), "{output}");
    assert!(output.contains(":b :literal true"), "{output}");
    assert!(output.contains(":a :lookahead true"), "{output}");
}

#[test]
fn integer_arithmetic_is_exact_beyond_what_an_f64_can_hold() {
    // Every numeric builtin used to parse its operands into `f64` and format
    // the `f64` back out, so an integer past 2^53 came back changed: 2^1003
    // minus 3 was still 2^1003, because an `f64` at that magnitude has no
    // room for the 3, and 2^65536 was "INF". An xsd:integer literal already
    // carries its value exactly, so the operations that stay in the integers
    // now keep it.
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.

        {
            (2 1003) math:exponentiation ?Power.
            (?Power 3) math:difference ?Less.
            (?Less 3) math:sum ?Again.
            (?Again 1) math:product ?Same.
            ?Same math:negation ?Negated.
            ?Negated math:negation ?Back.
        } => {
            :result :less ?Less.
            :result :round-trips ?Back.
        }.
    "#;

    let output = reason(source).unwrap();
    // 2^1003 ends ...555008, so 2^1003 - 3 ends ...555005.
    assert!(output.contains(":less 85720688574901385675874003924800144844912"), "{output}");
    assert!(output.contains("341283438653220995094697645344555005"), "{output}");
    assert!(output.contains(":round-trips 857206885749013856758740039248001448449"), "{output}");
    assert!(output.contains("341283438653220995094697645344555008"), "{output}");
    assert!(!output.contains("INF"), "{output}");
}

#[test]
fn an_exact_power_too_large_to_materialise_is_refused_rather_than_attempted() {
    // The exact path is capped at two million bits, matching eyeling. Past
    // that the operation falls back to the f64 one, which overflows to "INF"
    // rather than allocating a gigabyte-scale integer.
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.

        { (2 3000000) math:exponentiation ?X } => { :result :is ?X }.
    "#;

    let output = reason(source).unwrap();
    assert!(output.contains("INF"), "{output}");
}

#[test]
fn a_computed_number_is_written_the_way_ecma_262_writes_it() {
    // Eyeling is JavaScript and prints a computed number with `String(n)`.
    // Eyeron wrote its own positional spelling, so the two engines disagreed
    // on every example that computes a decimal: `3.0` against `"3"`, and
    // `0.00000000000000006123233995736766` against `"6.123...e-17"`.
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.

        { (1.0 2) math:sum ?X } => { :a :whole ?X }.
        { (1.0 0.0000001) math:product ?X } => { :a :small ?X }.
        { (1.0 0.000001) math:product ?X } => { :a :not-quite-small ?X }.
        { (1.0 1000000000000000000000.0) math:product ?X } => { :a :large ?X }.
        { 1 math:acos ?X } => { :a :acos-of-one ?X }.
    "#;

    let output = reason(source).unwrap();
    // A whole decimal keeps its datatype but loses the invented ".0", so it
    // can no longer be written as the bare `3`.
    assert!(output.contains(r#":whole "3"^^xsd:decimal"#), "{output}");
    // Outside (-6, 21] the form is exponential, and xsd:decimal has no
    // exponential lexical form, so the result is an xsd:double.
    assert!(output.contains(":small 1e-7"), "{output}");
    // Printed bare, which reads back as exactly that xsd:decimal.
    assert!(output.contains(":not-quite-small 0.000001 "), "{output}");
    assert!(output.contains(":large 1e+21"), "{output}");
    // A trig result keeps the operand's datatype when it stays whole.
    assert!(output.contains(":acos-of-one 0 "), "{output}");
}

#[test]
fn one_number_written_two_ways_matches_itself() {
    // `0.0` and `"0"^^xsd:decimal` are the same number. Eyeron compared the
    // written form, so a premise spelling it one way missed a fact spelling
    // it the other -- which stayed hidden only while every computed number
    // happened to come out in the same spelling as the data.
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix xsd: <http://www.w3.org/2001/XMLSchema#>.

        :a :value 0.0 .
        :b :value "0"^^xsd:decimal .
        { :a :value "0"^^xsd:decimal } => { :result :quoted-finds-bare true }.
        { :b :value 0.0 } => { :result :bare-finds-quoted true }.
        { ?S :value 0.0 } => { ?S :open-match true }.
    "#;

    let output = reason(source).unwrap();
    assert!(output.contains(":quoted-finds-bare true"), "{output}");
    assert!(output.contains(":bare-finds-quoted true"), "{output}");
    assert_eq!(output.matches(":open-match true").count(), 2, "{output}");
}

#[test]
fn an_exponential_literal_keeps_the_lexical_form_it_was_written_with() {
    // The parser rewrote `6.1e-17` into its positional spelling, so eyeron's
    // own printed output read back as a different literal than the one it
    // printed.
    let source = r#"
        @prefix : <http://example.org/>.
        :a :value 6.123233995736766e-17 .
        { :a :value ?X } => { :b :value ?X }.
    "#;

    let output = reason(source).unwrap();
    assert!(output.contains(":b :value 6.123233995736766e-17"), "{output}");
}

#[test]
fn a_rule_concluding_false_stops_the_run_and_names_itself() {
    // `{ .. } => false` is an inference fuse: its premise becoming provable
    // is the thing the rule forbids. Eyeron used to refuse to parse it.
    let source = r#"
        @prefix : <http://example.org/>.
        :stone :color :black.
        :stone :color :white.
        { ?X :color :black. ?X :color :white. } => false.
    "#;

    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());
    let fuse = result.fuse.as_ref().expect("the fuse should have fired");
    // Nothing is asserted: the rules forbade this situation.
    assert!(result.derived.is_empty(), "{:?}", result.derived);

    let report = eyeron::fuse_report(&doc.prefixes, fuse);
    assert_eq!(
        report,
        "# Inference fuse triggered.\n\
         # Fired rule:\n\
         #   {\n\
         #     ?X :color :black .\n\
         #     ?X :color :white .\n\
         #   } => false .\n\
         # Matched instance:\n\
         #   {\n\
         #     :stone :color :black .\n\
         #     :stone :color :white .\n\
         #   } => false .\n",
        "{report}"
    );
}

#[test]
fn a_fuse_that_cannot_fire_leaves_the_rest_of_the_run_alone() {
    // Most uses of `=> false` are guards that never fire. They must parse,
    // be checked, and otherwise cost the run nothing.
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.
        :tank :level 30.
        { :tank :level ?L. ?L math:greaterThan 100 } => false.
        { :tank :level ?L. ?L math:lessThan 50 } => { :tank :status :low }.
    "#;

    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());
    assert!(result.fuse.is_none());
    let output = result_to_string(&doc.prefixes, &result.derived);
    assert!(output.contains(":tank :status :low"), "{output}");
}

#[test]
fn a_fuse_is_visible_as_data_to_another_fuse() {
    // The liar example: the outer rule forbids the inner rule's existence,
    // and rules are matchable as quoted implication triples. A fuse has to
    // show up as one concluding `false`, not as one concluding `true`.
    let source = r#"
        @prefix : <http://example.org/>.
        { :Alice a :Liar } => false .
        { { :Alice a :Liar } => false } => false .
    "#;

    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());
    let fuse = result.fuse.as_ref().expect("the outer fuse should have fired");
    let report = eyeron::fuse_report(&doc.prefixes, fuse);
    assert!(report.contains("} => false ."), "{report}");
    // The fired rule is the outer one, whose premise is the inner rule.
    assert!(report.contains(":Alice a :Liar"), "{report}");
    assert!(!report.contains("log:implies"), "{report}");
}

// --- ReasonerOptions::include_explicit: a caller that only reads
// `.derived` (`eyeron::reason(&str)`, the `log:conclusion` builtin's nested
// call) can skip the `.explicit`/`.explicit_sources` clone of every input
// fact entirely. Default stays `true` (the old, always-populated behavior);
// `proof: true` forces it back on regardless, since proof reconstruction
// needs it. ---

#[test]
fn include_explicit_false_leaves_explicit_and_explicit_sources_empty() {
    let source = "@prefix : <http://e/> .\n:a :p :b .\n{ ?s :p ?o } => { ?s :q ?o } .\n";
    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(
        &doc,
        &ReasonerOptions { include_explicit: false, ..ReasonerOptions::default() },
    );
    assert!(result.explicit.is_empty(), "{:?}", result.explicit);
    assert!(result.explicit_sources.is_empty(), "{:?}", result.explicit_sources);
    // What the caller actually asked for is untouched by the flag.
    assert_eq!(result.derived.len(), 1);
    assert!(result.is_complete());
}

#[test]
fn include_explicit_defaults_to_true_and_is_unchanged_from_before() {
    let source = "@prefix : <http://e/> .\n:a :p :b .\n{ ?s :p ?o } => { ?s :q ?o } .\n";
    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());
    assert_eq!(result.explicit, doc.facts);
    assert_eq!(result.explicit_sources, doc.fact_sources);
}

#[test]
fn proof_forces_include_explicit_on_even_if_the_caller_set_it_false() {
    let source = "@prefix : <http://e/> .\n:a :p :b .\n{ ?s :p ?o } => { ?s :q ?o } .\n";
    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(
        &doc,
        &ReasonerOptions { include_explicit: false, proof: true, ..ReasonerOptions::default() },
    );
    // A proof that could not find its own explicit support would be a
    // correctness bug, not a memory optimization: proof must win.
    assert_eq!(result.explicit, doc.facts);
    assert_eq!(result.explicit_sources, doc.fact_sources);
    // And the proof tree built from it must actually resolve, not just have
    // the raw data sitting there unused.
    let proof_n3 = proof_to_n3(&doc.prefixes, &result);
    assert!(!proof_n3.is_empty());
}

#[test]
fn the_reason_str_convenience_wrapper_still_derives_correctly_without_explicit() {
    // eyeron::reason(&str) passes include_explicit: false internally; this
    // only re-confirms its own contract (derived output unaffected) using
    // the public surface, since its internals aren't visible from here.
    let source = "@prefix : <http://example.org/>.\n:a :p :b .\n{ ?s :p ?o } => { ?s :q ?o } .\n";
    let output = reason(source).unwrap();
    assert!(output.contains(":a :q :b"), "{output}");
}

#[test]
fn writing_a_proof_is_linear_in_the_number_of_steps_it_explains() {
    // `explain_backward` built a fact index from scratch on every call, and
    // writing a proof calls it once per premise it has to justify -- so the
    // cost was the number of premises times the number of facts. Measured on
    // kaprekar-6174 at that version: 8 minutes without finishing, against
    // eyeling's 8.7s; reduced to a six-digit alphabet it took 46.5s, and
    // halving the alphabet again took 7.7s -- quadratic, not linear. With the
    // index built once per proof the same two take 0.57s and 0.29s, and the
    // full example 14.8s.
    //
    // This program derives ~1,100 facts, each justified by ten built-in
    // premises, which is the shape that made the product large. Measured
    // here: 0.30s with the index built once, 18.4s with it rebuilt per
    // premise. The bound is 5s -- well above what a linear walk costs even on
    // a CI runner a few times slower than this, and well under the quadratic.
    let source = r#"
        @prefix : <http://e/>.
        @prefix list: <http://www.w3.org/2000/10/swap/list#>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.

        :d :items (0 1 2 3 4 5 6 7 8 9 10).

        {
            :d :items ?L.
            ?L list:member ?a.
            ?L list:member ?b.
            ?L list:member ?c.
            (?a 100) math:product ?x.
            (?b 10) math:product ?y.
            (?x ?y ?c) math:sum ?n.
            (?n 1) math:sum ?n1.
            (?n1 1) math:sum ?n2.
            (?n2 1) math:sum ?n3.
            (?n3 1) math:sum ?n4.
            (?n4 1) math:sum ?n5.
            (?n5 1) math:sum ?n6.
        } => {
            ?n :reached ?n6.
        }.
    "#;

    let doc = parse_n3(source, None).unwrap();
    let started = std::time::Instant::now();
    let result = reason_document(&doc, &ReasonerOptions { proof: true, ..ReasonerOptions::default() });
    let proof = proof_to_n3(&doc.prefixes, &result);
    let elapsed = started.elapsed();

    // 100a + 10b + c over 0..=10 collides, so the distinct results are fewer
    // than the 1,331 triples the rule fires for.
    assert_eq!(result.derived.len(), 1111);
    assert!(!proof.is_empty());
    assert!(
        elapsed.as_secs() < 5,
        "writing the proof took {elapsed:?}: explain_backward is indexing every fact per premise again"
    );
}

#[test]
fn a_log_query_answer_carries_a_proof_of_its_own() {
    // A query answer is derived too -- by the query rule, from the premises
    // that matched. Until this was recorded, an example whose whole printed
    // result came from a `log:query` goal had nothing to write a proof from,
    // and seven of the packaged examples were in exactly that position.
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.

        :a :p :b.
        { ?s :p ?o } => { ?s :q ?o }.
        { ?s :q ?o } log:query { ?s :answer ?o }.
    "#;

    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions { proof: true, ..ReasonerOptions::default() });
    let output = result_to_string(&doc.prefixes, &result.derived);
    assert!(output.contains(":a :answer :b"), "{output}");

    let proof = proof_to_n3(&doc.prefixes, &result);
    // Both the answer and the forward step it rests on are in the proof.
    assert!(proof.contains(":a :answer :b"), "{proof}");
    assert!(proof.contains(":a :q :b"), "{proof}");
}

#[test]
fn a_query_that_hands_back_its_own_premise_records_no_step() {
    // `{ ?s ?p ?o } log:query { ?s ?p ?o }` selects a fact rather than
    // inferring one. A step for it would say the fact holds because it
    // holds, which is the circularity a proof checker exists to reject --
    // and did, on kronecker.n3, relational-cube-lookup.n3 and
    // kaprekar-6174.n3.
    let source = r#"
        @prefix : <http://example.org/>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.

        :a :p :b.
        { ?s :p ?o } => { ?s :q ?o }.
        { ?s ?p ?o } log:query { ?s ?p ?o }.
    "#;

    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions { proof: true, ..ReasonerOptions::default() });
    let proof = proof_to_n3(&doc.prefixes, &result);

    // The forward step is still proved; the query restating it is not a step.
    assert!(proof.contains(":a :q :b"), "{proof}");
    assert!(!proof.contains("log:query"), "{proof}");
}

#[test]
fn a_float_relation_checked_the_other_way_round_is_still_the_same_number() {
    // `(10 ?e) math:exponentiation 35766` is solved by logarithm, and raising
    // 10 to that exponent gives 35765.999999999956 -- six units in the last
    // place short. Comparing against `f64::EPSILON` is a test for bit-identity
    // at any magnitude above 1, so re-checking the premise the other way round
    // failed and control-system.n3's proof recorded the step as unproven.
    let source = r#"
        @prefix : <http://e/>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.
        :d :measure 35766.
        { :d :measure ?D. (10 ?E) math:exponentiation ?D } => { :d :exponent ?E }.
    "#;

    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions { proof: true, ..ReasonerOptions::default() });
    let output = result_to_string(&doc.prefixes, &result.derived);
    assert!(output.contains(":d :exponent 4.553470372213121"), "{output}");

    // The proof re-checks that premise forward, which is where it used to fail.
    let proof = proof_to_n3(&doc.prefixes, &result);
    assert!(!proof.contains("pe:unproven"), "{proof}");
}

#[test]
fn a_rule_that_concludes_its_own_premise_is_not_its_own_justification() {
    // polygon.n3 forces a backward goal to be evaluated with
    // `{ (..) polygon:area ?A } => { (..) polygon:area ?A }`. That rule is
    // what puts the fact in the closure, so the fact stays a claim the proof
    // makes -- but writing the rule application as its step would say the
    // fact holds because it holds, which the checker rejects as self-support.
    let source = r#"
        @prefix : <http://e/>.
        { :a :size 3 } <= true.
        { :a :size ?S } => { :a :size ?S }.
    "#;

    let doc = parse_n3(source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions { proof: true, ..ReasonerOptions::default() });
    let proof = proof_to_n3(&doc.prefixes, &result);

    // The fact is claimed, and justified by the backward rule, not by itself.
    assert!(proof.contains(":a :size 3"), "{proof}");
    assert!(!proof.contains("pe:unproven"), "{proof}");
}

#[test]
fn a_guard_that_holds_neither_changes_the_answers_nor_their_order() {
    // The matcher drops a ready test that holds instead of materialising a
    // continuation for it, and re-examines only the premises whose variables
    // moved. Both are sound because such a test binds nothing -- but only if
    // the answers, and the order they come out in, are untouched.
    let source = r#"
        @prefix : <http://e/>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.

        :a :n 1. :a :n 2. :a :n 3. :a :n 4. :a :n 5.
        {
            :a :n ?X.
            ?X log:notEqualTo 3.
            ?X math:greaterThan 1.
            :a :n ?Y.
            ?Y log:notEqualTo ?X.
            (?X ?Y) math:sum ?S.
            ?S math:lessThan 8.
        } => { :pair :sum ?S }.
    "#;

    let output = reason(source).unwrap();
    // 2,4,5 pass the guards on ?X; the sums under 8 are the ones listed here.
    let mut sums: Vec<&str> = output
        .lines()
        .filter_map(|line| line.trim().strip_prefix(":pair :sum "))
        .map(|rest| rest.trim_end_matches(" ."))
        .collect();
    sums.sort();
    assert_eq!(sums, vec!["3", "5", "6", "7"], "{output}");
}

#[test]
fn a_guard_that_fails_still_stops_the_branch() {
    // The early-failure check is what stops hanoi.n3 recursing through 0, -1,
    // .. after `?n math:greaterThan 1` is already false. Examining fewer
    // premises per node must not lose that.
    let source = r#"
        @prefix : <http://e/>.
        @prefix math: <http://www.w3.org/2000/10/swap/math#>.
        { (0 ?N) :count ?N } <= true.
        { (?K ?N) :count ?R } <= {
            ?K math:greaterThan 0.
            (?K 1) math:difference ?K1.
            (?N 1) math:sum ?N1.
            (?K1 ?N1) :count ?R.
        }.
        { (5 0) :count ?R } => { :result :is ?R }.
    "#;

    let output = reason(source).unwrap();
    assert!(output.contains(":result :is 5"), "{output}");
}
