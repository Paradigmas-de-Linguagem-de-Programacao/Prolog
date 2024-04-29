gerador_linha(0, []) :- !.
gerador_linha(DimensaoX, [Termo | RestoLinha]) :- Termo is DimensaoX mod 3,
                                                  NovaDimensaoX is DimensaoX - 1,
                                                  gerador_linha(NovaDimensaoX, RestoLinha).

gerador_matriz(_, 0, []) :- !.                                                                   
gerador_matriz(DimensaoX, DimensaoY, [Linha | RestoMatriz]) :- gerador_linha(DimensaoX, Linha),
                                                               NovaDimensaoY is DimensaoY - 1,
                                                               gerador_matriz(DimensaoX, NovaDimensaoY, RestoMatriz).                                                                   
