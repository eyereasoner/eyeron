ranked_report("Example Agreement",
              "Example consumer profile",
              [ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])),
               ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])),
               ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])),
               ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))]).

clause(1, profile(consumer_example, "Example consumer profile"), true).
clause(2, has_need(consumer_example, need_data_cannot_be_removed), true).
clause(3, has_need(consumer_example, need_change_only_with_prior_notice), true).
clause(4, has_need(consumer_example, need_no_sharing_without_consent), true).
clause(5, has_need(consumer_example, need_data_portability), true).
clause(6, need(need_data_cannot_be_removed, 20), true).
clause(7, need(need_change_only_with_prior_notice, 15), true).
clause(8, need(need_no_sharing_without_consent, 12), true).
clause(9, need(need_data_portability, 10), true).
clause(10, minimum_notice_days(need_change_only_with_prior_notice, 14), true).
clause(11, agreement(agreement1, "Example Agreement", policy1), true).
clause(12,
       permission(policy1, perm_delete_account, remove_account, user_account, clause_c1),
       true).
clause(13,
       permission(policy1, perm_change_terms, change_terms, agreement_text, clause_c2),
       true).
clause(14, permission(policy1, perm_share_data, share_data, user_data, clause_c3), true).
clause(15, prohibition(policy1, prohibit_export_data, export_data, user_data, clause_c4), true).
clause(16, duty(perm_change_terms, inform), true).
clause(17, constraint(perm_change_terms, notice_days, gteq, 3), true).
clause(18,
       clause(clause_c1, "C1", "Provider may remove the user account and associated data at its discretion."),
       true).
clause(19,
       clause(clause_c2, "C2", "Provider may change terms by informing users at least 3 days in advance."),
       true).
clause(20,
       clause(clause_c3, "C3", "Provider may share user data with partners for business purposes."),
       true).
clause(21, clause(clause_c4, "C4", "Users are not permitted to export their data."), true).
clause(26,
       detected_risk(risk_delete_without_safeguards, source_delete_without_safeguards, legal_compliance_risk, unwanted_data_deletion, perm_delete_account, var('Clause'), need_data_cannot_be_removed, var('Raw'), "Account removal is permitted without a notice constraint or duty to inform."),
       (agreement(agreement1, var('Title'), policy1),
        has_need(consumer_example, need_data_cannot_be_removed),
        need(need_data_cannot_be_removed, var('Weight')),
        permission(policy1, perm_delete_account, remove_account, user_account, var('Clause')),
        \+has_notice_constraint(perm_delete_account),
        \+has_inform_duty(perm_delete_account),
        var('Raw') is 90 + var('Weight'))).
clause(27,
       detected_risk(risk_notice_too_short, source_notice_too_short, policy_risk, customer_confidence_loss, perm_change_terms, var('Clause'), need_change_only_with_prior_notice, var('Raw'), "Terms may change with less notice than the consumer requires."),
       (has_need(consumer_example, need_change_only_with_prior_notice),
        need(need_change_only_with_prior_notice, var('Weight')),
        minimum_notice_days(need_change_only_with_prior_notice, var('Required')),
        permission(policy1, perm_change_terms, change_terms, agreement_text, var('Clause')),
        duty(perm_change_terms, inform),
        constraint(perm_change_terms, notice_days, gteq, var('Days')),
        var('Days') < var('Required'),
        var('Raw') is 70 + var('Weight'))).
clause(28,
       detected_risk(risk_share_without_consent, source_share_without_consent, policy_risk, unwanted_disclosure_data, perm_share_data, var('Clause'), need_no_sharing_without_consent, var('Raw'), "User data sharing is permitted without an explicit consent constraint."),
       (has_need(consumer_example, need_no_sharing_without_consent),
        need(need_no_sharing_without_consent, var('Weight')),
        permission(policy1, perm_share_data, share_data, user_data, var('Clause')),
        \+has_explicit_consent(perm_share_data),
        var('Raw') is 85 + var('Weight'))).
clause(29,
       detected_risk(risk_no_portability, source_no_portability, policy_risk, customer_confidence_loss, prohibit_export_data, var('Clause'), need_data_portability, var('Raw'), "Portability is restricted because exporting user data is prohibited."),
       (has_need(consumer_example, need_data_portability),
        need(need_data_portability, var('Weight')),
        prohibition(policy1, prohibit_export_data, export_data, user_data, var('Clause')),
        var('Raw') is 60 + var('Weight'))).
clause(30,
       score(var('Risk'), 100),
       (detected_risk(var('Risk'), var('Source'), var('Source_type'), var('Kind'), var('Rule'), var('Clause'), var('Need'), var('Raw'), var('Why')),
        var('Raw') > 100)).
clause(31,
       score(var('Risk'), var('Raw')),
       (detected_risk(var('Risk'), var('Source'), var('Source_type'), var('Kind'), var('Rule'), var('Clause'), var('Need'), var('Raw'), var('Why')),
        var('Raw') =< 100)).
clause(32,
       risk_level(var('Risk'), high_risk, high_severity),
       (score(var('Risk'), var('Score')), var('Score') > 79)).
clause(33,
       risk_level(var('Risk'), moderate_risk, moderate_severity),
       (score(var('Risk'), var('Score')), var('Score') >= 50, var('Score') < 80)).
