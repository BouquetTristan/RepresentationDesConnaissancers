monnaie(T,P,[E2,E1,C50,C20,C10],[XE2,XE1,XC50,XC20,XC10]):-
    /* Déclaration */
    fd_domain(XE2 , 0,E2 ),
    fd_domain(XE1 , 0,E1 ),
    fd_domain(XC50, 0,C50),
    fd_domain(XC20, 0,C20),
    fd_domain(XC10, 0,C10),

    /* Contraintes */
    T#=P+XE2*200+XE1*100+XC50*50+XC20*20+XC10*10,


    fd_labeling([XE2,XE1,XC50,XC20,XC10]).

/** REPONSES **/

/**
| ?- findall(L,monnaie(200,90,[10,10,10,10,10],L),ListeSol).

ListeSol = [[0,0,0,1,9],[0,0,0,2,7],[0,0,0,3,5],[0,0,0,4,3],[0,0,0,5,1],[0,0,1,0,6],[0,0,1,1,4],[0,0,1,2,2],[0,0,1,3,0],[0,0,2,0,1],[0,1,0,0,1]]


| ?- findall(L,monnaie(200,90,[10,10,10,10,0],L),ListeSol). 

ListeSol = [[0,0,1,3,0]]


| ?- findall(L,monnaie(200,90,[10,10,0,10,0],L),ListeSol). 

ListeSol = []

**/