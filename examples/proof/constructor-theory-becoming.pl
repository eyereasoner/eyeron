status(perfectRestoreTask, impossibleTask).
status(writeTask, possibleTask).
status(stabilizeTask, possibleTask).
status(vBad, blockedTransition).
retains_capacity_for(writer, writeTask).
retains_capacity_for(stabilizer, stabilizeTask).
can_undergo(v2, writeTask).
can_undergo(v3, stabilizeTask).
becomes_from(v2, v1).
becomes_from(v3, v2).
has_attribute(v1, blankMemory).
has_attribute(damaged1, damagedMemory).
has_attribute(v2, encodedMemory).
has_attribute(v3, stabilizedMemory).
available_for_further_task(v1, yes).
available_for_further_task(damaged1, yes).
available_for_further_task(v2, yes).
available_for_further_task(v3, yes).

clause(1, task_input(writeTask, blankMemory), true).
clause(2, task_output(writeTask, encodedMemory), true).
clause(3, task_input(stabilizeTask, encodedMemory), true).
clause(4, task_output(stabilizeTask, stabilizedMemory), true).
clause(7, forbidden_by(perfectRestoreTask, noMiraclePrinciple), true).
clause(8, can_perform(writer, writeTask), true).
clause(9, can_perform(stabilizer, stabilizeTask), true).
clause(10, has_attribute(v1, blankMemory), true).
clause(11, derives_from(v2, v1), true).
clause(12, intends_task(v2, writeTask), true).
clause(13, derives_from(v3, v2), true).
clause(14, intends_task(v3, stabilizeTask), true).
clause(15, has_attribute(damaged1, damagedMemory), true).
clause(17, intends_task(vBad, perfectRestoreTask), true).
clause(18, status(var('Task'), impossibleTask), forbidden_by(var('Task'), var('Principle'))).
clause(19, status(var('Task'), possibleTask), can_perform(var('Constructor'), var('Task'))).
clause(20,
       retains_capacity_for(var('Constructor'), var('Task')),
       can_perform(var('Constructor'), var('Task'))).
clause(21,
       can_undergo(var('Next'), var('Task')),
       (derives_from(var('Next'), var('Prev')),
        intends_task(var('Next'), var('Task')),
        status(var('Task'), possibleTask),
        task_input(var('Task'), var('In')),
        has_attribute(var('Prev'), var('In')))).
clause(22,
       becomes_from(var('Next'), var('Prev')),
       (derives_from(var('Next'), var('Prev')),
        intends_task(var('Next'), var('Task')),
        status(var('Task'), possibleTask),
        task_input(var('Task'), var('In')),
        has_attribute(var('Prev'), var('In')))).
clause(23,
       has_attribute(var('Next'), var('Out')),
       (can_undergo(var('Next'), var('Task')), task_output(var('Task'), var('Out')))).
clause(24,
       status(var('Next'), blockedTransition),
       (intends_task(var('Next'), var('Task')), status(var('Task'), impossibleTask))).
clause(25,
       available_for_further_task(var('Next'), yes),
       has_attribute(var('Next'), var('Attr'))).

step(status(perfectRestoreTask, impossibleTask),
     rule(18),
     ['Task' = perfectRestoreTask, 'Principle' = noMiraclePrinciple],
     [forbidden_by(perfectRestoreTask, noMiraclePrinciple)]).
step(forbidden_by(perfectRestoreTask, noMiraclePrinciple), fact(7), [], []).
step(status(writeTask, possibleTask),
     rule(19),
     ['Task' = writeTask, 'Constructor' = writer],
     [can_perform(writer, writeTask)]).
step(can_perform(writer, writeTask), fact(8), [], []).
step(status(stabilizeTask, possibleTask),
     rule(19),
     ['Task' = stabilizeTask, 'Constructor' = stabilizer],
     [can_perform(stabilizer, stabilizeTask)]).
step(can_perform(stabilizer, stabilizeTask), fact(9), [], []).
step(status(vBad, blockedTransition),
     rule(24),
     ['Next' = vBad, 'Task' = perfectRestoreTask],
     [intends_task(vBad, perfectRestoreTask), status(perfectRestoreTask, impossibleTask)]).
