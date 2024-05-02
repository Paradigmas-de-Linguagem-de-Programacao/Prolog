cria_linha_vazia([], []).
cria_linha_vazia( [_ | ProximasPecas], [0 | ProximasPecasZeradas] ) :- cria_linha_vazia(ProximasPecas, ProximasPecasZeradas).

pode_limpar_linha(Linha) :- \+ member(0, Linha).

limpar_linhas([], 0).

limpar_linhas([Linha | Linhas], [LinhaLimpa | LinhasLimpas], QuantidadeLinhasTrocadas) :- pode_limpar_linha(Linha),
                                                                                          limpar_linhas(Linhas, LinhasLimpas, QuantidadeLinhasTrocadasPilha),
                                                                                          QuantidadeLinhasTrocadas is QuantidadeLinhasTrocadasPilha + 1,
                                                                                          cria_linha_vazia(Linha, LinhaLimpa), !.

limpar_linhas([Linha | Linhas], [Linha | LinhasLimpas], QuantidadeLinhasTrocadas) :- limpar_linhas(Linhas, LinhasLimpas, QuantidadeLinhasTrocadas).

shift_baixo_clear([], []).

shift_baixo_clear([LinhaAbaixo, LinhaAcima | LinhasAcima], [LinhaAcima | LinhasAcimaComShift]) :- pode_limpar_linha(LinhaAbaixo),
                                                                                                  shift_baixo_clear([LinhaAbaixo | LinhasAcima], LinhasAcimaComShift), !.

shift_baixo_clear([LinhaAbaixo, LinhaAcima | LinhasAcima], [LinhaAbaixo | LinhasAcimaComShift]) :- shift_baixo_clear([LinhaAcima | LinhasAcima], LinhasAcimaComShift).

clear_game(Linhas, NovasLinhas, QuantidadeLinhasLimpas) :- limpar_linhas(Linhas, LinhasLimpas, QuantidadeLinhasLimpas),
                                                           shift_baixo_clear(LinhasLimpas, NovasLinhas).