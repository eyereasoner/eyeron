% Companion to rdf-message-flow.n3/.srl: the eye source has no RDF
% Message Log parser (the ingest/validate/interpret/route/sink pipeline
% staging and eymsg: envelope replay are specific to eyeron's N3 parser
% level), so this tests the threshold-routing decision itself: given
% the same five messages' results (two normal, one empty heartbeat, two
% hot) in order, does each land in the right sink.

threshold(26).
message(1, result, 21).
message(2, result, 22).
message(3, empty).
message(4, result, 28).
message(5, result, 29).

route(M, archive_sink) :-
    message(M, result, R),
    threshold(T),
    R =< T.
route(M, alert_sink) :-
    message(M, result, R),
    threshold(T),
    R > T.
route(M, heartbeat_sink) :-
    message(M, empty).

?- route(M, Sink).
