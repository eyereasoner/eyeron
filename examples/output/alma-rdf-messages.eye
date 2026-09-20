# Eyelang result format 2
query(1, [call(title(?v0, ?v1))], [binding("id", ?v0), binding("val", ?v1)]).
result(1, complete, 1).
answer(1, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Reasoning about RDF Message Logs")]).
query(2, [call(subject(?v0, ?v1))], [binding("id", ?v0), binding("val", ?v1)]).
result(2, complete, 1).
answer(2, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Linked Data Streams")]).
query(3, [call(type(?v0, ?v1))], [binding("id", ?v0), binding("val", ?v1)]).
result(3, complete, 1).
answer(3, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "book")]).
