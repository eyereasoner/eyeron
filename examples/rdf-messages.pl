% Prolog example: rdf-messages.
payload_graph(envelope1, payload1).
payload_triple(payload1, triple(reading1, sensor, thermometer1)).
payload_kind(envelope2, empty).
mentions_sensor(Envelope, Sensor) :-
    payload_graph(Envelope, Payload),
    payload_triple(Payload, triple(Reading, sensor, Sensor)).
heartbeat(Envelope) :-
    payload_kind(Envelope, empty).
?- mentions_sensor(Envelope, Sensor).
?- heartbeat(Envelope).
