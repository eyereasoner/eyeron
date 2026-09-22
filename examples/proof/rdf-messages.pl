% Prolog result format 4
query(1, mentions_sensor(_0, _1), ['Envelope' = _0, 'Sensor' = _1]).
result(1, complete, 1).
answer(1, ['Envelope' = envelope1, 'Sensor' = thermometer1]).
why(1,
    ['Envelope' = envelope1, 'Sensor' = thermometer1],
    [mentions_sensor(envelope1, thermometer1)]).
query(2, heartbeat(_0), ['Envelope' = _0]).
result(2, complete, 1).
answer(2, ['Envelope' = envelope2]).
why(2, ['Envelope' = envelope2], [heartbeat(envelope2)]).

clause(1, payload_graph(envelope1, payload1), true).
clause(2, payload_triple(payload1, triple(reading1, sensor, thermometer1)), true).
clause(3, payload_kind(envelope2, empty), true).
clause(4,
       mentions_sensor(var('Envelope'), var('Sensor')),
       (payload_graph(var('Envelope'), var('Payload')),
        payload_triple(var('Payload'), triple(var('Reading'), sensor, var('Sensor'))))).
clause(5, heartbeat(var('Envelope')), payload_kind(var('Envelope'), empty)).

step(mentions_sensor(envelope1, thermometer1),
     rule(4),
     ['Envelope' = envelope1,
      'Sensor' = thermometer1,
      'Payload' = payload1,
      'Reading' = reading1],
     [payload_graph(envelope1, payload1),
      payload_triple(payload1, triple(reading1, sensor, thermometer1))]).
step(payload_graph(envelope1, payload1), fact(1), [], []).
step(payload_triple(payload1, triple(reading1, sensor, thermometer1)), fact(2), [], []).
step(heartbeat(envelope2), rule(5), ['Envelope' = envelope2], [payload_kind(envelope2, empty)]).
step(payload_kind(envelope2, empty), fact(3), [], []).
