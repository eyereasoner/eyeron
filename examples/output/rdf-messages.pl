% Prolog result format 4
query(1, mentions_sensor(_0, _1), ['Envelope' = _0, 'Sensor' = _1]).
result(1, complete, 1).
answer(1, ['Envelope' = envelope1, 'Sensor' = thermometer1]).
query(2, heartbeat(_0), ['Envelope' = _0]).
result(2, complete, 1).
answer(2, ['Envelope' = envelope2]).
