% ODRL policy risks evaluated against a DPV-style consumer profile.
% RDF resources and classes are represented as symbols; graph joins, missing
% safeguards, score normalization, classification, mitigation, and ranking are
% performed by ordinary Prolog rules.

% Consumer profile and weighted needs.
profile(consumer_example, "Example consumer profile").
has_need(consumer_example, need_data_cannot_be_removed).
has_need(consumer_example, need_change_only_with_prior_notice).
has_need(consumer_example, need_no_sharing_without_consent).
has_need(consumer_example, need_data_portability).
need(need_data_cannot_be_removed, 20).
need(need_change_only_with_prior_notice, 15).
need(need_no_sharing_without_consent, 12).
need(need_data_portability, 10).
minimum_notice_days(need_change_only_with_prior_notice, 14).

% Agreement, ODRL policy, and human-readable clauses.
agreement(agreement1, "Example Agreement", policy1).
permission(policy1, perm_delete_account, remove_account, user_account, clause_c1).
permission(policy1, perm_change_terms, change_terms, agreement_text, clause_c2).
permission(policy1, perm_share_data, share_data, user_data, clause_c3).
prohibition(policy1, prohibit_export_data, export_data, user_data, clause_c4).
duty(perm_change_terms, inform).
constraint(perm_change_terms, notice_days, gteq, 3).
clause(clause_c1, "C1", "Provider may remove the user account and associated data at its discretion.").
clause(clause_c2, "C2", "Provider may change terms by informing users at least 3 days in advance.").
clause(clause_c3, "C3", "Provider may share user data with partners for business purposes.").
clause(clause_c4, "C4", "Users are not permitted to export their data.").
process(process_context1, agreement1, "Service operation under Agreement1").

has_notice_constraint(Rule) :-
    constraint(Rule, notice_days, Operator, Days).
has_inform_duty(Rule) :-
    duty(Rule, inform).
has_explicit_consent(Rule) :-
    constraint(Rule, consent, eq, true).

% R1: deletion is permitted without either notice safeguard.
detected_risk(risk_delete_without_safeguards, source_delete_without_safeguards, legal_compliance_risk, unwanted_data_deletion, perm_delete_account, Clause, need_data_cannot_be_removed, Raw, "Account removal is permitted without a notice constraint or duty to inform.") :-
    agreement(agreement1, Title, policy1),
    has_need(consumer_example, need_data_cannot_be_removed),
    need(need_data_cannot_be_removed, Weight),
    permission(policy1, perm_delete_account, remove_account, user_account, Clause),
    \+ has_notice_constraint(perm_delete_account),
    \+ has_inform_duty(perm_delete_account),
    Raw is 90 + Weight.

% R2: the stated change-of-terms notice is shorter than the profile requires.
detected_risk(risk_notice_too_short, source_notice_too_short, policy_risk, customer_confidence_loss, perm_change_terms, Clause, need_change_only_with_prior_notice, Raw, "Terms may change with less notice than the consumer requires.") :-
    has_need(consumer_example, need_change_only_with_prior_notice),
    need(need_change_only_with_prior_notice, Weight),
    minimum_notice_days(need_change_only_with_prior_notice, Required),
    permission(policy1, perm_change_terms, change_terms, agreement_text, Clause),
    duty(perm_change_terms, inform),
    constraint(perm_change_terms, notice_days, gteq, Days),
    Days < Required,
    Raw is 70 + Weight.

% R3: sharing is permitted without an explicit-consent constraint.
detected_risk(risk_share_without_consent, source_share_without_consent, policy_risk, unwanted_disclosure_data, perm_share_data, Clause, need_no_sharing_without_consent, Raw, "User data sharing is permitted without an explicit consent constraint.") :-
    has_need(consumer_example, need_no_sharing_without_consent),
    need(need_no_sharing_without_consent, Weight),
    permission(policy1, perm_share_data, share_data, user_data, Clause),
    \+ has_explicit_consent(perm_share_data),
    Raw is 85 + Weight.

