discovered_airroute(["Ostend-Bruges International Airport",
                     "Liège Airport",
                     "Heraklion International Nikos Kazantzakis Airport",
                     "Václav Havel Airport Prague"]).
discovered_airroute(["Ostend-Bruges International Airport",
                     "Liège Airport",
                     "Diagoras Airport",
                     "Václav Havel Airport Prague"]).
discovered_airroute(["Ostend-Bruges International Airport",
                     "Liège Airport",
                     "Palma De Mallorca Airport",
                     "Václav Havel Airport Prague"]).

clause(3857, hasRoute("AIRPORT_1452", "AIRPORT_1587"), true).
clause(4131, hasRoute("AIRPORT_1472", "AIRPORT_1587"), true).
clause(15870, hasRoute("AIRPORT_309", "AIRPORT_1452"), true).
clause(15871, hasRoute("AIRPORT_309", "AIRPORT_1472"), true).
clause(15872, hasRoute("AIRPORT_309", "AIRPORT_3998"), true).
clause(15985, hasRoute("AIRPORT_310", "AIRPORT_309"), true).
clause(27826, hasRoute("AIRPORT_3998", "AIRPORT_1587"), true).
clause(38296, label("AIRPORT_1452", "Heraklion International Nikos Kazantzakis Airport"), true).
clause(38314, label("AIRPORT_1472", "Diagoras Airport"), true).
clause(38372, label("AIRPORT_1587", "Václav Havel Airport Prague"), true).
clause(39246, label("AIRPORT_309", "Liège Airport"), true).
clause(39253, label("AIRPORT_310", "Ostend-Bruges International Airport"), true).
clause(39779, label("AIRPORT_3998", "Palma De Mallorca Airport"), true).
clause(96423, label_path([], []), true).
clause(96424,
       label_path([var('Id')|var('Ids')], [var('Lbl')|var('Lbls')]),
       (label(var('Id'), var('Lbl')), label_path(var('Ids'), var('Lbls')))).
clause(96425,
       route(var('From'), var('To'), var('Visited'), var('Length'), var('Max'), [var('From'), var('To')]),
       (var('Length') =< var('Max'),
        hasRoute(var('From'), var('To')),
        \+member(var('To'), var('Visited')))).
clause(96426,
       route(var('From'), var('To'), var('Visited'), var('Length'), var('Max'), [var('From')|var('Path')]),
       (var('Length') =< var('Max'),
        hasRoute(var('From'), var('Via')),
        \+member(var('Via'), var('Visited')),
        var('Next') is var('Length') + 1,
        route(var('Via'), var('To'), [var('Via')|var('Visited')], var('Next'), var('Max'), var('Path')))).
clause(96427,
       discovered_airroute(var('Labels')),
       (route("AIRPORT_310", "AIRPORT_1587", ["AIRPORT_310"], 0, 2, var('Ids')),
        label_path(var('Ids'), var('Labels')))).

step(discovered_airroute(["Ostend-Bruges International Airport", "Liège Airport", "Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"]),
     rule(96427),
     ['Labels' = ["Ostend-Bruges International Airport", "Liège Airport", "Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"],
      'Ids' = ["AIRPORT_310", "AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"]],
     [route("AIRPORT_310", "AIRPORT_1587", ["AIRPORT_310"], 0, 2, ["AIRPORT_310", "AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"]),
      label_path(["AIRPORT_310", "AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"], ["Ostend-Bruges International Airport", "Liège Airport", "Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"])]).
step(route("AIRPORT_310", "AIRPORT_1587", ["AIRPORT_310"], 0, 2, ["AIRPORT_310", "AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"]),
     rule(96426),
     ['From' = "AIRPORT_310",
      'To' = "AIRPORT_1587",
      'Visited' = ["AIRPORT_310"],
      'Length' = 0,
      'Max' = 2,
      'Path' = ["AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"],
      'Via' = "AIRPORT_309",
      'Next' = 1],
     [0 =< 2,
      hasRoute("AIRPORT_310", "AIRPORT_309"),
      \+member("AIRPORT_309", ["AIRPORT_310"]),
      1 is 0 + 1,
      route("AIRPORT_309", "AIRPORT_1587", ["AIRPORT_309", "AIRPORT_310"], 1, 2, ["AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"])]).
