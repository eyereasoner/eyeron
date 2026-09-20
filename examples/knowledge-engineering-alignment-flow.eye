# Eyelang example: knowledge-engineering-alignment-flow.
# Companion to knowledge-engineering-alignment-flow.n3/.srl: generic
# RDFS/OWL-style alignment rules (subClassOf, subPropertyOf,
# equivalentProperty) plus a flow-trust hook, over one incoming
# observation message. Since these rules are generic over the predicate
# position itself, they need reified `fact/3` triples here (matching
# similar.eye/patch.eye's own convention), rather than Eyelang relations
# keyed by a fixed predicate name.
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

fact(?thing, type_of, ?super) if fact(?thing, type_of, ?class), subclass_of(?class, ?super).
fact(?s, ?superP, ?o) if fact(?s, ?p, ?o), subproperty_of(?p, ?superP).
fact(?s, ?q, ?o) if equivalent_property(?p, ?q), fact(?s, ?p, ?o).
fact(?s, ?p, ?o) if equivalent_property(?p, ?q), fact(?s, ?q, ?o).

runtime_rule(?sourcePredicate, copyToTarget) if subproperty_of(?sourcePredicate, ?targetPredicate).
target_predicate(?sourcePredicate, ?targetPredicate) if subproperty_of(?sourcePredicate, ?targetPredicate).
runtime_rule(?sourcePredicate, copyToTarget) if equivalent_property(?sourcePredicate, ?targetPredicate).
target_predicate(?sourcePredicate, ?targetPredicate) if equivalent_property(?sourcePredicate, ?targetPredicate).

emits(?step, ?message) if fact(?message, type_of, observation), fact(?message, hasFlowStep, ?step), fact(?message, madeBySensor, ?sensor).
trusted_by(?step, ?sensor) if fact(?message, type_of, observation), fact(?message, hasFlowStep, ?step), fact(?message, madeBySensor, ?sensor).

ask fact(?s, ?p, ?o).
ask runtime_rule(?p, ?r).
ask target_predicate(?p, ?t).
ask emits(?step, ?msg).
ask trusted_by(?step, ?sensor).