% R4: an export prohibition conflicts with the portability need.
detected_risk(risk_no_portability, source_no_portability, policy_risk, customer_confidence_loss, prohibit_export_data, Clause, need_data_portability, Raw, "Portability is restricted because exporting user data is prohibited.") :-
    has_need(consumer_example, need_data_portability),
    need(need_data_portability, Weight),
    prohibition(policy1, prohibit_export_data, export_data, user_data, Clause),
    Raw is 60 + Weight.

% Score normalization and DPV-RISK level/severity classification.
score(Risk, 100) :-
    detected_risk(Risk, Source, Source_type, Kind, Rule, Clause, Need, Raw, Why),
    Raw > 100.
score(Risk, Raw) :-
    detected_risk(Risk, Source, Source_type, Kind, Rule, Clause, Need, Raw, Why),
    Raw =< 100.
risk_level(Risk, high_risk, high_severity) :-
    score(Risk, Score),
    Score > 79.
risk_level(Risk, moderate_risk, moderate_severity) :-
    score(Risk, Score),
    Score >= 50,
    Score < 80.
risk_level(Risk, low_risk, low_severity) :-
    score(Risk, Score),
    Score < 50.

% DPV-style provenance, consequence, impact, and process associations.
risk_source(Risk, Source, Source_type, Rule) :-
    detected_risk(Risk, Source, Source_type, Kind, Rule, Clause, Need, Raw, Why).

process_risk(process_context1, Risk) :-
    detected_risk(Risk, Source, Source_type, Kind, Rule, Clause, Need, Raw, Why).

consequence(risk_delete_without_safeguards, data_loss) :-
    detected_risk(risk_delete_without_safeguards, S, St, K, R, C, N, Raw, W).
consequence(risk_delete_without_safeguards, data_unavailable) :-
    detected_risk(risk_delete_without_safeguards, S, St, K, R, C, N, Raw, W).
consequence(risk_delete_without_safeguards, customer_confidence_loss) :-
    detected_risk(risk_delete_without_safeguards, S, St, K, R, C, N, Raw, W).
consequence(risk_notice_too_short, customer_confidence_loss) :-
    detected_risk(risk_notice_too_short, S, St, K, R, C, N, Raw, W).
consequence(risk_share_without_consent, customer_confidence_loss) :-
    detected_risk(risk_share_without_consent, S, St, K, R, C, N, Raw, W).
consequence(risk_no_portability, customer_confidence_loss) :-
    detected_risk(risk_no_portability, S, St, K, R, C, N, Raw, W).
impact(risk_delete_without_safeguards, financial_loss) :-
    detected_risk(risk_delete_without_safeguards, S, St, K, R, C, N, Raw, W).
impact(risk_delete_without_safeguards, non_material_damage) :-
    detected_risk(risk_delete_without_safeguards, S, St, K, R, C, N, Raw, W).
impact(risk_notice_too_short, non_material_damage) :-
    detected_risk(risk_notice_too_short, S, St, K, R, C, N, Raw, W).
impact(risk_share_without_consent, financial_loss) :-
    detected_risk(risk_share_without_consent, S, St, K, R, C, N, Raw, W).
impact(risk_share_without_consent, non_material_damage) :-
    detected_risk(risk_share_without_consent, S, St, K, R, C, N, Raw, W).
impact(risk_no_portability, non_material_damage) :-
    detected_risk(risk_no_portability, S, St, K, R, C, N, Raw, W).

