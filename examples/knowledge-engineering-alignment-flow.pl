% Prolog example: knowledge-engineering-alignment-flow.
% Companion to knowledge-engineering-alignment-flow.n3/.srl: generic
% RDFS/OWL-style alignment rules (subClassOf, subPropertyOf,
% equivalentProperty) plus a flow-trust hook, over one incoming
% observation message. Since these rules are generic over the predicate
% position itself, they need reified `fact/3` triples here (matching
% similar.pl/patch.pl's own convention), rather than Prolog relations
% keyed by a fixed predicate name.
fact(msg1, type_of, localObservation).
fact(msg1, observedBy, probe7).
fact(msg1, observedAt, "2026-06-17T12:34:56Z").
fact(msg1, temperatureCelsius, 18.6).
fact(msg1, observedFeature, platformB).
fact(msg1, inFlow, ingestStep).
fact(probe7, type_of, temperatureProbe).

subclass_of(localObservation, observation).
subclass_of(temperatureProbe, sensor).
subproperty_of(observedBy, madeBySensor).
subproperty_of(observedAt, resultTime).
subproperty_of(temperatureCelsius, hasSimpleResult).
equivalent_property(observedFeature, hasFeatureOfInterest).
subproperty_of(inFlow, hasFlowStep).

fact(Thing, type_of, Super) :-
    fact(Thing, type_of, Class),
    subclass_of(Class, Super).
fact(S, SuperP, O) :-
    fact(S, P, O),
    subproperty_of(P, SuperP).
fact(S, Q, O) :-
    equivalent_property(P, Q),
    fact(S, P, O).
fact(S, P, O) :-
    equivalent_property(P, Q),
    fact(S, Q, O).

runtime_rule(SourcePredicate, copyToTarget) :-
    subproperty_of(SourcePredicate, TargetPredicate).
target_predicate(SourcePredicate, TargetPredicate) :-
    subproperty_of(SourcePredicate, TargetPredicate).
runtime_rule(SourcePredicate, copyToTarget) :-
    equivalent_property(SourcePredicate, TargetPredicate).
target_predicate(SourcePredicate, TargetPredicate) :-
    equivalent_property(SourcePredicate, TargetPredicate).

emits(Step, Message) :-
    fact(Message, type_of, observation),
    fact(Message, hasFlowStep, Step),
    fact(Message, madeBySensor, Sensor).
trusted_by(Step, Sensor) :-
    fact(Message, type_of, observation),
    fact(Message, hasFlowStep, Step),
    fact(Message, madeBySensor, Sensor).

?- fact(S, P, O).
?- runtime_rule(P, R).
?- target_predicate(P, T).
?- emits(Step, Msg).
?- trusted_by(Step, Sensor).
