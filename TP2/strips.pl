strips :- 	objectif(B), initial(S),
	format("Taper entree apres chaque etape \n\n",[]),
	strips([but(B)],S,[]), ligne.

strips(Pile,_S,_P) :- ligne, format("Pile : ",[]), write(Pile), ligne, get0(_), fail.

/* DEBUT STRIPS */

/* Cas d'arrêt */
strips([],_,P):- afficher_plan(P).

/* Clause 1 : Si le sommet de Pile est de type but(B) et que B filtre la situation courante, afficher le message 1 et dépiler B*/
strips([but(B)|Reste],E,P):-
	filtre(B,E),
	message(1,B),
	strips(Reste,E,P).
	
/* Clause 2 : Si le sommet de Pile est de type but(B) et que B est un but simple qui ne filtre pas la situation courante, rechercher une action dont la liste Ajout contienne ce but, afficher le message 2 et empiler cette action et ses préconditions*/
strips([but([B])|Reste],E,P):-
	non_filtre(B,E),
	action(A,C,_,L),
	membre(B,L),
	message(2,A),
	strips([but(C),act(A)|Reste],E,P).
	
/* Clause 3 : Si le sommet de Pile est de type but(B) et que B est un but composé qui ne filtre pas la situation courante, afficher le message 3, dcomposer B en une liste de buts simples et empiler cette liste*/
strips([but(B)|Reste],E,P):-
	non_filtre(B,E),
	message(3,B),
	decomposer(B,Bs),
	conc(Bs, [but(B)|Reste], Pile),
	strips(Pile,E,P).

/* Clause 4 : Si le sommet de Pile est de type act(A), afficher le message 4, appliquer l'action à l'état courant, afficher le message 5 et dépiler l'action*/
strips([act(A)|Reste],E,P):-
	message(4,A),
	appliquer(A,E,Enew),
	message(5,Enew),
	strips(Reste,Enew,P).

/* FIN   STRIPS */

afficher_plan([]) :- 
	!, ligne, format("Plan solution : ",[]), ligne.
afficher_plan([A1|A2]) :- 
	afficher_plan(A2), format("   -",[]), write(A1), ligne.

filtre([],_).
filtre([B1|B2],S) :- membre(B1,S), filtre(B2,S).

non_filtre(B,S) :- filtre(B,S), !, fail.
non_filtre(_B,_S).

membre(E, [E|_]).
membre(E,[_|L]) :- membre(E,L).

compose([_,_|_]).

decomposer([],[]).
decomposer([B1|B2],[but([B1])|B3]) :- decomposer(B2,B3).

conc([],L2,L2).
conc([X|L1],L2,[X|L3]) :- conc(L1,L2,L3).

appliquer(N_action,S_courante,S_nouvelle) :-
	action(N_action,_P,S,A),
	retirer(S,S_courante,S_inter),
	conc(A,S_inter,S_nouvelle).

retirer([],S,S).
retirer([R1|R2],S,S2) :- oter(R1,S,S1), retirer(R2, S1, S2).

oter(_E,[],[]).
oter(E,[E|L],L) :- !.
oter(E,[A|L],[A|L1]) :- oter(E,L,L1).

ligne :- format("\n",[]).

message(1,B) :- 
	format("Le but ",[]), write(B), format(" filtre la situation",[]), ligne.
message(2,A) :-
	format("On empile l'action ",[]), write(A), ligne.
message(3,B) :- format("On empile les sous-buts ",[]), write(B), ligne.
message(4,A) :- format("*** On execute l'action ",[]), write(A), format(" ***",[]), ligne.
message(5,S) :- format("Nouvelle situation ",[]), write(S), ligne.


/* Exemple 1 */
/*
initial([lasagnes]).
objectif([lasagnes,rassasie]).
action(manger_lasagnes,[lasagnes],[lasagnes],[sans_lasagnes,rassasie]).
action(cuire_lasagnes,[sans_lasagnes],[sans_lasagnes],[lasagnes]). 
*/

/* Exemple 2 */
/*
initial([singe(a),caisse(b),bananes(c),sursol]).
objectif([avoir_bananes]).
action(aller(X,Y),[singe(X),sursol],[singe(X)],[singe(Y)]).
action(pousser(X,Y),[caisse(X),singe(X),sursol],[caisse(X),singe(X)],[caisse(Y),singe(Y)]).
action(monter,[caisse(X),singe(X),sursol],[sursol],[surcaisse]).
action(descendre,[surcaisse],[surcaisse],[sursol]).
action(attraper,[bananes(X),caisse(X),surcaisse],[],[avoir_bananes]).
*/