% Mitigation measures are emitted only for risks actually detected.
mitigation(risk_delete_without_safeguards, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal.") :-
    detected_risk(risk_delete_without_safeguards, S, St, K, R, C, N, Raw, W).

mitigation(risk_delete_without_safeguards, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.") :-
    detected_risk(risk_delete_without_safeguards, S, St, K, R, C, N, Raw, W).

mitigation(risk_notice_too_short, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.") :-
    detected_risk(risk_notice_too_short, S, St, K, R, C, N, Raw, W).

mitigation(risk_share_without_consent, mitigate_share_consent, "Add an explicit consent constraint before data sharing.") :-
    detected_risk(risk_share_without_consent, S, St, K, R, C, N, Raw, W).

mitigation(risk_no_portability, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.") :-
    detected_risk(risk_no_portability, S, St, K, R, C, N, Raw, W).

% Human-readable explanations are derived from the same policy facts.
risk_explanation(risk_delete_without_safeguards, Text) :-
    detected_risk(risk_delete_without_safeguards, S, St, K, R, Clause, N, Raw, W),
    clause(Clause, Clause_id, Clause_text),
    atomics_to_string(["Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause ", Clause_id, ": ", Clause_text], Text).

risk_explanation(risk_notice_too_short, Text) :-
    detected_risk(risk_notice_too_short, S, St, K, R, Clause, N, Raw, W),
    constraint(perm_change_terms, notice_days, gteq, Days),
    minimum_notice_days(need_change_only_with_prior_notice, Required),
    clause(Clause, Clause_id, Clause_text),
    atomics_to_string(["Risk: terms may change with notice (", Days, " days) below consumer requirement (", Required, " days). Clause ", Clause_id, ": ", Clause_text], Text).

risk_explanation(risk_share_without_consent, Text) :-
    detected_risk(risk_share_without_consent, S, St, K, R, Clause, N, Raw, W),
    clause(Clause, Clause_id, Clause_text),
    atomics_to_string(["Risk: user data sharing is permitted without an explicit consent constraint. Clause ", Clause_id, ": ", Clause_text], Text).

risk_explanation(risk_no_portability, Text) :-
    detected_risk(risk_no_portability, S, St, K, R, Clause, N, Raw, W),
    clause(Clause, Clause_id, Clause_text),
    atomics_to_string(["Risk: portability is restricted because exporting user data is prohibited. Clause ", Clause_id, ": ", Clause_text], Text).

risk_labels(high_risk, high_severity, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity")).

risk_labels(moderate_risk, moderate_severity, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity")).

risk_labels(low_risk, low_severity, iri("https://w3id.org/dpv/risk#LowRisk"), iri("https://w3id.org/dpv/risk#LowSeverity")).

mitigation_order(mitigate_delete_notice, 1).
mitigation_order(mitigate_delete_inform, 2).
mitigation_order(mitigate_share_consent, 1).
mitigation_order(mitigate_notice_too_short, 1).
mitigation_order(mitigate_portability, 1).

% Rank is one plus the number of distinct risks with a strictly higher score.
rank_position(Risk, Rank) :-
    score(Risk, Score),
    findall(Other, (score(Other, Other_score), Other_score > Score), Bag1),
    sort(Bag1, Higher),
    length(Higher, Higher_count),
    Rank is Higher_count + 1.

% The report remains structured Prolog data. Mitigations are nested with each
% risk, and sorting by the derived rank produces highest-risk-first order.
ranked_report(Agreement_title, Profile_title, Ranked) :-
    agreement(agreement1, Agreement_title, policy1),
    profile(consumer_example, Profile_title),
    findall(ranked(Rank, clause(Clause_id, Clause_text), risk(Risk, Score, Level_iri, Severity_iri, Explanation), mitigations(Mitigations)), (detected_risk(Risk, Source, Source_type, Kind, Rule, Clause, Need, Raw, Why), score(Risk, Score), rank_position(Risk, Rank), risk_level(Risk, Level, Severity), risk_labels(Level, Severity, Level_iri, Severity_iri), risk_explanation(Risk, Explanation), clause(Clause, Clause_id, Clause_text), findall(mitigation(Order, Measure, Description), (mitigation(Risk, Measure, Description), mitigation_order(Measure, Order)), Bag1), sort(Bag1, Mitigations)), Bag2),
    sort(Bag2, Rows),
    sort(Rows, Ranked).

?- ranked_report(Agreement, Profile, Risks).
