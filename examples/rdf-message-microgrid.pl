% Companion to rdf-message-microgrid.n3/.srl: the eye source has no
% RDF Message Log parser (that VERSION "1.2-messages"/MESSAGE-delimited
% streaming replay -- eymsg: envelopes, log:includes-scoped payload
% inspection, the empty heartbeat -- is specific to eyeron's own parser
% level), so this tests the load-shedding decision itself: given the
% same four messages' payload facts as ordinary given facts (life-safety
% loads, current power status, sheddable demand, and a no-op heartbeat
% that adds nothing), does the clinic have enough protected budget to
% keep life-safety loads powered while deferring EV charging.

requires_watts(oxygen_concentrator, 500).
requires_watts(vaccine_fridge, 120).
available_watts(battery_bank, 650).
expected_watts(solar_forecast, 150).
shed_watts(ev_chargers, 600).
heartbeat(true).

critical_watts(W) :-
    requires_watts(oxygen_concentrator, O),
    requires_watts(vaccine_fridge, F),
    W is O + F.

available_total(W) :-
    available_watts(battery_bank, B),
    expected_watts(solar_forecast, S),
    W is B + S.

deferrable_watts(W) :-
    shed_watts(ev_chargers, W).

protected_budget(W) :-
    available_total(A),
    deferrable_watts(D),
    W is A + D.

resilience_action(protect_clinic) :-
    protected_budget(P),
    critical_watts(C),
    P > C.

?- critical_watts(Critical).
?- available_total(Available).
?- deferrable_watts(Deferrable).
?- protected_budget(Protected).
?- resilience_action(Action).
