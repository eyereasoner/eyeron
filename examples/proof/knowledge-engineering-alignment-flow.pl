% Prolog result format 4
query(1, fact(_0, _1, _2), ['S' = _0, 'P' = _1, 'O' = _2]).
result(1, complete, 14).
answer(1, ['S' = msg1, 'P' = type_of, 'O' = localObservation]).
why(1,
    ['S' = msg1, 'P' = type_of, 'O' = localObservation],
    [fact(msg1, type_of, localObservation)]).
answer(1, ['S' = msg1, 'P' = observedBy, 'O' = probe7]).
why(1, ['S' = msg1, 'P' = observedBy, 'O' = probe7], [fact(msg1, observedBy, probe7)]).
answer(1, ['S' = msg1, 'P' = observedAt, 'O' = "2026-06-17T12:34:56Z"]).
why(1,
    ['S' = msg1, 'P' = observedAt, 'O' = "2026-06-17T12:34:56Z"],
    [fact(msg1, observedAt, "2026-06-17T12:34:56Z")]).
answer(1, ['S' = msg1, 'P' = temperatureCelsius, 'O' = 18.6]).
why(1,
    ['S' = msg1, 'P' = temperatureCelsius, 'O' = 18.6],
    [fact(msg1, temperatureCelsius, 18.6)]).
answer(1, ['S' = msg1, 'P' = observedFeature, 'O' = platformB]).
why(1,
    ['S' = msg1, 'P' = observedFeature, 'O' = platformB],
    [fact(msg1, observedFeature, platformB)]).
answer(1, ['S' = msg1, 'P' = inFlow, 'O' = ingestStep]).
why(1, ['S' = msg1, 'P' = inFlow, 'O' = ingestStep], [fact(msg1, inFlow, ingestStep)]).
answer(1, ['S' = probe7, 'P' = type_of, 'O' = temperatureProbe]).
why(1,
    ['S' = probe7, 'P' = type_of, 'O' = temperatureProbe],
    [fact(probe7, type_of, temperatureProbe)]).
answer(1, ['S' = msg1, 'P' = madeBySensor, 'O' = probe7]).
why(1, ['S' = msg1, 'P' = madeBySensor, 'O' = probe7], [fact(msg1, madeBySensor, probe7)]).
answer(1, ['S' = msg1, 'P' = resultTime, 'O' = "2026-06-17T12:34:56Z"]).
why(1,
    ['S' = msg1, 'P' = resultTime, 'O' = "2026-06-17T12:34:56Z"],
    [fact(msg1, resultTime, "2026-06-17T12:34:56Z")]).
answer(1, ['S' = msg1, 'P' = hasSimpleResult, 'O' = 18.6]).
why(1, ['S' = msg1, 'P' = hasSimpleResult, 'O' = 18.6], [fact(msg1, hasSimpleResult, 18.6)]).
answer(1, ['S' = msg1, 'P' = hasFlowStep, 'O' = ingestStep]).
why(1, ['S' = msg1, 'P' = hasFlowStep, 'O' = ingestStep], [fact(msg1, hasFlowStep, ingestStep)]).
answer(1, ['S' = msg1, 'P' = type_of, 'O' = observation]).
why(1, ['S' = msg1, 'P' = type_of, 'O' = observation], [fact(msg1, type_of, observation)]).
answer(1, ['S' = probe7, 'P' = type_of, 'O' = sensor]).
why(1, ['S' = probe7, 'P' = type_of, 'O' = sensor], [fact(probe7, type_of, sensor)]).
answer(1, ['S' = msg1, 'P' = hasFeatureOfInterest, 'O' = platformB]).
why(1,
    ['S' = msg1, 'P' = hasFeatureOfInterest, 'O' = platformB],
    [fact(msg1, hasFeatureOfInterest, platformB)]).
query(2, runtime_rule(_0, _1), ['P' = _0, 'R' = _1]).
result(2, complete, 5).
answer(2, ['P' = observedBy, 'R' = copyToTarget]).
why(2, ['P' = observedBy, 'R' = copyToTarget], [runtime_rule(observedBy, copyToTarget)]).
answer(2, ['P' = observedAt, 'R' = copyToTarget]).
why(2, ['P' = observedAt, 'R' = copyToTarget], [runtime_rule(observedAt, copyToTarget)]).
answer(2, ['P' = temperatureCelsius, 'R' = copyToTarget]).
why(2,
    ['P' = temperatureCelsius, 'R' = copyToTarget],
    [runtime_rule(temperatureCelsius, copyToTarget)]).
answer(2, ['P' = inFlow, 'R' = copyToTarget]).
why(2, ['P' = inFlow, 'R' = copyToTarget], [runtime_rule(inFlow, copyToTarget)]).
answer(2, ['P' = observedFeature, 'R' = copyToTarget]).
why(2,
    ['P' = observedFeature, 'R' = copyToTarget],
    [runtime_rule(observedFeature, copyToTarget)]).
