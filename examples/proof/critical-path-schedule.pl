% Prolog result format 4
query(1, project_finish(_0), ['Finish' = _0]).
result(1, complete, 1).
answer(1, ['Finish' = 23]).
why(1, ['Finish' = 23], [project_finish(23)]).
query(2, critical_task(_0), ['Task' = _0]).
result(2, complete, 7).
answer(2, ['Task' = launch]).
why(2, ['Task' = launch], [critical_task(launch)]).
answer(2, ['Task' = security_review]).
why(2, ['Task' = security_review], [critical_task(security_review)]).
answer(2, ['Task' = integration]).
why(2, ['Task' = integration], [critical_task(integration)]).
answer(2, ['Task' = backend]).
why(2, ['Task' = backend], [critical_task(backend)]).
answer(2, ['Task' = database]).
why(2, ['Task' = database], [critical_task(database)]).
answer(2, ['Task' = architecture]).
why(2, ['Task' = architecture], [critical_task(architecture)]).
answer(2, ['Task' = requirements]).
why(2, ['Task' = requirements], [critical_task(requirements)]).
query(3, schedule(_0, _1, _2), ['Task' = _0, 'Start' = _1, 'Finish' = _2]).
result(3, complete, 11).
answer(3, ['Task' = requirements, 'Start' = 0, 'Finish' = 2]).
why(3, ['Task' = requirements, 'Start' = 0, 'Finish' = 2], [schedule(requirements, 0, 2)]).
answer(3, ['Task' = architecture, 'Start' = 2, 'Finish' = 5]).
why(3, ['Task' = architecture, 'Start' = 2, 'Finish' = 5], [schedule(architecture, 2, 5)]).
answer(3, ['Task' = api_design, 'Start' = 2, 'Finish' = 4]).
why(3, ['Task' = api_design, 'Start' = 2, 'Finish' = 4], [schedule(api_design, 2, 4)]).
answer(3, ['Task' = database, 'Start' = 5, 'Finish' = 9]).
why(3, ['Task' = database, 'Start' = 5, 'Finish' = 9], [schedule(database, 5, 9)]).
answer(3, ['Task' = backend, 'Start' = 9, 'Finish' = 15]).
why(3, ['Task' = backend, 'Start' = 9, 'Finish' = 15], [schedule(backend, 9, 15)]).
answer(3, ['Task' = frontend, 'Start' = 4, 'Finish' = 9]).
why(3, ['Task' = frontend, 'Start' = 4, 'Finish' = 9], [schedule(frontend, 4, 9)]).
answer(3, ['Task' = auth, 'Start' = 5, 'Finish' = 8]).
why(3, ['Task' = auth, 'Start' = 5, 'Finish' = 8], [schedule(auth, 5, 8)]).
answer(3, ['Task' = integration, 'Start' = 15, 'Finish' = 19]).
why(3, ['Task' = integration, 'Start' = 15, 'Finish' = 19], [schedule(integration, 15, 19)]).
answer(3, ['Task' = security_review, 'Start' = 19, 'Finish' = 22]).
why(3,
    ['Task' = security_review, 'Start' = 19, 'Finish' = 22],
    [schedule(security_review, 19, 22)]).
answer(3, ['Task' = load_test, 'Start' = 19, 'Finish' = 21]).
why(3, ['Task' = load_test, 'Start' = 19, 'Finish' = 21], [schedule(load_test, 19, 21)]).
answer(3, ['Task' = launch, 'Start' = 22, 'Finish' = 23]).
why(3, ['Task' = launch, 'Start' = 22, 'Finish' = 23], [schedule(launch, 22, 23)]).

clause(1, task(requirements, 2), true).
clause(2, task(architecture, 3), true).
clause(3, task(api_design, 2), true).
clause(4, task(database, 4), true).
clause(5, task(backend, 6), true).
clause(6, task(frontend, 5), true).
clause(7, task(auth, 3), true).
clause(8, task(integration, 4), true).
clause(9, task(security_review, 3), true).
clause(10, task(load_test, 2), true).
clause(11, task(launch, 1), true).
clause(12, depends(architecture, requirements), true).
clause(13, depends(api_design, requirements), true).
clause(14, depends(database, architecture), true).
clause(15, depends(backend, api_design), true).
clause(16, depends(backend, database), true).
clause(17, depends(frontend, api_design), true).
clause(18, depends(auth, architecture), true).
clause(19, depends(integration, backend), true).
clause(20, depends(integration, frontend), true).
clause(21, depends(integration, auth), true).
clause(22, depends(security_review, integration), true).
clause(23, depends(load_test, integration), true).
clause(24, depends(launch, security_review), true).
clause(25, depends(launch, load_test), true).
clause(27,
       duration_path(var('Task'), [var('Task')], var('Duration')),
       (task(var('Task'), var('Duration')), \+has_predecessor(var('Task')))).
clause(28,
       duration_path(var('Task'), [var('Task')|var('Path')], var('Finish')),
       (task(var('Task'), var('Duration')),
        depends(var('Task'), var('Predecessor')),
        duration_path(var('Predecessor'), var('Path'), var('Previous')),
        var('Finish') is var('Previous') + var('Duration'))).