step(0 =< 2, builtin, [], []).
step(hasRoute("AIRPORT_310", "AIRPORT_309"), fact(15985), [], []).
step(\+member("AIRPORT_309", ["AIRPORT_310"]), absent, [], []).
step(1 is 0 + 1, builtin, [], []).
step(route("AIRPORT_309", "AIRPORT_1587", ["AIRPORT_309", "AIRPORT_310"], 1, 2, ["AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"]),
     rule(96426),
     ['From' = "AIRPORT_309",
      'To' = "AIRPORT_1587",
      'Visited' = ["AIRPORT_309", "AIRPORT_310"],
      'Length' = 1,
      'Max' = 2,
      'Path' = ["AIRPORT_1452", "AIRPORT_1587"],
      'Via' = "AIRPORT_1452",
      'Next' = 2],
     [1 =< 2,
      hasRoute("AIRPORT_309", "AIRPORT_1452"),
      \+member("AIRPORT_1452", ["AIRPORT_309", "AIRPORT_310"]),
      2 is 1 + 1,
      route("AIRPORT_1452", "AIRPORT_1587", ["AIRPORT_1452", "AIRPORT_309", "AIRPORT_310"], 2, 2, ["AIRPORT_1452", "AIRPORT_1587"])]).
step(1 =< 2, builtin, [], []).
step(hasRoute("AIRPORT_309", "AIRPORT_1452"), fact(15870), [], []).
step(\+member("AIRPORT_1452", ["AIRPORT_309", "AIRPORT_310"]), absent, [], []).
step(2 is 1 + 1, builtin, [], []).
step(route("AIRPORT_1452", "AIRPORT_1587", ["AIRPORT_1452", "AIRPORT_309", "AIRPORT_310"], 2, 2, ["AIRPORT_1452", "AIRPORT_1587"]),
     rule(96425),
     ['From' = "AIRPORT_1452",
      'To' = "AIRPORT_1587",
      'Visited' = ["AIRPORT_1452", "AIRPORT_309", "AIRPORT_310"],
      'Length' = 2,
      'Max' = 2],
     [2 =< 2,
      hasRoute("AIRPORT_1452", "AIRPORT_1587"),
      \+member("AIRPORT_1587", ["AIRPORT_1452", "AIRPORT_309", "AIRPORT_310"])]).
