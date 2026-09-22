% Prolog result format 4
query(1, already_committed(_0), ['M' = _0]).
result(1, complete, 3).
answer(1, ['M' = obs040]).
why(1, ['M' = obs040], [already_committed(obs040)]).
answer(1, ['M' = obs041]).
why(1, ['M' = obs041], [already_committed(obs041)]).
answer(1, ['M' = obs042]).
why(1, ['M' = obs042], [already_committed(obs042)]).
query(2, newly_emitted(_0), ['M' = _0]).
result(2, complete, 6).
answer(2, ['M' = obs043]).
why(2, ['M' = obs043], [newly_emitted(obs043)]).
answer(2, ['M' = obs044]).
why(2, ['M' = obs044], [newly_emitted(obs044)]).
answer(2, ['M' = obs045]).
why(2, ['M' = obs045], [newly_emitted(obs045)]).
answer(2, ['M' = obs046]).
why(2, ['M' = obs046], [newly_emitted(obs046)]).
answer(2, ['M' = obs047]).
why(2, ['M' = obs047], [newly_emitted(obs047)]).
answer(2, ['M' = obs048]).
why(2, ['M' = obs048], [newly_emitted(obs048)]).
query(3, in_window(_0), ['M' = _0]).
result(3, complete, 6).
answer(3, ['M' = obs043]).
why(3, ['M' = obs043], [in_window(obs043)]).
answer(3, ['M' = obs044]).
why(3, ['M' = obs044], [in_window(obs044)]).
answer(3, ['M' = obs045]).
why(3, ['M' = obs045], [in_window(obs045)]).
answer(3, ['M' = obs046]).
why(3, ['M' = obs046], [in_window(obs046)]).
answer(3, ['M' = obs047]).
why(3, ['M' = obs047], [in_window(obs047)]).
answer(3, ['M' = obs048]).
why(3, ['M' = obs048], [in_window(obs048)]).
query(4, raw_conflict(_0), ['Batch' = _0]).
result(4, complete, 1).
answer(4, ['Batch' = batchA]).
why(4, ['Batch' = batchA], [raw_conflict(batchA)]).
query(5,
      preferred_repair(_0, _1, _2, _3),
      ['M' = _0, 'Temp' = _1, 'Priority' = _2, 'Source' = _3]).
result(5, complete, 1).
answer(5,
       ['M' = obs047, 'Temp' = 118, 'Priority' = 5, 'Source' = "calibrated-cold-chain-logger"]).
why(5,
    ['M' = obs047, 'Temp' = 118, 'Priority' = 5, 'Source' = "calibrated-cold-chain-logger"],
    [preferred_repair(obs047, 118, 5, "calibrated-cold-chain-logger")]).
query(6, quarantine_decision(_0), ['Text' = _0]).
result(6, complete, 1).
answer(6, ['Text' = "quarantine batchA, notify QA, and hold shipment"]).
why(6,
    ['Text' = "quarantine batchA, notify QA, and hold shipment"],
    [quarantine_decision("quarantine batchA, notify QA, and hold shipment")]).

clause(1, member(obs040, 40, 42, 1, "dock-sensor", false), true).
clause(2, member(obs041, 41, 43, 1, "warehouse-reader", false), true).
clause(3, member(obs042, 42, 44, 1, "truck-gateway", false), true).
clause(4, member(obs043, 43, 45, 1, "truck-gateway", false), true).
clause(5, member(obs044, 44, 46, 1, "dock-sensor", false), true).
clause(6, member(obs045, 45, 47, 1, "warehouse-reader", false), true).
clause(7, member(obs046, 46, 121, 2, "truck-gateway", false), true).
clause(8, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), true).
clause(9, member(obs048, 48, 44, 1, "door-proximity-sensor", false), true).
clause(10, bookmark(42), true).
clause(11, window_start(43), true).
clause(12, limit_tenths_c(80), true).
clause(13,
       already_committed(var('M')),
       (member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3), anonymous(4)),
        bookmark(var('B')),
        var('Seq') =< var('B'))).