clause(29,
       finish_time(var('Task'), var('Finish')),
       (task(var('Task'), anonymous(1)),
        findall(var('Candidate'), duration_path(var('Task'), anonymous(2), var('Candidate')), var('Bag1')),
        sort(var('Bag1'), var('Finishes')),
        max_list(var('Finishes'), var('Finish')))).
clause(30,
       schedule(var('Task'), var('Start'), var('Finish')),
       (task(var('Task'), var('Duration')),
        finish_time(var('Task'), var('Finish')),
        var('Start') is var('Finish') - var('Duration'))).
clause(31,
       project_finish(var('Finish')),
       (findall(var('Candidate'), finish_time(anonymous(1), var('Candidate')), var('Bag1')),
        sort(var('Bag1'), var('Finishes')),
        max_list(var('Finishes'), var('Finish')))).
clause(32, member(var('X'), [var('X')|anonymous(1)]), true).
clause(33, member(var('X'), [anonymous(1)|var('Rest')]), member(var('X'), var('Rest'))).
clause(34,
       critical_task(var('Task')),
       (project_finish(var('Finish')),
        duration_path(anonymous(1), var('Path'), var('Finish')),
        member(var('Task'), var('Path')))).

step(project_finish(23),
     rule(31),
     ['Finish' = 23,
      'Candidate' = _0,
      'Bag1' = [2, 5, 4, 9, 15, 8, 19, 22, 21, 23],
      'Finishes' = [2, 4, 5, 8, 9, 15, 19, 21, 22, 23]],
     [findall(_1, finish_time(_2, _1), [2, 5, 4, 9, 15, 8, 19, 22, 21, 23]),
      sort([2, 5, 4, 9, 15, 8, 19, 22, 21, 23], [2, 4, 5, 8, 9, 15, 19, 21, 22, 23]),
      max_list([2, 4, 5, 8, 9, 15, 19, 21, 22, 23], 23)]).
step(findall(_0, finish_time(_1, _0), [2, 5, 4, 9, 15, 8, 19, 22, 21, 23]),
     collected,
     [],
     [finish_time(requirements, 2),
      finish_time(architecture, 5),
      finish_time(api_design, 4),
      finish_time(database, 9),
      finish_time(backend, 15),
      finish_time(auth, 8),
      finish_time(integration, 19),
      finish_time(security_review, 22),
      finish_time(load_test, 21),
      finish_time(launch, 23)]).
step(finish_time(requirements, 2),
     rule(29),
     ['Task' = requirements, 'Finish' = 2, 'Candidate' = _0, 'Bag1' = [2], 'Finishes' = [2]],
     [task(requirements, 2),
      findall(_1, duration_path(requirements, _2, _1), [2]),
      sort([2], [2]),
      max_list([2], 2)]).
step(task(requirements, 2), fact(1), [], []).
step(findall(_0, duration_path(requirements, _1, _0), [2]),
     collected,
     [],
     [duration_path(requirements, [requirements], 2)]).
step(duration_path(requirements, [requirements], 2),
     rule(27),
     ['Task' = requirements, 'Duration' = 2],
     [task(requirements, 2), \+has_predecessor(requirements)]).
step(\+has_predecessor(requirements), absent, [], []).
step(sort([2], [2]), builtin, [], []).
step(max_list([2], 2), builtin, [], []).
step(finish_time(architecture, 5),
     rule(29),
     ['Task' = architecture, 'Finish' = 5, 'Candidate' = _0, 'Bag1' = [5], 'Finishes' = [5]],
     [task(architecture, 3),
      findall(_1, duration_path(architecture, _2, _1), [5]),
      sort([5], [5]),
      max_list([5], 5)]).
step(task(architecture, 3), fact(2), [], []).
step(findall(_0, duration_path(architecture, _1, _0), [5]),
     collected,
     [],
     [duration_path(architecture, [architecture, requirements], 5)]).
step(duration_path(architecture, [architecture, requirements], 5),
     rule(28),
     ['Task' = architecture,
      'Path' = [requirements],
      'Finish' = 5,
      'Duration' = 3,
      'Predecessor' = requirements,
      'Previous' = 2],
     [task(architecture, 3),
      depends(architecture, requirements),
      duration_path(requirements, [requirements], 2),
      5 is 2 + 3]).
step(depends(architecture, requirements), fact(12), [], []).
step(5 is 2 + 3, builtin, [], []).
step(sort([5], [5]), builtin, [], []).
step(max_list([5], 5), builtin, [], []).
step(finish_time(api_design, 4),
     rule(29),
     ['Task' = api_design, 'Finish' = 4, 'Candidate' = _0, 'Bag1' = [4], 'Finishes' = [4]],
     [task(api_design, 2),
      findall(_1, duration_path(api_design, _2, _1), [4]),
      sort([4], [4]),
      max_list([4], 4)]).
