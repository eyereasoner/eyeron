use eyeron::{parse_n3, reason, reason_document, triples_to_n3, Graph, ReasonerOptions, Term};

const PREFIX: &str = "@prefix : <http://example.org/>.\n";
fn parse(body: &str) -> eyeron::Document {
    parse_n3(&format!("{PREFIX}{body}"), None).unwrap()
}
fn derives(body: &str) -> String {
    reason(&format!("{PREFIX}{body}")).unwrap()
}
fn graph(term: &Term) -> &Graph {
    let Term::Formula(g) = term else {
        panic!("expected graph")
    };
    g
}

#[test]
fn quoted_graph_matching_cannot_confuse_input_iris_with_internal_quantifiers() {
    for name in ["urn:eyeron:includes-rigid:u:__q1", "urn:eyeron:includes-rigid:_u:__q1"] {
        let source = format!(r#"
            @prefix log: <http://www.w3.org/2000/10/swap/log#>.
            {{ {{ @forAll :x. :x :p :b }} log:includes {{ <{name}> :p :b }} }}
                => {{ :forged :holds true }}.
        "#);
        assert!(derives(&source).is_empty(), "internal IRI became a universal instance: {name}");
    }
    let source = r#"
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        { { <urn:eyeron:includes-rigid:u:__q1> :p :b } log:includes
          { <urn:eyeron:includes-rigid:u:__q1> :p :b } }
            => { :ordinary :holds true }.
    "#;
    assert!(derives(source).contains(":ordinary :holds true"));
}

#[test]
fn quoted_negative_tests_keep_local_blank_patterns_and_match_quoted_statements() {
    let cases = [
        ("{ :alice :p :b }", "{ _:who :p :b }", false),
        ("{}", "{ 1 math:lessThan 2 }", true),
        ("{}", "{ 3 math:lessThan 2 }", true),
        ("{ 1 math:lessThan 2 }", "{ 1 math:lessThan 2 }", false),
    ];
    for (scope, pattern, expected) in cases {
        let source = format!(r#"
            @prefix log: <http://www.w3.org/2000/10/swap/log#>.
            @prefix math: <http://www.w3.org/2000/10/swap/math#>.
            {{ {scope} log:notIncludes {pattern} }} => {{ :test :holds true }}.
        "#);
        assert_eq!(!derives(&source).is_empty(), expected, "{scope} log:notIncludes {pattern}");
    }
}

#[test]
fn quoted_inclusion_keeps_literal_lexical_identity() {
    let cases = [
        ("{ :a :p \"01\"^^xsd:integer }", "{ :a :p 1 }", false),
        ("{ :a :p 1 }", "{ :a :p \"01\"^^xsd:integer }", false),
        ("{ :a :p (1 2) }", "{ :a :p (\"01\"^^xsd:integer 2) }", false),
        ("{ :a :p { :b :q \"01\"^^xsd:integer } }", "{ :a :p { :b :q 1 } }", false),
        ("{ :a :p \"01\"^^xsd:integer }", "{ :a :p \"01\"^^xsd:integer }", true),
        ("{ :a :p \"x\"@EN }", "{ :a :p \"x\"@en }", true),
    ];
    for (scope, pattern, included) in cases {
        let source = format!(r#"
            @prefix log: <http://www.w3.org/2000/10/swap/log#>.
            @prefix xsd: <http://www.w3.org/2001/XMLSchema#>.
            {{ {scope} log:includes {pattern} }} => {{ :test :includes true }}.
            {{ {scope} log:notIncludes {pattern} }} => {{ :test :notIncludes true }}.
        "#);
        let out = derives(&source);
        assert_eq!(out.contains(":includes"), included, "{scope} log:includes {pattern}: {out}");
        assert_eq!(out.contains(":notIncludes"), !included, "{scope} log:notIncludes {pattern}: {out}");
    }
    // The current graph is no graph term: its facts match by value.
    let out = derives(r#"
        @prefix log: <http://www.w3.org/2000/10/swap/log#>.
        @prefix xsd: <http://www.w3.org/2001/XMLSchema#>.
        :a :p "01"^^xsd:integer.
        { ?scope log:includes { :a :p 1 } } => { :test :currentGraph true }.
    "#);
    assert!(out.contains(":test :currentGraph true"), "{out}");
}

#[test]
fn explicit_declarations_resolve_iris_and_all_triple_positions() {
    let doc = parse("@forAll :x, <http://example.org/p>. @forSome :y. :x :p :y.");
    assert_eq!(doc.universals.len(), 2);
    assert_eq!(doc.existentials.len(), 1);
    assert!(matches!(doc.facts[0].s, Term::Var(_)));
    assert!(matches!(doc.facts[0].p, Term::Var(_)));
    assert!(matches!(doc.facts[0].o, Term::Blank(_)));
}

#[test]
fn declarations_have_the_required_order_and_placement() {
    for bad in [
        "@forSome :y. @forAll :x. :x :loves :y.",
        ":a :p :b. @forAll :x.",
        ":a :p { :a :p :b. @forSome :x. }.",
        "@forAll ?x.",
        "@forSome _:x.",
        "@forAll :x. @forSome :x.",
        "@forAll :x. @forAll :x.",
        "@forAll .",
        "@forAll :x",
    ] {
        assert!(
            parse_n3(&format!("{PREFIX}{bad}"), None).is_err(),
            "accepted: {bad}"
        );
    }
}

#[test]
fn local_universals_are_ground_graph_terms_and_implicit_universals_are_outermost() {
    let doc =
        parse("<example.n3> log:semantics { @forAll :x. :x :loves _:y }. :a :p { ?x :p _:x }.");
    let local = graph(&doc.facts[0].o);
    assert_eq!(local.universals.len(), 1);
    assert_eq!(local.existentials.len(), 1);
    assert!(doc.facts[0].o.is_ground());
    assert!(!doc.facts[1].o.is_ground());
    assert!(doc.universals.contains("x"));
}

#[test]
fn outer_variables_are_inherited_and_inner_declarations_shadow_them() {
    let doc = parse(
        "@forSome :y. :y :says { @forAll :x. :y :likes :x }. :a :says { @forAll :y. :y :p :b }.",
    );
    let inner = graph(&doc.facts[0].o);
    assert_eq!(doc.facts[0].s, inner[0].s);
    assert!(inner.free_variables().contains(&doc.facts[0].s));
    assert!(matches!(graph(&doc.facts[1].o)[0].s, Term::Var(_)));
}

#[test]
fn an_outer_existential_connects_a_quoted_statement_to_an_asserted_fact() {
    let source = format!(r#"{PREFIX}
        @forSome :witness .
        :s :p {{ :witness :b :c }} .
        :witness a :Unicorn .
        {{ :s :p {{ ?x :b :c }} . ?x a :Unicorn }} => {{ :x :y :z }} .
    "#);
    let doc = parse_n3(&source, None).unwrap();
    let result = reason_document(&doc, &ReasonerOptions::default());
    assert!(result.is_complete());
    assert_eq!(result.derived, vec![eyeron::Triple::new(
        Term::iri("http://example.org/x"),
        Term::iri("http://example.org/y"),
        Term::iri("http://example.org/z"),
    )]);
    // Reusing a local blank label across the graph boundary does not connect it.
    assert!(derives(r#"
        :s :p { _:x :b :c } . _:x a :Unicorn .
        { :s :p { ?x :b :c } . ?x a :Unicorn } => { :x :y :z } .
    "#).is_empty());
}

#[test]
fn explicit_universals_drive_rules_and_existentials_produce_witnesses() {
    let output =
        derives("@forAll :x. { :x a :Human } => { @forSome :y. :x :hasMother :y }. :tom a :Human.");
    assert!(output.contains(":tom :hasMother _:"), "{output}");
}

#[test]
fn bound_graph_variables_are_alpha_equivalent_but_never_wildcards() {
    let output = derives(
        r#"
        :bob :says { @forAll :x. :x :likes :pasta }.
        { :bob :says { @forAll :renamed. :renamed :likes :pasta } } => { :alpha :ok true }.
        { :bob :says { :alice :likes :pasta } } => { :bad :constant true }.
        { :bob :says { @forSome :x. :x :likes :pasta } } => { :bad :existential true }.
    "#,
    );
    assert!(output.contains(":alpha :ok true"), "{output}");
    assert!(!output.contains(":bad"), "{output}");
}

#[test]
fn existential_isomorphism_is_bijective_and_graph_terms_are_closed() {
    let output = derives(
        r#"
        :bob :says { _:x :p :a. _:y :p :a }.
        { :bob :says { _:z :p :a } } => { :bad :subset true }.
        { :bob :says { _:z :p :a. _:z :p :a } } => { :bad :collapse true }.
        { :bob :says { _:u :p :a. _:v :p :a } } => { :alpha :ok true }.
    "#,
    );
    assert!(output.contains(":alpha :ok true"), "{output}");
    assert!(!output.contains(":bad"), "{output}");
}

#[test]
fn printing_preserves_local_universals_and_escaping_existentials() {
    let doc = parse("@forSome :y. :y :says { @forAll :x. :y :likes :x }.");
    let printed = triples_to_n3(&doc.prefixes, &doc.facts);
    assert!(printed.contains("@forAll"), "{printed}");
    assert!(printed.contains("@forSome"), "{printed}");
    let again = parse_n3(&printed, None).unwrap();
    let inner = graph(&again.facts[0].o);
    assert_eq!(again.facts[0].s, inner[0].s, "{printed}");
    assert_eq!(inner.universals.len(), 1);
}

#[test]
fn unquoting_keeps_quantification() {
    let doc = parse(":bob :says { @forAll :x. :x :p :o }. { :bob :says ?g } => ?g. { :s :p :o } => { :result :ok true }.");
    let result = reason_document(&doc, &ReasonerOptions::default());
    assert!(
        result
            .derived
            .iter()
            .any(|t| t.s == Term::iri("http://example.org/result")),
        "{:?}",
        result.derived
    );
}

#[test]
fn universal_instances_have_dependent_existentials() {
    let doc = parse("@forAll :x. @forSome :y. :x :hasMother :y. { :bob :hasMother ?b. :liz :hasMother ?l } => { :bob :mother ?b. :liz :mother ?l }.");
    let result = reason_document(&doc, &ReasonerOptions::default());
    let bob = result
        .derived
        .iter()
        .find(|t| t.s == Term::iri("http://example.org/bob"))
        .unwrap();
    let liz = result
        .derived
        .iter()
        .find(|t| t.s == Term::iri("http://example.org/liz"))
        .unwrap();
    assert_ne!(bob.o, liz.o);
    let output = derives("@forAll :x. :x :p :o. { :s :p :o } => { :result :ok true }.");
    assert!(output.contains(":result :ok true"), "{output}");
}

#[test]
fn existential_before_nested_universal_is_shared() {
    let doc = parse("@forSome :y. {} => { @forAll :x. :x :loves :y }. { :bob :loves ?b. :liz :loves ?l } => { :bob :beloved ?b. :liz :beloved ?l }.");
    let result = reason_document(&doc, &ReasonerOptions::default());
    let bob = result
        .derived
        .iter()
        .find(|t| t.s == Term::iri("http://example.org/bob"))
        .unwrap();
    let liz = result
        .derived
        .iter()
        .find(|t| t.s == Term::iri("http://example.org/liz"))
        .unwrap();
    assert_eq!(bob.o, liz.o);
}

#[test]
fn local_universal_premise_cannot_be_proved_by_one_concrete_fact() {
    let output = derives(":alice :p :o. { @forAll :x. :x :p :o } => { :bad :ok true }.");
    assert!(!output.contains(":bad"), "{output}");
    let output = derives("@forAll :x. :x :p :o. { @forAll :y. :y :p :o } => { :result :ok true }.");
    assert!(output.contains(":result :ok true"), "{output}");
}

#[test]
fn includes_is_existential_consequence_without_instantiating_universals() {
    let output = derives(
        r#"
        { { :s :p :o. :a :b :c } log:includes { :a :b :c } } => { :subset :ok true }.
        { { @forAll :x. :x :p :o } log:includes { @forAll :u. @forSome :y. :u :p :y } } => { :generalisation :ok true }.
        { { @forAll :x. :x :p :o } log:includes { :s :p :o } } => { :bad :universalInstance true }.
        { { _:x :p :o } log:includes { :s :p :o } } => { :bad :existentialInstance true }.
        { { :s :p :o } log:includes { @forSome :x. :x :p :o } } => { :existential :ok true }.
    "#,
    );
    assert!(output.contains(":subset :ok true"), "{output}");
    assert!(output.contains(":generalisation :ok true"), "{output}");
    assert!(output.contains(":existential :ok true"), "{output}");
    assert!(!output.contains(":bad"), "{output}");
}

#[test]
fn normalization_and_duplicate_triples_do_not_change_graph_identity() {
    let output = derives(
        r#"
        { { @forAll :unused. :a :p :b. :a :p :b } log:equalTo { :a :p :b } } => { :result :ok true }.
    "#,
    );
    assert!(output.contains(":result :ok true"), "{output}");
}

#[test]
fn universal_instantiation_reaches_free_variables_in_nested_terms() {
    let output = derives("@forAll :x. :bob :says { :x :is :wise }. { :bob :says { :alice :is :wise } } => { :result :ok true }.");
    assert!(output.contains(":result :ok true"), "{output}");
}

#[test]
fn separately_parsed_documents_merge_with_disjoint_binders() {
    let mut first = parse("@forSome :x. :x :p :a.");
    let second = parse("@forSome :x. :x :p :b.");
    first.merge(second);
    assert_ne!(first.facts[0].s, first.facts[1].s);
    assert_eq!(first.existentials.len(), 2);
}

#[test]
fn quoted_literals_keep_their_lexical_identity() {
    let output = derives(
        r#"
        { { :s :p "01"^^xsd:integer } log:equalTo { :s :p 1 } } => { :bad :ok true }.
        { { :s :p "hello"^^xsd:string } log:equalTo { :s :p "hello" } } => { :result :ok true }.
    "#,
    );
    assert!(!output.contains(":bad"), "{output}");
    assert!(output.contains(":result :ok true"), "{output}");
}

#[test]
fn quantification_examples_parse_and_finish() {
    let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("examples");
    for name in [
        "graph-terms.n3",
        "graph-term-opacity.n3",
        "explicit-quantification.n3",
        "explicit-existential-rule.n3",
        "universal-instances.n3",
        "graph-includes.n3",
        "shared-existential.n3",
    ] {
        let path = root.join(name);
        let source = std::fs::read_to_string(&path).unwrap();
        let doc = parse_n3(&source, None).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
        let result = reason_document(&doc, &ReasonerOptions::default());
        assert!(
            result.is_complete(),
            "{}: {:?}",
            path.display(),
            result.incomplete_summary()
        );
        if path.ends_with("graph-terms.n3") {
            assert!(result
                .derived
                .iter()
                .any(|t| t.s == Term::iri("http://example.org/alice")
                    && t.o == Term::iri("http://example.org/pizza")));
        }
        if path.ends_with("graph-term-opacity.n3") {
            assert!(result
                .derived
                .iter()
                .any(|t| t.s == Term::iri("http://example.org/loisLane")));
        }
        if path.ends_with("graph-includes.n3") {
            assert_eq!(result.derived.len(), 2);
        }
        if path.ends_with("universal-instances.n3") {
            assert_eq!(result.derived.len(), 3);
            let mothers: Vec<_> = result
                .derived
                .iter()
                .filter(|t| t.p == Term::iri("http://example.org/mother"))
                .collect();
            assert_eq!(mothers.len(), 2);
            assert_ne!(mothers[0].o, mothers[1].o);
        }
    }
}

#[test]
fn quantified_aliases_are_variables_but_literal_datatypes_are_constants() {
    let doc = parse(
        "@forAll rdf:type, log:implies, xsd:string. :s a :o. {} => {}. :s :p \"v\"^^xsd:string.",
    );
    assert!(matches!(doc.facts[0].p, Term::Var(_)));
    assert!(matches!(doc.facts[1].p, Term::Var(_)));
    assert!(doc.rules.is_empty());
    assert!(
        matches!(&doc.facts[2].o, Term::Literal(l) if l.datatype.as_deref() == Some("http://www.w3.org/2001/XMLSchema#string"))
    );
}

#[test]
fn explicit_quantifier_rule_proofs_check() {
    let source = format!("{PREFIX}@forAll :x. {{ :x a :Human }} => {{ @forSome :y. :x :hasMother :y }}. :tom a :Human.");
    let doc = parse_n3(&source, None).unwrap();
    let result = reason_document(
        &doc,
        &ReasonerOptions {
            proof: true,
            ..ReasonerOptions::default()
        },
    );
    let proof = eyeron::proof_to_n3(&doc.prefixes, &result);
    let report = eyeron::proof_check_n3::check_proof_document(&doc, &proof).unwrap();
    assert!(report.valid(), "{}\n{proof}", report.verdict());
}

#[test]
fn empty_graph_terms_remain_graph_terms_when_serialized() {
    let doc = parse(":s :p {}.");
    let text = triples_to_n3(&doc.prefixes, &doc.facts);
    let again = parse_n3(&text, None).unwrap();
    assert!(
        matches!(&again.facts[0].o, Term::Formula(g) if g.is_empty()),
        "{text}"
    );
}

#[test]
fn isomorphism_preserves_outer_coreference_across_nested_graph_terms() {
    let output = derives(
        r#"
        :source :graph {
            @forAll :x, :y.
            :bob :says { :x :p :o }.
            :carol :says { :x :p :o }.
            :dave :says { :y :p :o }.
        }.
        { :source :graph {
            @forAll :u, :v.
            :bob :says { :u :p :o }.
            :carol :says { :v :p :o }.
            :dave :says { :v :p :o }.
        } } => { :bad :ok true }.
    "#,
    );
    assert!(!output.contains(":bad"), "{output}");
}

#[test]
fn isomorphism_does_not_swap_local_and_captured_binders() {
    let output = derives(
        r#"
        :source :graph { @forAll :x. :s :p { @forAll :y. :x :p :y } }.
        { :source :graph { @forAll :u. :s :p { @forAll :v. :v :p :u } } }
            => { :bad :ok true }.
        { :source :graph { @forAll :u. :s :p { @forAll :v. :u :p :v } } }
            => { :result :ok true }.
    "#,
    );
    assert!(!output.contains(":bad"), "{output}");
    assert!(output.contains(":result :ok true"), "{output}");
}

#[test]
fn isomorphism_backtracks_across_symmetric_nested_graphs() {
    let output = derives(
        r#"
        :source :graph {
            @forAll :x, :y.
            :bob :says { :x :p :y. :y :p :x }.
            :carol :says { :x :q :o }.
        }.
        { :source :graph {
            @forAll :u, :v.
            :bob :says { :u :p :v. :v :p :u }.
            :carol :says { :v :q :o }.
        } } => { :result :ok true }.
    "#,
    );
    assert!(output.contains(":result :ok true"), "{output}");
}
