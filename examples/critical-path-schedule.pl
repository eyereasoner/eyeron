% Same DAG, durations, schedule, finish date, and critical tasks.
% Reformulation: enumerate dependency-path durations before taking maxima.
% This avoids recursion through collect, which Prolog deliberately rejects.
% Paths are finite for this DAG; this is not an efficient large-project scheduler.

task(requirements, 2).
task(architecture, 3).
task(api_design, 2).
task(database, 4).
task(backend, 6).
task(frontend, 5).
task(auth, 3).
task(integration, 4).
task(security_review, 3).
task(load_test, 2).
task(launch, 1).

depends(architecture, requirements).
depends(api_design, requirements).
depends(database, architecture).
depends(backend, api_design).
depends(backend, database).
depends(frontend, api_design).
depends(auth, architecture).
depends(integration, backend).
depends(integration, frontend).
depends(integration, auth).
depends(security_review, integration).
depends(load_test, integration).
depends(launch, security_review).
depends(launch, load_test).

has_predecessor(Task) :-
    depends(Task, _).

duration_path(Task, [Task], Duration) :-
    task(Task, Duration),
    \+ has_predecessor(Task).

duration_path(Task, [Task|Path], Finish) :-
    task(Task, Duration),
    depends(Task, Predecessor),
    duration_path(Predecessor, Path, Previous),
    Finish is Previous + Duration.

finish_time(Task, Finish) :-
    task(Task, _),
    findall(Candidate, duration_path(Task, _, Candidate), Bag1),
    sort(Bag1, Finishes),
    max_list(Finishes, Finish).

schedule(Task, Start, Finish) :-
    task(Task, Duration),
    finish_time(Task, Finish),
    Start is Finish - Duration.

project_finish(Finish) :-
    findall(Candidate, finish_time(_, Candidate), Bag1),
    sort(Bag1, Finishes),
    max_list(Finishes, Finish).

member(X, [X|_]).
member(X, [_|Rest]) :-
    member(X, Rest).

critical_task(Task) :-
    project_finish(Finish),
    duration_path(_, Path, Finish),
    member(Task, Path).

?- project_finish(Finish).
?- critical_task(Task).
?- schedule(Task, Start, Finish).