step(task(api_design, 2), fact(3), [], []).
step(findall(_0, duration_path(api_design, _1, _0), [4]),
     collected,
     [],
     [duration_path(api_design, [api_design, requirements], 4)]).
step(duration_path(api_design, [api_design, requirements], 4),
     rule(28),
     ['Task' = api_design,
      'Path' = [requirements],
      'Finish' = 4,
      'Duration' = 2,
      'Predecessor' = requirements,
      'Previous' = 2],
     [task(api_design, 2),
      depends(api_design, requirements),
      duration_path(requirements, [requirements], 2),
      4 is 2 + 2]).
step(depends(api_design, requirements), fact(13), [], []).
step(4 is 2 + 2, builtin, [], []).
step(sort([4], [4]), builtin, [], []).
step(max_list([4], 4), builtin, [], []).
step(finish_time(database, 9),
     rule(29),
     ['Task' = database, 'Finish' = 9, 'Candidate' = _0, 'Bag1' = [9], 'Finishes' = [9]],
     [task(database, 4),
      findall(_1, duration_path(database, _2, _1), [9]),
      sort([9], [9]),
      max_list([9], 9)]).
step(task(database, 4), fact(4), [], []).
step(findall(_0, duration_path(database, _1, _0), [9]),
     collected,
     [],
     [duration_path(database, [database, architecture, requirements], 9)]).
step(duration_path(database, [database, architecture, requirements], 9),
     rule(28),
     ['Task' = database,
      'Path' = [architecture, requirements],
      'Finish' = 9,
      'Duration' = 4,
      'Predecessor' = architecture,
      'Previous' = 5],
     [task(database, 4),
      depends(database, architecture),
      duration_path(architecture, [architecture, requirements], 5),
      9 is 5 + 4]).
step(depends(database, architecture), fact(14), [], []).
step(9 is 5 + 4, builtin, [], []).
step(sort([9], [9]), builtin, [], []).
step(max_list([9], 9), builtin, [], []).
step(finish_time(backend, 15),
     rule(29),
     ['Task' = backend,
      'Finish' = 15,
      'Candidate' = _0,
      'Bag1' = [10, 15],
      'Finishes' = [10, 15]],
     [task(backend, 6),
      findall(_1, duration_path(backend, _2, _1), [10, 15]),
      sort([10, 15], [10, 15]),
      max_list([10, 15], 15)]).
step(task(backend, 6), fact(5), [], []).
step(findall(_0, duration_path(backend, _1, _0), [10, 15]),
     collected,
     [],
     [duration_path(backend, [backend, api_design, requirements], 10),
      duration_path(backend, [backend, database, architecture, requirements], 15)]).
step(duration_path(backend, [backend, api_design, requirements], 10),
     rule(28),
     ['Task' = backend,
      'Path' = [api_design, requirements],
      'Finish' = 10,
      'Duration' = 6,
      'Predecessor' = api_design,
      'Previous' = 4],
     [task(backend, 6),
      depends(backend, api_design),
      duration_path(api_design, [api_design, requirements], 4),
      10 is 4 + 6]).
step(depends(backend, api_design), fact(15), [], []).
step(10 is 4 + 6, builtin, [], []).
step(duration_path(backend, [backend, database, architecture, requirements], 15),
     rule(28),
     ['Task' = backend,
      'Path' = [database, architecture, requirements],
      'Finish' = 15,
      'Duration' = 6,
      'Predecessor' = database,
      'Previous' = 9],
     [task(backend, 6),
      depends(backend, database),
      duration_path(database, [database, architecture, requirements], 9),
      15 is 9 + 6]).
step(depends(backend, database), fact(16), [], []).
step(15 is 9 + 6, builtin, [], []).
step(sort([10, 15], [10, 15]), builtin, [], []).
step(max_list([10, 15], 15), builtin, [], []).
step(finish_time(auth, 8),
     rule(29),
     ['Task' = auth, 'Finish' = 8, 'Candidate' = _0, 'Bag1' = [8], 'Finishes' = [8]],
     [task(auth, 3),
      findall(_1, duration_path(auth, _2, _1), [8]),
      sort([8], [8]),
      max_list([8], 8)]).
step(task(auth, 3), fact(7), [], []).
step(findall(_0, duration_path(auth, _1, _0), [8]),
     collected,
     [],
     [duration_path(auth, [auth, architecture, requirements], 8)]).
step(duration_path(auth, [auth, architecture, requirements], 8),
     rule(28),
     ['Task' = auth,
      'Path' = [architecture, requirements],
      'Finish' = 8,
      'Duration' = 3,
      'Predecessor' = architecture,
      'Previous' = 5],
     [task(auth, 3),
      depends(auth, architecture),
      duration_path(architecture, [architecture, requirements], 5),
      8 is 5 + 3]).
