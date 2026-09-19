# Same DAG, durations, schedule, finish date, and critical tasks.
# Reformulation: enumerate dependency-path durations before taking maxima.
# This avoids recursion through collect, which Eyelang deliberately rejects.
# Paths are finite for this DAG; this is not an efficient large-project scheduler.

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

has_predecessor(?task) if depends(?task, ?_).
duration_path(?task, [?task], ?duration) if
    task(?task, ?duration), not has_predecessor(?task).
duration_path(?task, [?task | ?path], ?finish) if
    task(?task, ?duration), depends(?task, ?predecessor),
    duration_path(?predecessor, ?path, ?previous),
    let ?finish = ?previous + ?duration.

finish_time(?task, ?finish) if
    task(?task, ?_),
    collect ?finishes = ?candidate where { duration_path(?task, ?_, ?candidate) },
    let ?finish = max(?finishes).
schedule(?task, ?start, ?finish) if
    task(?task, ?duration), finish_time(?task, ?finish), let ?start = ?finish - ?duration.
project_finish(?finish) if
    collect ?finishes = ?candidate where { finish_time(?_, ?candidate) },
    let ?finish = max(?finishes).

member(?x, [?x | ?_]).
member(?x, [?_ | ?rest]) if member(?x, ?rest).
critical_task(?task) if
    project_finish(?finish), duration_path(?_, ?path, ?finish), member(?task, ?path).

ask project_finish(?finish).
ask critical_task(?task).
ask schedule(?task, ?start, ?finish).
