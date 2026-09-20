# Eyelang example: constructor-theory-becoming.
# Companion to constructor-theory-becoming.n3/.srl: a constructor-theory
# model of possible/impossible tasks and how a sequence of possible
# tasks transforms a substrate, as ordinary relations.
task_input(writeTask, blankMemory). task_output(writeTask, encodedMemory).
task_input(stabilizeTask, encodedMemory). task_output(stabilizeTask, stabilizedMemory).
task_input(perfectRestoreTask, damagedMemory). task_output(perfectRestoreTask, pristineMemory). forbidden_by(perfectRestoreTask, noMiraclePrinciple).

can_perform(writer, writeTask).
can_perform(stabilizer, stabilizeTask).

has_attribute(v1, blankMemory).
derives_from(v2, v1). intends_task(v2, writeTask).
derives_from(v3, v2). intends_task(v3, stabilizeTask).
has_attribute(damaged1, damagedMemory).
derives_from(vBad, damaged1). intends_task(vBad, perfectRestoreTask).

status(?task, impossibleTask) if forbidden_by(?task, ?principle).
status(?task, possibleTask) if can_perform(?constructor, ?task).
retains_capacity_for(?constructor, ?task) if can_perform(?constructor, ?task).

can_undergo(?next, ?task) if derives_from(?next, ?prev), intends_task(?next, ?task), status(?task, possibleTask), task_input(?task, ?in), has_attribute(?prev, ?in).
becomes_from(?next, ?prev) if derives_from(?next, ?prev), intends_task(?next, ?task), status(?task, possibleTask), task_input(?task, ?in), has_attribute(?prev, ?in).

has_attribute(?next, ?out) if can_undergo(?next, ?task), task_output(?task, ?out).

status(?next, blockedTransition) if intends_task(?next, ?task), status(?task, impossibleTask).

available_for_further_task(?next, yes) if has_attribute(?next, ?attr).

ask status(?x, ?s).
ask retains_capacity_for(?c, ?t).
ask can_undergo(?next, ?task).
ask becomes_from(?next, ?prev).
ask has_attribute(?x, ?attr).
ask available_for_further_task(?x, ?y).
