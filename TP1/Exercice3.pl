prevision([A,B,C,D]):-
    /* Déclaration */
    fd_domain([A,B,C,D], 1,4),
    /* Cinema  = 1 
     * Theatre = 2
     * Concert = 3
     * Pub     = 4
     */

    /* Contraintes */
    (A#=1)#==>(D#=1),
    (B#=3)#<=>(C#=2),
    (B#\=3)#==>(D#=B),
    (B#=4)#/\(A#=4),
    (A#=3)#<=>(B#=3#/\C#=3),
    (D#\=4)#==>(A#=2#/\B#=2),
    (C#\=2)#<=>(D#\=2),
    (A#=4)#\/(D#=4)#==>(C#=4),

    fd_labeling([A,B,C,D]).

/** REPONSES **/

/**
| ?- prevision(L).           

L = [4,4,4,4]

**/