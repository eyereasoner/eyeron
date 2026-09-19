# ODRL policy risks evaluated against a DPV-style consumer profile.
# RDF resources and classes are represented as symbols; graph joins, missing
# safeguards, score normalization, classification, mitigation, and ranking are
# performed by ordinary Eyelang rules.

# Consumer profile and weighted needs.
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

# Agreement, ODRL policy, and human-readable clauses.
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

has_notice_constraint(?rule) if constraint(?rule, notice_days, ?operator, ?days).
has_inform_duty(?rule) if duty(?rule, inform).
has_explicit_consent(?rule) if constraint(?rule, consent, eq, true).

# R1: deletion is permitted without either notice safeguard.
detected_risk(risk_delete_without_safeguards, source_delete_without_safeguards,
              legal_compliance_risk, unwanted_data_deletion, perm_delete_account,
              ?clause, need_data_cannot_be_removed, ?raw,
              "Account removal is permitted without a notice constraint or duty to inform.") if
    agreement(agreement1, ?title, policy1),
    has_need(consumer_example, need_data_cannot_be_removed),
    need(need_data_cannot_be_removed, ?weight),
    permission(policy1, perm_delete_account, remove_account, user_account, ?clause),
    not has_notice_constraint(perm_delete_account),
    not has_inform_duty(perm_delete_account),
    let ?raw = 90 + ?weight.

# R2: the stated change-of-terms notice is shorter than the profile requires.
detected_risk(risk_notice_too_short, source_notice_too_short,
              policy_risk, customer_confidence_loss, perm_change_terms,
              ?clause, need_change_only_with_prior_notice, ?raw,
              "Terms may change with less notice than the consumer requires.") if
    has_need(consumer_example, need_change_only_with_prior_notice),
    need(need_change_only_with_prior_notice, ?weight),
    minimum_notice_days(need_change_only_with_prior_notice, ?required),
    permission(policy1, perm_change_terms, change_terms, agreement_text, ?clause),
    duty(perm_change_terms, inform),
    constraint(perm_change_terms, notice_days, gteq, ?days),
    ?days < ?required,
    let ?raw = 70 + ?weight.

# R3: sharing is permitted without an explicit-consent constraint.
detected_risk(risk_share_without_consent, source_share_without_consent,
              policy_risk, unwanted_disclosure_data, perm_share_data,
              ?clause, need_no_sharing_without_consent, ?raw,
              "User data sharing is permitted without an explicit consent constraint.") if
    has_need(consumer_example, need_no_sharing_without_consent),
    need(need_no_sharing_without_consent, ?weight),
    permission(policy1, perm_share_data, share_data, user_data, ?clause),
    not has_explicit_consent(perm_share_data),
    let ?raw = 85 + ?weight.

# R4: an export prohibition conflicts with the portability need.
detected_risk(risk_no_portability, source_no_portability,
              policy_risk, customer_confidence_loss, prohibit_export_data,
              ?clause, need_data_portability, ?raw,
              "Portability is restricted because exporting user data is prohibited.") if
    has_need(consumer_example, need_data_portability),
    need(need_data_portability, ?weight),
    prohibition(policy1, prohibit_export_data, export_data, user_data, ?clause),
    let ?raw = 60 + ?weight.

# Score normalization and DPV-RISK level/severity classification.
score(?risk, 100) if detected_risk(?risk, ?source, ?source_type, ?kind, ?rule, ?clause, ?need, ?raw, ?why), ?raw > 100.
score(?risk, ?raw) if detected_risk(?risk, ?source, ?source_type, ?kind, ?rule, ?clause, ?need, ?raw, ?why), ?raw <= 100.
risk_level(?risk, high_risk, high_severity) if score(?risk, ?score), ?score > 79.
risk_level(?risk, moderate_risk, moderate_severity) if score(?risk, ?score), ?score >= 50, ?score < 80.
risk_level(?risk, low_risk, low_severity) if score(?risk, ?score), ?score < 50.

# DPV-style provenance, consequence, impact, and process associations.
risk_source(?risk, ?source, ?source_type, ?rule) if
    detected_risk(?risk, ?source, ?source_type, ?kind, ?rule, ?clause, ?need, ?raw, ?why).
process_risk(process_context1, ?risk) if
    detected_risk(?risk, ?source, ?source_type, ?kind, ?rule, ?clause, ?need, ?raw, ?why).
