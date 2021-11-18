/*--------------------------------------------------------------------------------*/
/*                TP diagnostic                      			*/
/* Calcul des diagnostics minimaux a partir d'observations  	*/
/* diag(L) renvoie dans L la liste des diagnostics minimaux 	*/
/* diag(L) n�cessite:					*/
/*   - un fait observations(Obs): la liste des observations	 	*/
/*   - un fait composants(Comp): la liste des composants    	*/
/*--------------------------------------------------------------------------------*/

diag(Lcomp):-
	observations(Obs),
	findall(E,etat_systeme(E,Obs),Ldiag),
	filtrer(Ldiag,Ldiag,[],LdiagMin),
	convertir(LdiagMin,Lcomp).

/* Ote de Ldiag les diags non minimaux et renvoie LdiagMin */
filtrer([],_,L,L).
filtrer([E|L],Lcomplet,L1,L2):-
	nonMinimal(E,Lcomplet), !,
	filtrer(L,Lcomplet,L1,L2).
filtrer([E|L],Lcomplet,L1,L2):-
	filtrer(L,Lcomplet,[E|L1],L2).

/* R�ussit si X n'est pas un diag minimal */
nonMinimal(X,[E|_]):-
	dif(X,E),
	inclut(X,E), !.
nonMinimal(X,[_|L]):-
	nonMinimal(X,L).

/* R�ussit si le premier diagnostic inclut le second */
inclut([],[]).
inclut([1|L1],[1|L2]):-
	inclut(L1,L2).
inclut([1|L1],[0|L2]):-
	inclut(L1,L2).
inclut([2|L1],[2|L2]):-
	inclut(L1,L2).
inclut([2|L1],[0|L2]):-
	inclut(L1,L2).
inclut([0|L1],[0|L2]):-
	inclut(L1,L2).

/* Produit une liste L2 d'ensembles de composants en panne */
/* � partir d'une liste L1 de diagnostics (�tats) */
convertir(L1,L2):-
	composants(Comp),
	convertirL(L1,Comp,L2).

/* Parcourt la liste des �tats */
convertirL([],_,[]).
convertirL([E1|L1],Comp,[E2|L2]):-
	convertirD(E1,Comp,E2),
	convertirL(L1,Comp,L2).

/* Produit une liste de composants en panne � partir d'un �tat*/
convertirD([],[],[]).
convertirD([N|L1],[Co|L2],[panne(Co,N)|R]):-
	dif(N,0),
	convertirD(L1,L2,R).
convertirD([0|L1],[_|L2],R):-
	convertirD(L1,L2,R).

dif(X,X):- !,fail.
dif(_,_).

/*--------------------------------------------------------------------------------*/
/* La liste des �tats Ldiag doit �tre dans le m�me ordre 		*/
/* que la liste des composants (A1, A2,O1, X1,X2)   		*/
/* Idem pour les observations (In1X1,In2X1,In1A2,OutX2,OutO1)	*/
/* Codage des �tats :	  				*/
/* 0 = ok, 1 = panne 					*/
/* 0 = ok, 1 = panne1, 2 = panne2  (question d)		*/
/*--------------------------------------------------------------------------------*/

etat_systeme([EtatA1, EtatA2,EtatO1, EtatX1,EtatX2],[In1X1,In2X1,In1A2,OutX2,OutO1]) :-
	fd_domain([EtatA1, EtatA2, EtatO1, EtatX1, EtatX2], [0,1]),

	(EtatX1#=0)#==> (In1X1#=In2X1)  #==> OutX1#= 0,
	(EtatX1#=0)#==> (In1X1#\=In2X1) #==> OutX1#= 1,
	(EtatX1#=1)#==> OutX1#= 0,
	(EtatX1#=2)#==> OutX1#= 1,

	(EtatA1#=0)#==> (In1X1#=1#/\In2X1#=1) #==> OutA1#= 1,
	(EtatA1#=0)#==> (In1X1#=0#\/In2X1#=0) #==> OutA1#= 0,
	(EtatA1#=1)#==> OutA1#= 0,
	(EtatA1#=2)#==> OutA1#= 1,

	(EtatA2#=0)#==> (In1A2#=1#/\OutX1#=1) #==> OutA2#= 1,
	(EtatA2#=0)#==> (In1A2#=0#\/OutX1#=0) #==> OutA2#= 0,
	(EtatA2#=1)#==> OutA2#= 0,
	(EtatA2#=2)#==> OutA2#= 1,

	(EtatO1#=0)#==> (OutA2#=1#\/OutA1#=1) #==> OutO1#= 1,
	(EtatO1#=0)#==> (OutA2#=0#/\OutA1#=0) #==> OutO1#= 0,
	(EtatO1#=1)#==> OutO1#= 0,
	(EtatO1#=2)#==> OutO1#= 1,

	(EtatX2#=0)#==> (OutX1#=In1A2)  #==> OutX2#= 0,
	(EtatX2#=0)#==> (OutX1#\=In1A2) #==> OutX2#= 1,
	(EtatX2#=1)#==> OutX2#= 0,
	(EtatX2#=2)#==> OutX2#= 1,

	fd_labeling([EtatA1, EtatA2, EtatO1, EtatX1, EtatX2]).



/* Exemple d'observations dans l'ordre [In1X1,In2X1,In1A2,OutX2,OutO1] */
/* Sur cet exemple (obs1) : trois diagnostics minimaux possibles (x1), (x2,o1) et (x2,a2)*/
observations([1,0,1,1,0]).


/* Noms des composants (pour afficher le diagnostic) */
composants([a1,a2,o1,x1,x2]).

	