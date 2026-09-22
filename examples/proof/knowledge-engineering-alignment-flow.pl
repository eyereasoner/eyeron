% Prolog result format 3
query(1, fact(_0, _1, _2), ['S' = _0, 'P' = _1, 'O' = _2]).
result(1, complete, 14).
answer(1, ['S' = msg1, 'P' = type_of, 'O' = localObservation]).
why(1, ['S' = msg1, 'P' = type_of, 'O' = localObservation], 8).
answer(1, ['S' = msg1, 'P' = observedBy, 'O' = probe7]).
why(1, ['S' = msg1, 'P' = observedBy, 'O' = probe7], 9).
answer(1, ['S' = msg1, 'P' = observedAt, 'O' = "2026-06-17T12:34:56Z"]).
why(1, ['S' = msg1, 'P' = observedAt, 'O' = "2026-06-17T12:34:56Z"], 10).
answer(1, ['S' = msg1, 'P' = temperatureCelsius, 'O' = 18.6]).
why(1, ['S' = msg1, 'P' = temperatureCelsius, 'O' = 18.6], 11).
answer(1, ['S' = msg1, 'P' = observedFeature, 'O' = platformB]).
why(1, ['S' = msg1, 'P' = observedFeature, 'O' = platformB], 12).
answer(1, ['S' = msg1, 'P' = inFlow, 'O' = ingestStep]).
why(1, ['S' = msg1, 'P' = inFlow, 'O' = ingestStep], 13).
answer(1, ['S' = probe7, 'P' = type_of, 'O' = temperatureProbe]).
why(1, ['S' = probe7, 'P' = type_of, 'O' = temperatureProbe], 14).
answer(1, ['S' = msg1, 'P' = madeBySensor, 'O' = probe7]).
why(1, ['S' = msg1, 'P' = madeBySensor, 'O' = probe7], 28).
answer(1, ['S' = msg1, 'P' = resultTime, 'O' = "2026-06-17T12:34:56Z"]).
why(1, ['S' = msg1, 'P' = resultTime, 'O' = "2026-06-17T12:34:56Z"], 29).
answer(1, ['S' = msg1, 'P' = hasSimpleResult, 'O' = 18.6]).
why(1, ['S' = msg1, 'P' = hasSimpleResult, 'O' = 18.6], 30).
answer(1, ['S' = msg1, 'P' = hasFlowStep, 'O' = ingestStep]).
why(1, ['S' = msg1, 'P' = hasFlowStep, 'O' = ingestStep], 31).
answer(1, ['S' = msg1, 'P' = type_of, 'O' = observation]).
why(1, ['S' = msg1, 'P' = type_of, 'O' = observation], 37).
answer(1, ['S' = probe7, 'P' = type_of, 'O' = sensor]).
why(1, ['S' = probe7, 'P' = type_of, 'O' = sensor], 38).
answer(1, ['S' = msg1, 'P' = hasFeatureOfInterest, 'O' = platformB]).
why(1, ['S' = msg1, 'P' = hasFeatureOfInterest, 'O' = platformB], 42).
query(2, runtime_rule(_0, _1), ['P' = _0, 'R' = _1]).
result(2, complete, 5).
answer(2, ['P' = observedBy, 'R' = copyToTarget]).
why(2, ['P' = observedBy, 'R' = copyToTarget], 54).
answer(2, ['P' = observedAt, 'R' = copyToTarget]).
why(2, ['P' = observedAt, 'R' = copyToTarget], 55).
answer(2, ['P' = temperatureCelsius, 'R' = copyToTarget]).
why(2, ['P' = temperatureCelsius, 'R' = copyToTarget], 56).
answer(2, ['P' = inFlow, 'R' = copyToTarget]).
why(2, ['P' = inFlow, 'R' = copyToTarget], 57).
answer(2, ['P' = observedFeature, 'R' = copyToTarget]).
why(2, ['P' = observedFeature, 'R' = copyToTarget], 58).
query(3, target_predicate(_0, _1), ['P' = _0, 'T' = _1]).
result(3, complete, 5).
answer(3, ['P' = observedBy, 'T' = madeBySensor]).
why(3, ['P' = observedBy, 'T' = madeBySensor], 69).
answer(3, ['P' = observedAt, 'T' = resultTime]).
why(3, ['P' = observedAt, 'T' = resultTime], 70).
answer(3, ['P' = temperatureCelsius, 'T' = hasSimpleResult]).
why(3, ['P' = temperatureCelsius, 'T' = hasSimpleResult], 71).
answer(3, ['P' = inFlow, 'T' = hasFlowStep]).
why(3, ['P' = inFlow, 'T' = hasFlowStep], 72).
answer(3, ['P' = observedFeature, 'T' = hasFeatureOfInterest]).
why(3, ['P' = observedFeature, 'T' = hasFeatureOfInterest], 73).
query(4, emits(_0, _1), ['Step' = _0, 'Msg' = _1]).
result(4, complete, 1).
answer(4, ['Step' = ingestStep, 'Msg' = msg1]).
why(4, ['Step' = ingestStep, 'Msg' = msg1], 127).
query(5, trusted_by(_0, _1), ['Step' = _0, 'Sensor' = _1]).
result(5, complete, 1).
answer(5, ['Step' = ingestStep, 'Sensor' = probe7]).
why(5, ['Step' = ingestStep, 'Sensor' = probe7], 181).
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
clause(15, fact(var('Thing'), type_of, var('Super')), (fact(var('Thing'), type_of, var('Class')), subclass_of(var('Class'), var('Super')))).
clause(16, fact(var('S'), var('SuperP'), var('O')), (fact(var('S'), var('P'), var('O')), subproperty_of(var('P'), var('SuperP')))).
clause(17, fact(var('S'), var('Q'), var('O')), (equivalent_property(var('P'), var('Q')), fact(var('S'), var('P'), var('O')))).
clause(19, runtime_rule(var('SourcePredicate'), copyToTarget), subproperty_of(var('SourcePredicate'), var('TargetPredicate'))).
clause(20, target_predicate(var('SourcePredicate'), var('TargetPredicate')), subproperty_of(var('SourcePredicate'), var('TargetPredicate'))).
clause(21, runtime_rule(var('SourcePredicate'), copyToTarget), equivalent_property(var('SourcePredicate'), var('TargetPredicate'))).
clause(22, target_predicate(var('SourcePredicate'), var('TargetPredicate')), equivalent_property(var('SourcePredicate'), var('TargetPredicate'))).
clause(23, emits(var('Step'), var('Message')), (fact(var('Message'), type_of, observation), fact(var('Message'), hasFlowStep, var('Step')), fact(var('Message'), madeBySensor, var('Sensor')))).
clause(24, trusted_by(var('Step'), var('Sensor')), (fact(var('Message'), type_of, observation), fact(var('Message'), hasFlowStep, var('Step')), fact(var('Message'), madeBySensor, var('Sensor')))).
substitution(1, []).
proof(1, fact(msg1, type_of, localObservation), rule(1), []).
substitution(2, []).
proof(2, fact(msg1, observedBy, probe7), rule(2), []).
substitution(3, []).
proof(3, fact(msg1, observedAt, "2026-06-17T12:34:56Z"), rule(3), []).
substitution(4, []).
proof(4, fact(msg1, temperatureCelsius, 18.6), rule(4), []).
substitution(5, []).
proof(5, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(6, []).
proof(6, fact(msg1, inFlow, ingestStep), rule(6), []).
substitution(7, []).
proof(7, fact(probe7, type_of, temperatureProbe), rule(7), []).
substitution(8, ['S' = msg1, 'P' = type_of, 'O' = localObservation]).
proof(8, solution([msg1, type_of, localObservation]), query, [uses(1, fact(msg1, type_of, localObservation))]).
substitution(9, ['S' = msg1, 'P' = observedBy, 'O' = probe7]).
proof(9, solution([msg1, observedBy, probe7]), query, [uses(2, fact(msg1, observedBy, probe7))]).
substitution(10, ['S' = msg1, 'P' = observedAt, 'O' = "2026-06-17T12:34:56Z"]).
proof(10, solution([msg1, observedAt, "2026-06-17T12:34:56Z"]), query, [uses(3, fact(msg1, observedAt, "2026-06-17T12:34:56Z"))]).
substitution(11, ['S' = msg1, 'P' = temperatureCelsius, 'O' = 18.6]).
proof(11, solution([msg1, temperatureCelsius, 18.6]), query, [uses(4, fact(msg1, temperatureCelsius, 18.6))]).
substitution(12, ['S' = msg1, 'P' = observedFeature, 'O' = platformB]).
proof(12, solution([msg1, observedFeature, platformB]), query, [uses(5, fact(msg1, observedFeature, platformB))]).
substitution(13, ['S' = msg1, 'P' = inFlow, 'O' = ingestStep]).
proof(13, solution([msg1, inFlow, ingestStep]), query, [uses(6, fact(msg1, inFlow, ingestStep))]).
substitution(14, ['S' = probe7, 'P' = type_of, 'O' = temperatureProbe]).
proof(14, solution([probe7, type_of, temperatureProbe]), query, [uses(7, fact(probe7, type_of, temperatureProbe))]).
substitution(15, []).
proof(15, fact(msg1, type_of, localObservation), rule(1), []).
substitution(16, []).
proof(16, fact(probe7, type_of, temperatureProbe), rule(7), []).
substitution(17, []).
proof(17, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(18, []).
proof(18, subproperty_of(observedAt, resultTime), rule(11), []).
substitution(19, []).
proof(19, subproperty_of(temperatureCelsius, hasSimpleResult), rule(12), []).
substitution(20, []).
proof(20, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(21, []).
proof(21, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(22, ['S' = msg1, 'SuperP' = madeBySensor, 'O' = probe7, 'P' = observedBy]).
proof(22, fact(msg1, madeBySensor, probe7), rule(16), [uses(2, fact(msg1, observedBy, probe7)), uses(17, subproperty_of(observedBy, madeBySensor))]).
substitution(23, ['S' = msg1, 'SuperP' = resultTime, 'O' = "2026-06-17T12:34:56Z", 'P' = observedAt]).
proof(23, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(3, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(18, subproperty_of(observedAt, resultTime))]).
substitution(24, ['S' = msg1, 'SuperP' = hasSimpleResult, 'O' = 18.6, 'P' = temperatureCelsius]).
proof(24, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(4, fact(msg1, temperatureCelsius, 18.6)), uses(19, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(25, ['S' = msg1, 'SuperP' = hasFlowStep, 'O' = ingestStep, 'P' = inFlow]).
proof(25, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(6, fact(msg1, inFlow, ingestStep)), uses(20, subproperty_of(inFlow, hasFlowStep))]).
substitution(26, []).
proof(26, subclass_of(localObservation, observation), rule(8), []).
substitution(27, []).
proof(27, subclass_of(temperatureProbe, sensor), rule(9), []).
substitution(28, ['S' = msg1, 'P' = madeBySensor, 'O' = probe7]).
proof(28, solution([msg1, madeBySensor, probe7]), query, [uses(22, fact(msg1, madeBySensor, probe7))]).
substitution(29, ['S' = msg1, 'P' = resultTime, 'O' = "2026-06-17T12:34:56Z"]).
proof(29, solution([msg1, resultTime, "2026-06-17T12:34:56Z"]), query, [uses(23, fact(msg1, resultTime, "2026-06-17T12:34:56Z"))]).
substitution(30, ['S' = msg1, 'P' = hasSimpleResult, 'O' = 18.6]).
proof(30, solution([msg1, hasSimpleResult, 18.6]), query, [uses(24, fact(msg1, hasSimpleResult, 18.6))]).
substitution(31, ['S' = msg1, 'P' = hasFlowStep, 'O' = ingestStep]).
proof(31, solution([msg1, hasFlowStep, ingestStep]), query, [uses(25, fact(msg1, hasFlowStep, ingestStep))]).
substitution(32, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(32, fact(msg1, type_of, observation), rule(15), [uses(15, fact(msg1, type_of, localObservation)), uses(26, subclass_of(localObservation, observation))]).
substitution(33, ['Thing' = probe7, 'Super' = sensor, 'Class' = temperatureProbe]).
proof(33, fact(probe7, type_of, sensor), rule(15), [uses(16, fact(probe7, type_of, temperatureProbe)), uses(27, subclass_of(temperatureProbe, sensor))]).
substitution(34, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(34, fact(msg1, type_of, observation), rule(15), [uses(15, fact(msg1, type_of, localObservation)), uses(26, subclass_of(localObservation, observation))]).
substitution(35, ['Thing' = probe7, 'Super' = sensor, 'Class' = temperatureProbe]).
proof(35, fact(probe7, type_of, sensor), rule(15), [uses(16, fact(probe7, type_of, temperatureProbe)), uses(27, subclass_of(temperatureProbe, sensor))]).
substitution(36, []).
proof(36, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(37, ['S' = msg1, 'P' = type_of, 'O' = observation]).
proof(37, solution([msg1, type_of, observation]), query, [uses(32, fact(msg1, type_of, observation))]).
substitution(38, ['S' = probe7, 'P' = type_of, 'O' = sensor]).
proof(38, solution([probe7, type_of, sensor]), query, [uses(33, fact(probe7, type_of, sensor))]).
substitution(39, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(39, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(21, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(36, fact(msg1, observedFeature, platformB))]).
substitution(40, []).
proof(40, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(41, []).
proof(41, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(42, ['S' = msg1, 'P' = hasFeatureOfInterest, 'O' = platformB]).
proof(42, solution([msg1, hasFeatureOfInterest, platformB]), query, [uses(39, fact(msg1, hasFeatureOfInterest, platformB))]).
substitution(43, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(43, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(41, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(36, fact(msg1, observedFeature, platformB))]).
substitution(44, []).
proof(44, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(45, []).
proof(45, subproperty_of(observedAt, resultTime), rule(11), []).
substitution(46, []).
proof(46, subproperty_of(temperatureCelsius, hasSimpleResult), rule(12), []).
substitution(47, []).
proof(47, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(48, []).
proof(48, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(49, ['SourcePredicate' = observedBy, 'TargetPredicate' = madeBySensor]).
proof(49, runtime_rule(observedBy, copyToTarget), rule(19), [uses(44, subproperty_of(observedBy, madeBySensor))]).
substitution(50, ['SourcePredicate' = observedAt, 'TargetPredicate' = resultTime]).
proof(50, runtime_rule(observedAt, copyToTarget), rule(19), [uses(45, subproperty_of(observedAt, resultTime))]).
substitution(51, ['SourcePredicate' = temperatureCelsius, 'TargetPredicate' = hasSimpleResult]).
proof(51, runtime_rule(temperatureCelsius, copyToTarget), rule(19), [uses(46, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(52, ['SourcePredicate' = inFlow, 'TargetPredicate' = hasFlowStep]).
proof(52, runtime_rule(inFlow, copyToTarget), rule(19), [uses(47, subproperty_of(inFlow, hasFlowStep))]).
substitution(53, ['SourcePredicate' = observedFeature, 'TargetPredicate' = hasFeatureOfInterest]).
proof(53, runtime_rule(observedFeature, copyToTarget), rule(21), [uses(48, equivalent_property(observedFeature, hasFeatureOfInterest))]).
substitution(54, ['P' = observedBy, 'R' = copyToTarget]).
proof(54, solution([observedBy, copyToTarget]), query, [uses(49, runtime_rule(observedBy, copyToTarget))]).
substitution(55, ['P' = observedAt, 'R' = copyToTarget]).
proof(55, solution([observedAt, copyToTarget]), query, [uses(50, runtime_rule(observedAt, copyToTarget))]).
substitution(56, ['P' = temperatureCelsius, 'R' = copyToTarget]).
proof(56, solution([temperatureCelsius, copyToTarget]), query, [uses(51, runtime_rule(temperatureCelsius, copyToTarget))]).
substitution(57, ['P' = inFlow, 'R' = copyToTarget]).
proof(57, solution([inFlow, copyToTarget]), query, [uses(52, runtime_rule(inFlow, copyToTarget))]).
substitution(58, ['P' = observedFeature, 'R' = copyToTarget]).
proof(58, solution([observedFeature, copyToTarget]), query, [uses(53, runtime_rule(observedFeature, copyToTarget))]).
substitution(59, []).
proof(59, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(60, []).
proof(60, subproperty_of(observedAt, resultTime), rule(11), []).
substitution(61, []).
proof(61, subproperty_of(temperatureCelsius, hasSimpleResult), rule(12), []).
substitution(62, []).
proof(62, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(63, []).
proof(63, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(64, ['SourcePredicate' = observedBy, 'TargetPredicate' = madeBySensor]).
proof(64, target_predicate(observedBy, madeBySensor), rule(20), [uses(59, subproperty_of(observedBy, madeBySensor))]).
substitution(65, ['SourcePredicate' = observedAt, 'TargetPredicate' = resultTime]).
proof(65, target_predicate(observedAt, resultTime), rule(20), [uses(60, subproperty_of(observedAt, resultTime))]).
substitution(66, ['SourcePredicate' = temperatureCelsius, 'TargetPredicate' = hasSimpleResult]).
proof(66, target_predicate(temperatureCelsius, hasSimpleResult), rule(20), [uses(61, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(67, ['SourcePredicate' = inFlow, 'TargetPredicate' = hasFlowStep]).
proof(67, target_predicate(inFlow, hasFlowStep), rule(20), [uses(62, subproperty_of(inFlow, hasFlowStep))]).
substitution(68, ['SourcePredicate' = observedFeature, 'TargetPredicate' = hasFeatureOfInterest]).
proof(68, target_predicate(observedFeature, hasFeatureOfInterest), rule(22), [uses(63, equivalent_property(observedFeature, hasFeatureOfInterest))]).
substitution(69, ['P' = observedBy, 'T' = madeBySensor]).
proof(69, solution([observedBy, madeBySensor]), query, [uses(64, target_predicate(observedBy, madeBySensor))]).
substitution(70, ['P' = observedAt, 'T' = resultTime]).
proof(70, solution([observedAt, resultTime]), query, [uses(65, target_predicate(observedAt, resultTime))]).
substitution(71, ['P' = temperatureCelsius, 'T' = hasSimpleResult]).
proof(71, solution([temperatureCelsius, hasSimpleResult]), query, [uses(66, target_predicate(temperatureCelsius, hasSimpleResult))]).
substitution(72, ['P' = inFlow, 'T' = hasFlowStep]).
proof(72, solution([inFlow, hasFlowStep]), query, [uses(67, target_predicate(inFlow, hasFlowStep))]).
substitution(73, ['P' = observedFeature, 'T' = hasFeatureOfInterest]).
proof(73, solution([observedFeature, hasFeatureOfInterest]), query, [uses(68, target_predicate(observedFeature, hasFeatureOfInterest))]).
substitution(74, []).
proof(74, fact(msg1, type_of, localObservation), rule(1), []).
substitution(75, []).
proof(75, fact(probe7, type_of, temperatureProbe), rule(7), []).
substitution(76, []).
proof(76, subclass_of(localObservation, observation), rule(8), []).
substitution(77, []).
proof(77, subclass_of(temperatureProbe, sensor), rule(9), []).
substitution(78, []).
proof(78, fact(msg1, type_of, localObservation), rule(1), []).
substitution(79, []).
proof(79, fact(msg1, observedBy, probe7), rule(2), []).
substitution(80, []).
proof(80, fact(msg1, observedAt, "2026-06-17T12:34:56Z"), rule(3), []).
substitution(81, []).
proof(81, fact(msg1, temperatureCelsius, 18.6), rule(4), []).
substitution(82, []).
proof(82, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(83, []).
proof(83, fact(msg1, inFlow, ingestStep), rule(6), []).
substitution(84, []).
proof(84, fact(probe7, type_of, temperatureProbe), rule(7), []).
substitution(85, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(85, fact(msg1, type_of, observation), rule(15), [uses(74, fact(msg1, type_of, localObservation)), uses(76, subclass_of(localObservation, observation))]).
substitution(86, ['Thing' = probe7, 'Super' = sensor, 'Class' = temperatureProbe]).
proof(86, fact(probe7, type_of, sensor), rule(15), [uses(75, fact(probe7, type_of, temperatureProbe)), uses(77, subclass_of(temperatureProbe, sensor))]).
substitution(87, []).
proof(87, subclass_of(localObservation, observation), rule(8), []).
substitution(88, []).
proof(88, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(89, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(89, fact(msg1, type_of, observation), rule(15), [uses(74, fact(msg1, type_of, localObservation)), uses(76, subclass_of(localObservation, observation))]).
substitution(90, ['Thing' = probe7, 'Super' = sensor, 'Class' = temperatureProbe]).
proof(90, fact(probe7, type_of, sensor), rule(15), [uses(75, fact(probe7, type_of, temperatureProbe)), uses(77, subclass_of(temperatureProbe, sensor))]).
substitution(91, []).
proof(91, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(92, []).
proof(92, subproperty_of(observedAt, resultTime), rule(11), []).
substitution(93, []).
proof(93, subproperty_of(temperatureCelsius, hasSimpleResult), rule(12), []).
substitution(94, []).
proof(94, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(95, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(95, fact(msg1, type_of, observation), rule(15), [uses(74, fact(msg1, type_of, localObservation)), uses(87, subclass_of(localObservation, observation))]).
substitution(96, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(96, fact(msg1, type_of, observation), rule(15), [uses(74, fact(msg1, type_of, localObservation)), uses(87, subclass_of(localObservation, observation))]).
substitution(97, ['S' = msg1, 'SuperP' = madeBySensor, 'O' = probe7, 'P' = observedBy]).
proof(97, fact(msg1, madeBySensor, probe7), rule(16), [uses(79, fact(msg1, observedBy, probe7)), uses(91, subproperty_of(observedBy, madeBySensor))]).
substitution(98, ['S' = msg1, 'SuperP' = resultTime, 'O' = "2026-06-17T12:34:56Z", 'P' = observedAt]).
proof(98, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(80, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(92, subproperty_of(observedAt, resultTime))]).
substitution(99, ['S' = msg1, 'SuperP' = hasSimpleResult, 'O' = 18.6, 'P' = temperatureCelsius]).
proof(99, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(81, fact(msg1, temperatureCelsius, 18.6)), uses(93, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(100, ['S' = msg1, 'SuperP' = hasFlowStep, 'O' = ingestStep, 'P' = inFlow]).
proof(100, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(83, fact(msg1, inFlow, ingestStep)), uses(94, subproperty_of(inFlow, hasFlowStep))]).
substitution(101, []).
proof(101, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(102, []).
proof(102, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(103, []).
proof(103, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(104, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(104, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(88, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(101, fact(msg1, observedFeature, platformB))]).
substitution(105, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(105, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(103, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(101, fact(msg1, observedFeature, platformB))]).
substitution(106, []).
proof(106, fact(msg1, type_of, localObservation), rule(1), []).
substitution(107, []).
proof(107, fact(msg1, observedBy, probe7), rule(2), []).
substitution(108, []).
proof(108, fact(msg1, observedAt, "2026-06-17T12:34:56Z"), rule(3), []).
substitution(109, []).
proof(109, fact(msg1, temperatureCelsius, 18.6), rule(4), []).
substitution(110, []).
proof(110, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(111, []).
proof(111, fact(msg1, inFlow, ingestStep), rule(6), []).
substitution(112, ['S' = msg1, 'SuperP' = madeBySensor, 'O' = probe7, 'P' = observedBy]).
proof(112, fact(msg1, madeBySensor, probe7), rule(16), [uses(107, fact(msg1, observedBy, probe7)), uses(91, subproperty_of(observedBy, madeBySensor))]).
substitution(113, ['S' = msg1, 'SuperP' = resultTime, 'O' = "2026-06-17T12:34:56Z", 'P' = observedAt]).
proof(113, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(108, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(92, subproperty_of(observedAt, resultTime))]).
substitution(114, ['S' = msg1, 'SuperP' = hasSimpleResult, 'O' = 18.6, 'P' = temperatureCelsius]).
proof(114, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(109, fact(msg1, temperatureCelsius, 18.6)), uses(93, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(115, ['S' = msg1, 'SuperP' = hasFlowStep, 'O' = ingestStep, 'P' = inFlow]).
proof(115, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(111, fact(msg1, inFlow, ingestStep)), uses(94, subproperty_of(inFlow, hasFlowStep))]).
substitution(116, []).
proof(116, fact(msg1, type_of, localObservation), rule(1), []).
substitution(117, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(117, fact(msg1, type_of, observation), rule(15), [uses(116, fact(msg1, type_of, localObservation)), uses(76, subclass_of(localObservation, observation))]).
substitution(118, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(118, fact(msg1, type_of, observation), rule(15), [uses(116, fact(msg1, type_of, localObservation)), uses(76, subclass_of(localObservation, observation))]).
substitution(119, []).
proof(119, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(120, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(120, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(103, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(119, fact(msg1, observedFeature, platformB))]).
substitution(121, []).
proof(121, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(122, ['S' = msg1, 'SuperP' = hasFlowStep, 'O' = ingestStep, 'P' = inFlow]).
proof(122, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(111, fact(msg1, inFlow, ingestStep)), uses(121, subproperty_of(inFlow, hasFlowStep))]).
substitution(123, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(123, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(88, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(119, fact(msg1, observedFeature, platformB))]).
substitution(124, []).
proof(124, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(125, ['S' = msg1, 'SuperP' = madeBySensor, 'O' = probe7, 'P' = observedBy]).
proof(125, fact(msg1, madeBySensor, probe7), rule(16), [uses(107, fact(msg1, observedBy, probe7)), uses(124, subproperty_of(observedBy, madeBySensor))]).
substitution(126, ['Step' = ingestStep, 'Message' = msg1, 'Sensor' = probe7]).
proof(126, emits(ingestStep, msg1), rule(23), [uses(96, fact(msg1, type_of, observation)), uses(122, fact(msg1, hasFlowStep, ingestStep)), uses(125, fact(msg1, madeBySensor, probe7))]).
substitution(127, ['Step' = ingestStep, 'Msg' = msg1]).
proof(127, solution([ingestStep, msg1]), query, [uses(126, emits(ingestStep, msg1))]).
substitution(128, []).
proof(128, fact(msg1, type_of, localObservation), rule(1), []).
substitution(129, []).
proof(129, fact(probe7, type_of, temperatureProbe), rule(7), []).
substitution(130, []).
proof(130, subclass_of(localObservation, observation), rule(8), []).
substitution(131, []).
proof(131, subclass_of(temperatureProbe, sensor), rule(9), []).
substitution(132, []).
proof(132, fact(msg1, type_of, localObservation), rule(1), []).
substitution(133, []).
proof(133, fact(msg1, observedBy, probe7), rule(2), []).
substitution(134, []).
proof(134, fact(msg1, observedAt, "2026-06-17T12:34:56Z"), rule(3), []).
substitution(135, []).
proof(135, fact(msg1, temperatureCelsius, 18.6), rule(4), []).
substitution(136, []).
proof(136, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(137, []).
proof(137, fact(msg1, inFlow, ingestStep), rule(6), []).
substitution(138, []).
proof(138, fact(probe7, type_of, temperatureProbe), rule(7), []).
substitution(139, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(139, fact(msg1, type_of, observation), rule(15), [uses(128, fact(msg1, type_of, localObservation)), uses(130, subclass_of(localObservation, observation))]).
substitution(140, ['Thing' = probe7, 'Super' = sensor, 'Class' = temperatureProbe]).
proof(140, fact(probe7, type_of, sensor), rule(15), [uses(129, fact(probe7, type_of, temperatureProbe)), uses(131, subclass_of(temperatureProbe, sensor))]).
substitution(141, []).
proof(141, subclass_of(localObservation, observation), rule(8), []).
substitution(142, []).
proof(142, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(143, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(143, fact(msg1, type_of, observation), rule(15), [uses(128, fact(msg1, type_of, localObservation)), uses(130, subclass_of(localObservation, observation))]).
substitution(144, ['Thing' = probe7, 'Super' = sensor, 'Class' = temperatureProbe]).
proof(144, fact(probe7, type_of, sensor), rule(15), [uses(129, fact(probe7, type_of, temperatureProbe)), uses(131, subclass_of(temperatureProbe, sensor))]).
substitution(145, []).
proof(145, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(146, []).
proof(146, subproperty_of(observedAt, resultTime), rule(11), []).
substitution(147, []).
proof(147, subproperty_of(temperatureCelsius, hasSimpleResult), rule(12), []).
substitution(148, []).
proof(148, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(149, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(149, fact(msg1, type_of, observation), rule(15), [uses(128, fact(msg1, type_of, localObservation)), uses(141, subclass_of(localObservation, observation))]).
substitution(150, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(150, fact(msg1, type_of, observation), rule(15), [uses(128, fact(msg1, type_of, localObservation)), uses(141, subclass_of(localObservation, observation))]).
substitution(151, ['S' = msg1, 'SuperP' = madeBySensor, 'O' = probe7, 'P' = observedBy]).
proof(151, fact(msg1, madeBySensor, probe7), rule(16), [uses(133, fact(msg1, observedBy, probe7)), uses(145, subproperty_of(observedBy, madeBySensor))]).
substitution(152, ['S' = msg1, 'SuperP' = resultTime, 'O' = "2026-06-17T12:34:56Z", 'P' = observedAt]).
proof(152, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(134, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(146, subproperty_of(observedAt, resultTime))]).
substitution(153, ['S' = msg1, 'SuperP' = hasSimpleResult, 'O' = 18.6, 'P' = temperatureCelsius]).
proof(153, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(135, fact(msg1, temperatureCelsius, 18.6)), uses(147, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(154, ['S' = msg1, 'SuperP' = hasFlowStep, 'O' = ingestStep, 'P' = inFlow]).
proof(154, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(137, fact(msg1, inFlow, ingestStep)), uses(148, subproperty_of(inFlow, hasFlowStep))]).
substitution(155, []).
proof(155, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(156, []).
proof(156, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(157, []).
proof(157, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(158, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(158, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(142, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(155, fact(msg1, observedFeature, platformB))]).
substitution(159, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(159, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(157, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(155, fact(msg1, observedFeature, platformB))]).
substitution(160, []).
proof(160, fact(msg1, type_of, localObservation), rule(1), []).
substitution(161, []).
proof(161, fact(msg1, observedBy, probe7), rule(2), []).
substitution(162, []).
proof(162, fact(msg1, observedAt, "2026-06-17T12:34:56Z"), rule(3), []).
substitution(163, []).
proof(163, fact(msg1, temperatureCelsius, 18.6), rule(4), []).
substitution(164, []).
proof(164, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(165, []).
proof(165, fact(msg1, inFlow, ingestStep), rule(6), []).
substitution(166, ['S' = msg1, 'SuperP' = madeBySensor, 'O' = probe7, 'P' = observedBy]).
proof(166, fact(msg1, madeBySensor, probe7), rule(16), [uses(161, fact(msg1, observedBy, probe7)), uses(145, subproperty_of(observedBy, madeBySensor))]).
substitution(167, ['S' = msg1, 'SuperP' = resultTime, 'O' = "2026-06-17T12:34:56Z", 'P' = observedAt]).
proof(167, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(162, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(146, subproperty_of(observedAt, resultTime))]).
substitution(168, ['S' = msg1, 'SuperP' = hasSimpleResult, 'O' = 18.6, 'P' = temperatureCelsius]).
proof(168, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(163, fact(msg1, temperatureCelsius, 18.6)), uses(147, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(169, ['S' = msg1, 'SuperP' = hasFlowStep, 'O' = ingestStep, 'P' = inFlow]).
proof(169, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(165, fact(msg1, inFlow, ingestStep)), uses(148, subproperty_of(inFlow, hasFlowStep))]).
substitution(170, []).
proof(170, fact(msg1, type_of, localObservation), rule(1), []).
substitution(171, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(171, fact(msg1, type_of, observation), rule(15), [uses(170, fact(msg1, type_of, localObservation)), uses(130, subclass_of(localObservation, observation))]).
substitution(172, ['Thing' = msg1, 'Super' = observation, 'Class' = localObservation]).
proof(172, fact(msg1, type_of, observation), rule(15), [uses(170, fact(msg1, type_of, localObservation)), uses(130, subclass_of(localObservation, observation))]).
substitution(173, []).
proof(173, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(174, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(174, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(157, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(173, fact(msg1, observedFeature, platformB))]).
substitution(175, []).
proof(175, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(176, ['S' = msg1, 'SuperP' = hasFlowStep, 'O' = ingestStep, 'P' = inFlow]).
proof(176, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(165, fact(msg1, inFlow, ingestStep)), uses(175, subproperty_of(inFlow, hasFlowStep))]).
substitution(177, ['S' = msg1, 'Q' = hasFeatureOfInterest, 'O' = platformB, 'P' = observedFeature]).
proof(177, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(142, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(173, fact(msg1, observedFeature, platformB))]).
substitution(178, []).
proof(178, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(179, ['S' = msg1, 'SuperP' = madeBySensor, 'O' = probe7, 'P' = observedBy]).
proof(179, fact(msg1, madeBySensor, probe7), rule(16), [uses(161, fact(msg1, observedBy, probe7)), uses(178, subproperty_of(observedBy, madeBySensor))]).
substitution(180, ['Step' = ingestStep, 'Sensor' = probe7, 'Message' = msg1]).
proof(180, trusted_by(ingestStep, probe7), rule(24), [uses(150, fact(msg1, type_of, observation)), uses(176, fact(msg1, hasFlowStep, ingestStep)), uses(179, fact(msg1, madeBySensor, probe7))]).
substitution(181, ['Step' = ingestStep, 'Sensor' = probe7]).
proof(181, solution([ingestStep, probe7]), query, [uses(180, trusted_by(ingestStep, probe7))]).