step(intends_task(vBad, perfectRestoreTask), fact(17), [], []).
step(retains_capacity_for(writer, writeTask),
     rule(20),
     ['Constructor' = writer, 'Task' = writeTask],
     [can_perform(writer, writeTask)]).
step(retains_capacity_for(stabilizer, stabilizeTask),
     rule(20),
     ['Constructor' = stabilizer, 'Task' = stabilizeTask],
     [can_perform(stabilizer, stabilizeTask)]).
step(can_undergo(v2, writeTask),
     rule(21),
     ['Next' = v2, 'Task' = writeTask, 'Prev' = v1, 'In' = blankMemory],
     [derives_from(v2, v1),
      intends_task(v2, writeTask),
      status(writeTask, possibleTask),
      task_input(writeTask, blankMemory),
      has_attribute(v1, blankMemory)]).
step(derives_from(v2, v1), fact(11), [], []).
step(intends_task(v2, writeTask), fact(12), [], []).
step(task_input(writeTask, blankMemory), fact(1), [], []).
step(has_attribute(v1, blankMemory), fact(10), [], []).
step(can_undergo(v3, stabilizeTask),
     rule(21),
     ['Next' = v3, 'Task' = stabilizeTask, 'Prev' = v2, 'In' = encodedMemory],
     [derives_from(v3, v2),
      intends_task(v3, stabilizeTask),
      status(stabilizeTask, possibleTask),
      task_input(stabilizeTask, encodedMemory),
      has_attribute(v2, encodedMemory)]).
step(derives_from(v3, v2), fact(13), [], []).
step(intends_task(v3, stabilizeTask), fact(14), [], []).
step(task_input(stabilizeTask, encodedMemory), fact(3), [], []).
step(has_attribute(v2, encodedMemory),
     rule(23),
     ['Next' = v2, 'Out' = encodedMemory, 'Task' = writeTask],
     [can_undergo(v2, writeTask), task_output(writeTask, encodedMemory)]).
step(task_output(writeTask, encodedMemory), fact(2), [], []).
step(becomes_from(v2, v1),
     rule(22),
     ['Next' = v2, 'Prev' = v1, 'Task' = writeTask, 'In' = blankMemory],
     [derives_from(v2, v1),
      intends_task(v2, writeTask),
      status(writeTask, possibleTask),
      task_input(writeTask, blankMemory),
      has_attribute(v1, blankMemory)]).
step(becomes_from(v3, v2),
     rule(22),
     ['Next' = v3, 'Prev' = v2, 'Task' = stabilizeTask, 'In' = encodedMemory],
     [derives_from(v3, v2),
      intends_task(v3, stabilizeTask),
      status(stabilizeTask, possibleTask),
      task_input(stabilizeTask, encodedMemory),
      has_attribute(v2, encodedMemory)]).
step(has_attribute(damaged1, damagedMemory), fact(15), [], []).
step(has_attribute(v3, stabilizedMemory),
     rule(23),
     ['Next' = v3, 'Out' = stabilizedMemory, 'Task' = stabilizeTask],
     [can_undergo(v3, stabilizeTask), task_output(stabilizeTask, stabilizedMemory)]).
step(task_output(stabilizeTask, stabilizedMemory), fact(4), [], []).
step(available_for_further_task(v1, yes),
     rule(25),
     ['Next' = v1, 'Attr' = blankMemory],
     [has_attribute(v1, blankMemory)]).
step(available_for_further_task(damaged1, yes),
     rule(25),
     ['Next' = damaged1, 'Attr' = damagedMemory],
     [has_attribute(damaged1, damagedMemory)]).
step(available_for_further_task(v2, yes),
     rule(25),
     ['Next' = v2, 'Attr' = encodedMemory],
     [has_attribute(v2, encodedMemory)]).
step(available_for_further_task(v3, yes),
     rule(25),
     ['Next' = v3, 'Attr' = stabilizedMemory],
     [has_attribute(v3, stabilizedMemory)]).