clause(14,
       newly_emitted(var('M')),
       (member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3), anonymous(4)),
        bookmark(var('B')),
        var('Seq') > var('B'))).
clause(15,
       in_window(var('M')),
       (newly_emitted(var('M')),
        member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3), anonymous(4)),
        window_start(var('W')),
        var('Seq') >= var('W'))).
clause(16,
       raw_conflict(batchA),
       (in_window(var('M1')),
        member(var('M1'), anonymous(1), var('T1'), anonymous(2), anonymous(3), anonymous(4)),
        limit_tenths_c(var('Limit')),
        var('T1') =< var('Limit'),
        in_window(var('M2')),
        member(var('M2'), anonymous(5), var('T2'), anonymous(6), anonymous(7), anonymous(8)),
        var('T2') > var('Limit'))).
clause(17,
       preferred_repair(var('M'), var('Temp'), var('Priority'), var('Source')),
       (in_window(var('M')),
        member(var('M'), anonymous(1), var('Temp'), var('Priority'), var('Source'), true),
        limit_tenths_c(var('Limit')),
        var('Temp') > var('Limit'))).
clause(18,
       quarantine_decision("quarantine batchA, notify QA, and hold shipment"),
       preferred_repair(anonymous(1), anonymous(2), anonymous(3), anonymous(4))).

step(already_committed(obs040),
     rule(13),
     ['M' = obs040, 'Seq' = 40, 'B' = 42],
     [member(obs040, 40, 42, 1, "dock-sensor", false), bookmark(42), 40 =< 42]).
step(member(obs040, 40, 42, 1, "dock-sensor", false), fact(1), [], []).
step(bookmark(42), fact(10), [], []).
step(40 =< 42, builtin, [], []).
step(already_committed(obs041),
     rule(13),
     ['M' = obs041, 'Seq' = 41, 'B' = 42],
     [member(obs041, 41, 43, 1, "warehouse-reader", false), bookmark(42), 41 =< 42]).
step(member(obs041, 41, 43, 1, "warehouse-reader", false), fact(2), [], []).
step(41 =< 42, builtin, [], []).
step(already_committed(obs042),
     rule(13),
     ['M' = obs042, 'Seq' = 42, 'B' = 42],
     [member(obs042, 42, 44, 1, "truck-gateway", false), bookmark(42), 42 =< 42]).
step(member(obs042, 42, 44, 1, "truck-gateway", false), fact(3), [], []).
step(42 =< 42, builtin, [], []).
step(newly_emitted(obs043),
     rule(14),
     ['M' = obs043, 'Seq' = 43, 'B' = 42],
     [member(obs043, 43, 45, 1, "truck-gateway", false), bookmark(42), 43 > 42]).
step(member(obs043, 43, 45, 1, "truck-gateway", false), fact(4), [], []).
step(43 > 42, builtin, [], []).
step(newly_emitted(obs044),
     rule(14),
     ['M' = obs044, 'Seq' = 44, 'B' = 42],
     [member(obs044, 44, 46, 1, "dock-sensor", false), bookmark(42), 44 > 42]).
step(member(obs044, 44, 46, 1, "dock-sensor", false), fact(5), [], []).
step(44 > 42, builtin, [], []).
step(newly_emitted(obs045),
     rule(14),
     ['M' = obs045, 'Seq' = 45, 'B' = 42],
     [member(obs045, 45, 47, 1, "warehouse-reader", false), bookmark(42), 45 > 42]).
step(member(obs045, 45, 47, 1, "warehouse-reader", false), fact(6), [], []).
step(45 > 42, builtin, [], []).
step(newly_emitted(obs046),
     rule(14),
     ['M' = obs046, 'Seq' = 46, 'B' = 42],
     [member(obs046, 46, 121, 2, "truck-gateway", false), bookmark(42), 46 > 42]).
