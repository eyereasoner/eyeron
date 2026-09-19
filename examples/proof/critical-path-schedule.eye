# Eyelang result format 2
query(1, [call(project_finish(?v0))], [binding("finish", ?v0)]).
result(1, complete, 1).
answer(1, [binding("finish", 23)]).
why(1, [binding("finish", 23)], 301).
query(2, [call(critical_task(?v0))], [binding("task", ?v0)]).
result(2, complete, 7).
answer(2, [binding("task", launch)]).
why(2, [binding("task", launch)], 627).
answer(2, [binding("task", security_review)]).
why(2, [binding("task", security_review)], 633).
answer(2, [binding("task", integration)]).
why(2, [binding("task", integration)], 641).
answer(2, [binding("task", backend)]).
why(2, [binding("task", backend)], 650).
answer(2, [binding("task", database)]).
why(2, [binding("task", database)], 657).
answer(2, [binding("task", architecture)]).
why(2, [binding("task", architecture)], 662).
answer(2, [binding("task", requirements)]).
why(2, [binding("task", requirements)], 665).
query(3, [call(schedule(?v0, ?v1, ?v2))], [binding("task", ?v0), binding("start", ?v1), binding("finish", ?v2)]).
result(3, complete, 11).
answer(3, [binding("task", requirements), binding("start", 0), binding("finish", 2)]).
why(3, [binding("task", requirements), binding("start", 0), binding("finish", 2)], 943).
answer(3, [binding("task", architecture), binding("start", 2), binding("finish", 5)]).
why(3, [binding("task", architecture), binding("start", 2), binding("finish", 5)], 944).
answer(3, [binding("task", api_design), binding("start", 2), binding("finish", 4)]).
why(3, [binding("task", api_design), binding("start", 2), binding("finish", 4)], 945).
answer(3, [binding("task", database), binding("start", 5), binding("finish", 9)]).
why(3, [binding("task", database), binding("start", 5), binding("finish", 9)], 946).
answer(3, [binding("task", backend), binding("start", 9), binding("finish", 15)]).
why(3, [binding("task", backend), binding("start", 9), binding("finish", 15)], 947).
answer(3, [binding("task", frontend), binding("start", 4), binding("finish", 9)]).
why(3, [binding("task", frontend), binding("start", 4), binding("finish", 9)], 948).
answer(3, [binding("task", auth), binding("start", 5), binding("finish", 8)]).
why(3, [binding("task", auth), binding("start", 5), binding("finish", 8)], 949).
answer(3, [binding("task", integration), binding("start", 15), binding("finish", 19)]).
why(3, [binding("task", integration), binding("start", 15), binding("finish", 19)], 950).
answer(3, [binding("task", security_review), binding("start", 19), binding("finish", 22)]).
why(3, [binding("task", security_review), binding("start", 19), binding("finish", 22)], 951).
answer(3, [binding("task", load_test), binding("start", 19), binding("finish", 21)]).
why(3, [binding("task", load_test), binding("start", 19), binding("finish", 21)], 952).
answer(3, [binding("task", launch), binding("start", 22), binding("finish", 23)]).
why(3, [binding("task", launch), binding("start", 22), binding("finish", 23)], 953).
clause(1, task(requirements, 2), []).
clause(2, task(architecture, 3), []).
clause(3, task(api_design, 2), []).
clause(4, task(database, 4), []).
clause(5, task(backend, 6), []).
clause(6, task(frontend, 5), []).
clause(7, task(auth, 3), []).
clause(8, task(integration, 4), []).
clause(9, task(security_review, 3), []).
clause(10, task(load_test, 2), []).
clause(11, task(launch, 1), []).
clause(12, depends(architecture, requirements), []).
clause(13, depends(api_design, requirements), []).
clause(14, depends(database, architecture), []).
clause(15, depends(backend, api_design), []).
clause(16, depends(backend, database), []).
clause(17, depends(frontend, api_design), []).
clause(18, depends(auth, architecture), []).
clause(19, depends(integration, backend), []).
clause(20, depends(integration, frontend), []).
clause(21, depends(integration, auth), []).
clause(22, depends(security_review, integration), []).
clause(23, depends(load_test, integration), []).
clause(24, depends(launch, security_review), []).
clause(25, depends(launch, load_test), []).
clause(26, has_predecessor(var("task")), [call(depends(var("task"), anonymous(1)))]).
clause(27, duration_path(var("task"), [var("task")], var("duration")), [call(task(var("task"), var("duration"))), absent(has_predecessor(var("task")))]).
clause(28, duration_path(var("task"), [var("task") | var("path")], var("finish")), [call(task(var("task"), var("duration"))), call(depends(var("task"), var("predecessor"))), call(duration_path(var("predecessor"), var("path"), var("previous"))), calculate(var("finish"), binary("+", value(var("previous")), value(var("duration"))))]).
clause(29, finish_time(var("task"), var("finish")), [call(task(var("task"), anonymous(1))), collect(var("finishes"), var("candidate"), [call(duration_path(var("task"), anonymous(2), var("candidate")))]), calculate(var("finish"), function("max", [value(var("finishes"))]))]).
clause(30, schedule(var("task"), var("start"), var("finish")), [call(task(var("task"), var("duration"))), call(finish_time(var("task"), var("finish"))), calculate(var("start"), binary("-", value(var("finish")), value(var("duration"))))]).
clause(31, project_finish(var("finish")), [collect(var("finishes"), var("candidate"), [call(finish_time(anonymous(1), var("candidate")))]), calculate(var("finish"), function("max", [value(var("finishes"))]))]).
clause(32, member(var("x"), [var("x") | anonymous(1)]), []).
clause(33, member(var("x"), [anonymous(1) | var("rest")]), [call(member(var("x"), var("rest")))]).
clause(34, critical_task(var("task")), [call(project_finish(var("finish"))), call(duration_path(anonymous(1), var("path"), var("finish"))), call(member(var("task"), var("path")))]).
substitution(1, []).
proof(1, task(requirements, 2), rule(1), []).
substitution(2, []).
proof(2, task(architecture, 3), rule(2), []).
substitution(3, []).
proof(3, task(api_design, 2), rule(3), []).
substitution(4, []).
proof(4, task(database, 4), rule(4), []).
substitution(5, []).
proof(5, task(backend, 6), rule(5), []).
substitution(6, []).
proof(6, task(frontend, 5), rule(6), []).
substitution(7, []).
proof(7, task(auth, 3), rule(7), []).
substitution(8, []).
proof(8, task(integration, 4), rule(8), []).
substitution(9, []).
proof(9, task(security_review, 3), rule(9), []).
substitution(10, []).
proof(10, task(load_test, 2), rule(10), []).
substitution(11, []).
proof(11, task(launch, 1), rule(11), []).
substitution(12, []).
proof(12, task(requirements, 2), rule(1), []).
substitution(13, [binding("task", requirements), binding("duration", 2)]).
proof(13, duration_path(requirements, [requirements], 2), rule(27), [uses(12, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(14, [binding("candidate", 2)]).
proof(14, solution([2]), query, [uses(13, duration_path(requirements, [requirements], 2))]).
substitution(15, [binding("task", requirements), binding("finish", 2), binding("finishes", [2]), binding("candidate", ?v0)]).
proof(15, finish_time(requirements, 2), rule(29), [uses(1, task(requirements, 2)), collected([2], ?v0, [call(duration_path(requirements, ?v1, ?v0))], [14], complete), calculated(2, function("max", [value([2])]))]).
substitution(16, []).
proof(16, task(architecture, 3), rule(2), []).
substitution(17, []).
proof(17, depends(architecture, requirements), rule(12), []).
substitution(18, [binding("task", architecture)]).
proof(18, has_predecessor(architecture), rule(26), [uses(17, depends(architecture, requirements))]).
substitution(19, []).
proof(19, solution([]), query, [uses(18, has_predecessor(architecture))]).
substitution(20, []).
proof(20, depends(architecture, requirements), rule(12), []).
substitution(21, []).
proof(21, task(requirements, 2), rule(1), []).
substitution(22, [binding("task", requirements), binding("duration", 2)]).
proof(22, duration_path(requirements, [requirements], 2), rule(27), [uses(21, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(23, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(23, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(16, task(architecture, 3)), uses(20, depends(architecture, requirements)), uses(22, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(24, [binding("candidate", 5)]).
proof(24, solution([5]), query, [uses(23, duration_path(architecture, [architecture, requirements], 5))]).
substitution(25, [binding("task", architecture), binding("finish", 5), binding("finishes", [5]), binding("candidate", ?v0)]).
proof(25, finish_time(architecture, 5), rule(29), [uses(2, task(architecture, 3)), collected([5], ?v0, [call(duration_path(architecture, ?v1, ?v0))], [24], complete), calculated(5, function("max", [value([5])]))]).
substitution(26, []).
proof(26, task(api_design, 2), rule(3), []).
substitution(27, []).
proof(27, depends(api_design, requirements), rule(13), []).
substitution(28, [binding("task", api_design)]).
proof(28, has_predecessor(api_design), rule(26), [uses(27, depends(api_design, requirements))]).
substitution(29, []).
proof(29, solution([]), query, [uses(28, has_predecessor(api_design))]).
substitution(30, []).
proof(30, depends(api_design, requirements), rule(13), []).
substitution(31, []).
proof(31, task(requirements, 2), rule(1), []).
substitution(32, [binding("task", requirements), binding("duration", 2)]).
proof(32, duration_path(requirements, [requirements], 2), rule(27), [uses(31, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(33, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(33, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(26, task(api_design, 2)), uses(30, depends(api_design, requirements)), uses(32, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(34, [binding("candidate", 4)]).
proof(34, solution([4]), query, [uses(33, duration_path(api_design, [api_design, requirements], 4))]).
substitution(35, [binding("task", api_design), binding("finish", 4), binding("finishes", [4]), binding("candidate", ?v0)]).
proof(35, finish_time(api_design, 4), rule(29), [uses(3, task(api_design, 2)), collected([4], ?v0, [call(duration_path(api_design, ?v1, ?v0))], [34], complete), calculated(4, function("max", [value([4])]))]).
substitution(36, []).
proof(36, task(database, 4), rule(4), []).
substitution(37, []).
proof(37, depends(database, architecture), rule(14), []).
substitution(38, [binding("task", database)]).
proof(38, has_predecessor(database), rule(26), [uses(37, depends(database, architecture))]).
substitution(39, []).
proof(39, solution([]), query, [uses(38, has_predecessor(database))]).
substitution(40, []).
proof(40, depends(database, architecture), rule(14), []).
substitution(41, []).
proof(41, task(architecture, 3), rule(2), []).
substitution(42, []).
proof(42, depends(architecture, requirements), rule(12), []).
substitution(43, []).
proof(43, task(requirements, 2), rule(1), []).
substitution(44, [binding("task", requirements), binding("duration", 2)]).
proof(44, duration_path(requirements, [requirements], 2), rule(27), [uses(43, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(45, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(45, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(41, task(architecture, 3)), uses(42, depends(architecture, requirements)), uses(44, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(46, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(46, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(36, task(database, 4)), uses(40, depends(database, architecture)), uses(45, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(47, [binding("candidate", 9)]).
proof(47, solution([9]), query, [uses(46, duration_path(database, [database, architecture, requirements], 9))]).
substitution(48, [binding("task", database), binding("finish", 9), binding("finishes", [9]), binding("candidate", ?v0)]).
proof(48, finish_time(database, 9), rule(29), [uses(4, task(database, 4)), collected([9], ?v0, [call(duration_path(database, ?v1, ?v0))], [47], complete), calculated(9, function("max", [value([9])]))]).
substitution(49, []).
proof(49, task(backend, 6), rule(5), []).
substitution(50, []).
proof(50, depends(backend, api_design), rule(15), []).
substitution(51, []).
proof(51, depends(backend, database), rule(16), []).
substitution(52, [binding("task", backend)]).
proof(52, has_predecessor(backend), rule(26), [uses(50, depends(backend, api_design))]).
substitution(53, []).
proof(53, solution([]), query, [uses(52, has_predecessor(backend))]).
substitution(54, []).
proof(54, depends(backend, api_design), rule(15), []).
substitution(55, []).
proof(55, depends(backend, database), rule(16), []).
substitution(56, []).
proof(56, task(api_design, 2), rule(3), []).
substitution(57, []).
proof(57, task(database, 4), rule(4), []).
substitution(58, []).
proof(58, depends(api_design, requirements), rule(13), []).
substitution(59, []).
proof(59, depends(database, architecture), rule(14), []).
substitution(60, []).
proof(60, task(requirements, 2), rule(1), []).
substitution(61, []).
proof(61, task(architecture, 3), rule(2), []).
substitution(62, [binding("task", requirements), binding("duration", 2)]).
proof(62, duration_path(requirements, [requirements], 2), rule(27), [uses(60, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(63, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(63, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(56, task(api_design, 2)), uses(58, depends(api_design, requirements)), uses(62, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(64, []).
proof(64, depends(architecture, requirements), rule(12), []).
substitution(65, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(65, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(49, task(backend, 6)), uses(54, depends(backend, api_design)), uses(63, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(66, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(66, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(61, task(architecture, 3)), uses(64, depends(architecture, requirements)), uses(62, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(67, [binding("candidate", 10)]).
proof(67, solution([10]), query, [uses(65, duration_path(backend, [backend, api_design, requirements], 10))]).
substitution(68, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(68, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(57, task(database, 4)), uses(59, depends(database, architecture)), uses(66, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(69, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(69, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(49, task(backend, 6)), uses(55, depends(backend, database)), uses(68, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(70, [binding("candidate", 15)]).
proof(70, solution([15]), query, [uses(69, duration_path(backend, [backend, database, architecture, requirements], 15))]).
substitution(71, [binding("task", backend), binding("finish", 15), binding("finishes", [10, 15]), binding("candidate", ?v0)]).
proof(71, finish_time(backend, 15), rule(29), [uses(5, task(backend, 6)), collected([10, 15], ?v0, [call(duration_path(backend, ?v1, ?v0))], [67, 70], complete), calculated(15, function("max", [value([10, 15])]))]).
substitution(72, []).
proof(72, task(frontend, 5), rule(6), []).
substitution(73, []).
proof(73, depends(frontend, api_design), rule(17), []).
substitution(74, [binding("task", frontend)]).
proof(74, has_predecessor(frontend), rule(26), [uses(73, depends(frontend, api_design))]).
substitution(75, []).
proof(75, solution([]), query, [uses(74, has_predecessor(frontend))]).
substitution(76, []).
proof(76, depends(frontend, api_design), rule(17), []).
substitution(77, []).
proof(77, task(api_design, 2), rule(3), []).
substitution(78, []).
proof(78, depends(api_design, requirements), rule(13), []).
substitution(79, []).
proof(79, task(requirements, 2), rule(1), []).
substitution(80, [binding("task", requirements), binding("duration", 2)]).
proof(80, duration_path(requirements, [requirements], 2), rule(27), [uses(79, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(81, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(81, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(77, task(api_design, 2)), uses(78, depends(api_design, requirements)), uses(80, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(82, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(82, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(72, task(frontend, 5)), uses(76, depends(frontend, api_design)), uses(81, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(83, [binding("candidate", 9)]).
proof(83, solution([9]), query, [uses(82, duration_path(frontend, [frontend, api_design, requirements], 9))]).
substitution(84, [binding("task", frontend), binding("finish", 9), binding("finishes", [9]), binding("candidate", ?v0)]).
proof(84, finish_time(frontend, 9), rule(29), [uses(6, task(frontend, 5)), collected([9], ?v0, [call(duration_path(frontend, ?v1, ?v0))], [83], complete), calculated(9, function("max", [value([9])]))]).
substitution(85, []).
proof(85, task(auth, 3), rule(7), []).
substitution(86, []).
proof(86, depends(auth, architecture), rule(18), []).
substitution(87, [binding("task", auth)]).
proof(87, has_predecessor(auth), rule(26), [uses(86, depends(auth, architecture))]).
substitution(88, []).
proof(88, solution([]), query, [uses(87, has_predecessor(auth))]).
substitution(89, []).
proof(89, depends(auth, architecture), rule(18), []).
substitution(90, []).
proof(90, task(architecture, 3), rule(2), []).
substitution(91, []).
proof(91, depends(architecture, requirements), rule(12), []).
substitution(92, []).
proof(92, task(requirements, 2), rule(1), []).
substitution(93, [binding("task", requirements), binding("duration", 2)]).
proof(93, duration_path(requirements, [requirements], 2), rule(27), [uses(92, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(94, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(94, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(90, task(architecture, 3)), uses(91, depends(architecture, requirements)), uses(93, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(95, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(95, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(85, task(auth, 3)), uses(89, depends(auth, architecture)), uses(94, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(96, [binding("candidate", 8)]).
proof(96, solution([8]), query, [uses(95, duration_path(auth, [auth, architecture, requirements], 8))]).
substitution(97, [binding("task", auth), binding("finish", 8), binding("finishes", [8]), binding("candidate", ?v0)]).
proof(97, finish_time(auth, 8), rule(29), [uses(7, task(auth, 3)), collected([8], ?v0, [call(duration_path(auth, ?v1, ?v0))], [96], complete), calculated(8, function("max", [value([8])]))]).
substitution(98, []).
proof(98, task(integration, 4), rule(8), []).
substitution(99, []).
proof(99, depends(integration, backend), rule(19), []).
substitution(100, []).
proof(100, depends(integration, frontend), rule(20), []).
substitution(101, []).
proof(101, depends(integration, auth), rule(21), []).
substitution(102, [binding("task", integration)]).
proof(102, has_predecessor(integration), rule(26), [uses(99, depends(integration, backend))]).
substitution(103, []).
proof(103, solution([]), query, [uses(102, has_predecessor(integration))]).
substitution(104, []).
proof(104, depends(integration, backend), rule(19), []).
substitution(105, []).
proof(105, depends(integration, frontend), rule(20), []).
substitution(106, []).
proof(106, depends(integration, auth), rule(21), []).
substitution(107, []).
proof(107, task(backend, 6), rule(5), []).
substitution(108, []).
proof(108, task(frontend, 5), rule(6), []).
substitution(109, []).
proof(109, task(auth, 3), rule(7), []).
substitution(110, []).
proof(110, depends(backend, api_design), rule(15), []).
substitution(111, []).
proof(111, depends(backend, database), rule(16), []).
substitution(112, []).
proof(112, depends(frontend, api_design), rule(17), []).
substitution(113, []).
proof(113, depends(auth, architecture), rule(18), []).
substitution(114, []).
proof(114, task(api_design, 2), rule(3), []).
substitution(115, []).
proof(115, task(database, 4), rule(4), []).
substitution(116, []).
proof(116, task(architecture, 3), rule(2), []).
substitution(117, []).
proof(117, depends(api_design, requirements), rule(13), []).
substitution(118, []).
proof(118, depends(database, architecture), rule(14), []).
substitution(119, []).
proof(119, depends(architecture, requirements), rule(12), []).
substitution(120, []).
proof(120, task(requirements, 2), rule(1), []).
substitution(121, [binding("task", requirements), binding("duration", 2)]).
proof(121, duration_path(requirements, [requirements], 2), rule(27), [uses(120, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(122, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(122, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(114, task(api_design, 2)), uses(117, depends(api_design, requirements)), uses(121, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(123, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(123, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(116, task(architecture, 3)), uses(119, depends(architecture, requirements)), uses(121, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(124, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(124, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(107, task(backend, 6)), uses(110, depends(backend, api_design)), uses(122, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(125, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(125, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(108, task(frontend, 5)), uses(112, depends(frontend, api_design)), uses(122, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(126, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(126, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(109, task(auth, 3)), uses(113, depends(auth, architecture)), uses(123, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(127, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(127, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(115, task(database, 4)), uses(118, depends(database, architecture)), uses(123, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(128, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(128, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(98, task(integration, 4)), uses(104, depends(integration, backend)), uses(124, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(129, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(129, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(98, task(integration, 4)), uses(105, depends(integration, frontend)), uses(125, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(130, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(130, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(98, task(integration, 4)), uses(106, depends(integration, auth)), uses(126, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(131, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(131, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(107, task(backend, 6)), uses(111, depends(backend, database)), uses(127, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(132, [binding("candidate", 14)]).
proof(132, solution([14]), query, [uses(128, duration_path(integration, [integration, backend, api_design, requirements], 14))]).
substitution(133, [binding("candidate", 13)]).
proof(133, solution([13]), query, [uses(129, duration_path(integration, [integration, frontend, api_design, requirements], 13))]).
substitution(134, [binding("candidate", 12)]).
proof(134, solution([12]), query, [uses(130, duration_path(integration, [integration, auth, architecture, requirements], 12))]).
substitution(135, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(135, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(98, task(integration, 4)), uses(104, depends(integration, backend)), uses(131, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(136, [binding("candidate", 19)]).
proof(136, solution([19]), query, [uses(135, duration_path(integration, [integration, backend, database, architecture, requirements], 19))]).
substitution(137, [binding("task", integration), binding("finish", 19), binding("finishes", [12, 13, 14, 19]), binding("candidate", ?v0)]).
proof(137, finish_time(integration, 19), rule(29), [uses(8, task(integration, 4)), collected([12, 13, 14, 19], ?v0, [call(duration_path(integration, ?v1, ?v0))], [132, 133, 134, 136], complete), calculated(19, function("max", [value([12, 13, 14, 19])]))]).
substitution(138, []).
proof(138, task(security_review, 3), rule(9), []).
substitution(139, []).
proof(139, depends(security_review, integration), rule(22), []).
substitution(140, [binding("task", security_review)]).
proof(140, has_predecessor(security_review), rule(26), [uses(139, depends(security_review, integration))]).
substitution(141, []).
proof(141, solution([]), query, [uses(140, has_predecessor(security_review))]).
substitution(142, []).
proof(142, depends(security_review, integration), rule(22), []).
substitution(143, []).
proof(143, task(integration, 4), rule(8), []).
substitution(144, []).
proof(144, depends(integration, backend), rule(19), []).
substitution(145, []).
proof(145, depends(integration, frontend), rule(20), []).
substitution(146, []).
proof(146, depends(integration, auth), rule(21), []).
substitution(147, []).
proof(147, task(backend, 6), rule(5), []).
substitution(148, []).
proof(148, task(frontend, 5), rule(6), []).
substitution(149, []).
proof(149, task(auth, 3), rule(7), []).
substitution(150, []).
proof(150, depends(backend, api_design), rule(15), []).
substitution(151, []).
proof(151, depends(backend, database), rule(16), []).
substitution(152, []).
proof(152, depends(frontend, api_design), rule(17), []).
substitution(153, []).
proof(153, depends(auth, architecture), rule(18), []).
substitution(154, []).
proof(154, task(api_design, 2), rule(3), []).
substitution(155, []).
proof(155, task(database, 4), rule(4), []).
substitution(156, []).
proof(156, task(architecture, 3), rule(2), []).
substitution(157, []).
proof(157, depends(api_design, requirements), rule(13), []).
substitution(158, []).
proof(158, depends(database, architecture), rule(14), []).
substitution(159, []).
proof(159, depends(architecture, requirements), rule(12), []).
substitution(160, []).
proof(160, task(requirements, 2), rule(1), []).
substitution(161, [binding("task", requirements), binding("duration", 2)]).
proof(161, duration_path(requirements, [requirements], 2), rule(27), [uses(160, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(162, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(162, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(154, task(api_design, 2)), uses(157, depends(api_design, requirements)), uses(161, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(163, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(163, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(156, task(architecture, 3)), uses(159, depends(architecture, requirements)), uses(161, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(164, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(164, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(147, task(backend, 6)), uses(150, depends(backend, api_design)), uses(162, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(165, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(165, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(148, task(frontend, 5)), uses(152, depends(frontend, api_design)), uses(162, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(166, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(166, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(149, task(auth, 3)), uses(153, depends(auth, architecture)), uses(163, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(167, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(167, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(155, task(database, 4)), uses(158, depends(database, architecture)), uses(163, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(168, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(168, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(143, task(integration, 4)), uses(144, depends(integration, backend)), uses(164, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(169, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(169, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(143, task(integration, 4)), uses(145, depends(integration, frontend)), uses(165, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(170, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(170, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(143, task(integration, 4)), uses(146, depends(integration, auth)), uses(166, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(171, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(171, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(147, task(backend, 6)), uses(151, depends(backend, database)), uses(167, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(172, [binding("task", security_review), binding("path", [integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 3), binding("predecessor", integration), binding("previous", 14)]).
proof(172, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17), rule(28), [uses(138, task(security_review, 3)), uses(142, depends(security_review, integration)), uses(168, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(17, binary("+", value(14), value(3)))]).
substitution(173, [binding("task", security_review), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 3), binding("predecessor", integration), binding("previous", 13)]).
proof(173, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16), rule(28), [uses(138, task(security_review, 3)), uses(142, depends(security_review, integration)), uses(169, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(16, binary("+", value(13), value(3)))]).
substitution(174, [binding("task", security_review), binding("path", [integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 3), binding("predecessor", integration), binding("previous", 12)]).
proof(174, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15), rule(28), [uses(138, task(security_review, 3)), uses(142, depends(security_review, integration)), uses(170, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(15, binary("+", value(12), value(3)))]).
substitution(175, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(175, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(143, task(integration, 4)), uses(144, depends(integration, backend)), uses(171, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(176, [binding("candidate", 17)]).
proof(176, solution([17]), query, [uses(172, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17))]).
substitution(177, [binding("candidate", 16)]).
proof(177, solution([16]), query, [uses(173, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16))]).
substitution(178, [binding("candidate", 15)]).
proof(178, solution([15]), query, [uses(174, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15))]).
substitution(179, [binding("task", security_review), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 3), binding("predecessor", integration), binding("previous", 19)]).
proof(179, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22), rule(28), [uses(138, task(security_review, 3)), uses(142, depends(security_review, integration)), uses(175, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(22, binary("+", value(19), value(3)))]).
substitution(180, [binding("candidate", 22)]).
proof(180, solution([22]), query, [uses(179, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22))]).
substitution(181, [binding("task", security_review), binding("finish", 22), binding("finishes", [15, 16, 17, 22]), binding("candidate", ?v0)]).
proof(181, finish_time(security_review, 22), rule(29), [uses(9, task(security_review, 3)), collected([15, 16, 17, 22], ?v0, [call(duration_path(security_review, ?v1, ?v0))], [176, 177, 178, 180], complete), calculated(22, function("max", [value([15, 16, 17, 22])]))]).
substitution(182, []).
proof(182, task(load_test, 2), rule(10), []).
substitution(183, []).
proof(183, depends(load_test, integration), rule(23), []).
substitution(184, [binding("task", load_test)]).
proof(184, has_predecessor(load_test), rule(26), [uses(183, depends(load_test, integration))]).
substitution(185, []).
proof(185, solution([]), query, [uses(184, has_predecessor(load_test))]).
substitution(186, []).
proof(186, depends(load_test, integration), rule(23), []).
substitution(187, []).
proof(187, task(integration, 4), rule(8), []).
substitution(188, []).
proof(188, depends(integration, backend), rule(19), []).
substitution(189, []).
proof(189, depends(integration, frontend), rule(20), []).
substitution(190, []).
proof(190, depends(integration, auth), rule(21), []).
substitution(191, []).
proof(191, task(backend, 6), rule(5), []).
substitution(192, []).
proof(192, task(frontend, 5), rule(6), []).
substitution(193, []).
proof(193, task(auth, 3), rule(7), []).
substitution(194, []).
proof(194, depends(backend, api_design), rule(15), []).
substitution(195, []).
proof(195, depends(backend, database), rule(16), []).
substitution(196, []).
proof(196, depends(frontend, api_design), rule(17), []).
substitution(197, []).
proof(197, depends(auth, architecture), rule(18), []).
substitution(198, []).
proof(198, task(api_design, 2), rule(3), []).
substitution(199, []).
proof(199, task(database, 4), rule(4), []).
substitution(200, []).
proof(200, task(architecture, 3), rule(2), []).
substitution(201, []).
proof(201, depends(api_design, requirements), rule(13), []).
substitution(202, []).
proof(202, depends(database, architecture), rule(14), []).
substitution(203, []).
proof(203, depends(architecture, requirements), rule(12), []).
substitution(204, []).
proof(204, task(requirements, 2), rule(1), []).
substitution(205, [binding("task", requirements), binding("duration", 2)]).
proof(205, duration_path(requirements, [requirements], 2), rule(27), [uses(204, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(206, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(206, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(198, task(api_design, 2)), uses(201, depends(api_design, requirements)), uses(205, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(207, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(207, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(200, task(architecture, 3)), uses(203, depends(architecture, requirements)), uses(205, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(208, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(208, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(191, task(backend, 6)), uses(194, depends(backend, api_design)), uses(206, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(209, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(209, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(192, task(frontend, 5)), uses(196, depends(frontend, api_design)), uses(206, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(210, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(210, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(193, task(auth, 3)), uses(197, depends(auth, architecture)), uses(207, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(211, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(211, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(199, task(database, 4)), uses(202, depends(database, architecture)), uses(207, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(212, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(212, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(187, task(integration, 4)), uses(188, depends(integration, backend)), uses(208, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(213, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(213, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(187, task(integration, 4)), uses(189, depends(integration, frontend)), uses(209, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(214, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(214, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(187, task(integration, 4)), uses(190, depends(integration, auth)), uses(210, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(215, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(215, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(191, task(backend, 6)), uses(195, depends(backend, database)), uses(211, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(216, [binding("task", load_test), binding("path", [integration, backend, api_design, requirements]), binding("finish", 16), binding("duration", 2), binding("predecessor", integration), binding("previous", 14)]).
proof(216, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16), rule(28), [uses(182, task(load_test, 2)), uses(186, depends(load_test, integration)), uses(212, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(16, binary("+", value(14), value(2)))]).
substitution(217, [binding("task", load_test), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 15), binding("duration", 2), binding("predecessor", integration), binding("previous", 13)]).
proof(217, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15), rule(28), [uses(182, task(load_test, 2)), uses(186, depends(load_test, integration)), uses(213, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(15, binary("+", value(13), value(2)))]).
substitution(218, [binding("task", load_test), binding("path", [integration, auth, architecture, requirements]), binding("finish", 14), binding("duration", 2), binding("predecessor", integration), binding("previous", 12)]).
proof(218, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14), rule(28), [uses(182, task(load_test, 2)), uses(186, depends(load_test, integration)), uses(214, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(14, binary("+", value(12), value(2)))]).
substitution(219, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(219, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(187, task(integration, 4)), uses(188, depends(integration, backend)), uses(215, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(220, [binding("candidate", 16)]).
proof(220, solution([16]), query, [uses(216, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16))]).
substitution(221, [binding("candidate", 15)]).
proof(221, solution([15]), query, [uses(217, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15))]).
substitution(222, [binding("candidate", 14)]).
proof(222, solution([14]), query, [uses(218, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14))]).
substitution(223, [binding("task", load_test), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 21), binding("duration", 2), binding("predecessor", integration), binding("previous", 19)]).
proof(223, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21), rule(28), [uses(182, task(load_test, 2)), uses(186, depends(load_test, integration)), uses(219, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(21, binary("+", value(19), value(2)))]).
substitution(224, [binding("candidate", 21)]).
proof(224, solution([21]), query, [uses(223, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21))]).
substitution(225, [binding("task", load_test), binding("finish", 21), binding("finishes", [14, 15, 16, 21]), binding("candidate", ?v0)]).
proof(225, finish_time(load_test, 21), rule(29), [uses(10, task(load_test, 2)), collected([14, 15, 16, 21], ?v0, [call(duration_path(load_test, ?v1, ?v0))], [220, 221, 222, 224], complete), calculated(21, function("max", [value([14, 15, 16, 21])]))]).
substitution(226, []).
proof(226, task(launch, 1), rule(11), []).
substitution(227, []).
proof(227, depends(launch, security_review), rule(24), []).
substitution(228, []).
proof(228, depends(launch, load_test), rule(25), []).
substitution(229, [binding("task", launch)]).
proof(229, has_predecessor(launch), rule(26), [uses(227, depends(launch, security_review))]).
substitution(230, []).
proof(230, solution([]), query, [uses(229, has_predecessor(launch))]).
substitution(231, []).
proof(231, depends(launch, security_review), rule(24), []).
substitution(232, []).
proof(232, depends(launch, load_test), rule(25), []).
substitution(233, []).
proof(233, task(security_review, 3), rule(9), []).
substitution(234, []).
proof(234, task(load_test, 2), rule(10), []).
substitution(235, []).
proof(235, depends(security_review, integration), rule(22), []).
substitution(236, []).
proof(236, depends(load_test, integration), rule(23), []).
substitution(237, []).
proof(237, task(integration, 4), rule(8), []).
substitution(238, []).
proof(238, depends(integration, backend), rule(19), []).
substitution(239, []).
proof(239, depends(integration, frontend), rule(20), []).
substitution(240, []).
proof(240, depends(integration, auth), rule(21), []).
substitution(241, []).
proof(241, task(backend, 6), rule(5), []).
substitution(242, []).
proof(242, task(frontend, 5), rule(6), []).
substitution(243, []).
proof(243, task(auth, 3), rule(7), []).
substitution(244, []).
proof(244, depends(backend, api_design), rule(15), []).
substitution(245, []).
proof(245, depends(backend, database), rule(16), []).
substitution(246, []).
proof(246, depends(frontend, api_design), rule(17), []).
substitution(247, []).
proof(247, depends(auth, architecture), rule(18), []).
substitution(248, []).
proof(248, task(api_design, 2), rule(3), []).
substitution(249, []).
proof(249, task(database, 4), rule(4), []).
substitution(250, []).
proof(250, task(architecture, 3), rule(2), []).
substitution(251, []).
proof(251, depends(api_design, requirements), rule(13), []).
substitution(252, []).
proof(252, depends(database, architecture), rule(14), []).
substitution(253, []).
proof(253, depends(architecture, requirements), rule(12), []).
substitution(254, []).
proof(254, task(requirements, 2), rule(1), []).
substitution(255, [binding("task", requirements), binding("duration", 2)]).
proof(255, duration_path(requirements, [requirements], 2), rule(27), [uses(254, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(256, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(256, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(248, task(api_design, 2)), uses(251, depends(api_design, requirements)), uses(255, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(257, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(257, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(250, task(architecture, 3)), uses(253, depends(architecture, requirements)), uses(255, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(258, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(258, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(241, task(backend, 6)), uses(244, depends(backend, api_design)), uses(256, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(259, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(259, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(242, task(frontend, 5)), uses(246, depends(frontend, api_design)), uses(256, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(260, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(260, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(243, task(auth, 3)), uses(247, depends(auth, architecture)), uses(257, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(261, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(261, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(249, task(database, 4)), uses(252, depends(database, architecture)), uses(257, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(262, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(262, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(237, task(integration, 4)), uses(238, depends(integration, backend)), uses(258, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(263, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(263, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(237, task(integration, 4)), uses(239, depends(integration, frontend)), uses(259, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(264, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(264, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(237, task(integration, 4)), uses(240, depends(integration, auth)), uses(260, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(265, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(265, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(241, task(backend, 6)), uses(245, depends(backend, database)), uses(261, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(266, [binding("task", security_review), binding("path", [integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 3), binding("predecessor", integration), binding("previous", 14)]).
proof(266, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17), rule(28), [uses(233, task(security_review, 3)), uses(235, depends(security_review, integration)), uses(262, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(17, binary("+", value(14), value(3)))]).
substitution(267, [binding("task", security_review), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 3), binding("predecessor", integration), binding("previous", 13)]).
proof(267, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16), rule(28), [uses(233, task(security_review, 3)), uses(235, depends(security_review, integration)), uses(263, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(16, binary("+", value(13), value(3)))]).
substitution(268, [binding("task", security_review), binding("path", [integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 3), binding("predecessor", integration), binding("previous", 12)]).
proof(268, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15), rule(28), [uses(233, task(security_review, 3)), uses(235, depends(security_review, integration)), uses(264, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(15, binary("+", value(12), value(3)))]).
substitution(269, [binding("task", load_test), binding("path", [integration, backend, api_design, requirements]), binding("finish", 16), binding("duration", 2), binding("predecessor", integration), binding("previous", 14)]).
proof(269, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16), rule(28), [uses(234, task(load_test, 2)), uses(236, depends(load_test, integration)), uses(262, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(16, binary("+", value(14), value(2)))]).
substitution(270, [binding("task", load_test), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 15), binding("duration", 2), binding("predecessor", integration), binding("previous", 13)]).
proof(270, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15), rule(28), [uses(234, task(load_test, 2)), uses(236, depends(load_test, integration)), uses(263, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(15, binary("+", value(13), value(2)))]).
substitution(271, [binding("task", load_test), binding("path", [integration, auth, architecture, requirements]), binding("finish", 14), binding("duration", 2), binding("predecessor", integration), binding("previous", 12)]).
proof(271, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14), rule(28), [uses(234, task(load_test, 2)), uses(236, depends(load_test, integration)), uses(264, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(14, binary("+", value(12), value(2)))]).
substitution(272, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(272, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(237, task(integration, 4)), uses(238, depends(integration, backend)), uses(265, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(273, [binding("task", launch), binding("path", [security_review, integration, backend, api_design, requirements]), binding("finish", 18), binding("duration", 1), binding("predecessor", security_review), binding("previous", 17)]).
proof(273, duration_path(launch, [launch, security_review, integration, backend, api_design, requirements], 18), rule(28), [uses(226, task(launch, 1)), uses(231, depends(launch, security_review)), uses(266, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17)), calculated(18, binary("+", value(17), value(1)))]).
substitution(274, [binding("task", launch), binding("path", [security_review, integration, frontend, api_design, requirements]), binding("finish", 17), binding("duration", 1), binding("predecessor", security_review), binding("previous", 16)]).
proof(274, duration_path(launch, [launch, security_review, integration, frontend, api_design, requirements], 17), rule(28), [uses(226, task(launch, 1)), uses(231, depends(launch, security_review)), uses(267, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16)), calculated(17, binary("+", value(16), value(1)))]).
substitution(275, [binding("task", launch), binding("path", [security_review, integration, auth, architecture, requirements]), binding("finish", 16), binding("duration", 1), binding("predecessor", security_review), binding("previous", 15)]).
proof(275, duration_path(launch, [launch, security_review, integration, auth, architecture, requirements], 16), rule(28), [uses(226, task(launch, 1)), uses(231, depends(launch, security_review)), uses(268, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15)), calculated(16, binary("+", value(15), value(1)))]).
substitution(276, [binding("task", launch), binding("path", [load_test, integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 1), binding("predecessor", load_test), binding("previous", 16)]).
proof(276, duration_path(launch, [launch, load_test, integration, backend, api_design, requirements], 17), rule(28), [uses(226, task(launch, 1)), uses(232, depends(launch, load_test)), uses(269, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16)), calculated(17, binary("+", value(16), value(1)))]).
substitution(277, [binding("task", launch), binding("path", [load_test, integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 1), binding("predecessor", load_test), binding("previous", 15)]).
proof(277, duration_path(launch, [launch, load_test, integration, frontend, api_design, requirements], 16), rule(28), [uses(226, task(launch, 1)), uses(232, depends(launch, load_test)), uses(270, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15)), calculated(16, binary("+", value(15), value(1)))]).
substitution(278, [binding("task", launch), binding("path", [load_test, integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 1), binding("predecessor", load_test), binding("previous", 14)]).
proof(278, duration_path(launch, [launch, load_test, integration, auth, architecture, requirements], 15), rule(28), [uses(226, task(launch, 1)), uses(232, depends(launch, load_test)), uses(271, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14)), calculated(15, binary("+", value(14), value(1)))]).
substitution(279, [binding("task", security_review), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 3), binding("predecessor", integration), binding("previous", 19)]).
proof(279, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22), rule(28), [uses(233, task(security_review, 3)), uses(235, depends(security_review, integration)), uses(272, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(22, binary("+", value(19), value(3)))]).
substitution(280, [binding("task", load_test), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 21), binding("duration", 2), binding("predecessor", integration), binding("previous", 19)]).
proof(280, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21), rule(28), [uses(234, task(load_test, 2)), uses(236, depends(load_test, integration)), uses(272, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(21, binary("+", value(19), value(2)))]).
substitution(281, [binding("candidate", 18)]).
proof(281, solution([18]), query, [uses(273, duration_path(launch, [launch, security_review, integration, backend, api_design, requirements], 18))]).
substitution(282, [binding("candidate", 17)]).
proof(282, solution([17]), query, [uses(274, duration_path(launch, [launch, security_review, integration, frontend, api_design, requirements], 17))]).
substitution(283, [binding("candidate", 16)]).
proof(283, solution([16]), query, [uses(275, duration_path(launch, [launch, security_review, integration, auth, architecture, requirements], 16))]).
substitution(284, [binding("candidate", 15)]).
proof(284, solution([15]), query, [uses(278, duration_path(launch, [launch, load_test, integration, auth, architecture, requirements], 15))]).
substitution(285, [binding("task", launch), binding("path", [security_review, integration, backend, database, architecture, requirements]), binding("finish", 23), binding("duration", 1), binding("predecessor", security_review), binding("previous", 22)]).
proof(285, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23), rule(28), [uses(226, task(launch, 1)), uses(231, depends(launch, security_review)), uses(279, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22)), calculated(23, binary("+", value(22), value(1)))]).
substitution(286, [binding("task", launch), binding("path", [load_test, integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 1), binding("predecessor", load_test), binding("previous", 21)]).
proof(286, duration_path(launch, [launch, load_test, integration, backend, database, architecture, requirements], 22), rule(28), [uses(226, task(launch, 1)), uses(232, depends(launch, load_test)), uses(280, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21)), calculated(22, binary("+", value(21), value(1)))]).
substitution(287, [binding("candidate", 23)]).
proof(287, solution([23]), query, [uses(285, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23))]).
substitution(288, [binding("candidate", 22)]).
proof(288, solution([22]), query, [uses(286, duration_path(launch, [launch, load_test, integration, backend, database, architecture, requirements], 22))]).
substitution(289, [binding("task", launch), binding("finish", 23), binding("finishes", [15, 16, 17, 18, 22, 23]), binding("candidate", ?v0)]).
proof(289, finish_time(launch, 23), rule(29), [uses(11, task(launch, 1)), collected([15, 16, 17, 18, 22, 23], ?v0, [call(duration_path(launch, ?v1, ?v0))], [281, 282, 283, 284, 287, 288], complete), calculated(23, function("max", [value([15, 16, 17, 18, 22, 23])]))]).
substitution(290, [binding("candidate", 2)]).
proof(290, solution([2]), query, [uses(15, finish_time(requirements, 2))]).
substitution(291, [binding("candidate", 5)]).
proof(291, solution([5]), query, [uses(25, finish_time(architecture, 5))]).
substitution(292, [binding("candidate", 4)]).
proof(292, solution([4]), query, [uses(35, finish_time(api_design, 4))]).
substitution(293, [binding("candidate", 9)]).
proof(293, solution([9]), query, [uses(48, finish_time(database, 9))]).
substitution(294, [binding("candidate", 15)]).
proof(294, solution([15]), query, [uses(71, finish_time(backend, 15))]).
substitution(295, [binding("candidate", 8)]).
proof(295, solution([8]), query, [uses(97, finish_time(auth, 8))]).
substitution(296, [binding("candidate", 19)]).
proof(296, solution([19]), query, [uses(137, finish_time(integration, 19))]).
substitution(297, [binding("candidate", 22)]).
proof(297, solution([22]), query, [uses(181, finish_time(security_review, 22))]).
substitution(298, [binding("candidate", 21)]).
proof(298, solution([21]), query, [uses(225, finish_time(load_test, 21))]).
substitution(299, [binding("candidate", 23)]).
proof(299, solution([23]), query, [uses(289, finish_time(launch, 23))]).
substitution(300, [binding("finish", 23), binding("finishes", [15, 19, 2, 21, 22, 23, 4, 5, 8, 9]), binding("candidate", ?v0)]).
proof(300, project_finish(23), rule(31), [collected([15, 19, 2, 21, 22, 23, 4, 5, 8, 9], ?v0, [call(finish_time(?v1, ?v0))], [290, 291, 292, 293, 294, 295, 296, 297, 298, 299], complete), calculated(23, function("max", [value([15, 19, 2, 21, 22, 23, 4, 5, 8, 9])]))]).
substitution(301, [binding("finish", 23)]).
proof(301, solution([23]), query, [uses(300, project_finish(23))]).
substitution(302, []).
proof(302, task(requirements, 2), rule(1), []).
substitution(303, []).
proof(303, task(architecture, 3), rule(2), []).
substitution(304, []).
proof(304, task(api_design, 2), rule(3), []).
substitution(305, []).
proof(305, task(database, 4), rule(4), []).
substitution(306, []).
proof(306, task(backend, 6), rule(5), []).
substitution(307, []).
proof(307, task(frontend, 5), rule(6), []).
substitution(308, []).
proof(308, task(auth, 3), rule(7), []).
substitution(309, []).
proof(309, task(integration, 4), rule(8), []).
substitution(310, []).
proof(310, task(security_review, 3), rule(9), []).
substitution(311, []).
proof(311, task(load_test, 2), rule(10), []).
substitution(312, []).
proof(312, task(launch, 1), rule(11), []).
substitution(313, []).
proof(313, task(requirements, 2), rule(1), []).
substitution(314, [binding("task", requirements), binding("duration", 2)]).
proof(314, duration_path(requirements, [requirements], 2), rule(27), [uses(313, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(315, [binding("candidate", 2)]).
proof(315, solution([2]), query, [uses(314, duration_path(requirements, [requirements], 2))]).
substitution(316, [binding("task", requirements), binding("finish", 2), binding("finishes", [2]), binding("candidate", ?v0)]).
proof(316, finish_time(requirements, 2), rule(29), [uses(302, task(requirements, 2)), collected([2], ?v0, [call(duration_path(requirements, ?v1, ?v0))], [315], complete), calculated(2, function("max", [value([2])]))]).
substitution(317, []).
proof(317, task(architecture, 3), rule(2), []).
substitution(318, []).
proof(318, depends(architecture, requirements), rule(12), []).
substitution(319, []).
proof(319, task(requirements, 2), rule(1), []).
substitution(320, [binding("task", requirements), binding("duration", 2)]).
proof(320, duration_path(requirements, [requirements], 2), rule(27), [uses(319, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(321, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(321, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(317, task(architecture, 3)), uses(318, depends(architecture, requirements)), uses(320, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(322, [binding("candidate", 5)]).
proof(322, solution([5]), query, [uses(321, duration_path(architecture, [architecture, requirements], 5))]).
substitution(323, [binding("task", architecture), binding("finish", 5), binding("finishes", [5]), binding("candidate", ?v0)]).
proof(323, finish_time(architecture, 5), rule(29), [uses(303, task(architecture, 3)), collected([5], ?v0, [call(duration_path(architecture, ?v1, ?v0))], [322], complete), calculated(5, function("max", [value([5])]))]).
substitution(324, []).
proof(324, task(api_design, 2), rule(3), []).
substitution(325, []).
proof(325, depends(api_design, requirements), rule(13), []).
substitution(326, []).
proof(326, task(requirements, 2), rule(1), []).
substitution(327, [binding("task", requirements), binding("duration", 2)]).
proof(327, duration_path(requirements, [requirements], 2), rule(27), [uses(326, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(328, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(328, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(324, task(api_design, 2)), uses(325, depends(api_design, requirements)), uses(327, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(329, [binding("candidate", 4)]).
proof(329, solution([4]), query, [uses(328, duration_path(api_design, [api_design, requirements], 4))]).
substitution(330, [binding("task", api_design), binding("finish", 4), binding("finishes", [4]), binding("candidate", ?v0)]).
proof(330, finish_time(api_design, 4), rule(29), [uses(304, task(api_design, 2)), collected([4], ?v0, [call(duration_path(api_design, ?v1, ?v0))], [329], complete), calculated(4, function("max", [value([4])]))]).
substitution(331, []).
proof(331, task(database, 4), rule(4), []).
substitution(332, []).
proof(332, depends(database, architecture), rule(14), []).
substitution(333, []).
proof(333, task(architecture, 3), rule(2), []).
substitution(334, []).
proof(334, depends(architecture, requirements), rule(12), []).
substitution(335, []).
proof(335, task(requirements, 2), rule(1), []).
substitution(336, [binding("task", requirements), binding("duration", 2)]).
proof(336, duration_path(requirements, [requirements], 2), rule(27), [uses(335, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(337, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(337, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(333, task(architecture, 3)), uses(334, depends(architecture, requirements)), uses(336, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(338, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(338, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(331, task(database, 4)), uses(332, depends(database, architecture)), uses(337, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(339, [binding("candidate", 9)]).
proof(339, solution([9]), query, [uses(338, duration_path(database, [database, architecture, requirements], 9))]).
substitution(340, [binding("task", database), binding("finish", 9), binding("finishes", [9]), binding("candidate", ?v0)]).
proof(340, finish_time(database, 9), rule(29), [uses(305, task(database, 4)), collected([9], ?v0, [call(duration_path(database, ?v1, ?v0))], [339], complete), calculated(9, function("max", [value([9])]))]).
substitution(341, []).
proof(341, task(backend, 6), rule(5), []).
substitution(342, []).
proof(342, depends(backend, api_design), rule(15), []).
substitution(343, []).
proof(343, depends(backend, database), rule(16), []).
substitution(344, []).
proof(344, task(api_design, 2), rule(3), []).
substitution(345, []).
proof(345, task(database, 4), rule(4), []).
substitution(346, []).
proof(346, depends(api_design, requirements), rule(13), []).
substitution(347, []).
proof(347, depends(database, architecture), rule(14), []).
substitution(348, []).
proof(348, task(requirements, 2), rule(1), []).
substitution(349, []).
proof(349, task(architecture, 3), rule(2), []).
substitution(350, [binding("task", requirements), binding("duration", 2)]).
proof(350, duration_path(requirements, [requirements], 2), rule(27), [uses(348, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(351, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(351, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(344, task(api_design, 2)), uses(346, depends(api_design, requirements)), uses(350, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(352, []).
proof(352, depends(architecture, requirements), rule(12), []).
substitution(353, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(353, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(341, task(backend, 6)), uses(342, depends(backend, api_design)), uses(351, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(354, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(354, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(349, task(architecture, 3)), uses(352, depends(architecture, requirements)), uses(350, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(355, [binding("candidate", 10)]).
proof(355, solution([10]), query, [uses(353, duration_path(backend, [backend, api_design, requirements], 10))]).
substitution(356, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(356, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(345, task(database, 4)), uses(347, depends(database, architecture)), uses(354, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(357, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(357, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(341, task(backend, 6)), uses(343, depends(backend, database)), uses(356, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(358, [binding("candidate", 15)]).
proof(358, solution([15]), query, [uses(357, duration_path(backend, [backend, database, architecture, requirements], 15))]).
substitution(359, [binding("task", backend), binding("finish", 15), binding("finishes", [10, 15]), binding("candidate", ?v0)]).
proof(359, finish_time(backend, 15), rule(29), [uses(306, task(backend, 6)), collected([10, 15], ?v0, [call(duration_path(backend, ?v1, ?v0))], [355, 358], complete), calculated(15, function("max", [value([10, 15])]))]).
substitution(360, []).
proof(360, task(frontend, 5), rule(6), []).
substitution(361, []).
proof(361, depends(frontend, api_design), rule(17), []).
substitution(362, []).
proof(362, task(api_design, 2), rule(3), []).
substitution(363, []).
proof(363, depends(api_design, requirements), rule(13), []).
substitution(364, []).
proof(364, task(requirements, 2), rule(1), []).
substitution(365, [binding("task", requirements), binding("duration", 2)]).
proof(365, duration_path(requirements, [requirements], 2), rule(27), [uses(364, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(366, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(366, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(362, task(api_design, 2)), uses(363, depends(api_design, requirements)), uses(365, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(367, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(367, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(360, task(frontend, 5)), uses(361, depends(frontend, api_design)), uses(366, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(368, [binding("candidate", 9)]).
proof(368, solution([9]), query, [uses(367, duration_path(frontend, [frontend, api_design, requirements], 9))]).
substitution(369, [binding("task", frontend), binding("finish", 9), binding("finishes", [9]), binding("candidate", ?v0)]).
proof(369, finish_time(frontend, 9), rule(29), [uses(307, task(frontend, 5)), collected([9], ?v0, [call(duration_path(frontend, ?v1, ?v0))], [368], complete), calculated(9, function("max", [value([9])]))]).
substitution(370, []).
proof(370, task(auth, 3), rule(7), []).
substitution(371, []).
proof(371, depends(auth, architecture), rule(18), []).
substitution(372, []).
proof(372, task(architecture, 3), rule(2), []).
substitution(373, []).
proof(373, depends(architecture, requirements), rule(12), []).
substitution(374, []).
proof(374, task(requirements, 2), rule(1), []).
substitution(375, [binding("task", requirements), binding("duration", 2)]).
proof(375, duration_path(requirements, [requirements], 2), rule(27), [uses(374, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(376, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(376, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(372, task(architecture, 3)), uses(373, depends(architecture, requirements)), uses(375, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(377, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(377, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(370, task(auth, 3)), uses(371, depends(auth, architecture)), uses(376, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(378, [binding("candidate", 8)]).
proof(378, solution([8]), query, [uses(377, duration_path(auth, [auth, architecture, requirements], 8))]).
substitution(379, [binding("task", auth), binding("finish", 8), binding("finishes", [8]), binding("candidate", ?v0)]).
proof(379, finish_time(auth, 8), rule(29), [uses(308, task(auth, 3)), collected([8], ?v0, [call(duration_path(auth, ?v1, ?v0))], [378], complete), calculated(8, function("max", [value([8])]))]).
substitution(380, []).
proof(380, task(integration, 4), rule(8), []).
substitution(381, []).
proof(381, depends(integration, backend), rule(19), []).
substitution(382, []).
proof(382, depends(integration, frontend), rule(20), []).
substitution(383, []).
proof(383, depends(integration, auth), rule(21), []).
substitution(384, []).
proof(384, task(backend, 6), rule(5), []).
substitution(385, []).
proof(385, task(frontend, 5), rule(6), []).
substitution(386, []).
proof(386, task(auth, 3), rule(7), []).
substitution(387, []).
proof(387, depends(backend, api_design), rule(15), []).
substitution(388, []).
proof(388, depends(backend, database), rule(16), []).
substitution(389, []).
proof(389, depends(frontend, api_design), rule(17), []).
substitution(390, []).
proof(390, depends(auth, architecture), rule(18), []).
substitution(391, []).
proof(391, task(api_design, 2), rule(3), []).
substitution(392, []).
proof(392, task(database, 4), rule(4), []).
substitution(393, []).
proof(393, task(architecture, 3), rule(2), []).
substitution(394, []).
proof(394, depends(api_design, requirements), rule(13), []).
substitution(395, []).
proof(395, depends(database, architecture), rule(14), []).
substitution(396, []).
proof(396, depends(architecture, requirements), rule(12), []).
substitution(397, []).
proof(397, task(requirements, 2), rule(1), []).
substitution(398, [binding("task", requirements), binding("duration", 2)]).
proof(398, duration_path(requirements, [requirements], 2), rule(27), [uses(397, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(399, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(399, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(391, task(api_design, 2)), uses(394, depends(api_design, requirements)), uses(398, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(400, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(400, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(393, task(architecture, 3)), uses(396, depends(architecture, requirements)), uses(398, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(401, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(401, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(384, task(backend, 6)), uses(387, depends(backend, api_design)), uses(399, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(402, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(402, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(385, task(frontend, 5)), uses(389, depends(frontend, api_design)), uses(399, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(403, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(403, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(386, task(auth, 3)), uses(390, depends(auth, architecture)), uses(400, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(404, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(404, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(392, task(database, 4)), uses(395, depends(database, architecture)), uses(400, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(405, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(405, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(380, task(integration, 4)), uses(381, depends(integration, backend)), uses(401, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(406, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(406, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(380, task(integration, 4)), uses(382, depends(integration, frontend)), uses(402, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(407, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(407, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(380, task(integration, 4)), uses(383, depends(integration, auth)), uses(403, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(408, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(408, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(384, task(backend, 6)), uses(388, depends(backend, database)), uses(404, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(409, [binding("candidate", 14)]).
proof(409, solution([14]), query, [uses(405, duration_path(integration, [integration, backend, api_design, requirements], 14))]).
substitution(410, [binding("candidate", 13)]).
proof(410, solution([13]), query, [uses(406, duration_path(integration, [integration, frontend, api_design, requirements], 13))]).
substitution(411, [binding("candidate", 12)]).
proof(411, solution([12]), query, [uses(407, duration_path(integration, [integration, auth, architecture, requirements], 12))]).
substitution(412, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(412, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(380, task(integration, 4)), uses(381, depends(integration, backend)), uses(408, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(413, [binding("candidate", 19)]).
proof(413, solution([19]), query, [uses(412, duration_path(integration, [integration, backend, database, architecture, requirements], 19))]).
substitution(414, [binding("task", integration), binding("finish", 19), binding("finishes", [12, 13, 14, 19]), binding("candidate", ?v0)]).
proof(414, finish_time(integration, 19), rule(29), [uses(309, task(integration, 4)), collected([12, 13, 14, 19], ?v0, [call(duration_path(integration, ?v1, ?v0))], [409, 410, 411, 413], complete), calculated(19, function("max", [value([12, 13, 14, 19])]))]).
substitution(415, []).
proof(415, task(security_review, 3), rule(9), []).
substitution(416, []).
proof(416, depends(security_review, integration), rule(22), []).
substitution(417, []).
proof(417, task(integration, 4), rule(8), []).
substitution(418, []).
proof(418, depends(integration, backend), rule(19), []).
substitution(419, []).
proof(419, depends(integration, frontend), rule(20), []).
substitution(420, []).
proof(420, depends(integration, auth), rule(21), []).
substitution(421, []).
proof(421, task(backend, 6), rule(5), []).
substitution(422, []).
proof(422, task(frontend, 5), rule(6), []).
substitution(423, []).
proof(423, task(auth, 3), rule(7), []).
substitution(424, []).
proof(424, depends(backend, api_design), rule(15), []).
substitution(425, []).
proof(425, depends(backend, database), rule(16), []).
substitution(426, []).
proof(426, depends(frontend, api_design), rule(17), []).
substitution(427, []).
proof(427, depends(auth, architecture), rule(18), []).
substitution(428, []).
proof(428, task(api_design, 2), rule(3), []).
substitution(429, []).
proof(429, task(database, 4), rule(4), []).
substitution(430, []).
proof(430, task(architecture, 3), rule(2), []).
substitution(431, []).
proof(431, depends(api_design, requirements), rule(13), []).
substitution(432, []).
proof(432, depends(database, architecture), rule(14), []).
substitution(433, []).
proof(433, depends(architecture, requirements), rule(12), []).
substitution(434, []).
proof(434, task(requirements, 2), rule(1), []).
substitution(435, [binding("task", requirements), binding("duration", 2)]).
proof(435, duration_path(requirements, [requirements], 2), rule(27), [uses(434, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(436, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(436, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(428, task(api_design, 2)), uses(431, depends(api_design, requirements)), uses(435, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(437, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(437, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(430, task(architecture, 3)), uses(433, depends(architecture, requirements)), uses(435, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(438, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(438, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(421, task(backend, 6)), uses(424, depends(backend, api_design)), uses(436, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(439, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(439, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(422, task(frontend, 5)), uses(426, depends(frontend, api_design)), uses(436, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(440, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(440, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(423, task(auth, 3)), uses(427, depends(auth, architecture)), uses(437, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(441, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(441, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(429, task(database, 4)), uses(432, depends(database, architecture)), uses(437, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(442, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(442, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(417, task(integration, 4)), uses(418, depends(integration, backend)), uses(438, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(443, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(443, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(417, task(integration, 4)), uses(419, depends(integration, frontend)), uses(439, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(444, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(444, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(417, task(integration, 4)), uses(420, depends(integration, auth)), uses(440, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(445, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(445, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(421, task(backend, 6)), uses(425, depends(backend, database)), uses(441, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(446, [binding("task", security_review), binding("path", [integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 3), binding("predecessor", integration), binding("previous", 14)]).
proof(446, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17), rule(28), [uses(415, task(security_review, 3)), uses(416, depends(security_review, integration)), uses(442, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(17, binary("+", value(14), value(3)))]).
substitution(447, [binding("task", security_review), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 3), binding("predecessor", integration), binding("previous", 13)]).
proof(447, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16), rule(28), [uses(415, task(security_review, 3)), uses(416, depends(security_review, integration)), uses(443, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(16, binary("+", value(13), value(3)))]).
substitution(448, [binding("task", security_review), binding("path", [integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 3), binding("predecessor", integration), binding("previous", 12)]).
proof(448, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15), rule(28), [uses(415, task(security_review, 3)), uses(416, depends(security_review, integration)), uses(444, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(15, binary("+", value(12), value(3)))]).
substitution(449, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(449, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(417, task(integration, 4)), uses(418, depends(integration, backend)), uses(445, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(450, [binding("candidate", 17)]).
proof(450, solution([17]), query, [uses(446, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17))]).
substitution(451, [binding("candidate", 16)]).
proof(451, solution([16]), query, [uses(447, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16))]).
substitution(452, [binding("candidate", 15)]).
proof(452, solution([15]), query, [uses(448, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15))]).
substitution(453, [binding("task", security_review), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 3), binding("predecessor", integration), binding("previous", 19)]).
proof(453, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22), rule(28), [uses(415, task(security_review, 3)), uses(416, depends(security_review, integration)), uses(449, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(22, binary("+", value(19), value(3)))]).
substitution(454, [binding("candidate", 22)]).
proof(454, solution([22]), query, [uses(453, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22))]).
substitution(455, [binding("task", security_review), binding("finish", 22), binding("finishes", [15, 16, 17, 22]), binding("candidate", ?v0)]).
proof(455, finish_time(security_review, 22), rule(29), [uses(310, task(security_review, 3)), collected([15, 16, 17, 22], ?v0, [call(duration_path(security_review, ?v1, ?v0))], [450, 451, 452, 454], complete), calculated(22, function("max", [value([15, 16, 17, 22])]))]).
substitution(456, []).
proof(456, task(load_test, 2), rule(10), []).
substitution(457, []).
proof(457, depends(load_test, integration), rule(23), []).
substitution(458, []).
proof(458, task(integration, 4), rule(8), []).
substitution(459, []).
proof(459, depends(integration, backend), rule(19), []).
substitution(460, []).
proof(460, depends(integration, frontend), rule(20), []).
substitution(461, []).
proof(461, depends(integration, auth), rule(21), []).
substitution(462, []).
proof(462, task(backend, 6), rule(5), []).
substitution(463, []).
proof(463, task(frontend, 5), rule(6), []).
substitution(464, []).
proof(464, task(auth, 3), rule(7), []).
substitution(465, []).
proof(465, depends(backend, api_design), rule(15), []).
substitution(466, []).
proof(466, depends(backend, database), rule(16), []).
substitution(467, []).
proof(467, depends(frontend, api_design), rule(17), []).
substitution(468, []).
proof(468, depends(auth, architecture), rule(18), []).
substitution(469, []).
proof(469, task(api_design, 2), rule(3), []).
substitution(470, []).
proof(470, task(database, 4), rule(4), []).
substitution(471, []).
proof(471, task(architecture, 3), rule(2), []).
substitution(472, []).
proof(472, depends(api_design, requirements), rule(13), []).
substitution(473, []).
proof(473, depends(database, architecture), rule(14), []).
substitution(474, []).
proof(474, depends(architecture, requirements), rule(12), []).
substitution(475, []).
proof(475, task(requirements, 2), rule(1), []).
substitution(476, [binding("task", requirements), binding("duration", 2)]).
proof(476, duration_path(requirements, [requirements], 2), rule(27), [uses(475, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(477, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(477, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(469, task(api_design, 2)), uses(472, depends(api_design, requirements)), uses(476, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(478, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(478, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(471, task(architecture, 3)), uses(474, depends(architecture, requirements)), uses(476, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(479, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(479, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(462, task(backend, 6)), uses(465, depends(backend, api_design)), uses(477, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(480, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(480, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(463, task(frontend, 5)), uses(467, depends(frontend, api_design)), uses(477, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(481, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(481, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(464, task(auth, 3)), uses(468, depends(auth, architecture)), uses(478, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(482, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(482, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(470, task(database, 4)), uses(473, depends(database, architecture)), uses(478, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(483, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(483, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(458, task(integration, 4)), uses(459, depends(integration, backend)), uses(479, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(484, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(484, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(458, task(integration, 4)), uses(460, depends(integration, frontend)), uses(480, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(485, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(485, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(458, task(integration, 4)), uses(461, depends(integration, auth)), uses(481, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(486, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(486, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(462, task(backend, 6)), uses(466, depends(backend, database)), uses(482, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(487, [binding("task", load_test), binding("path", [integration, backend, api_design, requirements]), binding("finish", 16), binding("duration", 2), binding("predecessor", integration), binding("previous", 14)]).
proof(487, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16), rule(28), [uses(456, task(load_test, 2)), uses(457, depends(load_test, integration)), uses(483, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(16, binary("+", value(14), value(2)))]).
substitution(488, [binding("task", load_test), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 15), binding("duration", 2), binding("predecessor", integration), binding("previous", 13)]).
proof(488, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15), rule(28), [uses(456, task(load_test, 2)), uses(457, depends(load_test, integration)), uses(484, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(15, binary("+", value(13), value(2)))]).
substitution(489, [binding("task", load_test), binding("path", [integration, auth, architecture, requirements]), binding("finish", 14), binding("duration", 2), binding("predecessor", integration), binding("previous", 12)]).
proof(489, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14), rule(28), [uses(456, task(load_test, 2)), uses(457, depends(load_test, integration)), uses(485, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(14, binary("+", value(12), value(2)))]).
substitution(490, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(490, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(458, task(integration, 4)), uses(459, depends(integration, backend)), uses(486, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(491, [binding("candidate", 16)]).
proof(491, solution([16]), query, [uses(487, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16))]).
substitution(492, [binding("candidate", 15)]).
proof(492, solution([15]), query, [uses(488, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15))]).
substitution(493, [binding("candidate", 14)]).
proof(493, solution([14]), query, [uses(489, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14))]).
substitution(494, [binding("task", load_test), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 21), binding("duration", 2), binding("predecessor", integration), binding("previous", 19)]).
proof(494, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21), rule(28), [uses(456, task(load_test, 2)), uses(457, depends(load_test, integration)), uses(490, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(21, binary("+", value(19), value(2)))]).
substitution(495, [binding("candidate", 21)]).
proof(495, solution([21]), query, [uses(494, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21))]).
substitution(496, [binding("task", load_test), binding("finish", 21), binding("finishes", [14, 15, 16, 21]), binding("candidate", ?v0)]).
proof(496, finish_time(load_test, 21), rule(29), [uses(311, task(load_test, 2)), collected([14, 15, 16, 21], ?v0, [call(duration_path(load_test, ?v1, ?v0))], [491, 492, 493, 495], complete), calculated(21, function("max", [value([14, 15, 16, 21])]))]).
substitution(497, []).
proof(497, task(launch, 1), rule(11), []).
substitution(498, []).
proof(498, depends(launch, security_review), rule(24), []).
substitution(499, []).
proof(499, depends(launch, load_test), rule(25), []).
substitution(500, []).
proof(500, task(security_review, 3), rule(9), []).
substitution(501, []).
proof(501, task(load_test, 2), rule(10), []).
substitution(502, []).
proof(502, depends(security_review, integration), rule(22), []).
substitution(503, []).
proof(503, depends(load_test, integration), rule(23), []).
substitution(504, []).
proof(504, task(integration, 4), rule(8), []).
substitution(505, []).
proof(505, depends(integration, backend), rule(19), []).
substitution(506, []).
proof(506, depends(integration, frontend), rule(20), []).
substitution(507, []).
proof(507, depends(integration, auth), rule(21), []).
substitution(508, []).
proof(508, task(backend, 6), rule(5), []).
substitution(509, []).
proof(509, task(frontend, 5), rule(6), []).
substitution(510, []).
proof(510, task(auth, 3), rule(7), []).
substitution(511, []).
proof(511, depends(backend, api_design), rule(15), []).
substitution(512, []).
proof(512, depends(backend, database), rule(16), []).
substitution(513, []).
proof(513, depends(frontend, api_design), rule(17), []).
substitution(514, []).
proof(514, depends(auth, architecture), rule(18), []).
substitution(515, []).
proof(515, task(api_design, 2), rule(3), []).
substitution(516, []).
proof(516, task(database, 4), rule(4), []).
substitution(517, []).
proof(517, task(architecture, 3), rule(2), []).
substitution(518, []).
proof(518, depends(api_design, requirements), rule(13), []).
substitution(519, []).
proof(519, depends(database, architecture), rule(14), []).
substitution(520, []).
proof(520, depends(architecture, requirements), rule(12), []).
substitution(521, []).
proof(521, task(requirements, 2), rule(1), []).
substitution(522, [binding("task", requirements), binding("duration", 2)]).
proof(522, duration_path(requirements, [requirements], 2), rule(27), [uses(521, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(523, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(523, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(515, task(api_design, 2)), uses(518, depends(api_design, requirements)), uses(522, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(524, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(524, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(517, task(architecture, 3)), uses(520, depends(architecture, requirements)), uses(522, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(525, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(525, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(508, task(backend, 6)), uses(511, depends(backend, api_design)), uses(523, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(526, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(526, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(509, task(frontend, 5)), uses(513, depends(frontend, api_design)), uses(523, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(527, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(527, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(510, task(auth, 3)), uses(514, depends(auth, architecture)), uses(524, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(528, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(528, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(516, task(database, 4)), uses(519, depends(database, architecture)), uses(524, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(529, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(529, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(504, task(integration, 4)), uses(505, depends(integration, backend)), uses(525, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(530, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(530, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(504, task(integration, 4)), uses(506, depends(integration, frontend)), uses(526, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(531, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(531, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(504, task(integration, 4)), uses(507, depends(integration, auth)), uses(527, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(532, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(532, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(508, task(backend, 6)), uses(512, depends(backend, database)), uses(528, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(533, [binding("task", security_review), binding("path", [integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 3), binding("predecessor", integration), binding("previous", 14)]).
proof(533, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17), rule(28), [uses(500, task(security_review, 3)), uses(502, depends(security_review, integration)), uses(529, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(17, binary("+", value(14), value(3)))]).
substitution(534, [binding("task", security_review), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 3), binding("predecessor", integration), binding("previous", 13)]).
proof(534, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16), rule(28), [uses(500, task(security_review, 3)), uses(502, depends(security_review, integration)), uses(530, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(16, binary("+", value(13), value(3)))]).
substitution(535, [binding("task", security_review), binding("path", [integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 3), binding("predecessor", integration), binding("previous", 12)]).
proof(535, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15), rule(28), [uses(500, task(security_review, 3)), uses(502, depends(security_review, integration)), uses(531, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(15, binary("+", value(12), value(3)))]).
substitution(536, [binding("task", load_test), binding("path", [integration, backend, api_design, requirements]), binding("finish", 16), binding("duration", 2), binding("predecessor", integration), binding("previous", 14)]).
proof(536, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16), rule(28), [uses(501, task(load_test, 2)), uses(503, depends(load_test, integration)), uses(529, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(16, binary("+", value(14), value(2)))]).
substitution(537, [binding("task", load_test), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 15), binding("duration", 2), binding("predecessor", integration), binding("previous", 13)]).
proof(537, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15), rule(28), [uses(501, task(load_test, 2)), uses(503, depends(load_test, integration)), uses(530, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(15, binary("+", value(13), value(2)))]).
substitution(538, [binding("task", load_test), binding("path", [integration, auth, architecture, requirements]), binding("finish", 14), binding("duration", 2), binding("predecessor", integration), binding("previous", 12)]).
proof(538, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14), rule(28), [uses(501, task(load_test, 2)), uses(503, depends(load_test, integration)), uses(531, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(14, binary("+", value(12), value(2)))]).
substitution(539, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(539, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(504, task(integration, 4)), uses(505, depends(integration, backend)), uses(532, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(540, [binding("task", launch), binding("path", [security_review, integration, backend, api_design, requirements]), binding("finish", 18), binding("duration", 1), binding("predecessor", security_review), binding("previous", 17)]).
proof(540, duration_path(launch, [launch, security_review, integration, backend, api_design, requirements], 18), rule(28), [uses(497, task(launch, 1)), uses(498, depends(launch, security_review)), uses(533, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17)), calculated(18, binary("+", value(17), value(1)))]).
substitution(541, [binding("task", launch), binding("path", [security_review, integration, frontend, api_design, requirements]), binding("finish", 17), binding("duration", 1), binding("predecessor", security_review), binding("previous", 16)]).
proof(541, duration_path(launch, [launch, security_review, integration, frontend, api_design, requirements], 17), rule(28), [uses(497, task(launch, 1)), uses(498, depends(launch, security_review)), uses(534, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16)), calculated(17, binary("+", value(16), value(1)))]).
substitution(542, [binding("task", launch), binding("path", [security_review, integration, auth, architecture, requirements]), binding("finish", 16), binding("duration", 1), binding("predecessor", security_review), binding("previous", 15)]).
proof(542, duration_path(launch, [launch, security_review, integration, auth, architecture, requirements], 16), rule(28), [uses(497, task(launch, 1)), uses(498, depends(launch, security_review)), uses(535, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15)), calculated(16, binary("+", value(15), value(1)))]).
substitution(543, [binding("task", launch), binding("path", [load_test, integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 1), binding("predecessor", load_test), binding("previous", 16)]).
proof(543, duration_path(launch, [launch, load_test, integration, backend, api_design, requirements], 17), rule(28), [uses(497, task(launch, 1)), uses(499, depends(launch, load_test)), uses(536, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16)), calculated(17, binary("+", value(16), value(1)))]).
substitution(544, [binding("task", launch), binding("path", [load_test, integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 1), binding("predecessor", load_test), binding("previous", 15)]).
proof(544, duration_path(launch, [launch, load_test, integration, frontend, api_design, requirements], 16), rule(28), [uses(497, task(launch, 1)), uses(499, depends(launch, load_test)), uses(537, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15)), calculated(16, binary("+", value(15), value(1)))]).
substitution(545, [binding("task", launch), binding("path", [load_test, integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 1), binding("predecessor", load_test), binding("previous", 14)]).
proof(545, duration_path(launch, [launch, load_test, integration, auth, architecture, requirements], 15), rule(28), [uses(497, task(launch, 1)), uses(499, depends(launch, load_test)), uses(538, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14)), calculated(15, binary("+", value(14), value(1)))]).
substitution(546, [binding("task", security_review), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 3), binding("predecessor", integration), binding("previous", 19)]).
proof(546, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22), rule(28), [uses(500, task(security_review, 3)), uses(502, depends(security_review, integration)), uses(539, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(22, binary("+", value(19), value(3)))]).
substitution(547, [binding("task", load_test), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 21), binding("duration", 2), binding("predecessor", integration), binding("previous", 19)]).
proof(547, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21), rule(28), [uses(501, task(load_test, 2)), uses(503, depends(load_test, integration)), uses(539, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(21, binary("+", value(19), value(2)))]).
substitution(548, [binding("candidate", 18)]).
proof(548, solution([18]), query, [uses(540, duration_path(launch, [launch, security_review, integration, backend, api_design, requirements], 18))]).
substitution(549, [binding("candidate", 17)]).
proof(549, solution([17]), query, [uses(541, duration_path(launch, [launch, security_review, integration, frontend, api_design, requirements], 17))]).
substitution(550, [binding("candidate", 16)]).
proof(550, solution([16]), query, [uses(542, duration_path(launch, [launch, security_review, integration, auth, architecture, requirements], 16))]).
substitution(551, [binding("candidate", 15)]).
proof(551, solution([15]), query, [uses(545, duration_path(launch, [launch, load_test, integration, auth, architecture, requirements], 15))]).
substitution(552, [binding("task", launch), binding("path", [security_review, integration, backend, database, architecture, requirements]), binding("finish", 23), binding("duration", 1), binding("predecessor", security_review), binding("previous", 22)]).
proof(552, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23), rule(28), [uses(497, task(launch, 1)), uses(498, depends(launch, security_review)), uses(546, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22)), calculated(23, binary("+", value(22), value(1)))]).
substitution(553, [binding("task", launch), binding("path", [load_test, integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 1), binding("predecessor", load_test), binding("previous", 21)]).
proof(553, duration_path(launch, [launch, load_test, integration, backend, database, architecture, requirements], 22), rule(28), [uses(497, task(launch, 1)), uses(499, depends(launch, load_test)), uses(547, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21)), calculated(22, binary("+", value(21), value(1)))]).
substitution(554, [binding("candidate", 23)]).
proof(554, solution([23]), query, [uses(552, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23))]).
substitution(555, [binding("candidate", 22)]).
proof(555, solution([22]), query, [uses(553, duration_path(launch, [launch, load_test, integration, backend, database, architecture, requirements], 22))]).
substitution(556, [binding("task", launch), binding("finish", 23), binding("finishes", [15, 16, 17, 18, 22, 23]), binding("candidate", ?v0)]).
proof(556, finish_time(launch, 23), rule(29), [uses(312, task(launch, 1)), collected([15, 16, 17, 18, 22, 23], ?v0, [call(duration_path(launch, ?v1, ?v0))], [548, 549, 550, 551, 554, 555], complete), calculated(23, function("max", [value([15, 16, 17, 18, 22, 23])]))]).
substitution(557, [binding("candidate", 2)]).
proof(557, solution([2]), query, [uses(316, finish_time(requirements, 2))]).
substitution(558, [binding("candidate", 5)]).
proof(558, solution([5]), query, [uses(323, finish_time(architecture, 5))]).
substitution(559, [binding("candidate", 4)]).
proof(559, solution([4]), query, [uses(330, finish_time(api_design, 4))]).
substitution(560, [binding("candidate", 9)]).
proof(560, solution([9]), query, [uses(340, finish_time(database, 9))]).
substitution(561, [binding("candidate", 15)]).
proof(561, solution([15]), query, [uses(359, finish_time(backend, 15))]).
substitution(562, [binding("candidate", 8)]).
proof(562, solution([8]), query, [uses(379, finish_time(auth, 8))]).
substitution(563, [binding("candidate", 19)]).
proof(563, solution([19]), query, [uses(414, finish_time(integration, 19))]).
substitution(564, [binding("candidate", 22)]).
proof(564, solution([22]), query, [uses(455, finish_time(security_review, 22))]).
substitution(565, [binding("candidate", 21)]).
proof(565, solution([21]), query, [uses(496, finish_time(load_test, 21))]).
substitution(566, [binding("candidate", 23)]).
proof(566, solution([23]), query, [uses(556, finish_time(launch, 23))]).
substitution(567, [binding("finish", 23), binding("finishes", [15, 19, 2, 21, 22, 23, 4, 5, 8, 9]), binding("candidate", ?v0)]).
proof(567, project_finish(23), rule(31), [collected([15, 19, 2, 21, 22, 23, 4, 5, 8, 9], ?v0, [call(finish_time(?v1, ?v0))], [557, 558, 559, 560, 561, 562, 563, 564, 565, 566], complete), calculated(23, function("max", [value([15, 19, 2, 21, 22, 23, 4, 5, 8, 9])]))]).
substitution(568, []).
proof(568, task(requirements, 2), rule(1), []).
substitution(569, []).
proof(569, task(architecture, 3), rule(2), []).
substitution(570, []).
proof(570, task(api_design, 2), rule(3), []).
substitution(571, []).
proof(571, task(database, 4), rule(4), []).
substitution(572, []).
proof(572, task(backend, 6), rule(5), []).
substitution(573, []).
proof(573, task(frontend, 5), rule(6), []).
substitution(574, []).
proof(574, task(auth, 3), rule(7), []).
substitution(575, []).
proof(575, task(integration, 4), rule(8), []).
substitution(576, []).
proof(576, task(security_review, 3), rule(9), []).
substitution(577, []).
proof(577, task(load_test, 2), rule(10), []).
substitution(578, []).
proof(578, task(launch, 1), rule(11), []).
substitution(579, []).
proof(579, depends(architecture, requirements), rule(12), []).
substitution(580, []).
proof(580, depends(api_design, requirements), rule(13), []).
substitution(581, []).
proof(581, depends(database, architecture), rule(14), []).
substitution(582, []).
proof(582, depends(backend, api_design), rule(15), []).
substitution(583, []).
proof(583, depends(backend, database), rule(16), []).
substitution(584, []).
proof(584, depends(frontend, api_design), rule(17), []).
substitution(585, []).
proof(585, depends(auth, architecture), rule(18), []).
substitution(586, []).
proof(586, depends(integration, backend), rule(19), []).
substitution(587, []).
proof(587, depends(integration, frontend), rule(20), []).
substitution(588, []).
proof(588, depends(integration, auth), rule(21), []).
substitution(589, []).
proof(589, depends(security_review, integration), rule(22), []).
substitution(590, []).
proof(590, depends(load_test, integration), rule(23), []).
substitution(591, []).
proof(591, depends(launch, security_review), rule(24), []).
substitution(592, []).
proof(592, depends(launch, load_test), rule(25), []).
substitution(593, []).
proof(593, task(requirements, 2), rule(1), []).
substitution(594, []).
proof(594, task(architecture, 3), rule(2), []).
substitution(595, []).
proof(595, task(api_design, 2), rule(3), []).
substitution(596, []).
proof(596, task(database, 4), rule(4), []).
substitution(597, []).
proof(597, task(backend, 6), rule(5), []).
substitution(598, []).
proof(598, task(frontend, 5), rule(6), []).
substitution(599, []).
proof(599, task(auth, 3), rule(7), []).
substitution(600, []).
proof(600, task(integration, 4), rule(8), []).
substitution(601, []).
proof(601, task(security_review, 3), rule(9), []).
substitution(602, []).
proof(602, task(load_test, 2), rule(10), []).
substitution(603, [binding("task", requirements), binding("duration", 2)]).
proof(603, duration_path(requirements, [requirements], 2), rule(27), [uses(593, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(604, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(604, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(594, task(architecture, 3)), uses(579, depends(architecture, requirements)), uses(603, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(605, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(605, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(595, task(api_design, 2)), uses(580, depends(api_design, requirements)), uses(603, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(606, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(606, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(596, task(database, 4)), uses(581, depends(database, architecture)), uses(604, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(607, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(607, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(597, task(backend, 6)), uses(582, depends(backend, api_design)), uses(605, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(608, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(608, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(597, task(backend, 6)), uses(583, depends(backend, database)), uses(606, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(609, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(609, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(598, task(frontend, 5)), uses(584, depends(frontend, api_design)), uses(605, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(610, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(610, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(599, task(auth, 3)), uses(585, depends(auth, architecture)), uses(604, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(611, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(611, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(600, task(integration, 4)), uses(586, depends(integration, backend)), uses(607, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(612, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(612, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(600, task(integration, 4)), uses(586, depends(integration, backend)), uses(608, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(613, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(613, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(600, task(integration, 4)), uses(587, depends(integration, frontend)), uses(609, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(614, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(614, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(600, task(integration, 4)), uses(588, depends(integration, auth)), uses(610, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(615, [binding("task", security_review), binding("path", [integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 3), binding("predecessor", integration), binding("previous", 14)]).
proof(615, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17), rule(28), [uses(601, task(security_review, 3)), uses(589, depends(security_review, integration)), uses(611, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(17, binary("+", value(14), value(3)))]).
substitution(616, [binding("task", security_review), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 3), binding("predecessor", integration), binding("previous", 19)]).
proof(616, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22), rule(28), [uses(601, task(security_review, 3)), uses(589, depends(security_review, integration)), uses(612, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(22, binary("+", value(19), value(3)))]).
substitution(617, [binding("task", security_review), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 3), binding("predecessor", integration), binding("previous", 13)]).
proof(617, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16), rule(28), [uses(601, task(security_review, 3)), uses(589, depends(security_review, integration)), uses(613, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(16, binary("+", value(13), value(3)))]).
substitution(618, [binding("task", security_review), binding("path", [integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 3), binding("predecessor", integration), binding("previous", 12)]).
proof(618, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15), rule(28), [uses(601, task(security_review, 3)), uses(589, depends(security_review, integration)), uses(614, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(15, binary("+", value(12), value(3)))]).
substitution(619, [binding("task", load_test), binding("path", [integration, backend, api_design, requirements]), binding("finish", 16), binding("duration", 2), binding("predecessor", integration), binding("previous", 14)]).
proof(619, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16), rule(28), [uses(602, task(load_test, 2)), uses(590, depends(load_test, integration)), uses(611, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(16, binary("+", value(14), value(2)))]).
substitution(620, [binding("task", load_test), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 21), binding("duration", 2), binding("predecessor", integration), binding("previous", 19)]).
proof(620, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21), rule(28), [uses(602, task(load_test, 2)), uses(590, depends(load_test, integration)), uses(612, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(21, binary("+", value(19), value(2)))]).
substitution(621, [binding("task", load_test), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 15), binding("duration", 2), binding("predecessor", integration), binding("previous", 13)]).
proof(621, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15), rule(28), [uses(602, task(load_test, 2)), uses(590, depends(load_test, integration)), uses(613, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(15, binary("+", value(13), value(2)))]).
substitution(622, [binding("task", load_test), binding("path", [integration, auth, architecture, requirements]), binding("finish", 14), binding("duration", 2), binding("predecessor", integration), binding("previous", 12)]).
proof(622, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14), rule(28), [uses(602, task(load_test, 2)), uses(590, depends(load_test, integration)), uses(614, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(14, binary("+", value(12), value(2)))]).
substitution(623, [binding("task", launch), binding("path", [security_review, integration, backend, database, architecture, requirements]), binding("finish", 23), binding("duration", 1), binding("predecessor", security_review), binding("previous", 22)]).
proof(623, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23), rule(28), [uses(578, task(launch, 1)), uses(591, depends(launch, security_review)), uses(616, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22)), calculated(23, binary("+", value(22), value(1)))]).
substitution(624, [binding("x", launch)]).
proof(624, member(launch, [launch, security_review, integration, backend, database, architecture, requirements]), rule(32), []).
substitution(625, [binding("task", launch), binding("finish", 23), binding("path", [launch, security_review, integration, backend, database, architecture, requirements])]).
proof(625, critical_task(launch), rule(34), [uses(567, project_finish(23)), uses(623, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23)), uses(624, member(launch, [launch, security_review, integration, backend, database, architecture, requirements]))]).
substitution(626, [binding("x", security_review)]).
proof(626, member(security_review, [security_review, integration, backend, database, architecture, requirements]), rule(32), []).
substitution(627, [binding("task", launch)]).
proof(627, solution([launch]), query, [uses(625, critical_task(launch))]).
substitution(628, [binding("x", security_review), binding("rest", [security_review, integration, backend, database, architecture, requirements])]).
proof(628, member(security_review, [launch, security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(626, member(security_review, [security_review, integration, backend, database, architecture, requirements]))]).
substitution(629, [binding("x", integration)]).
proof(629, member(integration, [integration, backend, database, architecture, requirements]), rule(32), []).
substitution(630, [binding("task", security_review), binding("finish", 23), binding("path", [launch, security_review, integration, backend, database, architecture, requirements])]).
proof(630, critical_task(security_review), rule(34), [uses(567, project_finish(23)), uses(623, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23)), uses(628, member(security_review, [launch, security_review, integration, backend, database, architecture, requirements]))]).
substitution(631, [binding("x", integration), binding("rest", [integration, backend, database, architecture, requirements])]).
proof(631, member(integration, [security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(629, member(integration, [integration, backend, database, architecture, requirements]))]).
substitution(632, [binding("x", backend)]).
proof(632, member(backend, [backend, database, architecture, requirements]), rule(32), []).
substitution(633, [binding("task", security_review)]).
proof(633, solution([security_review]), query, [uses(630, critical_task(security_review))]).
substitution(634, [binding("x", integration), binding("rest", [security_review, integration, backend, database, architecture, requirements])]).
proof(634, member(integration, [launch, security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(631, member(integration, [security_review, integration, backend, database, architecture, requirements]))]).
substitution(635, [binding("x", backend), binding("rest", [backend, database, architecture, requirements])]).
proof(635, member(backend, [integration, backend, database, architecture, requirements]), rule(33), [uses(632, member(backend, [backend, database, architecture, requirements]))]).
substitution(636, [binding("x", database)]).
proof(636, member(database, [database, architecture, requirements]), rule(32), []).
substitution(637, [binding("task", integration), binding("finish", 23), binding("path", [launch, security_review, integration, backend, database, architecture, requirements])]).
proof(637, critical_task(integration), rule(34), [uses(567, project_finish(23)), uses(623, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23)), uses(634, member(integration, [launch, security_review, integration, backend, database, architecture, requirements]))]).
substitution(638, [binding("x", backend), binding("rest", [integration, backend, database, architecture, requirements])]).
proof(638, member(backend, [security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(635, member(backend, [integration, backend, database, architecture, requirements]))]).
substitution(639, [binding("x", database), binding("rest", [database, architecture, requirements])]).
proof(639, member(database, [backend, database, architecture, requirements]), rule(33), [uses(636, member(database, [database, architecture, requirements]))]).
substitution(640, [binding("x", architecture)]).
proof(640, member(architecture, [architecture, requirements]), rule(32), []).
substitution(641, [binding("task", integration)]).
proof(641, solution([integration]), query, [uses(637, critical_task(integration))]).
substitution(642, [binding("x", backend), binding("rest", [security_review, integration, backend, database, architecture, requirements])]).
proof(642, member(backend, [launch, security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(638, member(backend, [security_review, integration, backend, database, architecture, requirements]))]).
substitution(643, [binding("x", database), binding("rest", [backend, database, architecture, requirements])]).
proof(643, member(database, [integration, backend, database, architecture, requirements]), rule(33), [uses(639, member(database, [backend, database, architecture, requirements]))]).
substitution(644, [binding("x", architecture), binding("rest", [architecture, requirements])]).
proof(644, member(architecture, [database, architecture, requirements]), rule(33), [uses(640, member(architecture, [architecture, requirements]))]).
substitution(645, [binding("x", requirements)]).
proof(645, member(requirements, [requirements]), rule(32), []).
substitution(646, [binding("task", backend), binding("finish", 23), binding("path", [launch, security_review, integration, backend, database, architecture, requirements])]).
proof(646, critical_task(backend), rule(34), [uses(567, project_finish(23)), uses(623, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23)), uses(642, member(backend, [launch, security_review, integration, backend, database, architecture, requirements]))]).
substitution(647, [binding("x", database), binding("rest", [integration, backend, database, architecture, requirements])]).
proof(647, member(database, [security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(643, member(database, [integration, backend, database, architecture, requirements]))]).
substitution(648, [binding("x", architecture), binding("rest", [database, architecture, requirements])]).
proof(648, member(architecture, [backend, database, architecture, requirements]), rule(33), [uses(644, member(architecture, [database, architecture, requirements]))]).
substitution(649, [binding("x", requirements), binding("rest", [requirements])]).
proof(649, member(requirements, [architecture, requirements]), rule(33), [uses(645, member(requirements, [requirements]))]).
substitution(650, [binding("task", backend)]).
proof(650, solution([backend]), query, [uses(646, critical_task(backend))]).
substitution(651, [binding("x", database), binding("rest", [security_review, integration, backend, database, architecture, requirements])]).
proof(651, member(database, [launch, security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(647, member(database, [security_review, integration, backend, database, architecture, requirements]))]).
substitution(652, [binding("x", architecture), binding("rest", [backend, database, architecture, requirements])]).
proof(652, member(architecture, [integration, backend, database, architecture, requirements]), rule(33), [uses(648, member(architecture, [backend, database, architecture, requirements]))]).
substitution(653, [binding("x", requirements), binding("rest", [architecture, requirements])]).
proof(653, member(requirements, [database, architecture, requirements]), rule(33), [uses(649, member(requirements, [architecture, requirements]))]).
substitution(654, [binding("task", database), binding("finish", 23), binding("path", [launch, security_review, integration, backend, database, architecture, requirements])]).
proof(654, critical_task(database), rule(34), [uses(567, project_finish(23)), uses(623, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23)), uses(651, member(database, [launch, security_review, integration, backend, database, architecture, requirements]))]).
substitution(655, [binding("x", architecture), binding("rest", [integration, backend, database, architecture, requirements])]).
proof(655, member(architecture, [security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(652, member(architecture, [integration, backend, database, architecture, requirements]))]).
substitution(656, [binding("x", requirements), binding("rest", [database, architecture, requirements])]).
proof(656, member(requirements, [backend, database, architecture, requirements]), rule(33), [uses(653, member(requirements, [database, architecture, requirements]))]).
substitution(657, [binding("task", database)]).
proof(657, solution([database]), query, [uses(654, critical_task(database))]).
substitution(658, [binding("x", architecture), binding("rest", [security_review, integration, backend, database, architecture, requirements])]).
proof(658, member(architecture, [launch, security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(655, member(architecture, [security_review, integration, backend, database, architecture, requirements]))]).
substitution(659, [binding("x", requirements), binding("rest", [backend, database, architecture, requirements])]).
proof(659, member(requirements, [integration, backend, database, architecture, requirements]), rule(33), [uses(656, member(requirements, [backend, database, architecture, requirements]))]).
substitution(660, [binding("task", architecture), binding("finish", 23), binding("path", [launch, security_review, integration, backend, database, architecture, requirements])]).
proof(660, critical_task(architecture), rule(34), [uses(567, project_finish(23)), uses(623, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23)), uses(658, member(architecture, [launch, security_review, integration, backend, database, architecture, requirements]))]).
substitution(661, [binding("x", requirements), binding("rest", [integration, backend, database, architecture, requirements])]).
proof(661, member(requirements, [security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(659, member(requirements, [integration, backend, database, architecture, requirements]))]).
substitution(662, [binding("task", architecture)]).
proof(662, solution([architecture]), query, [uses(660, critical_task(architecture))]).
substitution(663, [binding("x", requirements), binding("rest", [security_review, integration, backend, database, architecture, requirements])]).
proof(663, member(requirements, [launch, security_review, integration, backend, database, architecture, requirements]), rule(33), [uses(661, member(requirements, [security_review, integration, backend, database, architecture, requirements]))]).
substitution(664, [binding("task", requirements), binding("finish", 23), binding("path", [launch, security_review, integration, backend, database, architecture, requirements])]).
proof(664, critical_task(requirements), rule(34), [uses(567, project_finish(23)), uses(623, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23)), uses(663, member(requirements, [launch, security_review, integration, backend, database, architecture, requirements]))]).
substitution(665, [binding("task", requirements)]).
proof(665, solution([requirements]), query, [uses(664, critical_task(requirements))]).
substitution(666, []).
proof(666, task(requirements, 2), rule(1), []).
substitution(667, []).
proof(667, task(architecture, 3), rule(2), []).
substitution(668, []).
proof(668, task(api_design, 2), rule(3), []).
substitution(669, []).
proof(669, task(database, 4), rule(4), []).
substitution(670, []).
proof(670, task(backend, 6), rule(5), []).
substitution(671, []).
proof(671, task(frontend, 5), rule(6), []).
substitution(672, []).
proof(672, task(auth, 3), rule(7), []).
substitution(673, []).
proof(673, task(integration, 4), rule(8), []).
substitution(674, []).
proof(674, task(security_review, 3), rule(9), []).
substitution(675, []).
proof(675, task(load_test, 2), rule(10), []).
substitution(676, []).
proof(676, task(launch, 1), rule(11), []).
substitution(677, []).
proof(677, task(requirements, 2), rule(1), []).
substitution(678, []).
proof(678, task(architecture, 3), rule(2), []).
substitution(679, []).
proof(679, task(api_design, 2), rule(3), []).
substitution(680, []).
proof(680, task(database, 4), rule(4), []).
substitution(681, []).
proof(681, task(backend, 6), rule(5), []).
substitution(682, []).
proof(682, task(frontend, 5), rule(6), []).
substitution(683, []).
proof(683, task(auth, 3), rule(7), []).
substitution(684, []).
proof(684, task(integration, 4), rule(8), []).
substitution(685, []).
proof(685, task(security_review, 3), rule(9), []).
substitution(686, []).
proof(686, task(load_test, 2), rule(10), []).
substitution(687, []).
proof(687, task(launch, 1), rule(11), []).
substitution(688, []).
proof(688, task(requirements, 2), rule(1), []).
substitution(689, [binding("task", requirements), binding("duration", 2)]).
proof(689, duration_path(requirements, [requirements], 2), rule(27), [uses(688, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(690, [binding("candidate", 2)]).
proof(690, solution([2]), query, [uses(689, duration_path(requirements, [requirements], 2))]).
substitution(691, [binding("task", requirements), binding("finish", 2), binding("finishes", [2]), binding("candidate", ?v0)]).
proof(691, finish_time(requirements, 2), rule(29), [uses(677, task(requirements, 2)), collected([2], ?v0, [call(duration_path(requirements, ?v1, ?v0))], [690], complete), calculated(2, function("max", [value([2])]))]).
substitution(692, []).
proof(692, task(architecture, 3), rule(2), []).
substitution(693, []).
proof(693, depends(architecture, requirements), rule(12), []).
substitution(694, []).
proof(694, task(requirements, 2), rule(1), []).
substitution(695, [binding("task", requirements), binding("duration", 2)]).
proof(695, duration_path(requirements, [requirements], 2), rule(27), [uses(694, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(696, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(696, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(692, task(architecture, 3)), uses(693, depends(architecture, requirements)), uses(695, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(697, [binding("candidate", 5)]).
proof(697, solution([5]), query, [uses(696, duration_path(architecture, [architecture, requirements], 5))]).
substitution(698, [binding("task", architecture), binding("finish", 5), binding("finishes", [5]), binding("candidate", ?v0)]).
proof(698, finish_time(architecture, 5), rule(29), [uses(678, task(architecture, 3)), collected([5], ?v0, [call(duration_path(architecture, ?v1, ?v0))], [697], complete), calculated(5, function("max", [value([5])]))]).
substitution(699, []).
proof(699, task(api_design, 2), rule(3), []).
substitution(700, []).
proof(700, depends(api_design, requirements), rule(13), []).
substitution(701, []).
proof(701, task(requirements, 2), rule(1), []).
substitution(702, [binding("task", requirements), binding("duration", 2)]).
proof(702, duration_path(requirements, [requirements], 2), rule(27), [uses(701, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(703, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(703, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(699, task(api_design, 2)), uses(700, depends(api_design, requirements)), uses(702, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(704, [binding("candidate", 4)]).
proof(704, solution([4]), query, [uses(703, duration_path(api_design, [api_design, requirements], 4))]).
substitution(705, [binding("task", api_design), binding("finish", 4), binding("finishes", [4]), binding("candidate", ?v0)]).
proof(705, finish_time(api_design, 4), rule(29), [uses(679, task(api_design, 2)), collected([4], ?v0, [call(duration_path(api_design, ?v1, ?v0))], [704], complete), calculated(4, function("max", [value([4])]))]).
substitution(706, []).
proof(706, task(database, 4), rule(4), []).
substitution(707, []).
proof(707, depends(database, architecture), rule(14), []).
substitution(708, []).
proof(708, task(architecture, 3), rule(2), []).
substitution(709, []).
proof(709, depends(architecture, requirements), rule(12), []).
substitution(710, []).
proof(710, task(requirements, 2), rule(1), []).
substitution(711, [binding("task", requirements), binding("duration", 2)]).
proof(711, duration_path(requirements, [requirements], 2), rule(27), [uses(710, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(712, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(712, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(708, task(architecture, 3)), uses(709, depends(architecture, requirements)), uses(711, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(713, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(713, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(706, task(database, 4)), uses(707, depends(database, architecture)), uses(712, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(714, [binding("candidate", 9)]).
proof(714, solution([9]), query, [uses(713, duration_path(database, [database, architecture, requirements], 9))]).
substitution(715, [binding("task", database), binding("finish", 9), binding("finishes", [9]), binding("candidate", ?v0)]).
proof(715, finish_time(database, 9), rule(29), [uses(680, task(database, 4)), collected([9], ?v0, [call(duration_path(database, ?v1, ?v0))], [714], complete), calculated(9, function("max", [value([9])]))]).
substitution(716, []).
proof(716, task(backend, 6), rule(5), []).
substitution(717, []).
proof(717, depends(backend, api_design), rule(15), []).
substitution(718, []).
proof(718, depends(backend, database), rule(16), []).
substitution(719, []).
proof(719, task(api_design, 2), rule(3), []).
substitution(720, []).
proof(720, task(database, 4), rule(4), []).
substitution(721, []).
proof(721, depends(api_design, requirements), rule(13), []).
substitution(722, []).
proof(722, depends(database, architecture), rule(14), []).
substitution(723, []).
proof(723, task(requirements, 2), rule(1), []).
substitution(724, []).
proof(724, task(architecture, 3), rule(2), []).
substitution(725, [binding("task", requirements), binding("duration", 2)]).
proof(725, duration_path(requirements, [requirements], 2), rule(27), [uses(723, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(726, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(726, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(719, task(api_design, 2)), uses(721, depends(api_design, requirements)), uses(725, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(727, []).
proof(727, depends(architecture, requirements), rule(12), []).
substitution(728, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(728, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(716, task(backend, 6)), uses(717, depends(backend, api_design)), uses(726, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(729, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(729, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(724, task(architecture, 3)), uses(727, depends(architecture, requirements)), uses(725, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(730, [binding("candidate", 10)]).
proof(730, solution([10]), query, [uses(728, duration_path(backend, [backend, api_design, requirements], 10))]).
substitution(731, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(731, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(720, task(database, 4)), uses(722, depends(database, architecture)), uses(729, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(732, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(732, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(716, task(backend, 6)), uses(718, depends(backend, database)), uses(731, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(733, [binding("candidate", 15)]).
proof(733, solution([15]), query, [uses(732, duration_path(backend, [backend, database, architecture, requirements], 15))]).
substitution(734, [binding("task", backend), binding("finish", 15), binding("finishes", [10, 15]), binding("candidate", ?v0)]).
proof(734, finish_time(backend, 15), rule(29), [uses(681, task(backend, 6)), collected([10, 15], ?v0, [call(duration_path(backend, ?v1, ?v0))], [730, 733], complete), calculated(15, function("max", [value([10, 15])]))]).
substitution(735, []).
proof(735, task(frontend, 5), rule(6), []).
substitution(736, []).
proof(736, depends(frontend, api_design), rule(17), []).
substitution(737, []).
proof(737, task(api_design, 2), rule(3), []).
substitution(738, []).
proof(738, depends(api_design, requirements), rule(13), []).
substitution(739, []).
proof(739, task(requirements, 2), rule(1), []).
substitution(740, [binding("task", requirements), binding("duration", 2)]).
proof(740, duration_path(requirements, [requirements], 2), rule(27), [uses(739, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(741, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(741, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(737, task(api_design, 2)), uses(738, depends(api_design, requirements)), uses(740, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(742, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(742, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(735, task(frontend, 5)), uses(736, depends(frontend, api_design)), uses(741, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(743, [binding("candidate", 9)]).
proof(743, solution([9]), query, [uses(742, duration_path(frontend, [frontend, api_design, requirements], 9))]).
substitution(744, [binding("task", frontend), binding("finish", 9), binding("finishes", [9]), binding("candidate", ?v0)]).
proof(744, finish_time(frontend, 9), rule(29), [uses(682, task(frontend, 5)), collected([9], ?v0, [call(duration_path(frontend, ?v1, ?v0))], [743], complete), calculated(9, function("max", [value([9])]))]).
substitution(745, []).
proof(745, task(auth, 3), rule(7), []).
substitution(746, []).
proof(746, depends(auth, architecture), rule(18), []).
substitution(747, []).
proof(747, task(architecture, 3), rule(2), []).
substitution(748, []).
proof(748, depends(architecture, requirements), rule(12), []).
substitution(749, []).
proof(749, task(requirements, 2), rule(1), []).
substitution(750, [binding("task", requirements), binding("duration", 2)]).
proof(750, duration_path(requirements, [requirements], 2), rule(27), [uses(749, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(751, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(751, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(747, task(architecture, 3)), uses(748, depends(architecture, requirements)), uses(750, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(752, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(752, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(745, task(auth, 3)), uses(746, depends(auth, architecture)), uses(751, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(753, [binding("candidate", 8)]).
proof(753, solution([8]), query, [uses(752, duration_path(auth, [auth, architecture, requirements], 8))]).
substitution(754, [binding("task", auth), binding("finish", 8), binding("finishes", [8]), binding("candidate", ?v0)]).
proof(754, finish_time(auth, 8), rule(29), [uses(683, task(auth, 3)), collected([8], ?v0, [call(duration_path(auth, ?v1, ?v0))], [753], complete), calculated(8, function("max", [value([8])]))]).
substitution(755, []).
proof(755, task(integration, 4), rule(8), []).
substitution(756, []).
proof(756, depends(integration, backend), rule(19), []).
substitution(757, []).
proof(757, depends(integration, frontend), rule(20), []).
substitution(758, []).
proof(758, depends(integration, auth), rule(21), []).
substitution(759, []).
proof(759, task(backend, 6), rule(5), []).
substitution(760, []).
proof(760, task(frontend, 5), rule(6), []).
substitution(761, []).
proof(761, task(auth, 3), rule(7), []).
substitution(762, []).
proof(762, depends(backend, api_design), rule(15), []).
substitution(763, []).
proof(763, depends(backend, database), rule(16), []).
substitution(764, []).
proof(764, depends(frontend, api_design), rule(17), []).
substitution(765, []).
proof(765, depends(auth, architecture), rule(18), []).
substitution(766, []).
proof(766, task(api_design, 2), rule(3), []).
substitution(767, []).
proof(767, task(database, 4), rule(4), []).
substitution(768, []).
proof(768, task(architecture, 3), rule(2), []).
substitution(769, []).
proof(769, depends(api_design, requirements), rule(13), []).
substitution(770, []).
proof(770, depends(database, architecture), rule(14), []).
substitution(771, []).
proof(771, depends(architecture, requirements), rule(12), []).
substitution(772, []).
proof(772, task(requirements, 2), rule(1), []).
substitution(773, [binding("task", requirements), binding("duration", 2)]).
proof(773, duration_path(requirements, [requirements], 2), rule(27), [uses(772, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(774, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(774, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(766, task(api_design, 2)), uses(769, depends(api_design, requirements)), uses(773, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(775, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(775, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(768, task(architecture, 3)), uses(771, depends(architecture, requirements)), uses(773, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(776, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(776, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(759, task(backend, 6)), uses(762, depends(backend, api_design)), uses(774, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(777, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(777, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(760, task(frontend, 5)), uses(764, depends(frontend, api_design)), uses(774, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(778, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(778, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(761, task(auth, 3)), uses(765, depends(auth, architecture)), uses(775, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(779, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(779, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(767, task(database, 4)), uses(770, depends(database, architecture)), uses(775, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(780, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(780, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(755, task(integration, 4)), uses(756, depends(integration, backend)), uses(776, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(781, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(781, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(755, task(integration, 4)), uses(757, depends(integration, frontend)), uses(777, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(782, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(782, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(755, task(integration, 4)), uses(758, depends(integration, auth)), uses(778, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(783, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(783, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(759, task(backend, 6)), uses(763, depends(backend, database)), uses(779, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(784, [binding("candidate", 14)]).
proof(784, solution([14]), query, [uses(780, duration_path(integration, [integration, backend, api_design, requirements], 14))]).
substitution(785, [binding("candidate", 13)]).
proof(785, solution([13]), query, [uses(781, duration_path(integration, [integration, frontend, api_design, requirements], 13))]).
substitution(786, [binding("candidate", 12)]).
proof(786, solution([12]), query, [uses(782, duration_path(integration, [integration, auth, architecture, requirements], 12))]).
substitution(787, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(787, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(755, task(integration, 4)), uses(756, depends(integration, backend)), uses(783, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(788, [binding("candidate", 19)]).
proof(788, solution([19]), query, [uses(787, duration_path(integration, [integration, backend, database, architecture, requirements], 19))]).
substitution(789, [binding("task", integration), binding("finish", 19), binding("finishes", [12, 13, 14, 19]), binding("candidate", ?v0)]).
proof(789, finish_time(integration, 19), rule(29), [uses(684, task(integration, 4)), collected([12, 13, 14, 19], ?v0, [call(duration_path(integration, ?v1, ?v0))], [784, 785, 786, 788], complete), calculated(19, function("max", [value([12, 13, 14, 19])]))]).
substitution(790, []).
proof(790, task(security_review, 3), rule(9), []).
substitution(791, []).
proof(791, depends(security_review, integration), rule(22), []).
substitution(792, []).
proof(792, task(integration, 4), rule(8), []).
substitution(793, []).
proof(793, depends(integration, backend), rule(19), []).
substitution(794, []).
proof(794, depends(integration, frontend), rule(20), []).
substitution(795, []).
proof(795, depends(integration, auth), rule(21), []).
substitution(796, []).
proof(796, task(backend, 6), rule(5), []).
substitution(797, []).
proof(797, task(frontend, 5), rule(6), []).
substitution(798, []).
proof(798, task(auth, 3), rule(7), []).
substitution(799, []).
proof(799, depends(backend, api_design), rule(15), []).
substitution(800, []).
proof(800, depends(backend, database), rule(16), []).
substitution(801, []).
proof(801, depends(frontend, api_design), rule(17), []).
substitution(802, []).
proof(802, depends(auth, architecture), rule(18), []).
substitution(803, []).
proof(803, task(api_design, 2), rule(3), []).
substitution(804, []).
proof(804, task(database, 4), rule(4), []).
substitution(805, []).
proof(805, task(architecture, 3), rule(2), []).
substitution(806, []).
proof(806, depends(api_design, requirements), rule(13), []).
substitution(807, []).
proof(807, depends(database, architecture), rule(14), []).
substitution(808, []).
proof(808, depends(architecture, requirements), rule(12), []).
substitution(809, []).
proof(809, task(requirements, 2), rule(1), []).
substitution(810, [binding("task", requirements), binding("duration", 2)]).
proof(810, duration_path(requirements, [requirements], 2), rule(27), [uses(809, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(811, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(811, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(803, task(api_design, 2)), uses(806, depends(api_design, requirements)), uses(810, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(812, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(812, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(805, task(architecture, 3)), uses(808, depends(architecture, requirements)), uses(810, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(813, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(813, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(796, task(backend, 6)), uses(799, depends(backend, api_design)), uses(811, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(814, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(814, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(797, task(frontend, 5)), uses(801, depends(frontend, api_design)), uses(811, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(815, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(815, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(798, task(auth, 3)), uses(802, depends(auth, architecture)), uses(812, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(816, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(816, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(804, task(database, 4)), uses(807, depends(database, architecture)), uses(812, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(817, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(817, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(792, task(integration, 4)), uses(793, depends(integration, backend)), uses(813, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(818, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(818, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(792, task(integration, 4)), uses(794, depends(integration, frontend)), uses(814, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(819, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(819, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(792, task(integration, 4)), uses(795, depends(integration, auth)), uses(815, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(820, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(820, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(796, task(backend, 6)), uses(800, depends(backend, database)), uses(816, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(821, [binding("task", security_review), binding("path", [integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 3), binding("predecessor", integration), binding("previous", 14)]).
proof(821, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17), rule(28), [uses(790, task(security_review, 3)), uses(791, depends(security_review, integration)), uses(817, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(17, binary("+", value(14), value(3)))]).
substitution(822, [binding("task", security_review), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 3), binding("predecessor", integration), binding("previous", 13)]).
proof(822, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16), rule(28), [uses(790, task(security_review, 3)), uses(791, depends(security_review, integration)), uses(818, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(16, binary("+", value(13), value(3)))]).
substitution(823, [binding("task", security_review), binding("path", [integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 3), binding("predecessor", integration), binding("previous", 12)]).
proof(823, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15), rule(28), [uses(790, task(security_review, 3)), uses(791, depends(security_review, integration)), uses(819, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(15, binary("+", value(12), value(3)))]).
substitution(824, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(824, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(792, task(integration, 4)), uses(793, depends(integration, backend)), uses(820, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(825, [binding("candidate", 17)]).
proof(825, solution([17]), query, [uses(821, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17))]).
substitution(826, [binding("candidate", 16)]).
proof(826, solution([16]), query, [uses(822, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16))]).
substitution(827, [binding("candidate", 15)]).
proof(827, solution([15]), query, [uses(823, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15))]).
substitution(828, [binding("task", security_review), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 3), binding("predecessor", integration), binding("previous", 19)]).
proof(828, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22), rule(28), [uses(790, task(security_review, 3)), uses(791, depends(security_review, integration)), uses(824, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(22, binary("+", value(19), value(3)))]).
substitution(829, [binding("candidate", 22)]).
proof(829, solution([22]), query, [uses(828, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22))]).
substitution(830, [binding("task", security_review), binding("finish", 22), binding("finishes", [15, 16, 17, 22]), binding("candidate", ?v0)]).
proof(830, finish_time(security_review, 22), rule(29), [uses(685, task(security_review, 3)), collected([15, 16, 17, 22], ?v0, [call(duration_path(security_review, ?v1, ?v0))], [825, 826, 827, 829], complete), calculated(22, function("max", [value([15, 16, 17, 22])]))]).
substitution(831, []).
proof(831, task(load_test, 2), rule(10), []).
substitution(832, []).
proof(832, depends(load_test, integration), rule(23), []).
substitution(833, []).
proof(833, task(integration, 4), rule(8), []).
substitution(834, []).
proof(834, depends(integration, backend), rule(19), []).
substitution(835, []).
proof(835, depends(integration, frontend), rule(20), []).
substitution(836, []).
proof(836, depends(integration, auth), rule(21), []).
substitution(837, []).
proof(837, task(backend, 6), rule(5), []).
substitution(838, []).
proof(838, task(frontend, 5), rule(6), []).
substitution(839, []).
proof(839, task(auth, 3), rule(7), []).
substitution(840, []).
proof(840, depends(backend, api_design), rule(15), []).
substitution(841, []).
proof(841, depends(backend, database), rule(16), []).
substitution(842, []).
proof(842, depends(frontend, api_design), rule(17), []).
substitution(843, []).
proof(843, depends(auth, architecture), rule(18), []).
substitution(844, []).
proof(844, task(api_design, 2), rule(3), []).
substitution(845, []).
proof(845, task(database, 4), rule(4), []).
substitution(846, []).
proof(846, task(architecture, 3), rule(2), []).
substitution(847, []).
proof(847, depends(api_design, requirements), rule(13), []).
substitution(848, []).
proof(848, depends(database, architecture), rule(14), []).
substitution(849, []).
proof(849, depends(architecture, requirements), rule(12), []).
substitution(850, []).
proof(850, task(requirements, 2), rule(1), []).
substitution(851, [binding("task", requirements), binding("duration", 2)]).
proof(851, duration_path(requirements, [requirements], 2), rule(27), [uses(850, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(852, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(852, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(844, task(api_design, 2)), uses(847, depends(api_design, requirements)), uses(851, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(853, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(853, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(846, task(architecture, 3)), uses(849, depends(architecture, requirements)), uses(851, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(854, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(854, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(837, task(backend, 6)), uses(840, depends(backend, api_design)), uses(852, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(855, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(855, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(838, task(frontend, 5)), uses(842, depends(frontend, api_design)), uses(852, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(856, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(856, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(839, task(auth, 3)), uses(843, depends(auth, architecture)), uses(853, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(857, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(857, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(845, task(database, 4)), uses(848, depends(database, architecture)), uses(853, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(858, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(858, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(833, task(integration, 4)), uses(834, depends(integration, backend)), uses(854, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(859, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(859, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(833, task(integration, 4)), uses(835, depends(integration, frontend)), uses(855, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(860, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(860, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(833, task(integration, 4)), uses(836, depends(integration, auth)), uses(856, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(861, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(861, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(837, task(backend, 6)), uses(841, depends(backend, database)), uses(857, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(862, [binding("task", load_test), binding("path", [integration, backend, api_design, requirements]), binding("finish", 16), binding("duration", 2), binding("predecessor", integration), binding("previous", 14)]).
proof(862, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16), rule(28), [uses(831, task(load_test, 2)), uses(832, depends(load_test, integration)), uses(858, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(16, binary("+", value(14), value(2)))]).
substitution(863, [binding("task", load_test), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 15), binding("duration", 2), binding("predecessor", integration), binding("previous", 13)]).
proof(863, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15), rule(28), [uses(831, task(load_test, 2)), uses(832, depends(load_test, integration)), uses(859, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(15, binary("+", value(13), value(2)))]).
substitution(864, [binding("task", load_test), binding("path", [integration, auth, architecture, requirements]), binding("finish", 14), binding("duration", 2), binding("predecessor", integration), binding("previous", 12)]).
proof(864, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14), rule(28), [uses(831, task(load_test, 2)), uses(832, depends(load_test, integration)), uses(860, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(14, binary("+", value(12), value(2)))]).
substitution(865, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(865, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(833, task(integration, 4)), uses(834, depends(integration, backend)), uses(861, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(866, [binding("candidate", 16)]).
proof(866, solution([16]), query, [uses(862, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16))]).
substitution(867, [binding("candidate", 15)]).
proof(867, solution([15]), query, [uses(863, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15))]).
substitution(868, [binding("candidate", 14)]).
proof(868, solution([14]), query, [uses(864, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14))]).
substitution(869, [binding("task", load_test), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 21), binding("duration", 2), binding("predecessor", integration), binding("previous", 19)]).
proof(869, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21), rule(28), [uses(831, task(load_test, 2)), uses(832, depends(load_test, integration)), uses(865, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(21, binary("+", value(19), value(2)))]).
substitution(870, [binding("candidate", 21)]).
proof(870, solution([21]), query, [uses(869, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21))]).
substitution(871, [binding("task", load_test), binding("finish", 21), binding("finishes", [14, 15, 16, 21]), binding("candidate", ?v0)]).
proof(871, finish_time(load_test, 21), rule(29), [uses(686, task(load_test, 2)), collected([14, 15, 16, 21], ?v0, [call(duration_path(load_test, ?v1, ?v0))], [866, 867, 868, 870], complete), calculated(21, function("max", [value([14, 15, 16, 21])]))]).
substitution(872, []).
proof(872, task(launch, 1), rule(11), []).
substitution(873, []).
proof(873, depends(launch, security_review), rule(24), []).
substitution(874, []).
proof(874, depends(launch, load_test), rule(25), []).
substitution(875, []).
proof(875, task(security_review, 3), rule(9), []).
substitution(876, []).
proof(876, task(load_test, 2), rule(10), []).
substitution(877, []).
proof(877, depends(security_review, integration), rule(22), []).
substitution(878, []).
proof(878, depends(load_test, integration), rule(23), []).
substitution(879, []).
proof(879, task(integration, 4), rule(8), []).
substitution(880, []).
proof(880, depends(integration, backend), rule(19), []).
substitution(881, []).
proof(881, depends(integration, frontend), rule(20), []).
substitution(882, []).
proof(882, depends(integration, auth), rule(21), []).
substitution(883, []).
proof(883, task(backend, 6), rule(5), []).
substitution(884, []).
proof(884, task(frontend, 5), rule(6), []).
substitution(885, []).
proof(885, task(auth, 3), rule(7), []).
substitution(886, []).
proof(886, depends(backend, api_design), rule(15), []).
substitution(887, []).
proof(887, depends(backend, database), rule(16), []).
substitution(888, []).
proof(888, depends(frontend, api_design), rule(17), []).
substitution(889, []).
proof(889, depends(auth, architecture), rule(18), []).
substitution(890, []).
proof(890, task(api_design, 2), rule(3), []).
substitution(891, []).
proof(891, task(database, 4), rule(4), []).
substitution(892, []).
proof(892, task(architecture, 3), rule(2), []).
substitution(893, []).
proof(893, depends(api_design, requirements), rule(13), []).
substitution(894, []).
proof(894, depends(database, architecture), rule(14), []).
substitution(895, []).
proof(895, depends(architecture, requirements), rule(12), []).
substitution(896, []).
proof(896, task(requirements, 2), rule(1), []).
substitution(897, [binding("task", requirements), binding("duration", 2)]).
proof(897, duration_path(requirements, [requirements], 2), rule(27), [uses(896, task(requirements, 2)), absent(has_predecessor(requirements), complete)]).
substitution(898, [binding("task", api_design), binding("path", [requirements]), binding("finish", 4), binding("duration", 2), binding("predecessor", requirements), binding("previous", 2)]).
proof(898, duration_path(api_design, [api_design, requirements], 4), rule(28), [uses(890, task(api_design, 2)), uses(893, depends(api_design, requirements)), uses(897, duration_path(requirements, [requirements], 2)), calculated(4, binary("+", value(2), value(2)))]).
substitution(899, [binding("task", architecture), binding("path", [requirements]), binding("finish", 5), binding("duration", 3), binding("predecessor", requirements), binding("previous", 2)]).
proof(899, duration_path(architecture, [architecture, requirements], 5), rule(28), [uses(892, task(architecture, 3)), uses(895, depends(architecture, requirements)), uses(897, duration_path(requirements, [requirements], 2)), calculated(5, binary("+", value(2), value(3)))]).
substitution(900, [binding("task", backend), binding("path", [api_design, requirements]), binding("finish", 10), binding("duration", 6), binding("predecessor", api_design), binding("previous", 4)]).
proof(900, duration_path(backend, [backend, api_design, requirements], 10), rule(28), [uses(883, task(backend, 6)), uses(886, depends(backend, api_design)), uses(898, duration_path(api_design, [api_design, requirements], 4)), calculated(10, binary("+", value(4), value(6)))]).
substitution(901, [binding("task", frontend), binding("path", [api_design, requirements]), binding("finish", 9), binding("duration", 5), binding("predecessor", api_design), binding("previous", 4)]).
proof(901, duration_path(frontend, [frontend, api_design, requirements], 9), rule(28), [uses(884, task(frontend, 5)), uses(888, depends(frontend, api_design)), uses(898, duration_path(api_design, [api_design, requirements], 4)), calculated(9, binary("+", value(4), value(5)))]).
substitution(902, [binding("task", auth), binding("path", [architecture, requirements]), binding("finish", 8), binding("duration", 3), binding("predecessor", architecture), binding("previous", 5)]).
proof(902, duration_path(auth, [auth, architecture, requirements], 8), rule(28), [uses(885, task(auth, 3)), uses(889, depends(auth, architecture)), uses(899, duration_path(architecture, [architecture, requirements], 5)), calculated(8, binary("+", value(5), value(3)))]).
substitution(903, [binding("task", database), binding("path", [architecture, requirements]), binding("finish", 9), binding("duration", 4), binding("predecessor", architecture), binding("previous", 5)]).
proof(903, duration_path(database, [database, architecture, requirements], 9), rule(28), [uses(891, task(database, 4)), uses(894, depends(database, architecture)), uses(899, duration_path(architecture, [architecture, requirements], 5)), calculated(9, binary("+", value(5), value(4)))]).
substitution(904, [binding("task", integration), binding("path", [backend, api_design, requirements]), binding("finish", 14), binding("duration", 4), binding("predecessor", backend), binding("previous", 10)]).
proof(904, duration_path(integration, [integration, backend, api_design, requirements], 14), rule(28), [uses(879, task(integration, 4)), uses(880, depends(integration, backend)), uses(900, duration_path(backend, [backend, api_design, requirements], 10)), calculated(14, binary("+", value(10), value(4)))]).
substitution(905, [binding("task", integration), binding("path", [frontend, api_design, requirements]), binding("finish", 13), binding("duration", 4), binding("predecessor", frontend), binding("previous", 9)]).
proof(905, duration_path(integration, [integration, frontend, api_design, requirements], 13), rule(28), [uses(879, task(integration, 4)), uses(881, depends(integration, frontend)), uses(901, duration_path(frontend, [frontend, api_design, requirements], 9)), calculated(13, binary("+", value(9), value(4)))]).
substitution(906, [binding("task", integration), binding("path", [auth, architecture, requirements]), binding("finish", 12), binding("duration", 4), binding("predecessor", auth), binding("previous", 8)]).
proof(906, duration_path(integration, [integration, auth, architecture, requirements], 12), rule(28), [uses(879, task(integration, 4)), uses(882, depends(integration, auth)), uses(902, duration_path(auth, [auth, architecture, requirements], 8)), calculated(12, binary("+", value(8), value(4)))]).
substitution(907, [binding("task", backend), binding("path", [database, architecture, requirements]), binding("finish", 15), binding("duration", 6), binding("predecessor", database), binding("previous", 9)]).
proof(907, duration_path(backend, [backend, database, architecture, requirements], 15), rule(28), [uses(883, task(backend, 6)), uses(887, depends(backend, database)), uses(903, duration_path(database, [database, architecture, requirements], 9)), calculated(15, binary("+", value(9), value(6)))]).
substitution(908, [binding("task", security_review), binding("path", [integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 3), binding("predecessor", integration), binding("previous", 14)]).
proof(908, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17), rule(28), [uses(875, task(security_review, 3)), uses(877, depends(security_review, integration)), uses(904, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(17, binary("+", value(14), value(3)))]).
substitution(909, [binding("task", security_review), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 3), binding("predecessor", integration), binding("previous", 13)]).
proof(909, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16), rule(28), [uses(875, task(security_review, 3)), uses(877, depends(security_review, integration)), uses(905, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(16, binary("+", value(13), value(3)))]).
substitution(910, [binding("task", security_review), binding("path", [integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 3), binding("predecessor", integration), binding("previous", 12)]).
proof(910, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15), rule(28), [uses(875, task(security_review, 3)), uses(877, depends(security_review, integration)), uses(906, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(15, binary("+", value(12), value(3)))]).
substitution(911, [binding("task", load_test), binding("path", [integration, backend, api_design, requirements]), binding("finish", 16), binding("duration", 2), binding("predecessor", integration), binding("previous", 14)]).
proof(911, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16), rule(28), [uses(876, task(load_test, 2)), uses(878, depends(load_test, integration)), uses(904, duration_path(integration, [integration, backend, api_design, requirements], 14)), calculated(16, binary("+", value(14), value(2)))]).
substitution(912, [binding("task", load_test), binding("path", [integration, frontend, api_design, requirements]), binding("finish", 15), binding("duration", 2), binding("predecessor", integration), binding("previous", 13)]).
proof(912, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15), rule(28), [uses(876, task(load_test, 2)), uses(878, depends(load_test, integration)), uses(905, duration_path(integration, [integration, frontend, api_design, requirements], 13)), calculated(15, binary("+", value(13), value(2)))]).
substitution(913, [binding("task", load_test), binding("path", [integration, auth, architecture, requirements]), binding("finish", 14), binding("duration", 2), binding("predecessor", integration), binding("previous", 12)]).
proof(913, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14), rule(28), [uses(876, task(load_test, 2)), uses(878, depends(load_test, integration)), uses(906, duration_path(integration, [integration, auth, architecture, requirements], 12)), calculated(14, binary("+", value(12), value(2)))]).
substitution(914, [binding("task", integration), binding("path", [backend, database, architecture, requirements]), binding("finish", 19), binding("duration", 4), binding("predecessor", backend), binding("previous", 15)]).
proof(914, duration_path(integration, [integration, backend, database, architecture, requirements], 19), rule(28), [uses(879, task(integration, 4)), uses(880, depends(integration, backend)), uses(907, duration_path(backend, [backend, database, architecture, requirements], 15)), calculated(19, binary("+", value(15), value(4)))]).
substitution(915, [binding("task", launch), binding("path", [security_review, integration, backend, api_design, requirements]), binding("finish", 18), binding("duration", 1), binding("predecessor", security_review), binding("previous", 17)]).
proof(915, duration_path(launch, [launch, security_review, integration, backend, api_design, requirements], 18), rule(28), [uses(872, task(launch, 1)), uses(873, depends(launch, security_review)), uses(908, duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17)), calculated(18, binary("+", value(17), value(1)))]).
substitution(916, [binding("task", launch), binding("path", [security_review, integration, frontend, api_design, requirements]), binding("finish", 17), binding("duration", 1), binding("predecessor", security_review), binding("previous", 16)]).
proof(916, duration_path(launch, [launch, security_review, integration, frontend, api_design, requirements], 17), rule(28), [uses(872, task(launch, 1)), uses(873, depends(launch, security_review)), uses(909, duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16)), calculated(17, binary("+", value(16), value(1)))]).
substitution(917, [binding("task", launch), binding("path", [security_review, integration, auth, architecture, requirements]), binding("finish", 16), binding("duration", 1), binding("predecessor", security_review), binding("previous", 15)]).
proof(917, duration_path(launch, [launch, security_review, integration, auth, architecture, requirements], 16), rule(28), [uses(872, task(launch, 1)), uses(873, depends(launch, security_review)), uses(910, duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15)), calculated(16, binary("+", value(15), value(1)))]).
substitution(918, [binding("task", launch), binding("path", [load_test, integration, backend, api_design, requirements]), binding("finish", 17), binding("duration", 1), binding("predecessor", load_test), binding("previous", 16)]).
proof(918, duration_path(launch, [launch, load_test, integration, backend, api_design, requirements], 17), rule(28), [uses(872, task(launch, 1)), uses(874, depends(launch, load_test)), uses(911, duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16)), calculated(17, binary("+", value(16), value(1)))]).
substitution(919, [binding("task", launch), binding("path", [load_test, integration, frontend, api_design, requirements]), binding("finish", 16), binding("duration", 1), binding("predecessor", load_test), binding("previous", 15)]).
proof(919, duration_path(launch, [launch, load_test, integration, frontend, api_design, requirements], 16), rule(28), [uses(872, task(launch, 1)), uses(874, depends(launch, load_test)), uses(912, duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15)), calculated(16, binary("+", value(15), value(1)))]).
substitution(920, [binding("task", launch), binding("path", [load_test, integration, auth, architecture, requirements]), binding("finish", 15), binding("duration", 1), binding("predecessor", load_test), binding("previous", 14)]).
proof(920, duration_path(launch, [launch, load_test, integration, auth, architecture, requirements], 15), rule(28), [uses(872, task(launch, 1)), uses(874, depends(launch, load_test)), uses(913, duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14)), calculated(15, binary("+", value(14), value(1)))]).
substitution(921, [binding("task", security_review), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 3), binding("predecessor", integration), binding("previous", 19)]).
proof(921, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22), rule(28), [uses(875, task(security_review, 3)), uses(877, depends(security_review, integration)), uses(914, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(22, binary("+", value(19), value(3)))]).
substitution(922, [binding("task", load_test), binding("path", [integration, backend, database, architecture, requirements]), binding("finish", 21), binding("duration", 2), binding("predecessor", integration), binding("previous", 19)]).
proof(922, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21), rule(28), [uses(876, task(load_test, 2)), uses(878, depends(load_test, integration)), uses(914, duration_path(integration, [integration, backend, database, architecture, requirements], 19)), calculated(21, binary("+", value(19), value(2)))]).
substitution(923, [binding("candidate", 18)]).
proof(923, solution([18]), query, [uses(915, duration_path(launch, [launch, security_review, integration, backend, api_design, requirements], 18))]).
substitution(924, [binding("candidate", 17)]).
proof(924, solution([17]), query, [uses(916, duration_path(launch, [launch, security_review, integration, frontend, api_design, requirements], 17))]).
substitution(925, [binding("candidate", 16)]).
proof(925, solution([16]), query, [uses(917, duration_path(launch, [launch, security_review, integration, auth, architecture, requirements], 16))]).
substitution(926, [binding("candidate", 15)]).
proof(926, solution([15]), query, [uses(920, duration_path(launch, [launch, load_test, integration, auth, architecture, requirements], 15))]).
substitution(927, [binding("task", launch), binding("path", [security_review, integration, backend, database, architecture, requirements]), binding("finish", 23), binding("duration", 1), binding("predecessor", security_review), binding("previous", 22)]).
proof(927, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23), rule(28), [uses(872, task(launch, 1)), uses(873, depends(launch, security_review)), uses(921, duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22)), calculated(23, binary("+", value(22), value(1)))]).
substitution(928, [binding("task", launch), binding("path", [load_test, integration, backend, database, architecture, requirements]), binding("finish", 22), binding("duration", 1), binding("predecessor", load_test), binding("previous", 21)]).
proof(928, duration_path(launch, [launch, load_test, integration, backend, database, architecture, requirements], 22), rule(28), [uses(872, task(launch, 1)), uses(874, depends(launch, load_test)), uses(922, duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21)), calculated(22, binary("+", value(21), value(1)))]).
substitution(929, [binding("candidate", 23)]).
proof(929, solution([23]), query, [uses(927, duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23))]).
substitution(930, [binding("candidate", 22)]).
proof(930, solution([22]), query, [uses(928, duration_path(launch, [launch, load_test, integration, backend, database, architecture, requirements], 22))]).
substitution(931, [binding("task", launch), binding("finish", 23), binding("finishes", [15, 16, 17, 18, 22, 23]), binding("candidate", ?v0)]).
proof(931, finish_time(launch, 23), rule(29), [uses(687, task(launch, 1)), collected([15, 16, 17, 18, 22, 23], ?v0, [call(duration_path(launch, ?v1, ?v0))], [923, 924, 925, 926, 929, 930], complete), calculated(23, function("max", [value([15, 16, 17, 18, 22, 23])]))]).
substitution(932, [binding("task", requirements), binding("start", 0), binding("finish", 2), binding("duration", 2)]).
proof(932, schedule(requirements, 0, 2), rule(30), [uses(666, task(requirements, 2)), uses(691, finish_time(requirements, 2)), calculated(0, binary("-", value(2), value(2)))]).
substitution(933, [binding("task", architecture), binding("start", 2), binding("finish", 5), binding("duration", 3)]).
proof(933, schedule(architecture, 2, 5), rule(30), [uses(667, task(architecture, 3)), uses(698, finish_time(architecture, 5)), calculated(2, binary("-", value(5), value(3)))]).
substitution(934, [binding("task", api_design), binding("start", 2), binding("finish", 4), binding("duration", 2)]).
proof(934, schedule(api_design, 2, 4), rule(30), [uses(668, task(api_design, 2)), uses(705, finish_time(api_design, 4)), calculated(2, binary("-", value(4), value(2)))]).
substitution(935, [binding("task", database), binding("start", 5), binding("finish", 9), binding("duration", 4)]).
proof(935, schedule(database, 5, 9), rule(30), [uses(669, task(database, 4)), uses(715, finish_time(database, 9)), calculated(5, binary("-", value(9), value(4)))]).
substitution(936, [binding("task", backend), binding("start", 9), binding("finish", 15), binding("duration", 6)]).
proof(936, schedule(backend, 9, 15), rule(30), [uses(670, task(backend, 6)), uses(734, finish_time(backend, 15)), calculated(9, binary("-", value(15), value(6)))]).
substitution(937, [binding("task", frontend), binding("start", 4), binding("finish", 9), binding("duration", 5)]).
proof(937, schedule(frontend, 4, 9), rule(30), [uses(671, task(frontend, 5)), uses(744, finish_time(frontend, 9)), calculated(4, binary("-", value(9), value(5)))]).
substitution(938, [binding("task", auth), binding("start", 5), binding("finish", 8), binding("duration", 3)]).
proof(938, schedule(auth, 5, 8), rule(30), [uses(672, task(auth, 3)), uses(754, finish_time(auth, 8)), calculated(5, binary("-", value(8), value(3)))]).
substitution(939, [binding("task", integration), binding("start", 15), binding("finish", 19), binding("duration", 4)]).
proof(939, schedule(integration, 15, 19), rule(30), [uses(673, task(integration, 4)), uses(789, finish_time(integration, 19)), calculated(15, binary("-", value(19), value(4)))]).
substitution(940, [binding("task", security_review), binding("start", 19), binding("finish", 22), binding("duration", 3)]).
proof(940, schedule(security_review, 19, 22), rule(30), [uses(674, task(security_review, 3)), uses(830, finish_time(security_review, 22)), calculated(19, binary("-", value(22), value(3)))]).
substitution(941, [binding("task", load_test), binding("start", 19), binding("finish", 21), binding("duration", 2)]).
proof(941, schedule(load_test, 19, 21), rule(30), [uses(675, task(load_test, 2)), uses(871, finish_time(load_test, 21)), calculated(19, binary("-", value(21), value(2)))]).
substitution(942, [binding("task", launch), binding("start", 22), binding("finish", 23), binding("duration", 1)]).
proof(942, schedule(launch, 22, 23), rule(30), [uses(676, task(launch, 1)), uses(931, finish_time(launch, 23)), calculated(22, binary("-", value(23), value(1)))]).
substitution(943, [binding("task", requirements), binding("start", 0), binding("finish", 2)]).
proof(943, solution([requirements, 0, 2]), query, [uses(932, schedule(requirements, 0, 2))]).
substitution(944, [binding("task", architecture), binding("start", 2), binding("finish", 5)]).
proof(944, solution([architecture, 2, 5]), query, [uses(933, schedule(architecture, 2, 5))]).
substitution(945, [binding("task", api_design), binding("start", 2), binding("finish", 4)]).
proof(945, solution([api_design, 2, 4]), query, [uses(934, schedule(api_design, 2, 4))]).
substitution(946, [binding("task", database), binding("start", 5), binding("finish", 9)]).
proof(946, solution([database, 5, 9]), query, [uses(935, schedule(database, 5, 9))]).
substitution(947, [binding("task", backend), binding("start", 9), binding("finish", 15)]).
proof(947, solution([backend, 9, 15]), query, [uses(936, schedule(backend, 9, 15))]).
substitution(948, [binding("task", frontend), binding("start", 4), binding("finish", 9)]).
proof(948, solution([frontend, 4, 9]), query, [uses(937, schedule(frontend, 4, 9))]).
substitution(949, [binding("task", auth), binding("start", 5), binding("finish", 8)]).
proof(949, solution([auth, 5, 8]), query, [uses(938, schedule(auth, 5, 8))]).
substitution(950, [binding("task", integration), binding("start", 15), binding("finish", 19)]).
proof(950, solution([integration, 15, 19]), query, [uses(939, schedule(integration, 15, 19))]).
substitution(951, [binding("task", security_review), binding("start", 19), binding("finish", 22)]).
proof(951, solution([security_review, 19, 22]), query, [uses(940, schedule(security_review, 19, 22))]).
substitution(952, [binding("task", load_test), binding("start", 19), binding("finish", 21)]).
proof(952, solution([load_test, 19, 21]), query, [uses(941, schedule(load_test, 19, 21))]).
substitution(953, [binding("task", launch), binding("start", 22), binding("finish", 23)]).
proof(953, solution([launch, 22, 23]), query, [uses(942, schedule(launch, 22, 23))]).
