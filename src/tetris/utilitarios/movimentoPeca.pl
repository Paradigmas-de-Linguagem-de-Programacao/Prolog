% auxiliares

eh_peca(Peca) :- Peca > 0, Peca < 10.
eh_congelado(Peca) :- Peca > 10.

% congela tabuleiro

congelar_tudo([], []).
congelar_tudo([Linha|Linhas], [LinhaCongelada|LinhasCongeladas]) :- 
    congelar_linha(Linha,LinhaCongelada), 
    congelar_tudo(Linhas, LinhasCongeladas).

congelar_linha([],[]).
congelar_linha([Peca|ProximasPecas], [PecaCongelada|ProximasPecasCongeladas]) :- 
    (eh_peca(Peca) -> PecaCongelada is Peca + 10; PecaCongelada = Peca), 
    congelar_linha(ProximasPecas, ProximasPecasCongeladas).


% verifica shifts

verifica_shift_direita([]).
verifica_shift_direita([LinhaAbaixo|LinhasAcima]) :- 
    verifica_shift_direita_linha(LinhaAbaixo), 
    verifica_shift_direita(LinhasAcima).

verifica_shift_direita_linha([]).
verifica_shift_direita_linha([UltimaPeca]) :- 
    \+ eh_peca(UltimaPeca).
verifica_shift_direita_linha([PecaEsquerda, PecaDireita|ProximasPecas]) :- 
    \+ (eh_peca(PecaEsquerda), eh_congelado(PecaDireita)), % \+ significa not 
    verifica_shift_direita_linha([PecaDireita|ProximasPecas]).

verifica_shift_esquerda([]).
verifica_shift_esquerda([LinhaAbaixo|LinhasAcima]) :- 
    verifica_shift_esquerda_linha(LinhaAbaixo),
    verifica_shift_esquerda(LinhasAcima).

verifica_shift_esquerda_linha([]).
verifica_shift_esquerda_linha([PecaEsquerda|PecasDireita]) :- 
    (\+ eh_peca(PecaEsquerda)), 
    verifica_shift_esquerda_linha_auxiliar([PecaEsquerda|PecasDireita]).

verifica_shift_esquerda_linha_auxiliar([]).
verifica_shift_esquerda_linha_auxiliar([_]).
verifica_shift_esquerda_linha_auxiliar([PecaEsquerda,PecaDireita|ProximasPecas]) :- 
    \+ (eh_congelado(PecaEsquerda), eh_peca(PecaDireita)), 
    verifica_shift_esquerda_linha_auxiliar([PecaDireita|ProximasPecas]).

verifica_shift_baixo([PrimeiraLinha|RestoDaMatriz]) :- 
    verifica_shift_baixo_primeira_linha(PrimeiraLinha), 
    verifica_shift_baixo_auxiliar([PrimeiraLinha|RestoDaMatriz]).

verifica_shift_baixo_primeira_linha([]).
verifica_shift_baixo_primeira_linha([Peca|ProximasPecas]) :- 
    \+ eh_peca(Peca), 
    verifica_shift_baixo_primeira_linha(ProximasPecas).

verifica_shift_baixo_auxiliar([]).
verifica_shift_baixo_auxiliar([LinhaAbaixo,LinhaAcima]):- 
    verifica_shift_baixo_linha(LinhaAbaixo,LinhaAcima).
verifica_shift_baixo_auxiliar([LinhaAbaixo,LinhaAcima|LinhasAcimas]) :- 
    verifica_shift_baixo_linha(LinhaAbaixo,LinhaAcima), 
    verifica_shift_baixo_auxiliar([LinhaAcima|LinhasAcimas]).

verifica_shift_baixo_linha([],[]).
verifica_shift_baixo_linha([PecaAbaixo|ProximasPecasAbaixo], [PecaAcima|ProximasPecasAcima]) :- 
    \+ (eh_congelado(PecaAbaixo), eh_peca(PecaAcima)),
    verifica_shift_baixo_linha(ProximasPecasAbaixo, ProximasPecasAcima).

% shifts

swap_direita([], []).
swap_direita([Peca], [Peca]).
swap_direita([PecaEsquerda, PecaDireita | ProximasPecas], [PecaDireita, PecaEsquerda | ProximasPecas]) :- 
    eh_peca(PecaEsquerda), !.
swap_direita([PecaEsquerda, PecaDireita | ProximasPecas], [PecaEsquerda, PecaDireita | ProximasPecas]).

shift_direita_linha([], []).
shift_direita_linha([Peca],[Peca]).
shift_direita_linha([PecaEsquerda, PecaDireita | ProximasPecas], LinhaComShift) :- 
    shift_direita_linha([PecaDireita | ProximasPecas], LinhaComShiftPilha),
    swap_direita([PecaEsquerda | LinhaComShiftPilha], LinhaComShift).

shift_direita([], []).
shift_direita([LinhaAbaixo | LinhasAcima], [LinhaAbaixoComShift | LinhasAcimaComShift]) :- 
    shift_direita_linha(LinhaAbaixo, LinhaAbaixoComShift),
    shift_direita(LinhasAcima, LinhasAcimaComShift).

shift_esquerda_linha([], []).
shift_esquerda_linha([Peca], [Peca]).
shift_esquerda_linha([PecaEsquerda, PecaDireita | ProximasPecas], [PecaDireita, ProximaPecaEsquerda | ProximasPecasShift]) :- 
    eh_peca(PecaDireita),
    shift_esquerda_linha([PecaEsquerda | ProximasPecas], [ProximaPecaEsquerda| ProximasPecasShift]),
    !.

shift_esquerda_linha([PecaEsquerda, PecaDireita | ProximasPecas], [PecaEsquerda, ProximaPecaDireita | ProximasPecasShift]) :-
    shift_esquerda_linha([PecaDireita | ProximasPecas], [ProximaPecaDireita| ProximasPecasShift]),
    !.

shift_esquerda([], []).
shift_esquerda([LinhaAbaixo | LinhasAcima], [LinhaAbaixoComShift | LinhasAcimaComShift]) :- 
    shift_esquerda_linha(LinhaAbaixo, LinhaAbaixoComShift),
    shift_esquerda(LinhasAcima, LinhasAcimaComShift).

shift_baixo_linha([[], []], [[], []]).
shift_baixo_linha([[PecaAbaixo | PecasAbaixo], [PecaAcima | PecasAcima]], [PecasAbaixoShift, PecasAcimaShift]) :- 
    shift_baixo_linha([PecasAbaixo, PecasAcima], [PecasAbaixoPilha, PecasAcimaPilha]),
    (eh_peca(PecaAcima) -> (PecasAbaixoShift = [PecaAcima | PecasAbaixoPilha], PecasAcimaShift = [PecaAbaixo | PecasAcimaPilha]);
    (PecasAbaixoShift = [PecaAbaixo | PecasAbaixoPilha], PecasAcimaShift = [PecaAcima | PecasAcimaPilha])
    ).

shift_baixo([], []).
shift_baixo([Linha], [Linha]).
shift_baixo([LinhaAbaixo, LinhaAcima | LinhasAcima], [NovaLinhaAbaixo, NovaLinhaAcima | NovasLinhasAcimas]) :- 
    shift_baixo_linha([LinhaAbaixo, LinhaAcima], [NovaLinhaAbaixo, LinhaAcimaIntermediaria]),
    shift_baixo([LinhaAcimaIntermediaria | LinhasAcima], [NovaLinhaAcima | NovasLinhasAcimas]).