step(member(obs046, 46, 121, 2, "truck-gateway", false), fact(7), [], []).
step(46 > 42, builtin, [], []).
step(newly_emitted(obs047),
     rule(14),
     ['M' = obs047, 'Seq' = 47, 'B' = 42],
     [member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), bookmark(42), 47 > 42]).
step(member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), fact(8), [], []).
step(47 > 42, builtin, [], []).
step(newly_emitted(obs048),
     rule(14),
     ['M' = obs048, 'Seq' = 48, 'B' = 42],
     [member(obs048, 48, 44, 1, "door-proximity-sensor", false), bookmark(42), 48 > 42]).
step(member(obs048, 48, 44, 1, "door-proximity-sensor", false), fact(9), [], []).
step(48 > 42, builtin, [], []).
step(in_window(obs043),
     rule(15),
     ['M' = obs043, 'Seq' = 43, 'W' = 43],
     [newly_emitted(obs043),
      member(obs043, 43, 45, 1, "truck-gateway", false),
      window_start(43),
      43 >= 43]).
step(window_start(43), fact(11), [], []).
step(43 >= 43, builtin, [], []).
step(in_window(obs044),
     rule(15),
     ['M' = obs044, 'Seq' = 44, 'W' = 43],
     [newly_emitted(obs044),
      member(obs044, 44, 46, 1, "dock-sensor", false),
      window_start(43),
      44 >= 43]).
step(44 >= 43, builtin, [], []).
step(in_window(obs045),
     rule(15),
     ['M' = obs045, 'Seq' = 45, 'W' = 43],
     [newly_emitted(obs045),
      member(obs045, 45, 47, 1, "warehouse-reader", false),
      window_start(43),
      45 >= 43]).
step(45 >= 43, builtin, [], []).
step(in_window(obs046),
     rule(15),
     ['M' = obs046, 'Seq' = 46, 'W' = 43],
     [newly_emitted(obs046),
      member(obs046, 46, 121, 2, "truck-gateway", false),
      window_start(43),
      46 >= 43]).
step(46 >= 43, builtin, [], []).
step(in_window(obs047),
     rule(15),
     ['M' = obs047, 'Seq' = 47, 'W' = 43],
     [newly_emitted(obs047),
      member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true),
      window_start(43),
      47 >= 43]).
step(47 >= 43, builtin, [], []).
step(in_window(obs048),
     rule(15),
     ['M' = obs048, 'Seq' = 48, 'W' = 43],
     [newly_emitted(obs048),
      member(obs048, 48, 44, 1, "door-proximity-sensor", false),
      window_start(43),
      48 >= 43]).
step(48 >= 43, builtin, [], []).
step(raw_conflict(batchA),
     rule(16),
     ['M1' = obs043, 'T1' = 45, 'Limit' = 80, 'M2' = obs046, 'T2' = 121],
     [in_window(obs043),
      member(obs043, 43, 45, 1, "truck-gateway", false),
      limit_tenths_c(80),
      45 =< 80,
      in_window(obs046),
      member(obs046, 46, 121, 2, "truck-gateway", false),
      121 > 80]).
step(limit_tenths_c(80), fact(12), [], []).
step(45 =< 80, builtin, [], []).
step(121 > 80, builtin, [], []).
step(preferred_repair(obs047, 118, 5, "calibrated-cold-chain-logger"),
     rule(17),
     ['M' = obs047,
      'Temp' = 118,
      'Priority' = 5,
      'Source' = "calibrated-cold-chain-logger",
      'Limit' = 80],
     [in_window(obs047),
      member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true),
      limit_tenths_c(80),
      118 > 80]).
step(118 > 80, builtin, [], []).
step(quarantine_decision("quarantine batchA, notify QA, and hold shipment"),
     rule(18),
     [],
     [preferred_repair(obs047, 118, 5, "calibrated-cold-chain-logger")]).
