fact(msg1, type_of, localObservation).
fact(msg1, observedBy, probe7).
fact(msg1, observedAt, "2026-06-17T12:34:56Z").
fact(msg1, temperatureCelsius, 18.6).
fact(msg1, observedFeature, platformB).
fact(msg1, inFlow, ingestStep).
fact(probe7, type_of, temperatureProbe).
fact(msg1, madeBySensor, probe7).
fact(msg1, resultTime, "2026-06-17T12:34:56Z").
fact(msg1, hasSimpleResult, 18.6).
fact(msg1, hasFlowStep, ingestStep).
fact(msg1, type_of, observation).
fact(probe7, type_of, sensor).
fact(msg1, hasFeatureOfInterest, platformB).
runtime_rule(observedBy, copyToTarget).
runtime_rule(observedAt, copyToTarget).
runtime_rule(temperatureCelsius, copyToTarget).
runtime_rule(inFlow, copyToTarget).
runtime_rule(observedFeature, copyToTarget).
target_predicate(observedBy, madeBySensor).
target_predicate(observedAt, resultTime).
target_predicate(temperatureCelsius, hasSimpleResult).
target_predicate(inFlow, hasFlowStep).
target_predicate(observedFeature, hasFeatureOfInterest).
emits(ingestStep, msg1).
trusted_by(ingestStep, probe7).