clause(49,
       mitigation(risk_delete_without_safeguards, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."),
       detected_risk(risk_delete_without_safeguards, var('S'), var('St'), var('K'), var('R'), var('C'), var('N'), var('Raw'), var('W'))).
clause(50,
       mitigation(risk_delete_without_safeguards, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal."),
       detected_risk(risk_delete_without_safeguards, var('S'), var('St'), var('K'), var('R'), var('C'), var('N'), var('Raw'), var('W'))).
clause(51,
       mitigation(risk_notice_too_short, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement."),
       detected_risk(risk_notice_too_short, var('S'), var('St'), var('K'), var('R'), var('C'), var('N'), var('Raw'), var('W'))).
clause(52,
       mitigation(risk_share_without_consent, mitigate_share_consent, "Add an explicit consent constraint before data sharing."),
       detected_risk(risk_share_without_consent, var('S'), var('St'), var('K'), var('R'), var('C'), var('N'), var('Raw'), var('W'))).
clause(53,
       mitigation(risk_no_portability, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability."),
       detected_risk(risk_no_portability, var('S'), var('St'), var('K'), var('R'), var('C'), var('N'), var('Raw'), var('W'))).
clause(54,
       risk_explanation(risk_delete_without_safeguards, var('Text')),
       (detected_risk(risk_delete_without_safeguards, var('S'), var('St'), var('K'), var('R'), var('Clause'), var('N'), var('Raw'), var('W')),
        clause(var('Clause'), var('Clause_id'), var('Clause_text')),
        atomics_to_string(["Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause ", var('Clause_id'), ": ", var('Clause_text')], var('Text')))).
clause(55,
       risk_explanation(risk_notice_too_short, var('Text')),
       (detected_risk(risk_notice_too_short, var('S'), var('St'), var('K'), var('R'), var('Clause'), var('N'), var('Raw'), var('W')),
        constraint(perm_change_terms, notice_days, gteq, var('Days')),
        minimum_notice_days(need_change_only_with_prior_notice, var('Required')),
        clause(var('Clause'), var('Clause_id'), var('Clause_text')),
        atomics_to_string(["Risk: terms may change with notice (", var('Days'), " days) below consumer requirement (", var('Required'), " days). Clause ", var('Clause_id'), ": ", var('Clause_text')], var('Text')))).
clause(56,
       risk_explanation(risk_share_without_consent, var('Text')),
       (detected_risk(risk_share_without_consent, var('S'), var('St'), var('K'), var('R'), var('Clause'), var('N'), var('Raw'), var('W')),
        clause(var('Clause'), var('Clause_id'), var('Clause_text')),
        atomics_to_string(["Risk: user data sharing is permitted without an explicit consent constraint. Clause ", var('Clause_id'), ": ", var('Clause_text')], var('Text')))).
clause(57,
       risk_explanation(risk_no_portability, var('Text')),
       (detected_risk(risk_no_portability, var('S'), var('St'), var('K'), var('R'), var('Clause'), var('N'), var('Raw'), var('W')),
        clause(var('Clause'), var('Clause_id'), var('Clause_text')),
        atomics_to_string(["Risk: portability is restricted because exporting user data is prohibited. Clause ", var('Clause_id'), ": ", var('Clause_text')], var('Text')))).
clause(58,
       risk_labels(high_risk, high_severity, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity")),
       true).
clause(59,
       risk_labels(moderate_risk, moderate_severity, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity")),
       true).
clause(61, mitigation_order(mitigate_delete_notice, 1), true).
clause(62, mitigation_order(mitigate_delete_inform, 2), true).
clause(63, mitigation_order(mitigate_share_consent, 1), true).
clause(64, mitigation_order(mitigate_notice_too_short, 1), true).
clause(65, mitigation_order(mitigate_portability, 1), true).
clause(66,
       rank_position(var('Risk'), var('Rank')),
       (score(var('Risk'), var('Score')),
        findall(var('Other'), (score(var('Other'), var('Other_score')), var('Other_score') > var('Score')), var('Bag1')),
        sort(var('Bag1'), var('Higher')),
        length(var('Higher'), var('Higher_count')),
        var('Rank') is var('Higher_count') + 1)).
clause(67,
       ranked_report(var('Agreement_title'), var('Profile_title'), var('Ranked')),
       (agreement(agreement1, var('Agreement_title'), policy1),
        profile(consumer_example, var('Profile_title')),
        findall(ranked(var('Rank'), clause(var('Clause_id'), var('Clause_text')), risk(var('Risk'), var('Score'), var('Level_iri'), var('Severity_iri'), var('Explanation')), mitigations(var('Mitigations'))), (detected_risk(var('Risk'), var('Source'), var('Source_type'), var('Kind'), var('Rule'), var('Clause'), var('Need'), var('Raw'), var('Why')), score(var('Risk'), var('Score')), rank_position(var('Risk'), var('Rank')), risk_level(var('Risk'), var('Level'), var('Severity')), risk_labels(var('Level'), var('Severity'), var('Level_iri'), var('Severity_iri')), risk_explanation(var('Risk'), var('Explanation')), clause(var('Clause'), var('Clause_id'), var('Clause_text')), findall(mitigation(var('Order'), var('Measure'), var('Description')), (mitigation(var('Risk'), var('Measure'), var('Description')), mitigation_order(var('Measure'), var('Order'))), var('Bag1')), sort(var('Bag1'), var('Mitigations'))), var('Bag2')),
        sort(var('Bag2'), var('Rows')),
        sort(var('Rows'), var('Ranked')))).

step(ranked_report("Example Agreement", "Example consumer profile", [ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))]),
     rule(67),
     ['Agreement_title' = "Example Agreement",
      'Profile_title' = "Example consumer profile",
      'Ranked' = [ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))],
      'Rank' = _0,
      'Clause_id' = _1,
      'Clause_text' = _2,
      'Risk' = _3,
      'Score' = _4,
      'Level_iri' = _5,
      'Severity_iri' = _6,
      'Explanation' = _7,
      'Mitigations' = _8,
      'Source' = _9,
      'Source_type' = _10,
      'Kind' = _11,
      'Rule' = _12,
      'Clause' = _13,
      'Need' = _14,
      'Raw' = _15,
      'Why' = _16,
      'Level' = _17,
      'Severity' = _18,
      'Order' = _19,
      'Measure' = _20,
      'Description' = _21,
      'Bag1' = _22,
      'Bag2' = [ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")])), ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")]))],
      'Rows' = [ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))]],
     [agreement(agreement1, "Example Agreement", policy1),
      profile(consumer_example, "Example consumer profile"),
      findall(ranked(_23, clause(_24, _25), risk(_26, _27, _28, _29, _30), mitigations(_31)), (detected_risk(_26, _32, _33, _34, _35, _36, _37, _38, _39), score(_26, _27), rank_position(_26, _23), risk_level(_26, _40, _41), risk_labels(_40, _41, _28, _29), risk_explanation(_26, _30), clause(_36, _24, _25), findall(mitigation(_42, _43, _44), (mitigation(_26, _43, _44), mitigation_order(_43, _42)), _45), sort(_45, _31)), [ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")])), ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")]))]),
      sort([ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")])), ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")]))], [ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))]),
      sort([ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))], [ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))])]).