step(depends(auth, architecture), fact(18), [], []).
step(8 is 5 + 3, builtin, [], []).
step(sort([8], [8]), builtin, [], []).
step(max_list([8], 8), builtin, [], []).
step(finish_time(integration, 19),
     rule(29),
     ['Task' = integration,
      'Finish' = 19,
      'Candidate' = _0,
      'Bag1' = [14, 13, 12, 19],
      'Finishes' = [12, 13, 14, 19]],
     [task(integration, 4),
      findall(_1, duration_path(integration, _2, _1), [14, 13, 12, 19]),
      sort([14, 13, 12, 19], [12, 13, 14, 19]),
      max_list([12, 13, 14, 19], 19)]).
step(task(integration, 4), fact(8), [], []).
step(findall(_0, duration_path(integration, _1, _0), [14, 13, 12, 19]),
     collected,
     [],
     [duration_path(integration, [integration, backend, api_design, requirements], 14),
      duration_path(integration, [integration, frontend, api_design, requirements], 13),
      duration_path(integration, [integration, auth, architecture, requirements], 12),
      duration_path(integration, [integration, backend, database, architecture, requirements], 19)]).
step(duration_path(integration, [integration, backend, api_design, requirements], 14),
     rule(28),
     ['Task' = integration,
      'Path' = [backend, api_design, requirements],
      'Finish' = 14,
      'Duration' = 4,
      'Predecessor' = backend,
      'Previous' = 10],
     [task(integration, 4),
      depends(integration, backend),
      duration_path(backend, [backend, api_design, requirements], 10),
      14 is 10 + 4]).
step(depends(integration, backend), fact(19), [], []).
step(14 is 10 + 4, builtin, [], []).
step(duration_path(integration, [integration, frontend, api_design, requirements], 13),
     rule(28),
     ['Task' = integration,
      'Path' = [frontend, api_design, requirements],
      'Finish' = 13,
      'Duration' = 4,
      'Predecessor' = frontend,
      'Previous' = 9],
     [task(integration, 4),
      depends(integration, frontend),
      duration_path(frontend, [frontend, api_design, requirements], 9),
      13 is 9 + 4]).
step(depends(integration, frontend), fact(20), [], []).
step(duration_path(frontend, [frontend, api_design, requirements], 9),
     rule(28),
     ['Task' = frontend,
      'Path' = [api_design, requirements],
      'Finish' = 9,
      'Duration' = 5,
      'Predecessor' = api_design,
      'Previous' = 4],
     [task(frontend, 5),
      depends(frontend, api_design),
      duration_path(api_design, [api_design, requirements], 4),
      9 is 4 + 5]).
step(task(frontend, 5), fact(6), [], []).
step(depends(frontend, api_design), fact(17), [], []).
step(9 is 4 + 5, builtin, [], []).
step(13 is 9 + 4, builtin, [], []).
step(duration_path(integration, [integration, auth, architecture, requirements], 12),
     rule(28),
     ['Task' = integration,
      'Path' = [auth, architecture, requirements],
      'Finish' = 12,
      'Duration' = 4,
      'Predecessor' = auth,
      'Previous' = 8],
     [task(integration, 4),
      depends(integration, auth),
      duration_path(auth, [auth, architecture, requirements], 8),
      12 is 8 + 4]).
step(depends(integration, auth), fact(21), [], []).
step(12 is 8 + 4, builtin, [], []).
step(duration_path(integration, [integration, backend, database, architecture, requirements], 19),
     rule(28),
     ['Task' = integration,
      'Path' = [backend, database, architecture, requirements],
      'Finish' = 19,
      'Duration' = 4,
      'Predecessor' = backend,
      'Previous' = 15],
     [task(integration, 4),
      depends(integration, backend),
      duration_path(backend, [backend, database, architecture, requirements], 15),
      19 is 15 + 4]).
step(19 is 15 + 4, builtin, [], []).
step(sort([14, 13, 12, 19], [12, 13, 14, 19]), builtin, [], []).
step(max_list([12, 13, 14, 19], 19), builtin, [], []).
step(finish_time(security_review, 22),
     rule(29),
     ['Task' = security_review,
      'Finish' = 22,
      'Candidate' = _0,
      'Bag1' = [17, 16, 15, 22],
      'Finishes' = [15, 16, 17, 22]],
     [task(security_review, 3),
      findall(_1, duration_path(security_review, _2, _1), [17, 16, 15, 22]),
      sort([17, 16, 15, 22], [15, 16, 17, 22]),
      max_list([15, 16, 17, 22], 22)]).
step(task(security_review, 3), fact(9), [], []).
step(findall(_0, duration_path(security_review, _1, _0), [17, 16, 15, 22]),
     collected,
     [],
     [duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17),
      duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16),
      duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15),
      duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22)]).
step(duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17),
     rule(28),
     ['Task' = security_review,
      'Path' = [integration, backend, api_design, requirements],
      'Finish' = 17,
      'Duration' = 3,
      'Predecessor' = integration,
      'Previous' = 14],
     [task(security_review, 3),
      depends(security_review, integration),
      duration_path(integration, [integration, backend, api_design, requirements], 14),
      17 is 14 + 3]).
