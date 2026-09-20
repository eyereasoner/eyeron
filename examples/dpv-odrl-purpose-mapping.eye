# Eyelang example: dpv-odrl-purpose-mapping.
# Companion to dpv-odrl-purpose-mapping.n3/.srl: derives an ODRL policy
# view (permission, assigner/assignee, target, action, purpose/legal-
# basis constraints) from a DPV process description, as ordinary
# relations. Since Eyelang isn't RDF-shaped, each group of N3 triples
# that share the same join is derived from one shared helper relation
# (process_info/purpose_info/basis_info) instead of repeating the full
# premise per output property.
represents_process(alphaPolicy, alphaCareProcess).
permission_node(alphaPolicy, alphaPermission).
purpose_constraint(alphaPolicy, alphaPurposeConstraint).
basis_constraint(alphaPolicy, alphaBasisConstraint).

is_process(alphaCareProcess).
has_data_controller(alphaCareProcess, hospitalA).
has_recipient(alphaCareProcess, researchPartner).
has_personal_data(alphaCareProcess, labResult).
has_processing(alphaCareProcess, use_).
has_purpose(alphaCareProcess, healthcare).
has_legal_basis(alphaCareProcess, consent).

process_info(?policy, ?permission, ?process, ?controller, ?recipient, ?data, ?processing) if
    represents_process(?policy, ?process), permission_node(?policy, ?permission),
    is_process(?process), has_data_controller(?process, ?controller), has_recipient(?process, ?recipient),
    has_personal_data(?process, ?data), has_processing(?process, ?processing).

is_policy(?policy) if process_info(?policy, ?permission, ?process, ?c, ?r, ?d, ?pr).
is_permission(?permission) if process_info(?policy, ?permission, ?process, ?c, ?r, ?d, ?pr).
assigner(?permission, ?c) if process_info(?policy, ?permission, ?process, ?c, ?r, ?d, ?pr).
assignee(?permission, ?r) if process_info(?policy, ?permission, ?process, ?c, ?r, ?d, ?pr).
target(?permission, ?d) if process_info(?policy, ?permission, ?process, ?c, ?r, ?d, ?pr).
action(?permission, ?pr) if process_info(?policy, ?permission, ?process, ?c, ?r, ?d, ?pr).
derived_from_process(?permission, ?process) if process_info(?policy, ?permission, ?process, ?c, ?r, ?d, ?pr).

purpose_info(?permission, ?constraint, ?purpose) if
    represents_process(?policy, ?process), permission_node(?policy, ?permission), purpose_constraint(?policy, ?constraint),
    has_purpose(?process, ?purpose).
permission_constraint(?permission, ?constraint) if purpose_info(?permission, ?constraint, ?purpose).
is_constraint(?constraint) if purpose_info(?permission, ?constraint, ?purpose).
left_operand(?constraint, purpose) if purpose_info(?permission, ?constraint, ?purpose).
operator(?constraint, isA) if purpose_info(?permission, ?constraint, ?purpose).
right_operand(?constraint, ?purpose) if purpose_info(?permission, ?constraint, ?purpose).

basis_info(?permission, ?constraint, ?basis) if
    represents_process(?policy, ?process), permission_node(?policy, ?permission), basis_constraint(?policy, ?constraint),
    has_legal_basis(?process, ?basis).
permission_constraint(?permission, ?constraint) if basis_info(?permission, ?constraint, ?basis).
left_operand(?constraint, legalBasis) if basis_info(?permission, ?constraint, ?basis).
operator(?constraint, isA) if basis_info(?permission, ?constraint, ?basis).
right_operand(?constraint, ?basis) if basis_info(?permission, ?constraint, ?basis).

ask is_policy(?p).
ask is_permission(?p).
ask assigner(?p, ?c).
ask assignee(?p, ?r).
ask target(?p, ?d).
ask action(?p, ?a).
ask derived_from_process(?p, ?pr).
ask permission_constraint(?p, ?c).
ask is_constraint(?c).
ask left_operand(?c, ?l).
ask operator(?c, ?o).
ask right_operand(?c, ?r).
