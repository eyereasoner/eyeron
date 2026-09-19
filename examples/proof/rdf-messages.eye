# Eyelang result format 2
query(1, [call(mentions_sensor(?v0, ?v1))], [binding("envelope", ?v0), binding("sensor", ?v1)]).
result(1, complete, 1).
answer(1, [binding("envelope", envelope1), binding("sensor", thermometer1)]).
why(1, [binding("envelope", envelope1), binding("sensor", thermometer1)], 4).
query(2, [call(heartbeat(?v0))], [binding("envelope", ?v0)]).
result(2, complete, 1).
answer(2, [binding("envelope", envelope2)]).
why(2, [binding("envelope", envelope2)], 7).
clause(1, payload_graph(envelope1, payload1), []).
clause(2, payload_triple(payload1, triple(reading1, sensor, thermometer1)), []).
clause(3, payload_kind(envelope2, empty), []).
clause(4, mentions_sensor(var("envelope"), var("sensor")), [call(payload_graph(var("envelope"), var("payload"))), call(payload_triple(var("payload"), triple(var("reading"), sensor, var("sensor"))))]).
clause(5, heartbeat(var("envelope")), [call(payload_kind(var("envelope"), empty))]).
substitution(1, []).
proof(1, payload_graph(envelope1, payload1), rule(1), []).
substitution(2, []).
proof(2, payload_triple(payload1, triple(reading1, sensor, thermometer1)), rule(2), []).
substitution(3, [binding("envelope", envelope1), binding("sensor", thermometer1), binding("payload", payload1), binding("reading", reading1)]).
proof(3, mentions_sensor(envelope1, thermometer1), rule(4), [uses(1, payload_graph(envelope1, payload1)), uses(2, payload_triple(payload1, triple(reading1, sensor, thermometer1)))]).
substitution(4, [binding("envelope", envelope1), binding("sensor", thermometer1)]).
proof(4, solution([envelope1, thermometer1]), query, [uses(3, mentions_sensor(envelope1, thermometer1))]).
substitution(5, []).
proof(5, payload_kind(envelope2, empty), rule(3), []).
substitution(6, [binding("envelope", envelope2)]).
proof(6, heartbeat(envelope2), rule(5), [uses(5, payload_kind(envelope2, empty))]).
substitution(7, [binding("envelope", envelope2)]).
proof(7, solution([envelope2]), query, [uses(6, heartbeat(envelope2))]).
