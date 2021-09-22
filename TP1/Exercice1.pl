
quatreReines([L1,L2,L3,L4]):-
    /* Déclaration */
    fd_domain([L1,L2,L3,L4], 1, 4),

    /* Contraintes */
    fd_all_different([L1, L2, L3, L4]),

    L1+1#\= L2+2,
    L1+1#\= L3+3,
    L1+1#\= L4+4,

    L1-1#\= L2-2,
    L1-1#\= L3-3,
    L1-1#\= L4-4,

    L2+2#\= L3+3,
    L2+2#\= L4+4,

    L2-2#\= L3-3,
    L2-2#\= L4-4,

    L3+3#\= L4+4,

    L3-3#\= L4-4,

    fd_labeling([L1,L2,L3,L4]).

/** REPONSES **/

/**
| ?- quatreReines(L).        

L = [2,4,1,3] ? ;

L = [3,1,4,2] ? ;
**/
