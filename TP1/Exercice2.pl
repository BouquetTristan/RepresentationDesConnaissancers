addition([S,E,N,D,M,O,R,Y]):-
    /* Déclaration */
    fd_domain([E,N,D,O,R,Y], 0, 9),
    fd_domain([S,M], 1, 9),

    /* Contraintes */
    fd_all_different([S,E,N,D,M,O,R,Y]),

    S*1000+E*100+N*10+D+M*1000+O*100+R*10+E#=M*10000+O*1000+N*100+E*10+Y,

    fd_labeling([S,E,N,D,M,O,R,Y]).



additionV2([S,E,N,D,M,O,R,Y]):-
    /* Déclaration */
    fd_domain([E,N,D,O,R,Y], 0, 9),
    fd_domain([S,M], 1, 9),
    fd_domain([R1,R2,R3], 0, 1),

    /* Contraintes */
    fd_all_different([S,E,N,D,M,O,R,Y]),

    D+E#=R1*10+Y,
    R1+N+R#=R2*10+E,
    R2+E+O#=R3*10+N,
    R3+S+M#=M*10+O,

    fd_labeling([S,E,N,D,M,O,R,Y]).

/** REPONSES **/

/**
| ?- addition(L).

L = [9,5,6,7,1,0,8,2] ? ;


| ?- additionV2(L).

L = [9,5,6,7,1,0,8,2] ? ;

**/