step(depends(security_review, integration), fact(22), [], []).
step(17 is 14 + 3, builtin, [], []).
step(duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16),
     rule(28),
     ['Task' = security_review,
      'Path' = [integration, frontend, api_design, requirements],
      'Finish' = 16,
      'Duration' = 3,
      'Predecessor' = integration,
      'Previous' = 13],
     [task(security_review, 3),
      depends(security_review, integration),
      duration_path(integration, [integration, frontend, api_design, requirements], 13),
      16 is 13 + 3]).
step(16 is 13 + 3, builtin, [], []).
step(duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15),
     rule(28),
     ['Task' = security_review,
      'Path' = [integration, auth, architecture, requirements],
      'Finish' = 15,
      'Duration' = 3,
      'Predecessor' = integration,
      'Previous' = 12],
     [task(security_review, 3),
      depends(security_review, integration),
      duration_path(integration, [integration, auth, architecture, requirements], 12),
      15 is 12 + 3]).
step(15 is 12 + 3, builtin, [], []).
step(duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22),
     rule(28),
     ['Task' = security_review,
      'Path' = [integration, backend, database, architecture, requirements],
      'Finish' = 22,
      'Duration' = 3,
      'Predecessor' = integration,
      'Previous' = 19],
     [task(security_review, 3),
      depends(security_review, integration),
      duration_path(integration, [integration, backend, database, architecture, requirements], 19),
      22 is 19 + 3]).
step(22 is 19 + 3, builtin, [], []).
step(sort([17, 16, 15, 22], [15, 16, 17, 22]), builtin, [], []).
step(max_list([15, 16, 17, 22], 22), builtin, [], []).
step(finish_time(load_test, 21),
     rule(29),
     ['Task' = load_test,
      'Finish' = 21,
      'Candidate' = _0,
      'Bag1' = [16, 15, 14, 21],
      'Finishes' = [14, 15, 16, 21]],
     [task(load_test, 2),
      findall(_1, duration_path(load_test, _2, _1), [16, 15, 14, 21]),
      sort([16, 15, 14, 21], [14, 15, 16, 21]),
      max_list([14, 15, 16, 21], 21)]).
step(task(load_test, 2), fact(10), [], []).
step(findall(_0, duration_path(load_test, _1, _0), [16, 15, 14, 21]),
     collected,
     [],
     [duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16),
      duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15),
      duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14),
      duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21)]).
step(duration_path(load_test, [load_test, integration, backend, api_design, requirements], 16),
     rule(28),
     ['Task' = load_test,
      'Path' = [integration, backend, api_design, requirements],
      'Finish' = 16,
      'Duration' = 2,
      'Predecessor' = integration,
      'Previous' = 14],
     [task(load_test, 2),
      depends(load_test, integration),
      duration_path(integration, [integration, backend, api_design, requirements], 14),
      16 is 14 + 2]).
step(depends(load_test, integration), fact(23), [], []).
step(16 is 14 + 2, builtin, [], []).
step(duration_path(load_test, [load_test, integration, frontend, api_design, requirements], 15),
     rule(28),
     ['Task' = load_test,
      'Path' = [integration, frontend, api_design, requirements],
      'Finish' = 15,
      'Duration' = 2,
      'Predecessor' = integration,
      'Previous' = 13],
     [task(load_test, 2),
      depends(load_test, integration),
      duration_path(integration, [integration, frontend, api_design, requirements], 13),
      15 is 13 + 2]).
step(15 is 13 + 2, builtin, [], []).
step(duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14),
     rule(28),
     ['Task' = load_test,
      'Path' = [integration, auth, architecture, requirements],
      'Finish' = 14,
      'Duration' = 2,
      'Predecessor' = integration,
      'Previous' = 12],
     [task(load_test, 2),
      depends(load_test, integration),
      duration_path(integration, [integration, auth, architecture, requirements], 12),
      14 is 12 + 2]).
step(14 is 12 + 2, builtin, [], []).
step(duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21),
     rule(28),
     ['Task' = load_test,
      'Path' = [integration, backend, database, architecture, requirements],
      'Finish' = 21,
      'Duration' = 2,
      'Predecessor' = integration,
      'Previous' = 19],
     [task(load_test, 2),
      depends(load_test, integration),
      duration_path(integration, [integration, backend, database, architecture, requirements], 19),
      21 is 19 + 2]).
step(21 is 19 + 2, builtin, [], []).
step(sort([16, 15, 14, 21], [14, 15, 16, 21]), builtin, [], []).
step(max_list([14, 15, 16, 21], 21), builtin, [], []).
step(finish_time(launch, 23),
     rule(29),
     ['Task' = launch,
      'Finish' = 23,
      'Candidate' = _0,
      'Bag1' = [18, 17, 16, 15, 23, 22],
      'Finishes' = [15, 16, 17, 18, 22, 23]],
     [task(launch, 1),
      findall(_1, duration_path(launch, _2, _1), [18, 17, 16, 15, 23, 22]),
      sort([18, 17, 16, 15, 23, 22], [15, 16, 17, 18, 22, 23]),
      max_list([15, 16, 17, 18, 22, 23], 23)]).
