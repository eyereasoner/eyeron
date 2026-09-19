# Eyelang example: rdf-messages.
payload_graph(envelope1, payload1). payload_triple(payload1, triple(reading1, sensor, thermometer1)).
payload_kind(envelope2, empty).
mentions_sensor(?envelope, ?sensor) if payload_graph(?envelope, ?payload), payload_triple(?payload, triple(?reading, sensor, ?sensor)).
heartbeat(?envelope) if payload_kind(?envelope, empty).
ask mentions_sensor(?envelope, ?sensor). ask heartbeat(?envelope).