step(agreement(agreement1, "Example Agreement", policy1), fact(11), [], []).
step(profile(consumer_example, "Example consumer profile"), fact(1), [], []).
step(findall(ranked(_0, clause(_1, _2), risk(_3, _4, _5, _6, _7), mitigations(_8)), (detected_risk(_3, _9, _10, _11, _12, _13, _14, _15, _16), score(_3, _4), rank_position(_3, _0), risk_level(_3, _17, _18), risk_labels(_17, _18, _5, _6), risk_explanation(_3, _7), clause(_13, _1, _2), findall(mitigation(_19, _20, _21), (mitigation(_3, _20, _21), mitigation_order(_20, _19)), _22), sort(_22, _8)), [ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")])), ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")]))]),
     collected,
     [],
     [detected_risk(risk_share_without_consent, source_share_without_consent, policy_risk, unwanted_disclosure_data, perm_share_data, clause_c3, need_no_sharing_without_consent, 97, "User data sharing is permitted without an explicit consent constraint."),
      score(risk_share_without_consent, 97),
      rank_position(risk_share_without_consent, 2),
      risk_level(risk_share_without_consent, high_risk, high_severity),
      risk_labels(high_risk, high_severity, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity")),
      risk_explanation(risk_share_without_consent, "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."),
      clause(clause_c3, "C3", "Provider may share user data with partners for business purposes."),
      findall(mitigation(_23, _24, _25), (mitigation(risk_share_without_consent, _24, _25), mitigation_order(_24, _23)), [mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")]),
      sort([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")], [mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")]),
      detected_risk(risk_no_portability, source_no_portability, policy_risk, customer_confidence_loss, prohibit_export_data, clause_c4, need_data_portability, 70, "Portability is restricted because exporting user data is prohibited."),
      score(risk_no_portability, 70),
      rank_position(risk_no_portability, 4),
      risk_level(risk_no_portability, moderate_risk, moderate_severity),
      risk_labels(moderate_risk, moderate_severity, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity")),
      risk_explanation(risk_no_portability, "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."),
      clause(clause_c4, "C4", "Users are not permitted to export their data."),
      findall(mitigation(_26, _27, _28), (mitigation(risk_no_portability, _27, _28), mitigation_order(_27, _26)), [mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]),
      sort([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")], [mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]),
      detected_risk(risk_delete_without_safeguards, source_delete_without_safeguards, legal_compliance_risk, unwanted_data_deletion, perm_delete_account, clause_c1, need_data_cannot_be_removed, 110, "Account removal is permitted without a notice constraint or duty to inform."),
      score(risk_delete_without_safeguards, 100),
      rank_position(risk_delete_without_safeguards, 1),
      risk_level(risk_delete_without_safeguards, high_risk, high_severity),
      risk_labels(high_risk, high_severity, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity")),
      risk_explanation(risk_delete_without_safeguards, "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."),
      clause(clause_c1, "C1", "Provider may remove the user account and associated data at its discretion."),
      findall(mitigation(_29, _30, _31), (mitigation(risk_delete_without_safeguards, _30, _31), mitigation_order(_30, _29)), [mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")]),
      sort([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")], [mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")]),
      detected_risk(risk_notice_too_short, source_notice_too_short, policy_risk, customer_confidence_loss, perm_change_terms, clause_c2, need_change_only_with_prior_notice, 85, "Terms may change with less notice than the consumer requires."),
      score(risk_notice_too_short, 85),
      rank_position(risk_notice_too_short, 3),
      risk_level(risk_notice_too_short, high_risk, high_severity),
      risk_labels(high_risk, high_severity, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity")),
      risk_explanation(risk_notice_too_short, "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."),
      clause(clause_c2, "C2", "Provider may change terms by informing users at least 3 days in advance."),
      findall(mitigation(_32, _33, _34), (mitigation(risk_notice_too_short, _33, _34), mitigation_order(_33, _32)), [mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")]),
      sort([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")], [mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])]).
step(detected_risk(risk_share_without_consent, source_share_without_consent, policy_risk, unwanted_disclosure_data, perm_share_data, clause_c3, need_no_sharing_without_consent, 97, "User data sharing is permitted without an explicit consent constraint."),
     rule(28),
     ['Clause' = clause_c3, 'Raw' = 97, 'Weight' = 12],
     [has_need(consumer_example, need_no_sharing_without_consent),
      need(need_no_sharing_without_consent, 12),
      permission(policy1, perm_share_data, share_data, user_data, clause_c3),
      \+has_explicit_consent(perm_share_data),
      97 is 85 + 12]).
step(has_need(consumer_example, need_no_sharing_without_consent), fact(4), [], []).
step(need(need_no_sharing_without_consent, 12), fact(8), [], []).
step(permission(policy1, perm_share_data, share_data, user_data, clause_c3), fact(14), [], []).
step(\+has_explicit_consent(perm_share_data), absent, [], []).
step(97 is 85 + 12, builtin, [], []).
step(score(risk_share_without_consent, 97),
     rule(31),
     ['Risk' = risk_share_without_consent,
      'Raw' = 97,
      'Source' = source_share_without_consent,
      'Source_type' = policy_risk,
      'Kind' = unwanted_disclosure_data,
      'Rule' = perm_share_data,
      'Clause' = clause_c3,
      'Need' = need_no_sharing_without_consent,
      'Why' = "User data sharing is permitted without an explicit consent constraint."],
     [detected_risk(risk_share_without_consent, source_share_without_consent, policy_risk, unwanted_disclosure_data, perm_share_data, clause_c3, need_no_sharing_without_consent, 97, "User data sharing is permitted without an explicit consent constraint."),
      97 =< 100]).
step(97 =< 100, builtin, [], []).
step(rank_position(risk_share_without_consent, 2),
     rule(66),
     ['Risk' = risk_share_without_consent,
      'Rank' = 2,
      'Score' = 97,
      'Other' = _0,
      'Other_score' = _1,
      'Bag1' = [risk_delete_without_safeguards],
      'Higher' = [risk_delete_without_safeguards],
      'Higher_count' = 1],
     [score(risk_share_without_consent, 97),
      findall(_2, (score(_2, _3), _3 > 97), [risk_delete_without_safeguards]),
      sort([risk_delete_without_safeguards], [risk_delete_without_safeguards]),
      length([risk_delete_without_safeguards], 1),
      2 is 1 + 1]).
step(findall(_0, (score(_0, _1), _1 > 97), [risk_delete_without_safeguards]),
     collected,
     [],
     [score(risk_delete_without_safeguards, 100), 100 > 97]).
step(score(risk_delete_without_safeguards, 100),
     rule(30),
     ['Risk' = risk_delete_without_safeguards,
      'Source' = source_delete_without_safeguards,
      'Source_type' = legal_compliance_risk,
      'Kind' = unwanted_data_deletion,
      'Rule' = perm_delete_account,
      'Clause' = clause_c1,
      'Need' = need_data_cannot_be_removed,
      'Raw' = 110,
      'Why' = "Account removal is permitted without a notice constraint or duty to inform."],
     [detected_risk(risk_delete_without_safeguards, source_delete_without_safeguards, legal_compliance_risk, unwanted_data_deletion, perm_delete_account, clause_c1, need_data_cannot_be_removed, 110, "Account removal is permitted without a notice constraint or duty to inform."),
      110 > 100]).
step(detected_risk(risk_delete_without_safeguards, source_delete_without_safeguards, legal_compliance_risk, unwanted_data_deletion, perm_delete_account, clause_c1, need_data_cannot_be_removed, 110, "Account removal is permitted without a notice constraint or duty to inform."),
     rule(26),
     ['Clause' = clause_c1, 'Raw' = 110, 'Title' = "Example Agreement", 'Weight' = 20],
     [agreement(agreement1, "Example Agreement", policy1),
      has_need(consumer_example, need_data_cannot_be_removed),
      need(need_data_cannot_be_removed, 20),
      permission(policy1, perm_delete_account, remove_account, user_account, clause_c1),
      \+has_notice_constraint(perm_delete_account),
      \+has_inform_duty(perm_delete_account),
      110 is 90 + 20]).
step(has_need(consumer_example, need_data_cannot_be_removed), fact(2), [], []).
step(need(need_data_cannot_be_removed, 20), fact(6), [], []).
step(permission(policy1, perm_delete_account, remove_account, user_account, clause_c1),
     fact(12),
     [],
     []).
step(\+has_notice_constraint(perm_delete_account), absent, [], []).
step(\+has_inform_duty(perm_delete_account), absent, [], []).
step(110 is 90 + 20, builtin, [], []).
step(110 > 100, builtin, [], []).
step(100 > 97, builtin, [], []).
step(sort([risk_delete_without_safeguards], [risk_delete_without_safeguards]), builtin, [], []).
step(length([risk_delete_without_safeguards], 1), builtin, [], []).
step(2 is 1 + 1, builtin, [], []).
step(risk_level(risk_share_without_consent, high_risk, high_severity),
     rule(32),
     ['Risk' = risk_share_without_consent, 'Score' = 97],
     [score(risk_share_without_consent, 97), 97 > 79]).
step(97 > 79, builtin, [], []).
step(risk_labels(high_risk, high_severity, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity")),
     fact(58),
     [],
     []).
step(risk_explanation(risk_share_without_consent, "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."),
     rule(56),
     ['Text' = "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes.",
      'S' = source_share_without_consent,
      'St' = policy_risk,
      'K' = unwanted_disclosure_data,
      'R' = perm_share_data,
      'Clause' = clause_c3,
      'N' = need_no_sharing_without_consent,
      'Raw' = 97,
      'W' = "User data sharing is permitted without an explicit consent constraint.",
      'Clause_id' = "C3",
      'Clause_text' = "Provider may share user data with partners for business purposes."],
     [detected_risk(risk_share_without_consent, source_share_without_consent, policy_risk, unwanted_disclosure_data, perm_share_data, clause_c3, need_no_sharing_without_consent, 97, "User data sharing is permitted without an explicit consent constraint."),
      clause(clause_c3, "C3", "Provider may share user data with partners for business purposes."),
      atomics_to_string(["Risk: user data sharing is permitted without an explicit consent constraint. Clause ", "C3", ": ", "Provider may share user data with partners for business purposes."], "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes.")]).
step(clause(clause_c3, "C3", "Provider may share user data with partners for business purposes."),
     fact(20),
     [],
     []).
step(atomics_to_string(["Risk: user data sharing is permitted without an explicit consent constraint. Clause ", "C3", ": ", "Provider may share user data with partners for business purposes."], "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."),
     builtin,
     [],
     []).
step(findall(mitigation(_0, _1, _2), (mitigation(risk_share_without_consent, _1, _2), mitigation_order(_1, _0)), [mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")]),
     collected,
     [],
     [mitigation(risk_share_without_consent, mitigate_share_consent, "Add an explicit consent constraint before data sharing."),
      mitigation_order(mitigate_share_consent, 1)]).
step(mitigation(risk_share_without_consent, mitigate_share_consent, "Add an explicit consent constraint before data sharing."),
     rule(52),
     ['S' = source_share_without_consent,
      'St' = policy_risk,
      'K' = unwanted_disclosure_data,
      'R' = perm_share_data,
      'C' = clause_c3,
      'N' = need_no_sharing_without_consent,
      'Raw' = 97,
      'W' = "User data sharing is permitted without an explicit consent constraint."],
     [detected_risk(risk_share_without_consent, source_share_without_consent, policy_risk, unwanted_disclosure_data, perm_share_data, clause_c3, need_no_sharing_without_consent, 97, "User data sharing is permitted without an explicit consent constraint.")]).
step(mitigation_order(mitigate_share_consent, 1), fact(63), [], []).
step(sort([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")], [mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")]),
     builtin,
     [],
     []).
step(detected_risk(risk_no_portability, source_no_portability, policy_risk, customer_confidence_loss, prohibit_export_data, clause_c4, need_data_portability, 70, "Portability is restricted because exporting user data is prohibited."),
     rule(29),
     ['Clause' = clause_c4, 'Raw' = 70, 'Weight' = 10],
     [has_need(consumer_example, need_data_portability),
      need(need_data_portability, 10),
      prohibition(policy1, prohibit_export_data, export_data, user_data, clause_c4),
      70 is 60 + 10]).
step(has_need(consumer_example, need_data_portability), fact(5), [], []).
step(need(need_data_portability, 10), fact(9), [], []).
step(prohibition(policy1, prohibit_export_data, export_data, user_data, clause_c4),
     fact(15),
     [],
     []).
step(70 is 60 + 10, builtin, [], []).
step(score(risk_no_portability, 70),
     rule(31),
     ['Risk' = risk_no_portability,
      'Raw' = 70,
      'Source' = source_no_portability,
      'Source_type' = policy_risk,
      'Kind' = customer_confidence_loss,
      'Rule' = prohibit_export_data,
      'Clause' = clause_c4,
      'Need' = need_data_portability,
      'Why' = "Portability is restricted because exporting user data is prohibited."],
     [detected_risk(risk_no_portability, source_no_portability, policy_risk, customer_confidence_loss, prohibit_export_data, clause_c4, need_data_portability, 70, "Portability is restricted because exporting user data is prohibited."),
      70 =< 100]).
step(70 =< 100, builtin, [], []).
step(rank_position(risk_no_portability, 4),
     rule(66),
     ['Risk' = risk_no_portability,
      'Rank' = 4,
      'Score' = 70,
      'Other' = _0,
      'Other_score' = _1,
      'Bag1' = [risk_share_without_consent, risk_delete_without_safeguards, risk_notice_too_short],
      'Higher' = [risk_delete_without_safeguards, risk_notice_too_short, risk_share_without_consent],
      'Higher_count' = 3],
     [score(risk_no_portability, 70),
      findall(_2, (score(_2, _3), _3 > 70), [risk_share_without_consent, risk_delete_without_safeguards, risk_notice_too_short]),
      sort([risk_share_without_consent, risk_delete_without_safeguards, risk_notice_too_short], [risk_delete_without_safeguards, risk_notice_too_short, risk_share_without_consent]),
      length([risk_delete_without_safeguards, risk_notice_too_short, risk_share_without_consent], 3),
      4 is 3 + 1]).
step(findall(_0, (score(_0, _1), _1 > 70), [risk_share_without_consent, risk_delete_without_safeguards, risk_notice_too_short]),
     collected,
     [],
     [score(risk_share_without_consent, 97),
      97 > 70,
      score(risk_delete_without_safeguards, 100),
      100 > 70,
      score(risk_notice_too_short, 85),
      85 > 70]).
step(97 > 70, builtin, [], []).
step(100 > 70, builtin, [], []).
step(score(risk_notice_too_short, 85),
     rule(31),
     ['Risk' = risk_notice_too_short,
      'Raw' = 85,
      'Source' = source_notice_too_short,
      'Source_type' = policy_risk,
      'Kind' = customer_confidence_loss,
      'Rule' = perm_change_terms,
      'Clause' = clause_c2,
      'Need' = need_change_only_with_prior_notice,
      'Why' = "Terms may change with less notice than the consumer requires."],
     [detected_risk(risk_notice_too_short, source_notice_too_short, policy_risk, customer_confidence_loss, perm_change_terms, clause_c2, need_change_only_with_prior_notice, 85, "Terms may change with less notice than the consumer requires."),
      85 =< 100]).
step(detected_risk(risk_notice_too_short, source_notice_too_short, policy_risk, customer_confidence_loss, perm_change_terms, clause_c2, need_change_only_with_prior_notice, 85, "Terms may change with less notice than the consumer requires."),
     rule(27),
     ['Clause' = clause_c2, 'Raw' = 85, 'Weight' = 15, 'Required' = 14, 'Days' = 3],
     [has_need(consumer_example, need_change_only_with_prior_notice),
      need(need_change_only_with_prior_notice, 15),
      minimum_notice_days(need_change_only_with_prior_notice, 14),
      permission(policy1, perm_change_terms, change_terms, agreement_text, clause_c2),
      duty(perm_change_terms, inform),
      constraint(perm_change_terms, notice_days, gteq, 3),
      3 < 14,
      85 is 70 + 15]).
step(has_need(consumer_example, need_change_only_with_prior_notice), fact(3), [], []).
step(need(need_change_only_with_prior_notice, 15), fact(7), [], []).
step(minimum_notice_days(need_change_only_with_prior_notice, 14), fact(10), [], []).
step(permission(policy1, perm_change_terms, change_terms, agreement_text, clause_c2),
     fact(13),
     [],
     []).
step(duty(perm_change_terms, inform), fact(16), [], []).
step(constraint(perm_change_terms, notice_days, gteq, 3), fact(17), [], []).
step(3 < 14, builtin, [], []).
step(85 is 70 + 15, builtin, [], []).
step(85 =< 100, builtin, [], []).
step(85 > 70, builtin, [], []).
step(sort([risk_share_without_consent, risk_delete_without_safeguards, risk_notice_too_short], [risk_delete_without_safeguards, risk_notice_too_short, risk_share_without_consent]),
     builtin,
     [],
     []).
step(length([risk_delete_without_safeguards, risk_notice_too_short, risk_share_without_consent], 3),
     builtin,
     [],
     []).
step(4 is 3 + 1, builtin, [], []).
step(risk_level(risk_no_portability, moderate_risk, moderate_severity),
     rule(33),
     ['Risk' = risk_no_portability, 'Score' = 70],
     [score(risk_no_portability, 70), 70 >= 50, 70 < 80]).
step(70 >= 50, builtin, [], []).
step(70 < 80, builtin, [], []).
step(risk_labels(moderate_risk, moderate_severity, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity")),
     fact(59),
     [],
     []).
step(risk_explanation(risk_no_portability, "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."),
     rule(57),
     ['Text' = "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data.",
      'S' = source_no_portability,
      'St' = policy_risk,
      'K' = customer_confidence_loss,
      'R' = prohibit_export_data,
      'Clause' = clause_c4,
      'N' = need_data_portability,
      'Raw' = 70,
      'W' = "Portability is restricted because exporting user data is prohibited.",
      'Clause_id' = "C4",
      'Clause_text' = "Users are not permitted to export their data."],
     [detected_risk(risk_no_portability, source_no_portability, policy_risk, customer_confidence_loss, prohibit_export_data, clause_c4, need_data_portability, 70, "Portability is restricted because exporting user data is prohibited."),
      clause(clause_c4, "C4", "Users are not permitted to export their data."),
      atomics_to_string(["Risk: portability is restricted because exporting user data is prohibited. Clause ", "C4", ": ", "Users are not permitted to export their data."], "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data.")]).
step(clause(clause_c4, "C4", "Users are not permitted to export their data."), fact(21), [], []).
step(atomics_to_string(["Risk: portability is restricted because exporting user data is prohibited. Clause ", "C4", ": ", "Users are not permitted to export their data."], "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."),
     builtin,
     [],
     []).
step(findall(mitigation(_0, _1, _2), (mitigation(risk_no_portability, _1, _2), mitigation_order(_1, _0)), [mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]),
     collected,
     [],
     [mitigation(risk_no_portability, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability."),
      mitigation_order(mitigate_portability, 1)]).
step(mitigation(risk_no_portability, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability."),
     rule(53),
     ['S' = source_no_portability,
      'St' = policy_risk,
      'K' = customer_confidence_loss,
      'R' = prohibit_export_data,
      'C' = clause_c4,
      'N' = need_data_portability,
      'Raw' = 70,
      'W' = "Portability is restricted because exporting user data is prohibited."],
     [detected_risk(risk_no_portability, source_no_portability, policy_risk, customer_confidence_loss, prohibit_export_data, clause_c4, need_data_portability, 70, "Portability is restricted because exporting user data is prohibited.")]).
step(mitigation_order(mitigate_portability, 1), fact(65), [], []).
step(sort([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")], [mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]),
     builtin,
     [],
     []).
step(rank_position(risk_delete_without_safeguards, 1),
     rule(66),
     ['Risk' = risk_delete_without_safeguards,
      'Rank' = 1,
      'Score' = 100,
      'Other' = _0,
      'Other_score' = _1,
      'Bag1' = [],
      'Higher' = [],
      'Higher_count' = 0],
     [score(risk_delete_without_safeguards, 100),
      findall(_2, (score(_2, _3), _3 > 100), []),
      sort([], []),
      length([], 0),
      1 is 0 + 1]).
step(findall(_0, (score(_0, _1), _1 > 100), []), collected, [], []).
step(sort([], []), builtin, [], []).
step(length([], 0), builtin, [], []).
step(1 is 0 + 1, builtin, [], []).
step(risk_level(risk_delete_without_safeguards, high_risk, high_severity),
     rule(32),
     ['Risk' = risk_delete_without_safeguards, 'Score' = 100],
     [score(risk_delete_without_safeguards, 100), 100 > 79]).
step(100 > 79, builtin, [], []).
step(risk_explanation(risk_delete_without_safeguards, "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."),
     rule(54),
     ['Text' = "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion.",
      'S' = source_delete_without_safeguards,
      'St' = legal_compliance_risk,
      'K' = unwanted_data_deletion,
      'R' = perm_delete_account,
      'Clause' = clause_c1,
      'N' = need_data_cannot_be_removed,
      'Raw' = 110,
      'W' = "Account removal is permitted without a notice constraint or duty to inform.",
      'Clause_id' = "C1",
      'Clause_text' = "Provider may remove the user account and associated data at its discretion."],
     [detected_risk(risk_delete_without_safeguards, source_delete_without_safeguards, legal_compliance_risk, unwanted_data_deletion, perm_delete_account, clause_c1, need_data_cannot_be_removed, 110, "Account removal is permitted without a notice constraint or duty to inform."),
      clause(clause_c1, "C1", "Provider may remove the user account and associated data at its discretion."),
      atomics_to_string(["Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause ", "C1", ": ", "Provider may remove the user account and associated data at its discretion."], "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion.")]).
step(clause(clause_c1, "C1", "Provider may remove the user account and associated data at its discretion."),
     fact(18),
     [],
     []).
step(atomics_to_string(["Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause ", "C1", ": ", "Provider may remove the user account and associated data at its discretion."], "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."),
     builtin,
     [],
     []).
step(findall(mitigation(_0, _1, _2), (mitigation(risk_delete_without_safeguards, _1, _2), mitigation_order(_1, _0)), [mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")]),
     collected,
     [],
     [mitigation(risk_delete_without_safeguards, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."),
      mitigation_order(mitigate_delete_notice, 1),
      mitigation(risk_delete_without_safeguards, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal."),
      mitigation_order(mitigate_delete_inform, 2)]).
step(mitigation(risk_delete_without_safeguards, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."),
     rule(49),
     ['S' = source_delete_without_safeguards,
      'St' = legal_compliance_risk,
      'K' = unwanted_data_deletion,
      'R' = perm_delete_account,
      'C' = clause_c1,
      'N' = need_data_cannot_be_removed,
      'Raw' = 110,
      'W' = "Account removal is permitted without a notice constraint or duty to inform."],
     [detected_risk(risk_delete_without_safeguards, source_delete_without_safeguards, legal_compliance_risk, unwanted_data_deletion, perm_delete_account, clause_c1, need_data_cannot_be_removed, 110, "Account removal is permitted without a notice constraint or duty to inform.")]).
step(mitigation_order(mitigate_delete_notice, 1), fact(61), [], []).
step(mitigation(risk_delete_without_safeguards, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal."),
     rule(50),
     ['S' = source_delete_without_safeguards,
      'St' = legal_compliance_risk,
      'K' = unwanted_data_deletion,
      'R' = perm_delete_account,
      'C' = clause_c1,
      'N' = need_data_cannot_be_removed,
      'Raw' = 110,
      'W' = "Account removal is permitted without a notice constraint or duty to inform."],
     [detected_risk(risk_delete_without_safeguards, source_delete_without_safeguards, legal_compliance_risk, unwanted_data_deletion, perm_delete_account, clause_c1, need_data_cannot_be_removed, 110, "Account removal is permitted without a notice constraint or duty to inform.")]).
step(mitigation_order(mitigate_delete_inform, 2), fact(62), [], []).
step(sort([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")], [mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")]),
     builtin,
     [],
     []).
step(rank_position(risk_notice_too_short, 3),
     rule(66),
     ['Risk' = risk_notice_too_short,
      'Rank' = 3,
      'Score' = 85,
      'Other' = _0,
      'Other_score' = _1,
      'Bag1' = [risk_share_without_consent, risk_delete_without_safeguards],
      'Higher' = [risk_delete_without_safeguards, risk_share_without_consent],
      'Higher_count' = 2],
     [score(risk_notice_too_short, 85),
      findall(_2, (score(_2, _3), _3 > 85), [risk_share_without_consent, risk_delete_without_safeguards]),
      sort([risk_share_without_consent, risk_delete_without_safeguards], [risk_delete_without_safeguards, risk_share_without_consent]),
      length([risk_delete_without_safeguards, risk_share_without_consent], 2),
      3 is 2 + 1]).
step(findall(_0, (score(_0, _1), _1 > 85), [risk_share_without_consent, risk_delete_without_safeguards]),
     collected,
     [],
     [score(risk_share_without_consent, 97),
      97 > 85,
      score(risk_delete_without_safeguards, 100),
      100 > 85]).
step(97 > 85, builtin, [], []).
step(100 > 85, builtin, [], []).
step(sort([risk_share_without_consent, risk_delete_without_safeguards], [risk_delete_without_safeguards, risk_share_without_consent]),
     builtin,
     [],
     []).
step(length([risk_delete_without_safeguards, risk_share_without_consent], 2), builtin, [], []).
step(3 is 2 + 1, builtin, [], []).
step(risk_level(risk_notice_too_short, high_risk, high_severity),
     rule(32),
     ['Risk' = risk_notice_too_short, 'Score' = 85],
     [score(risk_notice_too_short, 85), 85 > 79]).
step(85 > 79, builtin, [], []).
step(risk_explanation(risk_notice_too_short, "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."),
     rule(55),
     ['Text' = "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance.",
      'S' = source_notice_too_short,
      'St' = policy_risk,
      'K' = customer_confidence_loss,
      'R' = perm_change_terms,
      'Clause' = clause_c2,
      'N' = need_change_only_with_prior_notice,
      'Raw' = 85,
      'W' = "Terms may change with less notice than the consumer requires.",
      'Days' = 3,
      'Required' = 14,
      'Clause_id' = "C2",
      'Clause_text' = "Provider may change terms by informing users at least 3 days in advance."],
     [detected_risk(risk_notice_too_short, source_notice_too_short, policy_risk, customer_confidence_loss, perm_change_terms, clause_c2, need_change_only_with_prior_notice, 85, "Terms may change with less notice than the consumer requires."),
      constraint(perm_change_terms, notice_days, gteq, 3),
      minimum_notice_days(need_change_only_with_prior_notice, 14),
      clause(clause_c2, "C2", "Provider may change terms by informing users at least 3 days in advance."),
      atomics_to_string(["Risk: terms may change with notice (", 3, " days) below consumer requirement (", 14, " days). Clause ", "C2", ": ", "Provider may change terms by informing users at least 3 days in advance."], "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance.")]).
step(clause(clause_c2, "C2", "Provider may change terms by informing users at least 3 days in advance."),
     fact(19),
     [],
     []).
step(atomics_to_string(["Risk: terms may change with notice (", 3, " days) below consumer requirement (", 14, " days). Clause ", "C2", ": ", "Provider may change terms by informing users at least 3 days in advance."], "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."),
     builtin,
     [],
     []).
step(findall(mitigation(_0, _1, _2), (mitigation(risk_notice_too_short, _1, _2), mitigation_order(_1, _0)), [mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")]),
     collected,
     [],
     [mitigation(risk_notice_too_short, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement."),
      mitigation_order(mitigate_notice_too_short, 1)]).
step(mitigation(risk_notice_too_short, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement."),
     rule(51),
     ['S' = source_notice_too_short,
      'St' = policy_risk,
      'K' = customer_confidence_loss,
      'R' = perm_change_terms,
      'C' = clause_c2,
      'N' = need_change_only_with_prior_notice,
      'Raw' = 85,
      'W' = "Terms may change with less notice than the consumer requires."],
     [detected_risk(risk_notice_too_short, source_notice_too_short, policy_risk, customer_confidence_loss, perm_change_terms, clause_c2, need_change_only_with_prior_notice, 85, "Terms may change with less notice than the consumer requires.")]).
step(mitigation_order(mitigate_notice_too_short, 1), fact(64), [], []).
step(sort([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")], [mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")]),
     builtin,
     [],
     []).
step(sort([ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")])), ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")]))], [ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))]),
     builtin,
     [],
     []).
step(sort([ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))], [ranked(1, clause("C1", "Provider may remove the user account and associated data at its discretion."), risk(risk_delete_without_safeguards, 100, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account and associated data at its discretion."), mitigations([mitigation(1, mitigate_delete_notice, "Add a notice constraint (minimum noticeDays) before account removal."), mitigation(2, mitigate_delete_inform, "Add a duty to inform the consumer prior to account removal.")])), ranked(2, clause("C3", "Provider may share user data with partners for business purposes."), risk(risk_share_without_consent, 97, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes."), mitigations([mitigation(1, mitigate_share_consent, "Add an explicit consent constraint before data sharing.")])), ranked(3, clause("C2", "Provider may change terms by informing users at least 3 days in advance."), risk(risk_notice_too_short, 85, iri("https://w3id.org/dpv/risk#HighRisk"), iri("https://w3id.org/dpv/risk#HighSeverity"), "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance."), mitigations([mitigation(1, mitigate_notice_too_short, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.")])), ranked(4, clause("C4", "Users are not permitted to export their data."), risk(risk_no_portability, 70, iri("https://w3id.org/dpv/risk#ModerateRisk"), iri("https://w3id.org/dpv/risk#ModerateSeverity"), "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data."), mitigations([mitigation(1, mitigate_portability, "Add a permission allowing data export (or remove the prohibition) to support portability.")]))]),
     builtin,
     [],
     []).
