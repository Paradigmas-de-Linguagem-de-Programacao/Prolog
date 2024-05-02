:- use_module(library(clpfd)).

:- consult('movimentoPeca.pl').

mapeia_coordenadas([], IndiceLinha, [IndiceLinha, IndiceLinha], [-1, -1]).
mapeia_coordenadas([Linha | ProximasLinhas], IndiceLinha, [Xo, Yo], [Xf, Yf]) :- 
    ProximoIndiceLinha is IndiceLinha + 1,
    mapeia_coordenadas(ProximasLinhas, ProximoIndiceLinha, [XoPilha, YoPilha], [XfPilha, YfPilha]),
    mapeia_coordenadas_x(Linha, 0, XoVez, XfVez),
    ((XoVez < XoPilha) -> Xo = XoVez; Xo = XoPilha),
    ((XfVez > XfPilha) -> Xf = XfVez; Xf = XfPilha),
    ((XfVez > -1) -> (Yo = IndiceLinha, (YfPilha < IndiceLinha -> Yf = IndiceLinha; Yf = YfPilha));
    Yo = YoPilha, Yf = YfPilha).

mapeia_coordenadas_x([], IndicePeca, IndicePeca, -1).
mapeia_coordenadas_x([Peca | ProximasPecas], IndicePeca, Xo, Xf) :- 
    ProximoIndicePeca is IndicePeca + 1,
    mapeia_coordenadas_x(ProximasPecas, ProximoIndicePeca, XoPilha, XfPilha),
    (eh_peca(Peca) -> (
        Xo = IndicePeca, (XfPilha < IndicePeca -> Xf = IndicePeca; Xf = XfPilha)
    ); (Xo = XoPilha, Xf = XfPilha)).

calcula_dimensao_x(Xo, Xf, DimensaoX) :- DimensaoX is Xf - Xo.
calcula_dimensao_y(Yo, Yf, DimensaoY) :- DimensaoY is Yf - Yo.

gera_coordenadas([Xo, Yo], [Xf, Yf], [Xo, Yo], [Xf, Yf]) :- calcula_dimensao_x(Xo, Xf, DimensaoX),
                                                            calcula_dimensao_y(Yo, Yf, DimensaoY),
                                                            DimensaoX = DimensaoY, !.                

gera_coordenadas([Xo, Yo], [Xf, Yf], [Xo, NovoYo], [Xf, NovoYf]) :- calcula_dimensao_x(Xo, Xf, DimensaoX),
                                                                    calcula_dimensao_y(Yo, Yf, DimensaoY),
                                                                    DimensaoX > DimensaoY,
                                                                    Diferenca is DimensaoX - DimensaoY,
                                                                    (Yo - Diferenca > -1 -> (NovoYo is Yo - Diferenca, NovoYf = Yf); 
                                                                                            (NovoYf is Yf + Diferenca, NovoYo = Yo)
                                                                    ), !.

gera_coordenadas([Xo, Yo], [Xf, Yf], [NovoXo, Yo], [NovoXf, Yf]) :- calcula_dimensao_x(Xo, Xf, DimensaoX),
                                                                    calcula_dimensao_y(Yo, Yf, DimensaoY),
                                                                    DimensaoY > DimensaoX,
                                                                    Diferenca is DimensaoY - DimensaoX,
                                                                    (Xo - Diferenca > -1 -> (NovoXo is Xo - Diferenca, NovoXf = Xf); 
                                                                                            (NovoXf is Xf + Diferenca, NovoXo = Xo)
                                                                    ), !.

gera_peca_linha(_, [], []).
gera_peca_linha(LinhaGrid, [IndiceX | IndicesX], [Peca | Pecas]) :- nth0(IndiceX, LinhaGrid, PossivelPeca),
                                                                    (eh_peca(PossivelPeca) -> Peca = PossivelPeca ; Peca = 0),
                                                                    gera_peca_linha(LinhaGrid, IndicesX, Pecas).

gera_peca_recursivo(_, _, [], []).
gera_peca_recursivo(Grid, IndicesX, [IndiceY | IndicesY], [LinhaMatriz | LinhasMatriz]) :- nth0(IndiceY, Grid, LinhaGrid),
                                                                                           gera_peca_linha(LinhaGrid, IndicesX, LinhaMatriz),
                                                                                           gera_peca_recursivo(Grid, IndicesX, IndicesY, LinhasMatriz).

gera_peca(Grid, [Xo, Yo], [Xf, Yf], Peca) :- gera_indices([Xo, Yo], [Xf, Yf], IndicesX, IndicesY),
                                             gera_peca_recursivo(Grid, IndicesX, IndicesY, Peca).
 
