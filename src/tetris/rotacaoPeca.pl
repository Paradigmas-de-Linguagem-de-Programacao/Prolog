:- consult('movimentoPeca.pl').

% rotação

% mapeiaCoordenadas

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

% GeraCoordenadasAntiHorario
% GeraCoordenadasHorario

% GeraCoordenadas

% GeraPeca

% GeraPecaRotacionadaAntiHorario
% GeraPecaRotacionadaHorario
% GeraPecaRotacionada

% RotacionaPeca