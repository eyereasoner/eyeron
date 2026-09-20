# Eyelang result format 2
query(1, [call(fact(?v0, ?v1, ?v2))], [binding("s", ?v0), binding("p", ?v1), binding("o", ?v2)]).
result(1, complete, 14).
answer(1, [binding("s", msg1), binding("p", type_of), binding("o", localObservation)]).
answer(1, [binding("s", msg1), binding("p", observedBy), binding("o", probe7)]).
answer(1, [binding("s", msg1), binding("p", observedAt), binding("o", "2026-06-17T12:34:56Z")]).
answer(1, [binding("s", msg1), binding("p", temperatureCelsius), binding("o", 18.6)]).
answer(1, [binding("s", msg1), binding("p", observedFeature), binding("o", platformB)]).
answer(1, [binding("s", msg1), binding("p", inFlow), binding("o", ingestStep)]).
answer(1, [binding("s", probe7), binding("p", type_of), binding("o", temperatureProbe)]).
answer(1, [binding("s", msg1), binding("p", madeBySensor), binding("o", probe7)]).
answer(1, [binding("s", msg1), binding("p", resultTime), binding("o", "2026-06-17T12:34:56Z")]).
answer(1, [binding("s", msg1), binding("p", hasSimpleResult), binding("o", 18.6)]).
answer(1, [binding("s", msg1), binding("p", hasFlowStep), binding("o", ingestStep)]).
answer(1, [binding("s", msg1), binding("p", type_of), binding("o", observation)]).
answer(1, [binding("s", probe7), binding("p", type_of), binding("o", sensor)]).
answer(1, [binding("s", msg1), binding("p", hasFeatureOfInterest), binding("o", platformB)]).
query(2, [call(runtime_rule(?v0, ?v1))], [binding("p", ?v0), binding("r", ?v1)]).
result(2, complete, 5).
answer(2, [binding("p", observedBy), binding("r", copyToTarget)]).
answer(2, [binding("p", observedAt), binding("r", copyToTarget)]).
answer(2, [binding("p", temperatureCelsius), binding("r", copyToTarget)]).
answer(2, [binding("p", inFlow), binding("r", copyToTarget)]).
answer(2, [binding("p", observedFeature), binding("r", copyToTarget)]).
query(3, [call(target_predicate(?v0, ?v1))], [binding("p", ?v0), binding("t", ?v1)]).
result(3, complete, 5).
answer(3, [binding("p", observedBy), binding("t", madeBySensor)]).
answer(3, [binding("p", observedAt), binding("t", resultTime)]).
answer(3, [binding("p", temperatureCelsius), binding("t", hasSimpleResult)]).
answer(3, [binding("p", inFlow), binding("t", hasFlowStep)]).
answer(3, [binding("p", observedFeature), binding("t", hasFeatureOfInterest)]).
query(4, [call(emits(?v0, ?v1))], [binding("step", ?v0), binding("msg", ?v1)]).
result(4, complete, 1).
answer(4, [binding("step", ingestStep), binding("msg", msg1)]).
query(5, [call(trusted_by(?v0, ?v1))], [binding("step", ?v0), binding("sensor", ?v1)]).
result(5, complete, 1).
answer(5, [binding("step", ingestStep), binding("sensor", probe7)]).
