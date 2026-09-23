project_finish(23).
critical_task(launch).
critical_task(security_review).
critical_task(integration).
critical_task(backend).
critical_task(database).
critical_task(architecture).
critical_task(requirements).
schedule(requirements, 0, 2).
schedule(architecture, 2, 5).
schedule(api_design, 2, 4).
schedule(database, 5, 9).
schedule(backend, 9, 15).
schedule(frontend, 4, 9).
schedule(auth, 5, 8).
schedule(integration, 15, 19).
schedule(security_review, 19, 22).
schedule(load_test, 19, 21).
schedule(launch, 22, 23).
