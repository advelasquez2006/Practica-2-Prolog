% Relaciones de parentesco
parent(dorlan, pardo).
parent(dorlan, lucumi).
parent(dorlan, plata).
parent(dorlan, ibarguen).
parent(esperanza, pardo).
parent(esperanza, lucumi).
parent(esperanza, plata).
parent(esperanza, ibarguen).
parent(pardo, isabela).
parent(pardo, sofia). 
parent(lucumi, andres).
parent(lucumi, camilo).
parent(plata, valentina).
parent(plata, messi).
parent(ibarguen, manuela).
parent(ibarguen, laura).
parent(isabela, jose).
parent(isabela, juan).
parent(sofia, jorge).
parent(sofia, sandra).
parent(andres, tomas).
parent(andres, nicolas).
parent(camilo, hugo).
parent(camilo, ocampo).
parent(valentina, valeria).
parent(valentina, sara).
parent(messi, oscar).
parent(messi, patricia).
parent(manuela, pepe).
parent(manuela, zlatan).
parent(laura, neymar).
parent(laura, ismael).

% Género
male(dorlan).
male(pardo).
male(lucumi).
male(plata).
male(ibarguen).
male(andres).
male(camilo).
male(messi).
male(jose).
male(juan).
male(jorge).
male(tomas).
male(nicolas).
male(hugo).
male(ocampo).
male(oscar).
male(pepe).
male(zlatan).
male(neymar).
male(ismael).

female(esperanza).
female(isabela).
female(sofia).
female(valentina).
female(manuela).
female(laura).
female(sandra).
female(valeria).
female(sara).
female(patricia).


% Reglas de parentesco
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).
brother(X, Y) :- parent(Z, X), parent(Z, Y), male(X), X \= Y.
sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), X \= Y.
grandfather(X, Y) :- parent(X, Z), parent(Z, Y), male(X).
grandmother(X, Y) :- parent(X, Z), parent(Z, Y), female(X).
uncle(X, Y) :- brother(X, Z), parent(Z, Y).
aunt(X, Y) :- sister(X, Z), parent(Z, Y).
cousin(X, Y) :- parent(Z, X), parent(W, Y), Z \= W, (brother(Z, W); sister(Z, W)).

% Nivel de consanguinidad
levelConsanguinity(X, Y, 1) :- father(Y, X).
levelConsanguinity(X, Y, 1) :- mother(Y, X).
levelConsanguinity(X, Y, 2) :- brother(X, Y).
levelConsanguinity(X, Y, 2) :- sister(X, Y).
levelConsanguinity(X, Y, 2) :- grandfather(Y, X).
levelConsanguinity(X, Y, 2) :- grandmother(Y, X).
levelConsanguinity(X, Y, 3) :- uncle(Y, X).
levelConsanguinity(X, Y, 3) :- aunt(Y, X).
levelConsanguinity(X, Y, 3) :- cousin(X, Y).

% Porcentaje de herencia
percentLegacy(1, 30).
percentLegacy(2, 20).
percentLegacy(3, 10).

% Distribución de herencia (modificado para incluir el testador)
legacyMoney(_, _, [], []).
legacyMoney(Testador, LegacyTotal, [Family|F], [Distribution|F2]) :-
    levelConsanguinity(Family, Testador, Level),
    percentLegacy(Level, Percent),
    Distribution is (LegacyTotal * (Percent / 100)),
    legacyMoney(Testador, LegacyTotal, F, F2).

% Predicado para distribuir herencia
distribute_legacy(Testador, LegacyTotal, Heirs) :-
    legacyMoney(Testador, LegacyTotal, Heirs, Distributions),
    write('Distributions for testador '), write(Testador), write(': '), write(Distributions), nl.











