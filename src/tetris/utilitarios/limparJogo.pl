cria_linha_vazia([], []).
cria_linha_vazia( [_ | ProximasPecas], [0 | ProximasPecasZeradas] ) :- cria_linha_vazia(ProximasPecas, ProximasPecasZeradas).

pode_limpar_linha(Linha) :- \+ member(0, Linha).

eh_linha_vazia([]).
eh_linha_vazia([0 | Linha]) :- eh_linha_vazia(Linha).

limpar_linhas([], [], 0).
limpar_linhas([Linha | Linhas], [LinhaLimpa | LinhasLimpas], QuantidadeLinhasTrocadas) :- 
    pode_limpar_linha(Linha),
    limpar_linhas(Linhas, LinhasLimpas, QuantidadeLinhasTrocadasPilha),
    QuantidadeLinhasTrocadas is QuantidadeLinhasTrocadasPilha + 1,
    cria_linha_vazia(Linha, LinhaLimpa), !.

limpar_linhas([Linha | Linhas], [Linha | LinhasLimpas], QuantidadeLinhasTrocadas) :- 
    limpar_linhas(Linhas, LinhasLimpas, QuantidadeLinhasTrocadas).

troca_sucessores([LinhaAbaixo, LinhaAcima | Linhas], 0, [LinhaAcima, LinhaAbaixo | Linhas]) :- !.
troca_sucessores([LinhaAbaixo, LinhaAcima | Linhas], Indice, [LinhaAbaixo | ProximasLinhas]) :-
    NovoIndice is Indice - 1,
    troca_sucessores([LinhaAcima | Linhas], NovoIndice, ProximasLinhas).

shift_baixo_linha_clear(Grid, 0, Grid) :- !.

shift_baixo_linha_clear(Grid, Indice, Grid) :- 
    NovoIndice is Indice - 1,
    nth0(NovoIndice, Grid, LinhaGrid),
    \+ eh_linha_vazia(LinhaGrid), !. 

shift_baixo_linha_clear(Grid, Indice, NovaGrid) :-
    NovoIndice is Indice - 1,
    troca_sucessores(Grid, NovoIndice, GridIntermediaria),
    shift_baixo_linha_clear(GridIntermediaria, NovoIndice, NovaGrid).

shift_baixo_clear(Grid, 20, Grid) :- !.
shift_baixo_clear(Grid, Indice, NovaGrid) :-
    shift_baixo_linha_clear(Grid, Indice, GridIntermediaria),
    NovoIndice is Indice + 1,
    shift_baixo_clear(GridIntermediaria, NovoIndice, NovaGrid).

clear_game(Linhas, NovasLinhas, QuantidadeLinhasLimpas) :- 
    limpar_linhas(Linhas, LinhasLimpas, QuantidadeLinhasLimpas),
    shift_baixo_clear(LinhasLimpas,0, NovasLinhas).