step(task(launch, 1), fact(11), [], []).
step(findall(_0, duration_path(launch, _1, _0), [18, 17, 16, 15, 23, 22]),
     collected,
     [],
     [duration_path(launch, [launch, security_review, integration, backend, api_design, requirements], 18),
      duration_path(launch, [launch, security_review, integration, frontend, api_design, requirements], 17),
      duration_path(launch, [launch, security_review, integration, auth, architecture, requirements], 16),
      duration_path(launch, [launch, load_test, integration, auth, architecture, requirements], 15),
      duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23),
      duration_path(launch, [launch, load_test, integration, backend, database, architecture, requirements], 22)]).
step(duration_path(launch, [launch, security_review, integration, backend, api_design, requirements], 18),
     rule(28),
     ['Task' = launch,
      'Path' = [security_review, integration, backend, api_design, requirements],
      'Finish' = 18,
      'Duration' = 1,
      'Predecessor' = security_review,
      'Previous' = 17],
     [task(launch, 1),
      depends(launch, security_review),
      duration_path(security_review, [security_review, integration, backend, api_design, requirements], 17),
      18 is 17 + 1]).
step(depends(launch, security_review), fact(24), [], []).
step(18 is 17 + 1, builtin, [], []).
step(duration_path(launch, [launch, security_review, integration, frontend, api_design, requirements], 17),
     rule(28),
     ['Task' = launch,
      'Path' = [security_review, integration, frontend, api_design, requirements],
      'Finish' = 17,
      'Duration' = 1,
      'Predecessor' = security_review,
      'Previous' = 16],
     [task(launch, 1),
      depends(launch, security_review),
      duration_path(security_review, [security_review, integration, frontend, api_design, requirements], 16),
      17 is 16 + 1]).
step(17 is 16 + 1, builtin, [], []).
step(duration_path(launch, [launch, security_review, integration, auth, architecture, requirements], 16),
     rule(28),
     ['Task' = launch,
      'Path' = [security_review, integration, auth, architecture, requirements],
      'Finish' = 16,
      'Duration' = 1,
      'Predecessor' = security_review,
      'Previous' = 15],
     [task(launch, 1),
      depends(launch, security_review),
      duration_path(security_review, [security_review, integration, auth, architecture, requirements], 15),
      16 is 15 + 1]).
step(16 is 15 + 1, builtin, [], []).
step(duration_path(launch, [launch, load_test, integration, auth, architecture, requirements], 15),
     rule(28),
     ['Task' = launch,
      'Path' = [load_test, integration, auth, architecture, requirements],
      'Finish' = 15,
      'Duration' = 1,
      'Predecessor' = load_test,
      'Previous' = 14],
     [task(launch, 1),
      depends(launch, load_test),
      duration_path(load_test, [load_test, integration, auth, architecture, requirements], 14),
      15 is 14 + 1]).
step(depends(launch, load_test), fact(25), [], []).
step(15 is 14 + 1, builtin, [], []).
step(duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23),
     rule(28),
     ['Task' = launch,
      'Path' = [security_review, integration, backend, database, architecture, requirements],
      'Finish' = 23,
      'Duration' = 1,
      'Predecessor' = security_review,
      'Previous' = 22],
     [task(launch, 1),
      depends(launch, security_review),
      duration_path(security_review, [security_review, integration, backend, database, architecture, requirements], 22),
      23 is 22 + 1]).
step(23 is 22 + 1, builtin, [], []).
step(duration_path(launch, [launch, load_test, integration, backend, database, architecture, requirements], 22),
     rule(28),
     ['Task' = launch,
      'Path' = [load_test, integration, backend, database, architecture, requirements],
      'Finish' = 22,
      'Duration' = 1,
      'Predecessor' = load_test,
      'Previous' = 21],
     [task(launch, 1),
      depends(launch, load_test),
      duration_path(load_test, [load_test, integration, backend, database, architecture, requirements], 21),
      22 is 21 + 1]).
step(22 is 21 + 1, builtin, [], []).
step(sort([18, 17, 16, 15, 23, 22], [15, 16, 17, 18, 22, 23]), builtin, [], []).
step(max_list([15, 16, 17, 18, 22, 23], 23), builtin, [], []).
step(sort([2, 5, 4, 9, 15, 8, 19, 22, 21, 23], [2, 4, 5, 8, 9, 15, 19, 21, 22, 23]),
     builtin,
     [],
     []).
step(max_list([2, 4, 5, 8, 9, 15, 19, 21, 22, 23], 23), builtin, [], []).
step(critical_task(launch),
     rule(34),
     ['Task' = launch,
      'Finish' = 23,
      'Path' = [launch, security_review, integration, backend, database, architecture, requirements]],
     [project_finish(23),
      duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23),
      member(launch, [launch, security_review, integration, backend, database, architecture, requirements])]).
step(member(launch, [launch, security_review, integration, backend, database, architecture, requirements]),
     fact(32),
     ['X' = launch],
     []).
step(critical_task(security_review),
     rule(34),
     ['Task' = security_review,
      'Finish' = 23,
      'Path' = [launch, security_review, integration, backend, database, architecture, requirements]],
     [project_finish(23),
      duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23),
      member(security_review, [launch, security_review, integration, backend, database, architecture, requirements])]).
