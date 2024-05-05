:- consult('utilitarios/estado.pl').
:- consult('utilitarios/geradorPeca.pl').
:- consult('utilitarios/rotacaoPeca.pl').

gerador_linha(0, []) :- !.
gerador_linha(DimensaoX, [0 | RestoLinha]) :- NovaDimensaoX is DimensaoX - 1,
                                              gerador_linha(NovaDimensaoX, RestoLinha).

gerador_matriz(_, 0, []) :- !.                                                                   
gerador_matriz(DimensaoX, DimensaoY, [Linha | RestoMatriz]) :- gerador_linha(DimensaoX, Linha),
                                                               NovaDimensaoY is DimensaoY - 1,
                                                               gerador_matriz(DimensaoX, NovaDimensaoY, RestoMatriz).                                                                   

quick_start :-
    gerador_matriz(10, 20, Grid),
    gera_I(PrimeiraPeca, (Xo, Yo), (Xf, Yf)),
    gerador_matriz(10, 20, Grid),
    atribuicao_peca(Grid, PrimeiraPeca, [Xo, Yo], [Xf, Yf], NovaGrid),
    create_estado(NovaGrid, 0, 1, 0, 0, PrimeiraPeca, 1, 60, 0, 0).