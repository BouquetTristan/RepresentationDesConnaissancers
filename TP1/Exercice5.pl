chantier([Fondation,Murs,PortesFenetres,Toit,Cheminee,Peinture,Electricite,Repos]):-
    /* Déclaration */
    fd_domain([Fondation,Murs,PortesFenetres,Toit,Cheminee,Peinture,Electricite,Repos], 1,6),


    /* Contraintes */
    Fondation#<Murs,

    PortesFenetres#>Murs,
    Toit#>Murs,

    Peinture#>=Murs+3,

    Cheminee#>Toit,
    Cheminee#\=Peinture,

    Electricite#>Peinture,

    Repos#\=Fondation,
    Repos#\=Murs,
    Repos#\=PortesFenetres,
    Repos#\=Toit,
    Repos#\=Cheminee,
    Repos#\=Peinture,
    Repos#\=Electricite,

    fd_labeling([Fondation,Murs,PortesFenetres,Toit,Cheminee,Peinture,Electricite,Repos]).

/**
    L = [1,2,3,3,6,5,6,4] ? ;

    L = [1,2,3,5,6,5,6,4] ? ;

    L = [1,2,4,4,6,5,6,3] ? ;

    L = [1,2,4,5,6,5,6,3] ? ;

    L = [1,2,5,3,6,5,6,4] ? ;

    L = [1,2,5,4,6,5,6,3] ? ;

    L = [1,2,5,5,6,5,6,3] ? ;

    L = [1,2,5,5,6,5,6,4] ? ;

    L = [1,2,6,3,6,5,6,4] ? ;

    L = [1,2,6,4,6,5,6,3] ? ;

    L = [1,2,6,5,6,5,6,3] ? ;

    L = [1,2,6,5,6,5,6,4]
**/