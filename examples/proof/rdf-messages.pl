% Prolog result format 3
query(1, mentions_sensor(_0, _1), ['Envelope' = _0, 'Sensor' = _1]).
result(1, complete, 1).
answer(1, ['Envelope' = envelope1, 'Sensor' = thermometer1]).
why(1, ['Envelope' = envelope1, 'Sensor' = thermometer1], 4).
query(2, heartbeat(_0), ['Envelope' = _0]).
result(2, complete, 1).
answer(2, ['Envelope' = envelope2]).
why(2, ['Envelope' = envelope2], 7).
clause(1, payload_graph(envelope1, payload1), true).
clause(2, payload_triple(payload1, triple(reading1, sensor, thermometer1)), true).
clause(3, payload_kind(envelope2, empty), true).
clause(4, mentions_sensor(var('Envelope'), var('Sensor')), (payload_graph(var('Envelope'), var('Payload')), payload_triple(var('Payload'), triple(var('Reading'), sensor, var('Sensor'))))).
clause(5, heartbeat(var('Envelope')), payload_kind(var('Envelope'), empty)).
substitution(1, []).
proof(1, payload_graph(envelope1, payload1), rule(1), []).
substitution(2, []).
proof(2, payload_triple(payload1, triple(reading1, sensor, thermometer1)), rule(2), []).
substitution(3, ['Envelope' = envelope1, 'Sensor' = thermometer1, 'Payload' = payload1, 'Reading' = reading1]).
proof(3, mentions_sensor(envelope1, thermometer1), rule(4), [uses(1, payload_graph(envelope1, payload1)), uses(2, payload_triple(payload1, triple(reading1, sensor, thermometer1)))]).
substitution(4, ['Envelope' = envelope1, 'Sensor' = thermometer1]).
proof(4, solution([envelope1, thermometer1]), query, [uses(3, mentions_sensor(envelope1, thermometer1))]).
substitution(5, []).
proof(5, payload_kind(envelope2, empty), rule(3), []).
substitution(6, ['Envelope' = envelope2]).
proof(6, heartbeat(envelope2), rule(5), [uses(5, payload_kind(envelope2, empty))]).
substitution(7, ['Envelope' = envelope2]).
proof(7, solution([envelope2]), query, [uses(6, heartbeat(envelope2))]).
