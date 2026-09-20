# Companion to rdf-message-microgrid.n3/.srl: the eye source has no
# RDF Message Log parser (that VERSION "1.2-messages"/MESSAGE-delimited
# streaming replay -- eymsg: envelopes, log:includes-scoped payload
# inspection, the empty heartbeat -- is specific to eyeron's own parser
# level), so this tests the load-shedding decision itself: given the
# same four messages' payload facts as ordinary given facts (life-safety
# loads, current power status, sheddable demand, and a no-op heartbeat
# that adds nothing), does the clinic have enough protected budget to
# keep life-safety loads powered while deferring EV charging.

requires_watts(oxygen_concentrator, 500).
requires_watts(vaccine_fridge, 120).
available_watts(battery_bank, 650).
expected_watts(solar_forecast, 150).
shed_watts(ev_chargers, 600).
heartbeat(true).

critical_watts(?w) if
    requires_watts(oxygen_concentrator, ?o), requires_watts(vaccine_fridge, ?f),
    let ?w = ?o + ?f.

available_total(?w) if
    available_watts(battery_bank, ?b), expected_watts(solar_forecast, ?s),
    let ?w = ?b + ?s.

deferrable_watts(?w) if shed_watts(ev_chargers, ?w).

protected_budget(?w) if
    available_total(?a), deferrable_watts(?d),
    let ?w = ?a + ?d.

resilience_action(protect_clinic) if
    protected_budget(?p), critical_watts(?c), ?p > ?c.

ask critical_watts(?critical).
ask available_total(?available).
ask deferrable_watts(?deferrable).
ask protected_budget(?protected).
ask resilience_action(?action).