query(3, target_predicate(_0, _1), ['P' = _0, 'T' = _1]).
result(3, complete, 5).
answer(3, ['P' = observedBy, 'T' = madeBySensor]).
why(3, ['P' = observedBy, 'T' = madeBySensor], [target_predicate(observedBy, madeBySensor)]).
answer(3, ['P' = observedAt, 'T' = resultTime]).
why(3, ['P' = observedAt, 'T' = resultTime], [target_predicate(observedAt, resultTime)]).
answer(3, ['P' = temperatureCelsius, 'T' = hasSimpleResult]).
why(3,
    ['P' = temperatureCelsius, 'T' = hasSimpleResult],
    [target_predicate(temperatureCelsius, hasSimpleResult)]).
answer(3, ['P' = inFlow, 'T' = hasFlowStep]).
why(3, ['P' = inFlow, 'T' = hasFlowStep], [target_predicate(inFlow, hasFlowStep)]).
answer(3, ['P' = observedFeature, 'T' = hasFeatureOfInterest]).
why(3,
    ['P' = observedFeature, 'T' = hasFeatureOfInterest],
    [target_predicate(observedFeature, hasFeatureOfInterest)]).
query(4, emits(_0, _1), ['Step' = _0, 'Msg' = _1]).
result(4, complete, 1).
answer(4, ['Step' = ingestStep, 'Msg' = msg1]).
why(4, ['Step' = ingestStep, 'Msg' = msg1], [emits(ingestStep, msg1)]).
query(5, trusted_by(_0, _1), ['Step' = _0, 'Sensor' = _1]).
result(5, complete, 1).
answer(5, ['Step' = ingestStep, 'Sensor' = probe7]).
why(5, ['Step' = ingestStep, 'Sensor' = probe7], [trusted_by(ingestStep, probe7)]).

clause(1, fact(msg1, type_of, localObservation), true).
clause(2, fact(msg1, observedBy, probe7), true).
clause(3, fact(msg1, observedAt, "2026-06-17T12:34:56Z"), true).
clause(4, fact(msg1, temperatureCelsius, 18.6), true).
clause(5, fact(msg1, observedFeature, platformB), true).
clause(6, fact(msg1, inFlow, ingestStep), true).
clause(7, fact(probe7, type_of, temperatureProbe), true).
clause(8, subclass_of(localObservation, observation), true).
clause(9, subclass_of(temperatureProbe, sensor), true).
clause(10, subproperty_of(observedBy, madeBySensor), true).
clause(11, subproperty_of(observedAt, resultTime), true).
clause(12, subproperty_of(temperatureCelsius, hasSimpleResult), true).
clause(13, equivalent_property(observedFeature, hasFeatureOfInterest), true).
clause(14, subproperty_of(inFlow, hasFlowStep), true).
clause(15,
       fact(var('Thing'), type_of, var('Super')),
       (fact(var('Thing'), type_of, var('Class')), subclass_of(var('Class'), var('Super')))).
clause(16,
       fact(var('S'), var('SuperP'), var('O')),
       (fact(var('S'), var('P'), var('O')), subproperty_of(var('P'), var('SuperP')))).
clause(17,
       fact(var('S'), var('Q'), var('O')),
       (equivalent_property(var('P'), var('Q')), fact(var('S'), var('P'), var('O')))).
clause(19,
       runtime_rule(var('SourcePredicate'), copyToTarget),
       subproperty_of(var('SourcePredicate'), var('TargetPredicate'))).
clause(20,
       target_predicate(var('SourcePredicate'), var('TargetPredicate')),
       subproperty_of(var('SourcePredicate'), var('TargetPredicate'))).
clause(21,
       runtime_rule(var('SourcePredicate'), copyToTarget),
       equivalent_property(var('SourcePredicate'), var('TargetPredicate'))).
clause(22,
       target_predicate(var('SourcePredicate'), var('TargetPredicate')),
       equivalent_property(var('SourcePredicate'), var('TargetPredicate'))).
clause(23,
       emits(var('Step'), var('Message')),
       (fact(var('Message'), type_of, observation),
        fact(var('Message'), hasFlowStep, var('Step')),
        fact(var('Message'), madeBySensor, var('Sensor')))).
clause(24,
       trusted_by(var('Step'), var('Sensor')),
       (fact(var('Message'), type_of, observation),
        fact(var('Message'), hasFlowStep, var('Step')),
        fact(var('Message'), madeBySensor, var('Sensor')))).

step(fact(msg1, type_of, localObservation), fact(1), [], []).
step(fact(msg1, observedBy, probe7), fact(2), [], []).
step(fact(msg1, observedAt, "2026-06-17T12:34:56Z"), fact(3), [], []).
step(fact(msg1, temperatureCelsius, 18.6), fact(4), [], []).
step(fact(msg1, observedFeature, platformB), fact(5), [], []).
step(fact(msg1, inFlow, ingestStep), fact(6), [], []).
step(fact(probe7, type_of, temperatureProbe), fact(7), [], []).
step(fact(msg1, madeBySensor, probe7),
     rule(16),
     ['S' = msg1, 'SuperP' = madeBySensor, 'O' = probe7, 'P' = observedBy],
     [fact(msg1, observedBy, probe7), subproperty_of(observedBy, madeBySensor)]).
