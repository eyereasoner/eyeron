% Prolog result format 3
query(1, fact(_0, _1, _2), ['S' = _0, 'P' = _1, 'O' = _2]).
result(1, complete, 14).
answer(1, ['S' = msg1, 'P' = type_of, 'O' = localObservation]).
answer(1, ['S' = msg1, 'P' = observedBy, 'O' = probe7]).
answer(1, ['S' = msg1, 'P' = observedAt, 'O' = "2026-06-17T12:34:56Z"]).
answer(1, ['S' = msg1, 'P' = temperatureCelsius, 'O' = 18.6]).
answer(1, ['S' = msg1, 'P' = observedFeature, 'O' = platformB]).
answer(1, ['S' = msg1, 'P' = inFlow, 'O' = ingestStep]).
answer(1, ['S' = probe7, 'P' = type_of, 'O' = temperatureProbe]).
answer(1, ['S' = msg1, 'P' = madeBySensor, 'O' = probe7]).
answer(1, ['S' = msg1, 'P' = resultTime, 'O' = "2026-06-17T12:34:56Z"]).
answer(1, ['S' = msg1, 'P' = hasSimpleResult, 'O' = 18.6]).
answer(1, ['S' = msg1, 'P' = hasFlowStep, 'O' = ingestStep]).
answer(1, ['S' = msg1, 'P' = type_of, 'O' = observation]).
answer(1, ['S' = probe7, 'P' = type_of, 'O' = sensor]).
answer(1, ['S' = msg1, 'P' = hasFeatureOfInterest, 'O' = platformB]).
query(2, runtime_rule(_0, _1), ['P' = _0, 'R' = _1]).
result(2, complete, 5).
answer(2, ['P' = observedBy, 'R' = copyToTarget]).
answer(2, ['P' = observedAt, 'R' = copyToTarget]).
answer(2, ['P' = temperatureCelsius, 'R' = copyToTarget]).
answer(2, ['P' = inFlow, 'R' = copyToTarget]).
answer(2, ['P' = observedFeature, 'R' = copyToTarget]).
query(3, target_predicate(_0, _1), ['P' = _0, 'T' = _1]).
result(3, complete, 5).
answer(3, ['P' = observedBy, 'T' = madeBySensor]).
answer(3, ['P' = observedAt, 'T' = resultTime]).
answer(3, ['P' = temperatureCelsius, 'T' = hasSimpleResult]).
answer(3, ['P' = inFlow, 'T' = hasFlowStep]).
answer(3, ['P' = observedFeature, 'T' = hasFeatureOfInterest]).
query(4, emits(_0, _1), ['Step' = _0, 'Msg' = _1]).
result(4, complete, 1).
answer(4, ['Step' = ingestStep, 'Msg' = msg1]).
query(5, trusted_by(_0, _1), ['Step' = _0, 'Sensor' = _1]).
result(5, complete, 1).
answer(5, ['Step' = ingestStep, 'Sensor' = probe7]).