step(member(security_review, [launch, security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = security_review,
      'Rest' = [security_review, integration, backend, database, architecture, requirements]],
     [member(security_review, [security_review, integration, backend, database, architecture, requirements])]).
step(member(security_review, [security_review, integration, backend, database, architecture, requirements]),
     fact(32),
     ['X' = security_review],
     []).
step(critical_task(integration),
     rule(34),
     ['Task' = integration,
      'Finish' = 23,
      'Path' = [launch, security_review, integration, backend, database, architecture, requirements]],
     [project_finish(23),
      duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23),
      member(integration, [launch, security_review, integration, backend, database, architecture, requirements])]).
step(member(integration, [launch, security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = integration,
      'Rest' = [security_review, integration, backend, database, architecture, requirements]],
     [member(integration, [security_review, integration, backend, database, architecture, requirements])]).
step(member(integration, [security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = integration, 'Rest' = [integration, backend, database, architecture, requirements]],
     [member(integration, [integration, backend, database, architecture, requirements])]).
step(member(integration, [integration, backend, database, architecture, requirements]),
     fact(32),
     ['X' = integration],
     []).
step(critical_task(backend),
     rule(34),
     ['Task' = backend,
      'Finish' = 23,
      'Path' = [launch, security_review, integration, backend, database, architecture, requirements]],
     [project_finish(23),
      duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23),
      member(backend, [launch, security_review, integration, backend, database, architecture, requirements])]).
step(member(backend, [launch, security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = backend,
      'Rest' = [security_review, integration, backend, database, architecture, requirements]],
     [member(backend, [security_review, integration, backend, database, architecture, requirements])]).
step(member(backend, [security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = backend, 'Rest' = [integration, backend, database, architecture, requirements]],
     [member(backend, [integration, backend, database, architecture, requirements])]).
step(member(backend, [integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = backend, 'Rest' = [backend, database, architecture, requirements]],
     [member(backend, [backend, database, architecture, requirements])]).
step(member(backend, [backend, database, architecture, requirements]),
     fact(32),
     ['X' = backend],
     []).
step(critical_task(database),
     rule(34),
     ['Task' = database,
      'Finish' = 23,
      'Path' = [launch, security_review, integration, backend, database, architecture, requirements]],
     [project_finish(23),
      duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23),
      member(database, [launch, security_review, integration, backend, database, architecture, requirements])]).
step(member(database, [launch, security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = database,
      'Rest' = [security_review, integration, backend, database, architecture, requirements]],
     [member(database, [security_review, integration, backend, database, architecture, requirements])]).
step(member(database, [security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = database, 'Rest' = [integration, backend, database, architecture, requirements]],
     [member(database, [integration, backend, database, architecture, requirements])]).
step(member(database, [integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = database, 'Rest' = [backend, database, architecture, requirements]],
     [member(database, [backend, database, architecture, requirements])]).
step(member(database, [backend, database, architecture, requirements]),
     rule(33),
     ['X' = database, 'Rest' = [database, architecture, requirements]],
     [member(database, [database, architecture, requirements])]).
step(member(database, [database, architecture, requirements]), fact(32), ['X' = database], []).
step(critical_task(architecture),
     rule(34),
     ['Task' = architecture,
      'Finish' = 23,
      'Path' = [launch, security_review, integration, backend, database, architecture, requirements]],
     [project_finish(23),
      duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23),
      member(architecture, [launch, security_review, integration, backend, database, architecture, requirements])]).
step(member(architecture, [launch, security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = architecture,
      'Rest' = [security_review, integration, backend, database, architecture, requirements]],
     [member(architecture, [security_review, integration, backend, database, architecture, requirements])]).
step(member(architecture, [security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = architecture, 'Rest' = [integration, backend, database, architecture, requirements]],
     [member(architecture, [integration, backend, database, architecture, requirements])]).
step(member(architecture, [integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = architecture, 'Rest' = [backend, database, architecture, requirements]],
     [member(architecture, [backend, database, architecture, requirements])]).
step(member(architecture, [backend, database, architecture, requirements]),
     rule(33),
     ['X' = architecture, 'Rest' = [database, architecture, requirements]],
     [member(architecture, [database, architecture, requirements])]).
step(member(architecture, [database, architecture, requirements]),
     rule(33),
     ['X' = architecture, 'Rest' = [architecture, requirements]],
     [member(architecture, [architecture, requirements])]).
step(member(architecture, [architecture, requirements]), fact(32), ['X' = architecture], []).
step(critical_task(requirements),
     rule(34),
     ['Task' = requirements,
      'Finish' = 23,
      'Path' = [launch, security_review, integration, backend, database, architecture, requirements]],
     [project_finish(23),
      duration_path(launch, [launch, security_review, integration, backend, database, architecture, requirements], 23),
      member(requirements, [launch, security_review, integration, backend, database, architecture, requirements])]).
step(member(requirements, [launch, security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = requirements,
      'Rest' = [security_review, integration, backend, database, architecture, requirements]],
     [member(requirements, [security_review, integration, backend, database, architecture, requirements])]).
step(member(requirements, [security_review, integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = requirements, 'Rest' = [integration, backend, database, architecture, requirements]],
     [member(requirements, [integration, backend, database, architecture, requirements])]).
step(member(requirements, [integration, backend, database, architecture, requirements]),
     rule(33),
     ['X' = requirements, 'Rest' = [backend, database, architecture, requirements]],
     [member(requirements, [backend, database, architecture, requirements])]).
step(member(requirements, [backend, database, architecture, requirements]),
     rule(33),
     ['X' = requirements, 'Rest' = [database, architecture, requirements]],
     [member(requirements, [database, architecture, requirements])]).
step(member(requirements, [database, architecture, requirements]),
     rule(33),
     ['X' = requirements, 'Rest' = [architecture, requirements]],
     [member(requirements, [architecture, requirements])]).
step(member(requirements, [architecture, requirements]),
     rule(33),
     ['X' = requirements, 'Rest' = [requirements]],
     [member(requirements, [requirements])]).
step(member(requirements, [requirements]), fact(32), ['X' = requirements], []).
step(schedule(requirements, 0, 2),
     rule(30),
     ['Task' = requirements, 'Start' = 0, 'Finish' = 2, 'Duration' = 2],
     [task(requirements, 2), finish_time(requirements, 2), 0 is 2 - 2]).
step(0 is 2 - 2, builtin, [], []).
step(schedule(architecture, 2, 5),
     rule(30),
     ['Task' = architecture, 'Start' = 2, 'Finish' = 5, 'Duration' = 3],
     [task(architecture, 3), finish_time(architecture, 5), 2 is 5 - 3]).
step(2 is 5 - 3, builtin, [], []).
step(schedule(api_design, 2, 4),
     rule(30),
     ['Task' = api_design, 'Start' = 2, 'Finish' = 4, 'Duration' = 2],
     [task(api_design, 2), finish_time(api_design, 4), 2 is 4 - 2]).
step(2 is 4 - 2, builtin, [], []).
step(schedule(database, 5, 9),
     rule(30),
     ['Task' = database, 'Start' = 5, 'Finish' = 9, 'Duration' = 4],
     [task(database, 4), finish_time(database, 9), 5 is 9 - 4]).
step(5 is 9 - 4, builtin, [], []).
step(schedule(backend, 9, 15),
     rule(30),
     ['Task' = backend, 'Start' = 9, 'Finish' = 15, 'Duration' = 6],
     [task(backend, 6), finish_time(backend, 15), 9 is 15 - 6]).
step(9 is 15 - 6, builtin, [], []).
step(schedule(frontend, 4, 9),
     rule(30),
     ['Task' = frontend, 'Start' = 4, 'Finish' = 9, 'Duration' = 5],
     [task(frontend, 5), finish_time(frontend, 9), 4 is 9 - 5]).
step(finish_time(frontend, 9),
     rule(29),
     ['Task' = frontend, 'Finish' = 9, 'Candidate' = _0, 'Bag1' = [9], 'Finishes' = [9]],
     [task(frontend, 5),
      findall(_1, duration_path(frontend, _2, _1), [9]),
      sort([9], [9]),
      max_list([9], 9)]).
step(findall(_0, duration_path(frontend, _1, _0), [9]),
     collected,
     [],
     [duration_path(frontend, [frontend, api_design, requirements], 9)]).
step(4 is 9 - 5, builtin, [], []).
step(schedule(auth, 5, 8),
     rule(30),
     ['Task' = auth, 'Start' = 5, 'Finish' = 8, 'Duration' = 3],
     [task(auth, 3), finish_time(auth, 8), 5 is 8 - 3]).
step(5 is 8 - 3, builtin, [], []).
step(schedule(integration, 15, 19),
     rule(30),
     ['Task' = integration, 'Start' = 15, 'Finish' = 19, 'Duration' = 4],
     [task(integration, 4), finish_time(integration, 19), 15 is 19 - 4]).
step(15 is 19 - 4, builtin, [], []).
step(schedule(security_review, 19, 22),
     rule(30),
     ['Task' = security_review, 'Start' = 19, 'Finish' = 22, 'Duration' = 3],
     [task(security_review, 3), finish_time(security_review, 22), 19 is 22 - 3]).
step(19 is 22 - 3, builtin, [], []).
step(schedule(load_test, 19, 21),
     rule(30),
     ['Task' = load_test, 'Start' = 19, 'Finish' = 21, 'Duration' = 2],
     [task(load_test, 2), finish_time(load_test, 21), 19 is 21 - 2]).
step(19 is 21 - 2, builtin, [], []).
step(schedule(launch, 22, 23),
     rule(30),
     ['Task' = launch, 'Start' = 22, 'Finish' = 23, 'Duration' = 1],
     [task(launch, 1), finish_time(launch, 23), 22 is 23 - 1]).
step(22 is 23 - 1, builtin, [], []).
