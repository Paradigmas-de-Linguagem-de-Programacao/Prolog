:- use_module(library(clpfd)).

:- consult('movimentoPeca.pl').

mapeiaCoordenadas([], IndiceLinha, [IndiceLinha, IndiceLinha], [-1, -1]).
mapeiaCoordenadas([Linha | ProximasLinhas], IndiceLinha, [Xo, Yo], [Xf, Yf]) :- 
    ProximoIndiceLinha is IndiceLinha + 1,
    mapeiaCoordenadas(ProximasLinhas, ProximoIndiceLinha, [XoPilha, YoPilha], [XfPilha, YfPilha]),
    mapeiaCoordenadasX(Linha, 0, XoVez, XfVez),
    ((XoVez < XoPilha) -> Xo = XoVez; Xo = XoPilha),
    ((XfVez > XfPilha) -> Xf = XfVez; Xf = XfPilha),
    ((XfVez > -1) -> (
        Yo = IndiceLinha, (YfPilha < IndiceLinha -> Yf = IndiceLinha; Yf = YfPilha)
    ); Yo = YoPilha, Yf = YfPilha).


mapeiaCoordenadasX([], IndicePeca, IndicePeca, -1).
mapeiaCoordenadasX([Peca | ProximasPecas], IndicePeca, Xo, Xf) :- 
    ProximoIndicePeca is IndicePeca + 1,
    mapeiaCoordenadasX(ProximasPecas, ProximoIndicePeca, XoPilha, XfPilha),
    (eh_peca(Peca) -> (
        Xo = IndicePeca, (XfPilha < IndicePeca -> Xf = IndicePeca; Xf = XfPilha)
    ); (Xo = XoPilha, Xf = XfPilha)).

calculaDimensaoX(Xo, Xf, DimensaoX) :- DimensaoX is Xf - Xo.
calculaDimensaoY(Yo, Yf, DimensaoY) :- DimensaoY is Yf - Yo.

geraCoordenadas([Xo, Yo], [Xf, Yf], [Xo, Yo], [Xf, Yf]) :- calculaDimensaoX(Xo, Xf, DimensaoX),
                                                           calculaDimensaoY(Yo, Yf, DimensaoY),
                                                           DimensaoX = DimensaoY, !.                

geraCoordenadas([Xo, Yo], [Xf, Yf], [Xo, NovoYo], [Xf, NovoYf]) :- calculaDimensaoX(Xo, Xf, DimensaoX),
                                                                   calculaDimensaoY(Yo, Yf, DimensaoY),
                                                                   DimensaoX > DimensaoY,
                                                                   Diferenca is DimensaoX - DimensaoY,
                                                                   (Yo - Diferenca > -1 -> (NovoYo is Yo - Diferenca, NovoYf = Yf); 
                                                                                           (NovoYf is Yf + Diferenca, NovoYo = Yo)
                                                                   ), !.

geraCoordenadas([Xo, Yo], [Xf, Yf], [NovoXo, Yo], [NovoXf, Yf]) :- calculaDimensaoX(Xo, Xf, DimensaoX),
                                                                   calculaDimensaoY(Yo, Yf, DimensaoY),
                                                                   DimensaoY > DimensaoX,
                                                                   Diferenca is DimensaoY - DimensaoX,
                                                                   (Xo - Diferenca > -1 -> (NovoXo is Xo - Diferenca, NovoXf = Xf); 
                                                                                           (NovoXf is Xf + Diferenca, NovoXo = Xo)
                                                                   ), !.

geraPecaLinha(_, [], []).
geraPecaLinha(LinhaGrid, [IndiceX | IndicesX], [Peca | Pecas]) :- nth0(IndiceX, LinhaGrid, PossivelPeca),
                                                                   (eh_peca(PossivelPeca) -> Peca = PossivelPeca ; Peca = 0),
                                                                   geraPecaLinha(LinhaGrid, IndicesX, Pecas).

geraPecaRecursivo(_, _, [], []).
geraPecaRecursivo(Grid, IndicesX, [IndiceY | IndicesY], [LinhaMatriz | LinhasMatriz]) :- nth0(IndiceY, Grid, LinhaGrid),
                                                                                         geraPecaLinha(LinhaGrid, IndicesX, LinhaMatriz),
                                                                                         geraPecaRecursivo(Grid, IndicesX, IndicesY, LinhasMatriz).

geraPeca(Grid, [Xo, Yo], [Xf, Yf], Peca) :- geraIndices([Xo, Yo], [Xf, Yf], IndicesX, IndicesY),
                                            geraPecaRecursivo(Grid, IndicesX, IndicesY, Peca).

geraIndices([Xo, Yo], [Xf, Yf], IndicesX, IndicesY) :- findall(X, between(Xo,Xf,X), IndicesX),
                                                       findall(Y, between(Yo,Yf,Y), IndicesY).

reverterPeca([], []).
reverterPeca([LinhaPeca | LinhasPeca], [NovaLinhaPeca, NovasLinhasPeca]) :- reverse(LinhaPeca, NovaLinhaPeca), 
                                                                            reverterPeca(LinhasPeca, NovasLinhasPeca).

rotacionaPecaAntiHorario(Peca, PecaRotacionada) :- reverterPeca(Peca, PecaReversa),
                                                   transpose(PecaReversa, PecaRotacionada).

rotacionaPecaHorario(Peca, PecaRotacionada) :- transpose(Peca, PecaTransposta),
                                               reverterPeca(PecaTransposta, PecaRotacionada).

pode_atribuir_peca_linha(_, [], []).
pode_atribuir_peca_linha(LinhaGrid, [Peca | ProximasPecas], [IndiceX | IndicesX]) :- nth0(IndiceX, LinhaGrid, PossivelPeca),
                                                                                  (eh_peca(Peca) -> \+ eh_peca(PossivelPeca)),
                                                                                  pode_atribuir_peca_linha(LinhaGrid, ProximasPecas, IndicesX).

pode_atribuir_peca_recurisivo(_, [], _, []).
pode_atribuir_peca_recurisivo(Grid, [LinhaPeca | LinhasPeca], IndiceX, [IndiceY | IndicesY]) :- nth0(IndiceY, Grid, LinhaGrid),
                                                                                               pode_atribuir_peca_linha(LinhaGrid, LinhaPeca, IndiceX),
                                                                                               pode_atribuir_peca_recurisivo(Grid, LinhasPeca, IndiceX, IndicesY).

pode_atribuir_peca(Grid, Peca, [Xo, Yo], [Xf, Yf]) :- geraIndices([Xo, Yo], [Xf, Yf], IndicesX, IndicesY),
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
                                                                                                       atribuicao_peca_linha(LinhaGrid, LinhaPeca, IndicesX, IndiceY, NovaLinhaGrid),
                                                                                                       troca_elemento(NovaGridPilha, IndiceY, NovaLinhaGrid, NovaGrid).

atribuicao_peca(Grid, Peca, [Xo, Yo], [Xf, Yf], NovaGrid) :- geraIndices([Xo, Yo], [Xf, Yf], IndicesX, IndicesY),
                                                             atribuicao_peca_recursiva(Grid, Peca, IndicesX, IndicesY, NovaGrid).