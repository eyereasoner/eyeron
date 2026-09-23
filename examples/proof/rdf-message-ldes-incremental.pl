already_committed(obs033).
already_committed(obs034).
newly_emitted(obs035).
newly_emitted(obs036).
newly_emitted(obs037).
newly_emitted(obs038).
newly_emitted(obs039).
newly_emitted(obs040).
in_window(obs035).
in_window(obs036).
in_window(obs037).
in_window(obs038).
in_window(obs039).
in_window(obs040).
raw_conflict(doorA).
preferred_repair(obs040, closed, 5, "safety-controller").
materialized_action("keep the compartment sealed and continue monitoring").

clause(1, member(obs033, 33, closed, 1, "hallway-latch"), true).
clause(2, member(obs034, 34, closed, 1, "hallway-latch"), true).
clause(3, member(obs035, 35, closed, 1, "hallway-latch"), true).
clause(4, member(obs036, 36, closed, 1, "hallway-latch"), true).
clause(5, member(obs037, 37, open, 1, "corridor-camera"), true).
clause(6, member(obs038, 38, open, 1, "thermal-edge-camera"), true).
clause(7, member(obs039, 39, closed, 1, "hallway-latch"), true).
clause(8, member(obs040, 40, closed, 5, "safety-controller"), true).
clause(10, action_text(closed, "keep the compartment sealed and continue monitoring"), true).
clause(11, bookmark(34), true).
clause(12, window_start(35), true).
clause(13,
       already_committed(var('M')),
       (member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3)),
        bookmark(var('B')),
        var('Seq') =< var('B'))).
clause(14,
       newly_emitted(var('M')),
       (member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3)),
        bookmark(var('B')),
        var('Seq') > var('B'))).
clause(15,
       in_window(var('M')),
       (newly_emitted(var('M')),
        member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3)),
        window_start(var('W')),
        var('Seq') >= var('W'))).
clause(16,
       raw_conflict(doorA),
       (in_window(var('M1')),
        member(var('M1'), anonymous(1), open, anonymous(2), anonymous(3)),
        in_window(var('M2')),
        member(var('M2'), anonymous(4), closed, anonymous(5), anonymous(6)))).
clause(17,
       preferred_repair(var('M'), var('State'), var('Priority'), var('Source')),
       (in_window(var('M')),
        member(var('M'), anonymous(1), var('State'), var('Priority'), var('Source')),
        in_window(var('Other')),
        member(var('Other'), anonymous(2), var('OtherState'), var('OtherPriority'), anonymous(3)),
        var('State') \== var('OtherState'),
        var('Priority') > var('OtherPriority'))).
clause(18,
       materialized_action(var('Text')),
       (preferred_repair(anonymous(1), var('State'), anonymous(2), anonymous(3)),
        action_text(var('State'), var('Text')))).

step(already_committed(obs033),
     rule(13),
     ['M' = obs033, 'Seq' = 33, 'B' = 34],
     [member(obs033, 33, closed, 1, "hallway-latch"), bookmark(34), 33 =< 34]).
step(member(obs033, 33, closed, 1, "hallway-latch"), fact(1), [], []).
step(bookmark(34), fact(11), [], []).
step(33 =< 34, builtin, [], []).
step(already_committed(obs034),
     rule(13),
     ['M' = obs034, 'Seq' = 34, 'B' = 34],
     [member(obs034, 34, closed, 1, "hallway-latch"), bookmark(34), 34 =< 34]).
step(member(obs034, 34, closed, 1, "hallway-latch"), fact(2), [], []).
step(34 =< 34, builtin, [], []).
step(newly_emitted(obs035),
     rule(14),
     ['M' = obs035, 'Seq' = 35, 'B' = 34],
     [member(obs035, 35, closed, 1, "hallway-latch"), bookmark(34), 35 > 34]).
step(member(obs035, 35, closed, 1, "hallway-latch"), fact(3), [], []).
step(35 > 34, builtin, [], []).
step(newly_emitted(obs036),
     rule(14),
     ['M' = obs036, 'Seq' = 36, 'B' = 34],
     [member(obs036, 36, closed, 1, "hallway-latch"), bookmark(34), 36 > 34]).
step(member(obs036, 36, closed, 1, "hallway-latch"), fact(4), [], []).
step(36 > 34, builtin, [], []).
step(newly_emitted(obs037),
     rule(14),
     ['M' = obs037, 'Seq' = 37, 'B' = 34],
     [member(obs037, 37, open, 1, "corridor-camera"), bookmark(34), 37 > 34]).
