% Prolog example: void.
% Companion to void.n3/.srl: a relational distillation of the N3 source's
% small "Void" book knowledge base and its five forward rules (author
% implies made, about-a-person implies subjectOf, quantum-field-theory
% topic tagging, cosmological-constant/dark-energy linking, and an
% English-quantum-theory-reader recommendation).
author(book2016, jamesWeatherall).
in_language(book2016, en).
about(book2016, vacuum).
about(book2016, spaceTime).
about(book2016, quantumFieldTheory).
about(book2016, generalRelativity).
about(book2016, cosmologicalConstant).
about(book2016, casimirEffect).
about(book2016, isaacNewton).
about(book2016, albertEinstein).

person(jamesWeatherall).
person(isaacNewton).
person(albertEinstein).

made(Person, Book) :-
    author(Book, Person).
subject_of(Person, Book) :-
    about(Book, Person),
    person(Person).
subject(Book, quantumTheory) :-
    about(Book, quantumFieldTheory).
about(Book, darkEnergy) :-
    about(Book, cosmologicalConstant).
recommended_for(Book, curiousPhysicsReaderEn) :-
    subject(Book, quantumTheory),
    in_language(Book, en).

?- made(Person, Book).
?- subject_of(Person, Book).
?- subject(Book, Topic).
?- recommended_for(Book, Reader).
