% Prolog result format 4
query(1, project_finish(_0), ['Finish' = _0]).
result(1, complete, 1).
answer(1, ['Finish' = 23]).
query(2, critical_task(_0), ['Task' = _0]).
result(2, complete, 7).
answer(2, ['Task' = launch]).
answer(2, ['Task' = security_review]).
answer(2, ['Task' = integration]).
answer(2, ['Task' = backend]).
answer(2, ['Task' = database]).
answer(2, ['Task' = architecture]).
answer(2, ['Task' = requirements]).
query(3, schedule(_0, _1, _2), ['Task' = _0, 'Start' = _1, 'Finish' = _2]).
result(3, complete, 11).
answer(3, ['Task' = requirements, 'Start' = 0, 'Finish' = 2]).
answer(3, ['Task' = architecture, 'Start' = 2, 'Finish' = 5]).
answer(3, ['Task' = api_design, 'Start' = 2, 'Finish' = 4]).
answer(3, ['Task' = database, 'Start' = 5, 'Finish' = 9]).
answer(3, ['Task' = backend, 'Start' = 9, 'Finish' = 15]).
answer(3, ['Task' = frontend, 'Start' = 4, 'Finish' = 9]).
answer(3, ['Task' = auth, 'Start' = 5, 'Finish' = 8]).
answer(3, ['Task' = integration, 'Start' = 15, 'Finish' = 19]).
answer(3, ['Task' = security_review, 'Start' = 19, 'Finish' = 22]).
answer(3, ['Task' = load_test, 'Start' = 19, 'Finish' = 21]).
answer(3, ['Task' = launch, 'Start' = 22, 'Finish' = 23]).