step(2 =< 2, builtin, [], []).
step(hasRoute("AIRPORT_1452", "AIRPORT_1587"), fact(3857), [], []).
step(\+member("AIRPORT_1587", ["AIRPORT_1452", "AIRPORT_309", "AIRPORT_310"]), absent, [], []).
step(label_path(["AIRPORT_310", "AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"], ["Ostend-Bruges International Airport", "Liège Airport", "Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_310",
      'Ids' = ["AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"],
      'Lbl' = "Ostend-Bruges International Airport",
      'Lbls' = ["Liège Airport", "Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"]],
     [label("AIRPORT_310", "Ostend-Bruges International Airport"),
      label_path(["AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"], ["Liège Airport", "Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"])]).
step(label("AIRPORT_310", "Ostend-Bruges International Airport"), fact(39253), [], []).
step(label_path(["AIRPORT_309", "AIRPORT_1452", "AIRPORT_1587"], ["Liège Airport", "Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_309",
      'Ids' = ["AIRPORT_1452", "AIRPORT_1587"],
      'Lbl' = "Liège Airport",
      'Lbls' = ["Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"]],
     [label("AIRPORT_309", "Liège Airport"),
      label_path(["AIRPORT_1452", "AIRPORT_1587"], ["Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"])]).
step(label("AIRPORT_309", "Liège Airport"), fact(39246), [], []).
step(label_path(["AIRPORT_1452", "AIRPORT_1587"], ["Heraklion International Nikos Kazantzakis Airport", "Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_1452",
      'Ids' = ["AIRPORT_1587"],
      'Lbl' = "Heraklion International Nikos Kazantzakis Airport",
      'Lbls' = ["Václav Havel Airport Prague"]],
     [label("AIRPORT_1452", "Heraklion International Nikos Kazantzakis Airport"),
      label_path(["AIRPORT_1587"], ["Václav Havel Airport Prague"])]).
step(label("AIRPORT_1452", "Heraklion International Nikos Kazantzakis Airport"),
     fact(38296),
     [],
     []).
step(label_path(["AIRPORT_1587"], ["Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_1587", 'Ids' = [], 'Lbl' = "Václav Havel Airport Prague", 'Lbls' = []],
     [label("AIRPORT_1587", "Václav Havel Airport Prague"), label_path([], [])]).
step(label("AIRPORT_1587", "Václav Havel Airport Prague"), fact(38372), [], []).
step(label_path([], []), fact(96423), [], []).
step(discovered_airroute(["Ostend-Bruges International Airport", "Liège Airport", "Diagoras Airport", "Václav Havel Airport Prague"]),
     rule(96427),
     ['Labels' = ["Ostend-Bruges International Airport", "Liège Airport", "Diagoras Airport", "Václav Havel Airport Prague"],
      'Ids' = ["AIRPORT_310", "AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"]],
     [route("AIRPORT_310", "AIRPORT_1587", ["AIRPORT_310"], 0, 2, ["AIRPORT_310", "AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"]),
      label_path(["AIRPORT_310", "AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"], ["Ostend-Bruges International Airport", "Liège Airport", "Diagoras Airport", "Václav Havel Airport Prague"])]).
step(route("AIRPORT_310", "AIRPORT_1587", ["AIRPORT_310"], 0, 2, ["AIRPORT_310", "AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"]),
     rule(96426),
     ['From' = "AIRPORT_310",
      'To' = "AIRPORT_1587",
      'Visited' = ["AIRPORT_310"],
      'Length' = 0,
      'Max' = 2,
      'Path' = ["AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"],
      'Via' = "AIRPORT_309",
      'Next' = 1],
     [0 =< 2,
      hasRoute("AIRPORT_310", "AIRPORT_309"),
      \+member("AIRPORT_309", ["AIRPORT_310"]),
      1 is 0 + 1,
      route("AIRPORT_309", "AIRPORT_1587", ["AIRPORT_309", "AIRPORT_310"], 1, 2, ["AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"])]).
step(route("AIRPORT_309", "AIRPORT_1587", ["AIRPORT_309", "AIRPORT_310"], 1, 2, ["AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"]),
     rule(96426),
     ['From' = "AIRPORT_309",
      'To' = "AIRPORT_1587",
      'Visited' = ["AIRPORT_309", "AIRPORT_310"],
      'Length' = 1,
      'Max' = 2,
      'Path' = ["AIRPORT_1472", "AIRPORT_1587"],
      'Via' = "AIRPORT_1472",
      'Next' = 2],
     [1 =< 2,
      hasRoute("AIRPORT_309", "AIRPORT_1472"),
      \+member("AIRPORT_1472", ["AIRPORT_309", "AIRPORT_310"]),
      2 is 1 + 1,
      route("AIRPORT_1472", "AIRPORT_1587", ["AIRPORT_1472", "AIRPORT_309", "AIRPORT_310"], 2, 2, ["AIRPORT_1472", "AIRPORT_1587"])]).
step(hasRoute("AIRPORT_309", "AIRPORT_1472"), fact(15871), [], []).
step(\+member("AIRPORT_1472", ["AIRPORT_309", "AIRPORT_310"]), absent, [], []).
step(route("AIRPORT_1472", "AIRPORT_1587", ["AIRPORT_1472", "AIRPORT_309", "AIRPORT_310"], 2, 2, ["AIRPORT_1472", "AIRPORT_1587"]),
     rule(96425),
     ['From' = "AIRPORT_1472",
      'To' = "AIRPORT_1587",
      'Visited' = ["AIRPORT_1472", "AIRPORT_309", "AIRPORT_310"],
      'Length' = 2,
      'Max' = 2],
     [2 =< 2,
      hasRoute("AIRPORT_1472", "AIRPORT_1587"),
      \+member("AIRPORT_1587", ["AIRPORT_1472", "AIRPORT_309", "AIRPORT_310"])]).
step(hasRoute("AIRPORT_1472", "AIRPORT_1587"), fact(4131), [], []).
step(\+member("AIRPORT_1587", ["AIRPORT_1472", "AIRPORT_309", "AIRPORT_310"]), absent, [], []).
step(label_path(["AIRPORT_310", "AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"], ["Ostend-Bruges International Airport", "Liège Airport", "Diagoras Airport", "Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_310",
      'Ids' = ["AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"],
      'Lbl' = "Ostend-Bruges International Airport",
      'Lbls' = ["Liège Airport", "Diagoras Airport", "Václav Havel Airport Prague"]],
     [label("AIRPORT_310", "Ostend-Bruges International Airport"),
      label_path(["AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"], ["Liège Airport", "Diagoras Airport", "Václav Havel Airport Prague"])]).
step(label_path(["AIRPORT_309", "AIRPORT_1472", "AIRPORT_1587"], ["Liège Airport", "Diagoras Airport", "Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_309",
      'Ids' = ["AIRPORT_1472", "AIRPORT_1587"],
      'Lbl' = "Liège Airport",
      'Lbls' = ["Diagoras Airport", "Václav Havel Airport Prague"]],
     [label("AIRPORT_309", "Liège Airport"),
      label_path(["AIRPORT_1472", "AIRPORT_1587"], ["Diagoras Airport", "Václav Havel Airport Prague"])]).
step(label_path(["AIRPORT_1472", "AIRPORT_1587"], ["Diagoras Airport", "Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_1472",
      'Ids' = ["AIRPORT_1587"],
      'Lbl' = "Diagoras Airport",
      'Lbls' = ["Václav Havel Airport Prague"]],
     [label("AIRPORT_1472", "Diagoras Airport"),
      label_path(["AIRPORT_1587"], ["Václav Havel Airport Prague"])]).
step(label("AIRPORT_1472", "Diagoras Airport"), fact(38314), [], []).
step(discovered_airroute(["Ostend-Bruges International Airport", "Liège Airport", "Palma De Mallorca Airport", "Václav Havel Airport Prague"]),
     rule(96427),
     ['Labels' = ["Ostend-Bruges International Airport", "Liège Airport", "Palma De Mallorca Airport", "Václav Havel Airport Prague"],
      'Ids' = ["AIRPORT_310", "AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"]],
     [route("AIRPORT_310", "AIRPORT_1587", ["AIRPORT_310"], 0, 2, ["AIRPORT_310", "AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"]),
      label_path(["AIRPORT_310", "AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"], ["Ostend-Bruges International Airport", "Liège Airport", "Palma De Mallorca Airport", "Václav Havel Airport Prague"])]).
step(route("AIRPORT_310", "AIRPORT_1587", ["AIRPORT_310"], 0, 2, ["AIRPORT_310", "AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"]),
     rule(96426),
     ['From' = "AIRPORT_310",
      'To' = "AIRPORT_1587",
      'Visited' = ["AIRPORT_310"],
      'Length' = 0,
      'Max' = 2,
      'Path' = ["AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"],
      'Via' = "AIRPORT_309",
      'Next' = 1],
     [0 =< 2,
      hasRoute("AIRPORT_310", "AIRPORT_309"),
      \+member("AIRPORT_309", ["AIRPORT_310"]),
      1 is 0 + 1,
      route("AIRPORT_309", "AIRPORT_1587", ["AIRPORT_309", "AIRPORT_310"], 1, 2, ["AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"])]).
step(route("AIRPORT_309", "AIRPORT_1587", ["AIRPORT_309", "AIRPORT_310"], 1, 2, ["AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"]),
     rule(96426),
     ['From' = "AIRPORT_309",
      'To' = "AIRPORT_1587",
      'Visited' = ["AIRPORT_309", "AIRPORT_310"],
      'Length' = 1,
      'Max' = 2,
      'Path' = ["AIRPORT_3998", "AIRPORT_1587"],
      'Via' = "AIRPORT_3998",
      'Next' = 2],
     [1 =< 2,
      hasRoute("AIRPORT_309", "AIRPORT_3998"),
      \+member("AIRPORT_3998", ["AIRPORT_309", "AIRPORT_310"]),
      2 is 1 + 1,
      route("AIRPORT_3998", "AIRPORT_1587", ["AIRPORT_3998", "AIRPORT_309", "AIRPORT_310"], 2, 2, ["AIRPORT_3998", "AIRPORT_1587"])]).
step(hasRoute("AIRPORT_309", "AIRPORT_3998"), fact(15872), [], []).
step(\+member("AIRPORT_3998", ["AIRPORT_309", "AIRPORT_310"]), absent, [], []).
step(route("AIRPORT_3998", "AIRPORT_1587", ["AIRPORT_3998", "AIRPORT_309", "AIRPORT_310"], 2, 2, ["AIRPORT_3998", "AIRPORT_1587"]),
     rule(96425),
     ['From' = "AIRPORT_3998",
      'To' = "AIRPORT_1587",
      'Visited' = ["AIRPORT_3998", "AIRPORT_309", "AIRPORT_310"],
      'Length' = 2,
      'Max' = 2],
     [2 =< 2,
      hasRoute("AIRPORT_3998", "AIRPORT_1587"),
      \+member("AIRPORT_1587", ["AIRPORT_3998", "AIRPORT_309", "AIRPORT_310"])]).
step(hasRoute("AIRPORT_3998", "AIRPORT_1587"), fact(27826), [], []).
step(\+member("AIRPORT_1587", ["AIRPORT_3998", "AIRPORT_309", "AIRPORT_310"]), absent, [], []).
step(label_path(["AIRPORT_310", "AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"], ["Ostend-Bruges International Airport", "Liège Airport", "Palma De Mallorca Airport", "Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_310",
      'Ids' = ["AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"],
      'Lbl' = "Ostend-Bruges International Airport",
      'Lbls' = ["Liège Airport", "Palma De Mallorca Airport", "Václav Havel Airport Prague"]],
     [label("AIRPORT_310", "Ostend-Bruges International Airport"),
      label_path(["AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"], ["Liège Airport", "Palma De Mallorca Airport", "Václav Havel Airport Prague"])]).
step(label_path(["AIRPORT_309", "AIRPORT_3998", "AIRPORT_1587"], ["Liège Airport", "Palma De Mallorca Airport", "Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_309",
      'Ids' = ["AIRPORT_3998", "AIRPORT_1587"],
      'Lbl' = "Liège Airport",
      'Lbls' = ["Palma De Mallorca Airport", "Václav Havel Airport Prague"]],
     [label("AIRPORT_309", "Liège Airport"),
      label_path(["AIRPORT_3998", "AIRPORT_1587"], ["Palma De Mallorca Airport", "Václav Havel Airport Prague"])]).
step(label_path(["AIRPORT_3998", "AIRPORT_1587"], ["Palma De Mallorca Airport", "Václav Havel Airport Prague"]),
     rule(96424),
     ['Id' = "AIRPORT_3998",
      'Ids' = ["AIRPORT_1587"],
      'Lbl' = "Palma De Mallorca Airport",
      'Lbls' = ["Václav Havel Airport Prague"]],
     [label("AIRPORT_3998", "Palma De Mallorca Airport"),
      label_path(["AIRPORT_1587"], ["Václav Havel Airport Prague"])]).
step(label("AIRPORT_3998", "Palma De Mallorca Airport"), fact(39779), [], []).