gera_indices([Xo, Yo], [Xf, Yf], IndicesX, IndicesY) :- findall(X, between(Xo,Xf,X), IndicesX),
                                                        findall(Y, between(Yo,Yf,Y), IndicesY).

reverter_peca([], []).
reverter_peca([LinhaPeca | LinhasPeca], [NovaLinhaPeca, NovasLinhasPeca]) :- reverse(LinhaPeca, NovaLinhaPeca), 
                                                                             reverter_peca(LinhasPeca, NovasLinhasPeca).

rotaciona_peca_anti_horario(Peca, PecaRotacionada) :- reverter_peca(Peca, PecaReversa),
                                                      transpose(PecaReversa, PecaRotacionada).

rotaciona_peca_horario(Peca, PecaRotacionada) :- transpose(Peca, PecaTransposta),
                                                 reverter_peca(PecaTransposta, PecaRotacionada).

pode_atribuir_peca_linha(_, [], []).
pode_atribuir_peca_linha(LinhaGrid, [Peca | ProximasPecas], [IndiceX | IndicesX]) :- nth0(IndiceX, LinhaGrid, PossivelPeca),
                                                                                  (eh_peca(Peca) -> \+ eh_peca(PossivelPeca)),
                                                                                  pode_atribuir_peca_linha(LinhaGrid, ProximasPecas, IndicesX).

pode_atribuir_peca_recurisivo(_, [], _, []).
pode_atribuir_peca_recurisivo(Grid, [LinhaPeca | LinhasPeca], IndiceX, [IndiceY | IndicesY]) :- nth0(IndiceY, Grid, LinhaGrid),
                                                                                               pode_atribuir_peca_linha(LinhaGrid, LinhaPeca, IndiceX),
                                                                                               pode_atribuir_peca_recurisivo(Grid, LinhasPeca, IndiceX, IndicesY).

pode_atribuir_peca(Grid, Peca, [Xo, Yo], [Xf, Yf]) :- gera_indices([Xo, Yo], [Xf, Yf], IndicesX, IndicesY),
                                                      pode_atribuir_peca_recurisivo(Grid, Peca, IndicesX, IndicesY).


limpar_grid_linha([], []).
limpar_grid_linha([Peca | ProximasPecas], [PecaLimpa | ProximasPecasLimpas]) :- (eh_peca(Peca) -> PecaLimpa = 0; PecaLimpa = Peca),
                                                                                limpar_grid_linha(ProximasPecas, ProximasPecasLimpas).

limpar_grid([], []).
limpar_grid([LinhaGrid | LinhasGrid], [LinhaLimpa | LinhasLimpas]) :- limpar_grid_linha(LinhaGrid, LinhaLimpa),
                                                                      limpar_grid(LinhasGrid, LinhasLimpas).

troca_elemento([ _|ProximosElementos], 0, ElementoTrocar, [ElementoTrocar | ProximosElementos]) :- !. 
troca_elemento([Elemento | ProximosElementos], Indice, ElementoTrocar, [Elemento | ProximosElementosTrocados])  :- NovoIndice is Indice - 1,
                                                                                                                   troca_elemento(ProximosElementos, NovoIndice, ElementoTrocar, ProximosElementosTrocados).

atribuicao_peca_linha(LinhaGrid, [], [], LinhaGrid).
atribuicao_peca_linha(LinhaGrid, [Peca | ProximasPecas], [IndiceX | IndicesX], NovaLinhaGrid) :- atribuicao_peca_linha(LinhaGrid, ProximasPecas, IndicesX, NovaLinhaGridPilha),
                                                                                                 (eh_peca(Peca) -> troca_elemento(NovaLinhaGridPilha, IndiceX, Peca, NovaLinhaGrid); NovaLinhaGrid = NovaLinhaGridPilha).

atribuicao_peca_recursiva(Grid, [] ,_, [], Grid).
atribuicao_peca_recursiva(Grid, [LinhaPeca | LinhasPeca], IndicesX, [IndiceY | IndicesY], NovaGrid) :- atribuicao_peca_recursiva(Grid, LinhasPeca, IndicesX, IndicesY, NovaGridPilha),
                                                                                                       nth0(IndiceY, NovaGridPilha, LinhaGrid),
                                                                                                       atribuicao_peca_linha(LinhaGrid, LinhaPeca, IndicesX, NovaLinhaGrid),
                                                                                                       troca_elemento(NovaGridPilha, IndiceY, NovaLinhaGrid, NovaGrid).

atribuicao_peca(Grid, Peca, [Xo, Yo], [Xf, Yf], NovaGrid) :- gera_indices([Xo, Yo], [Xf, Yf], IndicesX, IndicesY),
                                                             atribuicao_peca_recursiva(Grid, Peca, IndicesX, IndicesY, NovaGrid).