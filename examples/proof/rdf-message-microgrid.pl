% Prolog result format 4
query(1, critical_watts(_0), ['Critical' = _0]).
result(1, complete, 1).
answer(1, ['Critical' = 620]).
why(1, ['Critical' = 620], [critical_watts(620)]).
query(2, available_total(_0), ['Available' = _0]).
result(2, complete, 1).
answer(2, ['Available' = 800]).
why(2, ['Available' = 800], [available_total(800)]).
query(3, deferrable_watts(_0), ['Deferrable' = _0]).
result(3, complete, 1).
answer(3, ['Deferrable' = 600]).
why(3, ['Deferrable' = 600], [deferrable_watts(600)]).
query(4, protected_budget(_0), ['Protected' = _0]).
result(4, complete, 1).
answer(4, ['Protected' = 1400]).
why(4, ['Protected' = 1400], [protected_budget(1400)]).
query(5, resilience_action(_0), ['Action' = _0]).
result(5, complete, 1).
answer(5, ['Action' = protect_clinic]).
why(5, ['Action' = protect_clinic], [resilience_action(protect_clinic)]).

clause(1, requires_watts(oxygen_concentrator, 500), true).
clause(2, requires_watts(vaccine_fridge, 120), true).
clause(3, available_watts(battery_bank, 650), true).
clause(4, expected_watts(solar_forecast, 150), true).
clause(5, shed_watts(ev_chargers, 600), true).
clause(7,
       critical_watts(var('W')),
       (requires_watts(oxygen_concentrator, var('O')),
        requires_watts(vaccine_fridge, var('F')),
        var('W') is var('O') + var('F'))).
clause(8,
       available_total(var('W')),
       (available_watts(battery_bank, var('B')),
        expected_watts(solar_forecast, var('S')),
        var('W') is var('B') + var('S'))).
clause(9, deferrable_watts(var('W')), shed_watts(ev_chargers, var('W'))).
clause(10,
       protected_budget(var('W')),
       (available_total(var('A')), deferrable_watts(var('D')), var('W') is var('A') + var('D'))).
clause(11,
       resilience_action(protect_clinic),
       (protected_budget(var('P')), critical_watts(var('C')), var('P') > var('C'))).

step(critical_watts(620),
     rule(7),
     ['W' = 620, 'O' = 500, 'F' = 120],
     [requires_watts(oxygen_concentrator, 500),
      requires_watts(vaccine_fridge, 120),
      620 is 500 + 120]).
step(requires_watts(oxygen_concentrator, 500), fact(1), [], []).
step(requires_watts(vaccine_fridge, 120), fact(2), [], []).
step(620 is 500 + 120, builtin, [], []).
step(available_total(800),
     rule(8),
     ['W' = 800, 'B' = 650, 'S' = 150],
     [available_watts(battery_bank, 650), expected_watts(solar_forecast, 150), 800 is 650 + 150]).
step(available_watts(battery_bank, 650), fact(3), [], []).
step(expected_watts(solar_forecast, 150), fact(4), [], []).
step(800 is 650 + 150, builtin, [], []).
step(deferrable_watts(600), rule(9), ['W' = 600], [shed_watts(ev_chargers, 600)]).
step(shed_watts(ev_chargers, 600), fact(5), [], []).
step(protected_budget(1400),
     rule(10),
     ['W' = 1400, 'A' = 800, 'D' = 600],
     [available_total(800), deferrable_watts(600), 1400 is 800 + 600]).
step(1400 is 800 + 600, builtin, [], []).
step(resilience_action(protect_clinic),
     rule(11),
     ['P' = 1400, 'C' = 620],
     [protected_budget(1400), critical_watts(620), 1400 > 620]).
step(1400 > 620, builtin, [], []).