step(subproperty_of(observedBy, madeBySensor), fact(10), [], []).
step(fact(msg1, resultTime, "2026-06-17T12:34:56Z"),
     rule(16),
     ['S' = msg1, 'SuperP' = resultTime, 'O' = "2026-06-17T12:34:56Z", 'P' = observedAt],
     [fact(msg1, observedAt, "2026-06-17T12:34:56Z"), subproperty_of(observedAt, resultTime)]).
step(subproperty_of(observedAt, resultTime), fact(11), [], []).
step(fact(msg1, hasSimpleResult, 18.6),
     rule(16),
     ['S' = msg1, 'SuperP' = hasSimpleResult, 'O' = 18.6, 'P' = temperatureCelsius],
     [fact(msg1, temperatureCelsius, 18.6), subproperty_of(temperatureCelsius, hasSimpleResult)]).
step(subproperty_of(temperatureCelsius, hasSimpleResult), fact(12), [], []).
step(fact(msg1, hasFlowStep, ingestStep),
     rule(16),
     ['S' = msg1, 'SuperP' = hasFlowStep, 'O' = ingestStep, 'P' = inFlow],
     [fact(msg1, inFlow, ingestStep), subproperty_of(inFlow, hasFlowStep)]).
step(subproperty_of(inFlow, hasFlowStep), fact(14), [], []).
step(fact(msg1, type_of, observation),
     rule(15),
     ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation],
     [fact(msg1, type_of, localObservation), subclass_of(localObservation, observation)]).
step(subclass_of(localObservation, observation), fact(8), [], []).
step(fact(probe7, type_of, sensor),
     rule(15),
     ['Thing' = probe7, 'Super' = sensor, 'Class' = temperatureProbe],
     [fact(probe7, type_of, temperatureProbe), subclass_of(temperatureProbe, sensor)]).
step(subclass_of(temperatureProbe, sensor), fact(9), [], []).
step(fact(msg1, hasFeatureOfInterest, platformB),
     rule(17),
     ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature],
     [equivalent_property(observedFeature, hasFeatureOfInterest),
      fact(msg1, observedFeature, platformB)]).
step(equivalent_property(observedFeature, hasFeatureOfInterest), fact(13), [], []).
step(runtime_rule(observedBy, copyToTarget),
     rule(19),
     ['SourcePredicate' = observedBy, 'TargetPredicate' = madeBySensor],
     [subproperty_of(observedBy, madeBySensor)]).
step(runtime_rule(observedAt, copyToTarget),
     rule(19),
     ['SourcePredicate' = observedAt, 'TargetPredicate' = resultTime],
     [subproperty_of(observedAt, resultTime)]).
step(runtime_rule(temperatureCelsius, copyToTarget),
     rule(19),
     ['SourcePredicate' = temperatureCelsius, 'TargetPredicate' = hasSimpleResult],
     [subproperty_of(temperatureCelsius, hasSimpleResult)]).
step(runtime_rule(inFlow, copyToTarget),
     rule(19),
     ['SourcePredicate' = inFlow, 'TargetPredicate' = hasFlowStep],
     [subproperty_of(inFlow, hasFlowStep)]).
step(runtime_rule(observedFeature, copyToTarget),
     rule(21),
     ['SourcePredicate' = observedFeature, 'TargetPredicate' = hasFeatureOfInterest],
     [equivalent_property(observedFeature, hasFeatureOfInterest)]).
step(target_predicate(observedBy, madeBySensor),
     rule(20),
     ['SourcePredicate' = observedBy, 'TargetPredicate' = madeBySensor],
     [subproperty_of(observedBy, madeBySensor)]).
step(target_predicate(observedAt, resultTime),
     rule(20),
     ['SourcePredicate' = observedAt, 'TargetPredicate' = resultTime],
     [subproperty_of(observedAt, resultTime)]).
step(target_predicate(temperatureCelsius, hasSimpleResult),
     rule(20),
     ['SourcePredicate' = temperatureCelsius, 'TargetPredicate' = hasSimpleResult],
     [subproperty_of(temperatureCelsius, hasSimpleResult)]).
step(target_predicate(inFlow, hasFlowStep),
     rule(20),
     ['SourcePredicate' = inFlow, 'TargetPredicate' = hasFlowStep],
     [subproperty_of(inFlow, hasFlowStep)]).
step(target_predicate(observedFeature, hasFeatureOfInterest),
     rule(22),
     ['SourcePredicate' = observedFeature, 'TargetPredicate' = hasFeatureOfInterest],
     [equivalent_property(observedFeature, hasFeatureOfInterest)]).
step(emits(ingestStep, msg1),
     rule(23),
     ['Step' = ingestStep, 'Message' = msg1, 'Sensor' = probe7],
     [fact(msg1, type_of, observation),
      fact(msg1, hasFlowStep, ingestStep),
      fact(msg1, madeBySensor, probe7)]).
step(trusted_by(ingestStep, probe7),
     rule(24),
     ['Step' = ingestStep, 'Sensor' = probe7, 'Message' = msg1],
     [fact(msg1, type_of, observation),
      fact(msg1, hasFlowStep, ingestStep),
      fact(msg1, madeBySensor, probe7)]).
