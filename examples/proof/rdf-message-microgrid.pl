% Prolog result format 3
query(1, critical_watts(_0), ['Critical' = _0]).
result(1, complete, 1).
answer(1, ['Critical' = 620]).
why(1, ['Critical' = 620], 4).
query(2, available_total(_0), ['Available' = _0]).
result(2, complete, 1).
answer(2, ['Available' = 800]).
why(2, ['Available' = 800], 8).
query(3, deferrable_watts(_0), ['Deferrable' = _0]).
result(3, complete, 1).
answer(3, ['Deferrable' = 600]).
why(3, ['Deferrable' = 600], 11).
query(4, protected_budget(_0), ['Protected' = _0]).
result(4, complete, 1).
answer(4, ['Protected' = 1400]).
why(4, ['Protected' = 1400], 18).
query(5, resilience_action(_0), ['Action' = _0]).
result(5, complete, 1).
answer(5, ['Action' = protect_clinic]).
why(5, ['Action' = protect_clinic], 29).
clause(1, requires_watts(oxygen_concentrator, 500), true).
clause(2, requires_watts(vaccine_fridge, 120), true).
clause(3, available_watts(battery_bank, 650), true).
clause(4, expected_watts(solar_forecast, 150), true).
clause(5, shed_watts(ev_chargers, 600), true).
clause(7, critical_watts(var('W')), (requires_watts(oxygen_concentrator, var('O')), requires_watts(vaccine_fridge, var('F')), var('W') is var('O') + var('F'))).
clause(8, available_total(var('W')), (available_watts(battery_bank, var('B')), expected_watts(solar_forecast, var('S')), var('W') is var('B') + var('S'))).
clause(9, deferrable_watts(var('W')), shed_watts(ev_chargers, var('W'))).
clause(10, protected_budget(var('W')), (available_total(var('A')), deferrable_watts(var('D')), var('W') is var('A') + var('D'))).
clause(11, resilience_action(protect_clinic), (protected_budget(var('P')), critical_watts(var('C')), var('P') > var('C'))).
substitution(1, []).
proof(1, requires_watts(oxygen_concentrator, 500), rule(1), []).
substitution(2, []).
proof(2, requires_watts(vaccine_fridge, 120), rule(2), []).
substitution(3, ['W' = 620, 'O' = 500, 'F' = 120]).
proof(3, critical_watts(620), rule(7), [uses(1, requires_watts(oxygen_concentrator, 500)), uses(2, requires_watts(vaccine_fridge, 120)), builtin(620 is 500 + 120)]).
substitution(4, ['Critical' = 620]).
proof(4, solution([620]), query, [uses(3, critical_watts(620))]).
substitution(5, []).
proof(5, available_watts(battery_bank, 650), rule(3), []).
substitution(6, []).
proof(6, expected_watts(solar_forecast, 150), rule(4), []).
substitution(7, ['W' = 800, 'B' = 650, 'S' = 150]).
proof(7, available_total(800), rule(8), [uses(5, available_watts(battery_bank, 650)), uses(6, expected_watts(solar_forecast, 150)), builtin(800 is 650 + 150)]).
substitution(8, ['Available' = 800]).
proof(8, solution([800]), query, [uses(7, available_total(800))]).
substitution(9, []).
proof(9, shed_watts(ev_chargers, 600), rule(5), []).
substitution(10, ['W' = 600]).
proof(10, deferrable_watts(600), rule(9), [uses(9, shed_watts(ev_chargers, 600))]).
substitution(11, ['Deferrable' = 600]).
proof(11, solution([600]), query, [uses(10, deferrable_watts(600))]).
substitution(12, []).
proof(12, available_watts(battery_bank, 650), rule(3), []).
substitution(13, []).
proof(13, expected_watts(solar_forecast, 150), rule(4), []).
substitution(14, ['W' = 800, 'B' = 650, 'S' = 150]).
proof(14, available_total(800), rule(8), [uses(12, available_watts(battery_bank, 650)), uses(13, expected_watts(solar_forecast, 150)), builtin(800 is 650 + 150)]).
substitution(15, []).
proof(15, shed_watts(ev_chargers, 600), rule(5), []).
substitution(16, ['W' = 600]).
proof(16, deferrable_watts(600), rule(9), [uses(15, shed_watts(ev_chargers, 600))]).
substitution(17, ['W' = 1400, 'A' = 800, 'D' = 600]).
proof(17, protected_budget(1400), rule(10), [uses(14, available_total(800)), uses(16, deferrable_watts(600)), builtin(1400 is 800 + 600)]).
substitution(18, ['Protected' = 1400]).
proof(18, solution([1400]), query, [uses(17, protected_budget(1400))]).
substitution(19, []).
proof(19, available_watts(battery_bank, 650), rule(3), []).
substitution(20, []).
proof(20, expected_watts(solar_forecast, 150), rule(4), []).
substitution(21, ['W' = 800, 'B' = 650, 'S' = 150]).
proof(21, available_total(800), rule(8), [uses(19, available_watts(battery_bank, 650)), uses(20, expected_watts(solar_forecast, 150)), builtin(800 is 650 + 150)]).
substitution(22, []).
proof(22, shed_watts(ev_chargers, 600), rule(5), []).
substitution(23, ['W' = 600]).
proof(23, deferrable_watts(600), rule(9), [uses(22, shed_watts(ev_chargers, 600))]).
substitution(24, ['W' = 1400, 'A' = 800, 'D' = 600]).
proof(24, protected_budget(1400), rule(10), [uses(21, available_total(800)), uses(23, deferrable_watts(600)), builtin(1400 is 800 + 600)]).
substitution(25, []).
proof(25, requires_watts(oxygen_concentrator, 500), rule(1), []).
substitution(26, []).
proof(26, requires_watts(vaccine_fridge, 120), rule(2), []).
substitution(27, ['W' = 620, 'O' = 500, 'F' = 120]).
proof(27, critical_watts(620), rule(7), [uses(25, requires_watts(oxygen_concentrator, 500)), uses(26, requires_watts(vaccine_fridge, 120)), builtin(620 is 500 + 120)]).
substitution(28, ['P' = 1400, 'C' = 620]).
proof(28, resilience_action(protect_clinic), rule(11), [uses(24, protected_budget(1400)), uses(27, critical_watts(620)), builtin(1400 > 620)]).
substitution(29, ['Action' = protect_clinic]).
proof(29, solution([protect_clinic]), query, [uses(28, resilience_action(protect_clinic))]).
