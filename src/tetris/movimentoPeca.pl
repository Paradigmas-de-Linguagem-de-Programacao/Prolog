% auxiliares

ehPeca(Peca) :- Peca > 0, Peca < 10.
ehCongelado(Peca) :- Peca > 10.

% congela tabuleiro

congelarTudo([], []).
congelarTudo([Linha|Linhas], [LinhaCongelada|LinhasCongeladas]) :- congelarLinha(Linha,LinhaCongelada), 
                                                                   congelarTudo(Linhas, LinhasCongeladas).

congelarLinha([],[]).
congelarLinha([Peca|ProximasPecas], [PecaCongelada|ProximasPecasCongeladas]) :- (ehPeca(Peca) -> PecaCongelada is Peca + 10; 
                                                                                PecaCongelada = Peca), 
                                                                                congelarLinha(ProximasPecas, ProximasPecasCongeladas).


% verifica shifts

verificaShiftDireita([]).
verificaShiftDireita([LinhaAbaixo|LinhasAcima]) :- verificaShiftDireitaLinha(LinhaAbaixo), 
                                                   verificaShiftDireita(LinhasAcima).

verificaShiftDireitaLinha([]).
verificaShiftDireitaLinha([UltimaPeca]) :- \+ ehPeca(UltimaPeca).
verificaShiftDireitaLinha([PecaEsquerda, PecaDireita|ProximasPecas]) :- (\+ ehPeca(PecaEsquerda); \+ ehCongelado(PecaDireita)), % \+ significa not 
                                                                        verificaShiftDireitaLinha([PecaDireita|ProximasPecas]).

verificaShiftEsquerda([]).
verificaShiftEsquerda([LinhaAbaixo|LinhasAcima]) :- verificaShiftEsquerdaLinha(LinhaAbaixo),
                                                    verificaShiftEsquerda(LinhasAcima).

verificaShiftEsquerdaLinha([]).
verificaShiftEsquerdaLinha([PecaEsquerda|PecasDireita]) :- \+ ehPeca(PecaEsquerda), 
                                                            verificaShiftEsquerdaLinhaAuxiliar([PecaEsquerda|PecasDireita]).

verificaShiftEsquerdaLinhaAuxiliar([]).
verificaShiftEsquerdaLinhaAuxiliar([_]).
verificaShiftEsquerdaLinhaAuxiliar([PecaEsquerda,PecaDeireita|ProximasPecas]) :- (\+ ehCongelado(PecaEsquerda); % ; significa ou 
                                                                                  \+ ehPeca(PecaDeireita)), 
                                                                                  verificaShiftEsquerdaLinhaAuxiliar([PecaDeireita|ProximasPecas]).

verificaShiftBaixo([PrimeiraLinha|RestoDaMatriz]) :- verificaShiftBaixoPrimeiraLinha(PrimeiraLinha), 
                                                     verificaShiftBaixoAuxiliar([PrimeiraLinha,RestoDaMatriz]).

verificaShiftBaixoPrimeiraLinha([]).
verificaShiftBaixoPrimeiraLinha([Peca|ProximasPecas]) :- \+ ehPeca(Peca), 
                                                         verificaShiftBaixoPrimeiraLinha(ProximasPecas).

verificaShiftBaixoAuxiliar([LinhaAbaixo,LinhaAcima]):- verificaShiftBaixoLinha(LinhaAbaixo,LinhaAcima).
verificaShiftBaixoAuxiliar([LinhaAbaixo,LinhaAcima|LinhasAcimas]) :- verificaShiftBaixoLinha(LinhaAbaixo,LinhaAcima), 
                                                                     verificaShiftBaixoAuxiliar(LinhaAcima,LinhasAcimas).

verificaShiftBaixoLinha([],[]).
verificaShiftBaixoLinha([PecaAbaixo|ProximasPecasAbaixo], [PecaAcima|ProximasPecasAcima]) :- \+ (ehCongelado(PecaAbaixo), ehPeca(PecaAcima)),
                                                                                              verificaShiftBaixoLinha(ProximasPecasAbaixo, ProximasPecasAcima).

% shifts

swapDireita([], []).
swapDireita([Peca], [Peca]).
swapDireita([PecaEsquerda, PecaDireita | ProximasPecas], [PecaDireita, PecaEsquerda | ProximasPecas]) :- ehPeca(PecaEsquerda), !.
swapDireita([PecaEsquerda, PecaDireita | ProximasPecas], [PecaEsquerda, PecaDireita | ProximasPecas]).

shiftDireitaLinha([], []).
shiftDireitaLinha([Peca],[Peca]).
shiftDireitaLinha([PecaEsquerda, PecaDireita | ProximasPecas], LinhaComShift) :- shiftDireitaLinha([PecaDireita | ProximasPecas], LinhaComShiftPilha),
                                                                                 swapDireita([PecaEsquerda | LinhaComShiftPilha], LinhaComShift).

shiftDireita([], []).
shiftDireita([LinhaAbaixo | LinhasAcima], [LinhaAbaixoComShift | LinhasAcimaComShift]) :- shiftDireitaLinha(LinhaAbaixo, LinhaAbaixoComShift),
                                                                                          shiftDireita(LinhasAcimas, LinhasAcimaComShift).

shiftEsquerdaLinha([], []).
shiftEsquerdaLinha([Peca], [Peca]).
shiftEsquerdaLinha([PecaEsquerda, PecaDireita | ProximasPecas], [PecaDireita, PecaEsquerda | ProximasPecas]) :- ehPeca(PecaDeireita), !.
shiftEsquerdaLinha([PecaEsquerda, PecaDireita | ProximasPecas], [PecaEsquerda, PecaDireita | ProximasPecas]).

shiftEsquerda([], []).
shiftEsquerda([LinhaAbaixo | LinhasAcima], [LinhaAbaixoComShift | LinhasAcimaComShift]) :- shiftEsquerdaLinha(LinhaAbaixo, LinhaAbaixoComShift),
                                                                                           shiftEsquerda(LinhasAcimas, LinhasAcimaComShift).

shiftBaixoLinha([[], []], [[], []]).
shiftBaixoLinha([[PecaAbaixo | PecasAbaixo], [PecaAcima | PecasAcima]], [PecasAbaixoShift, PecasAcimaShift]) :- 
    shiftBaixoLinha([PecasAbaixo, PecasAcima], [PecasAbaixoPilha, PecasAcimaPilha]),
    (ehPeca(PecaAcima) -> (PecasAbaixoShift = [PecaAcima | PecasAbaixoPilha], PecasAcimaShift = [PecaAbaixo | PecasAcimaPilha]);
     (PecasAbaixoShift = [PecaAbaixo | PecasAbaixoPilha], PecasAcimaShift = [PecaAcima | PecasAcimaPilha])
    ).