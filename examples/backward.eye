# Eyelang example: backward.
value(five, 5). value(three, 3).
more_interesting(?x, ?y) if value(?x, ?left), value(?y, ?right), ?left > ?right.
indeed_more_interesting(?x, ?y) if more_interesting(?x, ?y).
ask indeed_more_interesting(?x, ?y).
