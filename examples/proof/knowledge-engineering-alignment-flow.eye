# Eyelang result format 2
query(1, [call(fact(?v0, ?v1, ?v2))], [binding("s", ?v0), binding("p", ?v1), binding("o", ?v2)]).
result(1, complete, 14).
answer(1, [binding("s", msg1), binding("p", type_of), binding("o", localObservation)]).
why(1, [binding("s", msg1), binding("p", type_of), binding("o", localObservation)], 8).
answer(1, [binding("s", msg1), binding("p", observedBy), binding("o", probe7)]).
why(1, [binding("s", msg1), binding("p", observedBy), binding("o", probe7)], 9).
answer(1, [binding("s", msg1), binding("p", observedAt), binding("o", "2026-06-17T12:34:56Z")]).
why(1, [binding("s", msg1), binding("p", observedAt), binding("o", "2026-06-17T12:34:56Z")], 10).
answer(1, [binding("s", msg1), binding("p", temperatureCelsius), binding("o", 18.6)]).
why(1, [binding("s", msg1), binding("p", temperatureCelsius), binding("o", 18.6)], 11).
answer(1, [binding("s", msg1), binding("p", observedFeature), binding("o", platformB)]).
why(1, [binding("s", msg1), binding("p", observedFeature), binding("o", platformB)], 12).
answer(1, [binding("s", msg1), binding("p", inFlow), binding("o", ingestStep)]).
why(1, [binding("s", msg1), binding("p", inFlow), binding("o", ingestStep)], 13).
answer(1, [binding("s", probe7), binding("p", type_of), binding("o", temperatureProbe)]).
why(1, [binding("s", probe7), binding("p", type_of), binding("o", temperatureProbe)], 14).
answer(1, [binding("s", msg1), binding("p", madeBySensor), binding("o", probe7)]).
why(1, [binding("s", msg1), binding("p", madeBySensor), binding("o", probe7)], 28).
answer(1, [binding("s", msg1), binding("p", resultTime), binding("o", "2026-06-17T12:34:56Z")]).
why(1, [binding("s", msg1), binding("p", resultTime), binding("o", "2026-06-17T12:34:56Z")], 29).
answer(1, [binding("s", msg1), binding("p", hasSimpleResult), binding("o", 18.6)]).
why(1, [binding("s", msg1), binding("p", hasSimpleResult), binding("o", 18.6)], 30).
answer(1, [binding("s", msg1), binding("p", hasFlowStep), binding("o", ingestStep)]).
why(1, [binding("s", msg1), binding("p", hasFlowStep), binding("o", ingestStep)], 31).
answer(1, [binding("s", msg1), binding("p", type_of), binding("o", observation)]).
why(1, [binding("s", msg1), binding("p", type_of), binding("o", observation)], 37).
answer(1, [binding("s", probe7), binding("p", type_of), binding("o", sensor)]).
why(1, [binding("s", probe7), binding("p", type_of), binding("o", sensor)], 38).
answer(1, [binding("s", msg1), binding("p", hasFeatureOfInterest), binding("o", platformB)]).
why(1, [binding("s", msg1), binding("p", hasFeatureOfInterest), binding("o", platformB)], 42).
query(2, [call(runtime_rule(?v0, ?v1))], [binding("p", ?v0), binding("r", ?v1)]).
result(2, complete, 5).
answer(2, [binding("p", observedBy), binding("r", copyToTarget)]).
why(2, [binding("p", observedBy), binding("r", copyToTarget)], 54).
answer(2, [binding("p", observedAt), binding("r", copyToTarget)]).
why(2, [binding("p", observedAt), binding("r", copyToTarget)], 55).
answer(2, [binding("p", temperatureCelsius), binding("r", copyToTarget)]).
why(2, [binding("p", temperatureCelsius), binding("r", copyToTarget)], 56).
answer(2, [binding("p", inFlow), binding("r", copyToTarget)]).
why(2, [binding("p", inFlow), binding("r", copyToTarget)], 57).
answer(2, [binding("p", observedFeature), binding("r", copyToTarget)]).
why(2, [binding("p", observedFeature), binding("r", copyToTarget)], 58).
query(3, [call(target_predicate(?v0, ?v1))], [binding("p", ?v0), binding("t", ?v1)]).
result(3, complete, 5).
answer(3, [binding("p", observedBy), binding("t", madeBySensor)]).
why(3, [binding("p", observedBy), binding("t", madeBySensor)], 69).
answer(3, [binding("p", observedAt), binding("t", resultTime)]).
why(3, [binding("p", observedAt), binding("t", resultTime)], 70).
answer(3, [binding("p", temperatureCelsius), binding("t", hasSimpleResult)]).
why(3, [binding("p", temperatureCelsius), binding("t", hasSimpleResult)], 71).
answer(3, [binding("p", inFlow), binding("t", hasFlowStep)]).
why(3, [binding("p", inFlow), binding("t", hasFlowStep)], 72).
answer(3, [binding("p", observedFeature), binding("t", hasFeatureOfInterest)]).
why(3, [binding("p", observedFeature), binding("t", hasFeatureOfInterest)], 73).
query(4, [call(emits(?v0, ?v1))], [binding("step", ?v0), binding("msg", ?v1)]).
result(4, complete, 1).
answer(4, [binding("step", ingestStep), binding("msg", msg1)]).
why(4, [binding("step", ingestStep), binding("msg", msg1)], 127).
query(5, [call(trusted_by(?v0, ?v1))], [binding("step", ?v0), binding("sensor", ?v1)]).
result(5, complete, 1).
answer(5, [binding("step", ingestStep), binding("sensor", probe7)]).
why(5, [binding("step", ingestStep), binding("sensor", probe7)], 181).
clause(1, fact(msg1, type_of, localObservation), []).
clause(2, fact(msg1, observedBy, probe7), []).
clause(3, fact(msg1, observedAt, "2026-06-17T12:34:56Z"), []).
clause(4, fact(msg1, temperatureCelsius, 18.6), []).
clause(5, fact(msg1, observedFeature, platformB), []).
clause(6, fact(msg1, inFlow, ingestStep), []).
clause(7, fact(probe7, type_of, temperatureProbe), []).
clause(8, subclass_of(localObservation, observation), []).
clause(9, subclass_of(temperatureProbe, sensor), []).
clause(10, subproperty_of(observedBy, madeBySensor), []).
clause(11, subproperty_of(observedAt, resultTime), []).
clause(12, subproperty_of(temperatureCelsius, hasSimpleResult), []).
clause(13, equivalent_property(observedFeature, hasFeatureOfInterest), []).
clause(14, subproperty_of(inFlow, hasFlowStep), []).
clause(15, fact(var("thing"), type_of, var("super")), [call(fact(var("thing"), type_of, var("class"))), call(subclass_of(var("class"), var("super")))]).
clause(16, fact(var("s"), var("superP"), var("o")), [call(fact(var("s"), var("p"), var("o"))), call(subproperty_of(var("p"), var("superP")))]).
clause(17, fact(var("s"), var("q"), var("o")), [call(equivalent_property(var("p"), var("q"))), call(fact(var("s"), var("p"), var("o")))]).
clause(19, runtime_rule(var("sourcePredicate"), copyToTarget), [call(subproperty_of(var("sourcePredicate"), var("targetPredicate")))]).
clause(20, target_predicate(var("sourcePredicate"), var("targetPredicate")), [call(subproperty_of(var("sourcePredicate"), var("targetPredicate")))]).
clause(21, runtime_rule(var("sourcePredicate"), copyToTarget), [call(equivalent_property(var("sourcePredicate"), var("targetPredicate")))]).
clause(22, target_predicate(var("sourcePredicate"), var("targetPredicate")), [call(equivalent_property(var("sourcePredicate"), var("targetPredicate")))]).
clause(23, emits(var("step"), var("message")), [call(fact(var("message"), type_of, observation)), call(fact(var("message"), hasFlowStep, var("step"))), call(fact(var("message"), madeBySensor, var("sensor")))]).
clause(24, trusted_by(var("step"), var("sensor")), [call(fact(var("message"), type_of, observation)), call(fact(var("message"), hasFlowStep, var("step"))), call(fact(var("message"), madeBySensor, var("sensor")))]).
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
substitution(8, [binding("s", msg1), binding("p", type_of), binding("o", localObservation)]).
proof(8, solution([msg1, type_of, localObservation]), query, [uses(1, fact(msg1, type_of, localObservation))]).
substitution(9, [binding("s", msg1), binding("p", observedBy), binding("o", probe7)]).
proof(9, solution([msg1, observedBy, probe7]), query, [uses(2, fact(msg1, observedBy, probe7))]).
substitution(10, [binding("s", msg1), binding("p", observedAt), binding("o", "2026-06-17T12:34:56Z")]).
proof(10, solution([msg1, observedAt, "2026-06-17T12:34:56Z"]), query, [uses(3, fact(msg1, observedAt, "2026-06-17T12:34:56Z"))]).
substitution(11, [binding("s", msg1), binding("p", temperatureCelsius), binding("o", 18.6)]).
proof(11, solution([msg1, temperatureCelsius, 18.6]), query, [uses(4, fact(msg1, temperatureCelsius, 18.6))]).
substitution(12, [binding("s", msg1), binding("p", observedFeature), binding("o", platformB)]).
proof(12, solution([msg1, observedFeature, platformB]), query, [uses(5, fact(msg1, observedFeature, platformB))]).
substitution(13, [binding("s", msg1), binding("p", inFlow), binding("o", ingestStep)]).
proof(13, solution([msg1, inFlow, ingestStep]), query, [uses(6, fact(msg1, inFlow, ingestStep))]).
substitution(14, [binding("s", probe7), binding("p", type_of), binding("o", temperatureProbe)]).
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
substitution(22, [binding("s", msg1), binding("superP", madeBySensor), binding("o", probe7), binding("p", observedBy)]).
proof(22, fact(msg1, madeBySensor, probe7), rule(16), [uses(2, fact(msg1, observedBy, probe7)), uses(17, subproperty_of(observedBy, madeBySensor))]).
substitution(23, [binding("s", msg1), binding("superP", resultTime), binding("o", "2026-06-17T12:34:56Z"), binding("p", observedAt)]).
proof(23, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(3, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(18, subproperty_of(observedAt, resultTime))]).
substitution(24, [binding("s", msg1), binding("superP", hasSimpleResult), binding("o", 18.6), binding("p", temperatureCelsius)]).
proof(24, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(4, fact(msg1, temperatureCelsius, 18.6)), uses(19, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(25, [binding("s", msg1), binding("superP", hasFlowStep), binding("o", ingestStep), binding("p", inFlow)]).
proof(25, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(6, fact(msg1, inFlow, ingestStep)), uses(20, subproperty_of(inFlow, hasFlowStep))]).
substitution(26, []).
proof(26, subclass_of(localObservation, observation), rule(8), []).
substitution(27, []).
proof(27, subclass_of(temperatureProbe, sensor), rule(9), []).
substitution(28, [binding("s", msg1), binding("p", madeBySensor), binding("o", probe7)]).
proof(28, solution([msg1, madeBySensor, probe7]), query, [uses(22, fact(msg1, madeBySensor, probe7))]).
substitution(29, [binding("s", msg1), binding("p", resultTime), binding("o", "2026-06-17T12:34:56Z")]).
proof(29, solution([msg1, resultTime, "2026-06-17T12:34:56Z"]), query, [uses(23, fact(msg1, resultTime, "2026-06-17T12:34:56Z"))]).
substitution(30, [binding("s", msg1), binding("p", hasSimpleResult), binding("o", 18.6)]).
proof(30, solution([msg1, hasSimpleResult, 18.6]), query, [uses(24, fact(msg1, hasSimpleResult, 18.6))]).
substitution(31, [binding("s", msg1), binding("p", hasFlowStep), binding("o", ingestStep)]).
proof(31, solution([msg1, hasFlowStep, ingestStep]), query, [uses(25, fact(msg1, hasFlowStep, ingestStep))]).
substitution(32, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(32, fact(msg1, type_of, observation), rule(15), [uses(15, fact(msg1, type_of, localObservation)), uses(26, subclass_of(localObservation, observation))]).
substitution(33, [binding("thing", probe7), binding("super", sensor), binding("class", temperatureProbe)]).
proof(33, fact(probe7, type_of, sensor), rule(15), [uses(16, fact(probe7, type_of, temperatureProbe)), uses(27, subclass_of(temperatureProbe, sensor))]).
substitution(34, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(34, fact(msg1, type_of, observation), rule(15), [uses(15, fact(msg1, type_of, localObservation)), uses(26, subclass_of(localObservation, observation))]).
substitution(35, [binding("thing", probe7), binding("super", sensor), binding("class", temperatureProbe)]).
proof(35, fact(probe7, type_of, sensor), rule(15), [uses(16, fact(probe7, type_of, temperatureProbe)), uses(27, subclass_of(temperatureProbe, sensor))]).
substitution(36, []).
proof(36, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(37, [binding("s", msg1), binding("p", type_of), binding("o", observation)]).
proof(37, solution([msg1, type_of, observation]), query, [uses(32, fact(msg1, type_of, observation))]).
substitution(38, [binding("s", probe7), binding("p", type_of), binding("o", sensor)]).
proof(38, solution([probe7, type_of, sensor]), query, [uses(33, fact(probe7, type_of, sensor))]).
substitution(39, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
proof(39, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(21, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(36, fact(msg1, observedFeature, platformB))]).
substitution(40, []).
proof(40, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(41, []).
proof(41, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(42, [binding("s", msg1), binding("p", hasFeatureOfInterest), binding("o", platformB)]).
proof(42, solution([msg1, hasFeatureOfInterest, platformB]), query, [uses(39, fact(msg1, hasFeatureOfInterest, platformB))]).
substitution(43, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
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
substitution(49, [binding("sourcePredicate", observedBy), binding("targetPredicate", madeBySensor)]).
proof(49, runtime_rule(observedBy, copyToTarget), rule(19), [uses(44, subproperty_of(observedBy, madeBySensor))]).
substitution(50, [binding("sourcePredicate", observedAt), binding("targetPredicate", resultTime)]).
proof(50, runtime_rule(observedAt, copyToTarget), rule(19), [uses(45, subproperty_of(observedAt, resultTime))]).
substitution(51, [binding("sourcePredicate", temperatureCelsius), binding("targetPredicate", hasSimpleResult)]).
proof(51, runtime_rule(temperatureCelsius, copyToTarget), rule(19), [uses(46, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(52, [binding("sourcePredicate", inFlow), binding("targetPredicate", hasFlowStep)]).
proof(52, runtime_rule(inFlow, copyToTarget), rule(19), [uses(47, subproperty_of(inFlow, hasFlowStep))]).
substitution(53, [binding("sourcePredicate", observedFeature), binding("targetPredicate", hasFeatureOfInterest)]).
proof(53, runtime_rule(observedFeature, copyToTarget), rule(21), [uses(48, equivalent_property(observedFeature, hasFeatureOfInterest))]).
substitution(54, [binding("p", observedBy), binding("r", copyToTarget)]).
proof(54, solution([observedBy, copyToTarget]), query, [uses(49, runtime_rule(observedBy, copyToTarget))]).
substitution(55, [binding("p", observedAt), binding("r", copyToTarget)]).
proof(55, solution([observedAt, copyToTarget]), query, [uses(50, runtime_rule(observedAt, copyToTarget))]).
substitution(56, [binding("p", temperatureCelsius), binding("r", copyToTarget)]).
proof(56, solution([temperatureCelsius, copyToTarget]), query, [uses(51, runtime_rule(temperatureCelsius, copyToTarget))]).
substitution(57, [binding("p", inFlow), binding("r", copyToTarget)]).
proof(57, solution([inFlow, copyToTarget]), query, [uses(52, runtime_rule(inFlow, copyToTarget))]).
substitution(58, [binding("p", observedFeature), binding("r", copyToTarget)]).
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
substitution(64, [binding("sourcePredicate", observedBy), binding("targetPredicate", madeBySensor)]).
proof(64, target_predicate(observedBy, madeBySensor), rule(20), [uses(59, subproperty_of(observedBy, madeBySensor))]).
substitution(65, [binding("sourcePredicate", observedAt), binding("targetPredicate", resultTime)]).
proof(65, target_predicate(observedAt, resultTime), rule(20), [uses(60, subproperty_of(observedAt, resultTime))]).
substitution(66, [binding("sourcePredicate", temperatureCelsius), binding("targetPredicate", hasSimpleResult)]).
proof(66, target_predicate(temperatureCelsius, hasSimpleResult), rule(20), [uses(61, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(67, [binding("sourcePredicate", inFlow), binding("targetPredicate", hasFlowStep)]).
proof(67, target_predicate(inFlow, hasFlowStep), rule(20), [uses(62, subproperty_of(inFlow, hasFlowStep))]).
substitution(68, [binding("sourcePredicate", observedFeature), binding("targetPredicate", hasFeatureOfInterest)]).
proof(68, target_predicate(observedFeature, hasFeatureOfInterest), rule(22), [uses(63, equivalent_property(observedFeature, hasFeatureOfInterest))]).
substitution(69, [binding("p", observedBy), binding("t", madeBySensor)]).
proof(69, solution([observedBy, madeBySensor]), query, [uses(64, target_predicate(observedBy, madeBySensor))]).
substitution(70, [binding("p", observedAt), binding("t", resultTime)]).
proof(70, solution([observedAt, resultTime]), query, [uses(65, target_predicate(observedAt, resultTime))]).
substitution(71, [binding("p", temperatureCelsius), binding("t", hasSimpleResult)]).
proof(71, solution([temperatureCelsius, hasSimpleResult]), query, [uses(66, target_predicate(temperatureCelsius, hasSimpleResult))]).
substitution(72, [binding("p", inFlow), binding("t", hasFlowStep)]).
proof(72, solution([inFlow, hasFlowStep]), query, [uses(67, target_predicate(inFlow, hasFlowStep))]).
substitution(73, [binding("p", observedFeature), binding("t", hasFeatureOfInterest)]).
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
substitution(85, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(85, fact(msg1, type_of, observation), rule(15), [uses(74, fact(msg1, type_of, localObservation)), uses(76, subclass_of(localObservation, observation))]).
substitution(86, [binding("thing", probe7), binding("super", sensor), binding("class", temperatureProbe)]).
proof(86, fact(probe7, type_of, sensor), rule(15), [uses(75, fact(probe7, type_of, temperatureProbe)), uses(77, subclass_of(temperatureProbe, sensor))]).
substitution(87, []).
proof(87, subclass_of(localObservation, observation), rule(8), []).
substitution(88, []).
proof(88, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(89, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(89, fact(msg1, type_of, observation), rule(15), [uses(74, fact(msg1, type_of, localObservation)), uses(76, subclass_of(localObservation, observation))]).
substitution(90, [binding("thing", probe7), binding("super", sensor), binding("class", temperatureProbe)]).
proof(90, fact(probe7, type_of, sensor), rule(15), [uses(75, fact(probe7, type_of, temperatureProbe)), uses(77, subclass_of(temperatureProbe, sensor))]).
substitution(91, []).
proof(91, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(92, []).
proof(92, subproperty_of(observedAt, resultTime), rule(11), []).
substitution(93, []).
proof(93, subproperty_of(temperatureCelsius, hasSimpleResult), rule(12), []).
substitution(94, []).
proof(94, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(95, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(95, fact(msg1, type_of, observation), rule(15), [uses(74, fact(msg1, type_of, localObservation)), uses(87, subclass_of(localObservation, observation))]).
substitution(96, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(96, fact(msg1, type_of, observation), rule(15), [uses(74, fact(msg1, type_of, localObservation)), uses(87, subclass_of(localObservation, observation))]).
substitution(97, [binding("s", msg1), binding("superP", madeBySensor), binding("o", probe7), binding("p", observedBy)]).
proof(97, fact(msg1, madeBySensor, probe7), rule(16), [uses(79, fact(msg1, observedBy, probe7)), uses(91, subproperty_of(observedBy, madeBySensor))]).
substitution(98, [binding("s", msg1), binding("superP", resultTime), binding("o", "2026-06-17T12:34:56Z"), binding("p", observedAt)]).
proof(98, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(80, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(92, subproperty_of(observedAt, resultTime))]).
substitution(99, [binding("s", msg1), binding("superP", hasSimpleResult), binding("o", 18.6), binding("p", temperatureCelsius)]).
proof(99, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(81, fact(msg1, temperatureCelsius, 18.6)), uses(93, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(100, [binding("s", msg1), binding("superP", hasFlowStep), binding("o", ingestStep), binding("p", inFlow)]).
proof(100, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(83, fact(msg1, inFlow, ingestStep)), uses(94, subproperty_of(inFlow, hasFlowStep))]).
substitution(101, []).
proof(101, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(102, []).
proof(102, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(103, []).
proof(103, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(104, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
proof(104, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(88, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(101, fact(msg1, observedFeature, platformB))]).
substitution(105, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
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
substitution(112, [binding("s", msg1), binding("superP", madeBySensor), binding("o", probe7), binding("p", observedBy)]).
proof(112, fact(msg1, madeBySensor, probe7), rule(16), [uses(107, fact(msg1, observedBy, probe7)), uses(91, subproperty_of(observedBy, madeBySensor))]).
substitution(113, [binding("s", msg1), binding("superP", resultTime), binding("o", "2026-06-17T12:34:56Z"), binding("p", observedAt)]).
proof(113, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(108, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(92, subproperty_of(observedAt, resultTime))]).
substitution(114, [binding("s", msg1), binding("superP", hasSimpleResult), binding("o", 18.6), binding("p", temperatureCelsius)]).
proof(114, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(109, fact(msg1, temperatureCelsius, 18.6)), uses(93, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(115, [binding("s", msg1), binding("superP", hasFlowStep), binding("o", ingestStep), binding("p", inFlow)]).
proof(115, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(111, fact(msg1, inFlow, ingestStep)), uses(94, subproperty_of(inFlow, hasFlowStep))]).
substitution(116, []).
proof(116, fact(msg1, type_of, localObservation), rule(1), []).
substitution(117, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(117, fact(msg1, type_of, observation), rule(15), [uses(116, fact(msg1, type_of, localObservation)), uses(76, subclass_of(localObservation, observation))]).
substitution(118, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(118, fact(msg1, type_of, observation), rule(15), [uses(116, fact(msg1, type_of, localObservation)), uses(76, subclass_of(localObservation, observation))]).
substitution(119, []).
proof(119, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(120, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
proof(120, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(103, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(119, fact(msg1, observedFeature, platformB))]).
substitution(121, []).
proof(121, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(122, [binding("s", msg1), binding("superP", hasFlowStep), binding("o", ingestStep), binding("p", inFlow)]).
proof(122, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(111, fact(msg1, inFlow, ingestStep)), uses(121, subproperty_of(inFlow, hasFlowStep))]).
substitution(123, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
proof(123, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(88, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(119, fact(msg1, observedFeature, platformB))]).
substitution(124, []).
proof(124, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(125, [binding("s", msg1), binding("superP", madeBySensor), binding("o", probe7), binding("p", observedBy)]).
proof(125, fact(msg1, madeBySensor, probe7), rule(16), [uses(107, fact(msg1, observedBy, probe7)), uses(124, subproperty_of(observedBy, madeBySensor))]).
substitution(126, [binding("step", ingestStep), binding("message", msg1), binding("sensor", probe7)]).
proof(126, emits(ingestStep, msg1), rule(23), [uses(96, fact(msg1, type_of, observation)), uses(122, fact(msg1, hasFlowStep, ingestStep)), uses(125, fact(msg1, madeBySensor, probe7))]).
substitution(127, [binding("step", ingestStep), binding("msg", msg1)]).
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
substitution(139, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(139, fact(msg1, type_of, observation), rule(15), [uses(128, fact(msg1, type_of, localObservation)), uses(130, subclass_of(localObservation, observation))]).
substitution(140, [binding("thing", probe7), binding("super", sensor), binding("class", temperatureProbe)]).
proof(140, fact(probe7, type_of, sensor), rule(15), [uses(129, fact(probe7, type_of, temperatureProbe)), uses(131, subclass_of(temperatureProbe, sensor))]).
substitution(141, []).
proof(141, subclass_of(localObservation, observation), rule(8), []).
substitution(142, []).
proof(142, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(143, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(143, fact(msg1, type_of, observation), rule(15), [uses(128, fact(msg1, type_of, localObservation)), uses(130, subclass_of(localObservation, observation))]).
substitution(144, [binding("thing", probe7), binding("super", sensor), binding("class", temperatureProbe)]).
proof(144, fact(probe7, type_of, sensor), rule(15), [uses(129, fact(probe7, type_of, temperatureProbe)), uses(131, subclass_of(temperatureProbe, sensor))]).
substitution(145, []).
proof(145, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(146, []).
proof(146, subproperty_of(observedAt, resultTime), rule(11), []).
substitution(147, []).
proof(147, subproperty_of(temperatureCelsius, hasSimpleResult), rule(12), []).
substitution(148, []).
proof(148, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(149, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(149, fact(msg1, type_of, observation), rule(15), [uses(128, fact(msg1, type_of, localObservation)), uses(141, subclass_of(localObservation, observation))]).
substitution(150, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(150, fact(msg1, type_of, observation), rule(15), [uses(128, fact(msg1, type_of, localObservation)), uses(141, subclass_of(localObservation, observation))]).
substitution(151, [binding("s", msg1), binding("superP", madeBySensor), binding("o", probe7), binding("p", observedBy)]).
proof(151, fact(msg1, madeBySensor, probe7), rule(16), [uses(133, fact(msg1, observedBy, probe7)), uses(145, subproperty_of(observedBy, madeBySensor))]).
substitution(152, [binding("s", msg1), binding("superP", resultTime), binding("o", "2026-06-17T12:34:56Z"), binding("p", observedAt)]).
proof(152, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(134, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(146, subproperty_of(observedAt, resultTime))]).
substitution(153, [binding("s", msg1), binding("superP", hasSimpleResult), binding("o", 18.6), binding("p", temperatureCelsius)]).
proof(153, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(135, fact(msg1, temperatureCelsius, 18.6)), uses(147, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(154, [binding("s", msg1), binding("superP", hasFlowStep), binding("o", ingestStep), binding("p", inFlow)]).
proof(154, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(137, fact(msg1, inFlow, ingestStep)), uses(148, subproperty_of(inFlow, hasFlowStep))]).
substitution(155, []).
proof(155, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(156, []).
proof(156, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(157, []).
proof(157, equivalent_property(observedFeature, hasFeatureOfInterest), rule(13), []).
substitution(158, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
proof(158, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(142, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(155, fact(msg1, observedFeature, platformB))]).
substitution(159, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
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
substitution(166, [binding("s", msg1), binding("superP", madeBySensor), binding("o", probe7), binding("p", observedBy)]).
proof(166, fact(msg1, madeBySensor, probe7), rule(16), [uses(161, fact(msg1, observedBy, probe7)), uses(145, subproperty_of(observedBy, madeBySensor))]).
substitution(167, [binding("s", msg1), binding("superP", resultTime), binding("o", "2026-06-17T12:34:56Z"), binding("p", observedAt)]).
proof(167, fact(msg1, resultTime, "2026-06-17T12:34:56Z"), rule(16), [uses(162, fact(msg1, observedAt, "2026-06-17T12:34:56Z")), uses(146, subproperty_of(observedAt, resultTime))]).
substitution(168, [binding("s", msg1), binding("superP", hasSimpleResult), binding("o", 18.6), binding("p", temperatureCelsius)]).
proof(168, fact(msg1, hasSimpleResult, 18.6), rule(16), [uses(163, fact(msg1, temperatureCelsius, 18.6)), uses(147, subproperty_of(temperatureCelsius, hasSimpleResult))]).
substitution(169, [binding("s", msg1), binding("superP", hasFlowStep), binding("o", ingestStep), binding("p", inFlow)]).
proof(169, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(165, fact(msg1, inFlow, ingestStep)), uses(148, subproperty_of(inFlow, hasFlowStep))]).
substitution(170, []).
proof(170, fact(msg1, type_of, localObservation), rule(1), []).
substitution(171, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(171, fact(msg1, type_of, observation), rule(15), [uses(170, fact(msg1, type_of, localObservation)), uses(130, subclass_of(localObservation, observation))]).
substitution(172, [binding("thing", msg1), binding("super", observation), binding("class", localObservation)]).
proof(172, fact(msg1, type_of, observation), rule(15), [uses(170, fact(msg1, type_of, localObservation)), uses(130, subclass_of(localObservation, observation))]).
substitution(173, []).
proof(173, fact(msg1, observedFeature, platformB), rule(5), []).
substitution(174, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
proof(174, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(157, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(173, fact(msg1, observedFeature, platformB))]).
substitution(175, []).
proof(175, subproperty_of(inFlow, hasFlowStep), rule(14), []).
substitution(176, [binding("s", msg1), binding("superP", hasFlowStep), binding("o", ingestStep), binding("p", inFlow)]).
proof(176, fact(msg1, hasFlowStep, ingestStep), rule(16), [uses(165, fact(msg1, inFlow, ingestStep)), uses(175, subproperty_of(inFlow, hasFlowStep))]).
substitution(177, [binding("s", msg1), binding("q", hasFeatureOfInterest), binding("o", platformB), binding("p", observedFeature)]).
proof(177, fact(msg1, hasFeatureOfInterest, platformB), rule(17), [uses(142, equivalent_property(observedFeature, hasFeatureOfInterest)), uses(173, fact(msg1, observedFeature, platformB))]).
substitution(178, []).
proof(178, subproperty_of(observedBy, madeBySensor), rule(10), []).
substitution(179, [binding("s", msg1), binding("superP", madeBySensor), binding("o", probe7), binding("p", observedBy)]).
proof(179, fact(msg1, madeBySensor, probe7), rule(16), [uses(161, fact(msg1, observedBy, probe7)), uses(178, subproperty_of(observedBy, madeBySensor))]).
substitution(180, [binding("step", ingestStep), binding("sensor", probe7), binding("message", msg1)]).
proof(180, trusted_by(ingestStep, probe7), rule(24), [uses(150, fact(msg1, type_of, observation)), uses(176, fact(msg1, hasFlowStep, ingestStep)), uses(179, fact(msg1, madeBySensor, probe7))]).
substitution(181, [binding("step", ingestStep), binding("sensor", probe7)]).
proof(181, solution([ingestStep, probe7]), query, [uses(180, trusted_by(ingestStep, probe7))]).