step(member(obs037, 37, open, 1, "corridor-camera"), fact(5), [], []).
step(37 > 34, builtin, [], []).
step(newly_emitted(obs038),
     rule(14),
     ['M' = obs038, 'Seq' = 38, 'B' = 34],
     [member(obs038, 38, open, 1, "thermal-edge-camera"), bookmark(34), 38 > 34]).
step(member(obs038, 38, open, 1, "thermal-edge-camera"), fact(6), [], []).
step(38 > 34, builtin, [], []).
step(newly_emitted(obs039),
     rule(14),
     ['M' = obs039, 'Seq' = 39, 'B' = 34],
     [member(obs039, 39, closed, 1, "hallway-latch"), bookmark(34), 39 > 34]).
step(member(obs039, 39, closed, 1, "hallway-latch"), fact(7), [], []).
step(39 > 34, builtin, [], []).
step(newly_emitted(obs040),
     rule(14),
     ['M' = obs040, 'Seq' = 40, 'B' = 34],
     [member(obs040, 40, closed, 5, "safety-controller"), bookmark(34), 40 > 34]).
step(member(obs040, 40, closed, 5, "safety-controller"), fact(8), [], []).
step(40 > 34, builtin, [], []).
step(in_window(obs035),
     rule(15),
     ['M' = obs035, 'Seq' = 35, 'W' = 35],
     [newly_emitted(obs035),
      member(obs035, 35, closed, 1, "hallway-latch"),
      window_start(35),
      35 >= 35]).
step(window_start(35), fact(12), [], []).
step(35 >= 35, builtin, [], []).
step(in_window(obs036),
     rule(15),
     ['M' = obs036, 'Seq' = 36, 'W' = 35],
     [newly_emitted(obs036),
      member(obs036, 36, closed, 1, "hallway-latch"),
      window_start(35),
      36 >= 35]).
step(36 >= 35, builtin, [], []).
step(in_window(obs037),
     rule(15),
     ['M' = obs037, 'Seq' = 37, 'W' = 35],
     [newly_emitted(obs037),
      member(obs037, 37, open, 1, "corridor-camera"),
      window_start(35),
      37 >= 35]).
step(37 >= 35, builtin, [], []).
step(in_window(obs038),
     rule(15),
     ['M' = obs038, 'Seq' = 38, 'W' = 35],
     [newly_emitted(obs038),
      member(obs038, 38, open, 1, "thermal-edge-camera"),
      window_start(35),
      38 >= 35]).
step(38 >= 35, builtin, [], []).
step(in_window(obs039),
     rule(15),
     ['M' = obs039, 'Seq' = 39, 'W' = 35],
     [newly_emitted(obs039),
      member(obs039, 39, closed, 1, "hallway-latch"),
      window_start(35),
      39 >= 35]).
step(39 >= 35, builtin, [], []).
step(in_window(obs040),
     rule(15),
     ['M' = obs040, 'Seq' = 40, 'W' = 35],
     [newly_emitted(obs040),
      member(obs040, 40, closed, 5, "safety-controller"),
      window_start(35),
      40 >= 35]).
step(40 >= 35, builtin, [], []).
step(raw_conflict(doorA),
     rule(16),
     ['M1' = obs037, 'M2' = obs035],
     [in_window(obs037),
      member(obs037, 37, open, 1, "corridor-camera"),
      in_window(obs035),
      member(obs035, 35, closed, 1, "hallway-latch")]).
step(preferred_repair(obs040, closed, 5, "safety-controller"),
     rule(17),
     ['M' = obs040,
      'State' = closed,
      'Priority' = 5,
      'Source' = "safety-controller",
      'Other' = obs037,
      'OtherState' = open,
      'OtherPriority' = 1],
     [in_window(obs040),
      member(obs040, 40, closed, 5, "safety-controller"),
      in_window(obs037),
      member(obs037, 37, open, 1, "corridor-camera"),
      closed \== open,
      5 > 1]).
step(closed \== open, builtin, [], []).
step(5 > 1, builtin, [], []).
step(materialized_action("keep the compartment sealed and continue monitoring"),
     rule(18),
     ['Text' = "keep the compartment sealed and continue monitoring", 'State' = closed],
     [preferred_repair(obs040, closed, 5, "safety-controller"),
      action_text(closed, "keep the compartment sealed and continue monitoring")]).
step(action_text(closed, "keep the compartment sealed and continue monitoring"),
     fact(10),
     [],
     []).
