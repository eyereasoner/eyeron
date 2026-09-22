% Prolog example: dpv-odrl-purpose-mapping.
% Companion to dpv-odrl-purpose-mapping.n3/.srl: derives an ODRL policy
% view (permission, assigner/assignee, target, action, purpose/legal-
% basis constraints) from a DPV process description, as ordinary
% relations. Since Prolog isn't RDF-shaped, each group of N3 triples
% that share the same join is derived from one shared helper relation
% (process_info/purpose_info/basis_info) instead of repeating the full
% premise per output property.
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

process_info(Policy, Permission, Process, Controller, Recipient, Data, Processing) :-
    represents_process(Policy, Process),
    permission_node(Policy, Permission),
    is_process(Process),
    has_data_controller(Process, Controller),
    has_recipient(Process, Recipient),
    has_personal_data(Process, Data),
    has_processing(Process, Processing).

is_policy(Policy) :-
    process_info(Policy, Permission, Process, C, R, D, Pr).
is_permission(Permission) :-
    process_info(Policy, Permission, Process, C, R, D, Pr).
assigner(Permission, C) :-
    process_info(Policy, Permission, Process, C, R, D, Pr).
assignee(Permission, R) :-
    process_info(Policy, Permission, Process, C, R, D, Pr).
target(Permission, D) :-
    process_info(Policy, Permission, Process, C, R, D, Pr).
action(Permission, Pr) :-
    process_info(Policy, Permission, Process, C, R, D, Pr).
derived_from_process(Permission, Process) :-
    process_info(Policy, Permission, Process, C, R, D, Pr).

purpose_info(Permission, Constraint, Purpose) :-
    represents_process(Policy, Process),
    permission_node(Policy, Permission),
    purpose_constraint(Policy, Constraint),
    has_purpose(Process, Purpose).

permission_constraint(Permission, Constraint) :-
    purpose_info(Permission, Constraint, Purpose).
is_constraint(Constraint) :-
    purpose_info(Permission, Constraint, Purpose).
left_operand(Constraint, purpose) :-
    purpose_info(Permission, Constraint, Purpose).
operator(Constraint, isA) :-
    purpose_info(Permission, Constraint, Purpose).
right_operand(Constraint, Purpose) :-
    purpose_info(Permission, Constraint, Purpose).

basis_info(Permission, Constraint, Basis) :-
    represents_process(Policy, Process),
    permission_node(Policy, Permission),
    basis_constraint(Policy, Constraint),
    has_legal_basis(Process, Basis).

permission_constraint(Permission, Constraint) :-
    basis_info(Permission, Constraint, Basis).
left_operand(Constraint, legalBasis) :-
    basis_info(Permission, Constraint, Basis).
operator(Constraint, isA) :-
    basis_info(Permission, Constraint, Basis).
right_operand(Constraint, Basis) :-
    basis_info(Permission, Constraint, Basis).

?- is_policy(P).
?- is_permission(P).
?- assigner(P, C).
?- assignee(P, R).
?- target(P, D).
?- action(P, A).
?- derived_from_process(P, Pr).
?- permission_constraint(P, C).
?- is_constraint(C).
?- left_operand(C, L).
?- operator(C, O).
?- right_operand(C, R).