consequence(risk_delete_without_safeguards, data_loss) if detected_risk(risk_delete_without_safeguards, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
consequence(risk_delete_without_safeguards, data_unavailable) if detected_risk(risk_delete_without_safeguards, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
consequence(risk_delete_without_safeguards, customer_confidence_loss) if detected_risk(risk_delete_without_safeguards, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
consequence(risk_notice_too_short, customer_confidence_loss) if detected_risk(risk_notice_too_short, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
consequence(risk_share_without_consent, customer_confidence_loss) if detected_risk(risk_share_without_consent, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
consequence(risk_no_portability, customer_confidence_loss) if detected_risk(risk_no_portability, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
impact(risk_delete_without_safeguards, financial_loss) if detected_risk(risk_delete_without_safeguards, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
impact(risk_delete_without_safeguards, non_material_damage) if detected_risk(risk_delete_without_safeguards, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
impact(risk_notice_too_short, non_material_damage) if detected_risk(risk_notice_too_short, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
impact(risk_share_without_consent, financial_loss) if detected_risk(risk_share_without_consent, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
impact(risk_share_without_consent, non_material_damage) if detected_risk(risk_share_without_consent, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
impact(risk_no_portability, non_material_damage) if detected_risk(risk_no_portability, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).

# Mitigation measures are emitted only for risks actually detected.
mitigation(risk_delete_without_safeguards, mitigate_delete_notice,
           "Add a notice constraint (minimum noticeDays) before account removal.") if
    detected_risk(risk_delete_without_safeguards, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
mitigation(risk_delete_without_safeguards, mitigate_delete_inform,
           "Add a duty to inform the consumer prior to account removal.") if
    detected_risk(risk_delete_without_safeguards, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
mitigation(risk_notice_too_short, mitigate_notice_too_short,
           "Increase minimum noticeDays in the inform duty to meet the consumer requirement.") if
    detected_risk(risk_notice_too_short, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
mitigation(risk_share_without_consent, mitigate_share_consent,
           "Add an explicit consent constraint before data sharing.") if
    detected_risk(risk_share_without_consent, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).
mitigation(risk_no_portability, mitigate_portability,
           "Add a permission allowing data export (or remove the prohibition) to support portability.") if
    detected_risk(risk_no_portability, ?s, ?st, ?k, ?r, ?c, ?n, ?raw, ?w).

# Human-readable explanations are derived from the same policy facts.
risk_explanation(risk_delete_without_safeguards, ?text) if
    detected_risk(risk_delete_without_safeguards, ?s, ?st, ?k, ?r, ?clause, ?n, ?raw, ?w),
    clause(?clause, ?clause_id, ?clause_text),
    let ?text = concat("Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause ", ?clause_id, ": ", ?clause_text).
risk_explanation(risk_notice_too_short, ?text) if
    detected_risk(risk_notice_too_short, ?s, ?st, ?k, ?r, ?clause, ?n, ?raw, ?w),
    constraint(perm_change_terms, notice_days, gteq, ?days),
    minimum_notice_days(need_change_only_with_prior_notice, ?required),
    clause(?clause, ?clause_id, ?clause_text),
    let ?text = concat("Risk: terms may change with notice (", str(?days), " days) below consumer requirement (", str(?required), " days). Clause ", ?clause_id, ": ", ?clause_text).
risk_explanation(risk_share_without_consent, ?text) if
    detected_risk(risk_share_without_consent, ?s, ?st, ?k, ?r, ?clause, ?n, ?raw, ?w),
    clause(?clause, ?clause_id, ?clause_text),
    let ?text = concat("Risk: user data sharing is permitted without an explicit consent constraint. Clause ", ?clause_id, ": ", ?clause_text).
risk_explanation(risk_no_portability, ?text) if
    detected_risk(risk_no_portability, ?s, ?st, ?k, ?r, ?clause, ?n, ?raw, ?w),
    clause(?clause, ?clause_id, ?clause_text),
    let ?text = concat("Risk: portability is restricted because exporting user data is prohibited. Clause ", ?clause_id, ": ", ?clause_text).

risk_labels(high_risk, high_severity,
            iri("https://w3id.org/dpv/risk#HighRisk"),
            iri("https://w3id.org/dpv/risk#HighSeverity")).
risk_labels(moderate_risk, moderate_severity,
            iri("https://w3id.org/dpv/risk#ModerateRisk"),
            iri("https://w3id.org/dpv/risk#ModerateSeverity")).
risk_labels(low_risk, low_severity,
            iri("https://w3id.org/dpv/risk#LowRisk"),
            iri("https://w3id.org/dpv/risk#LowSeverity")).
mitigation_order(mitigate_delete_notice, 1).
mitigation_order(mitigate_delete_inform, 2).
mitigation_order(mitigate_share_consent, 1).
mitigation_order(mitigate_notice_too_short, 1).
mitigation_order(mitigate_portability, 1).

# Rank is one plus the number of distinct risks with a strictly higher score.
rank_position(?risk, ?rank) if
    score(?risk, ?score),
    collect ?higher = ?other where {
        score(?other, ?other_score),
        ?other_score > ?score
    },
    let ?higher_count = count(?higher),
    let ?rank = ?higher_count + 1.

# The report remains structured Eyelang data. Mitigations are nested with each
# risk, and sorting by the derived rank produces highest-risk-first order.
ranked_report(?agreement_title, ?profile_title, ?ranked) if
    agreement(agreement1, ?agreement_title, policy1),
    profile(consumer_example, ?profile_title),
    collect ?rows = ranked(
        ?rank,
        clause(?clause_id, ?clause_text),
        risk(?risk, ?score, ?level_iri, ?severity_iri, ?explanation),
        mitigations(?mitigations)
    ) where {
        detected_risk(?risk, ?source, ?source_type, ?kind, ?rule, ?clause, ?need, ?raw, ?why),
        score(?risk, ?score),
        rank_position(?risk, ?rank),
        risk_level(?risk, ?level, ?severity),
        risk_labels(?level, ?severity, ?level_iri, ?severity_iri),
        risk_explanation(?risk, ?explanation),
        clause(?clause, ?clause_id, ?clause_text),
        collect ?mitigations = mitigation(?order, ?measure, ?description) where {
            mitigation(?risk, ?measure, ?description),
            mitigation_order(?measure, ?order)
        }
    },
    sort(?rows, ?ranked).

ask ranked_report(?agreement, ?profile, ?risks).
