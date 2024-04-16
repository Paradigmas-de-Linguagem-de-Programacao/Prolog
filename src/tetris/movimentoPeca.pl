% auxiliares

ehPeca(X) :- X > 0, X < 10.
ehCongelado(X) :- X > 10.

% congela tabuleiro

congelarTudo([], []).
congelarTudo([As|Ass], [Bs|Bss]) :- congelarLinha(As,Bs), congelarTudo(Ass, Bss).

congelarLinha([],[]).
congelarLinha([0|As], [0|Bs]) :- congelarLinha(As, Bs).
congelarLinha([X|As], [Y|Bs]) :- (X =< 10 -> Y is X + 10; Y = X), congelarLinha(As, Bs).

% verifica shifts

verificaShiftDireita([]).
verificaShiftDireita([Xs|Zs]) :- verificaShiftDireitaLinha(Xs), verificaShiftDireita(Zs).

verificaShiftDireitaLinha([]).
verificaShiftDireitaLinha([X]) :- X =:= 0 ; X > 10.
verificaShiftDireitaLinha([X,Y|Zs]) :- (\+ ehPeca(X); \+ ehCongelado(Y)), verificaShiftDireitaLinha([Y|Zs]).

verificaShiftEsquerda([]).
verificaShiftEsquerda([Xs|Zs]) :- verificaShiftEsquerdaLinha(Xs), verificaShiftEsquerda(Zs).

verificaShiftEsquerdaLinha([]).
verificaShiftEsquerdaLinha([X|Xs]) :- (\+ ehPeca(X)), verificaShiftEsquerdaLinhaAuxiliar([X|Xs]).

verificaShiftEsquerdaLinhaAuxiliar([]).
verificaShiftEsquerdaLinhaAuxiliar([_]).
verificaShiftEsquerdaLinhaAuxiliar([X,Y|Zs]) :- (\+ ehCongelado(X); \+ ehPeca(Y)), verificaShiftEsquerdaLinhaAuxiliar([Y|Zs]).

verificaShiftBaixo([X|Zs]) :- verificaShiftBaixoPrimeiraLinha(X), verificaShiftBaixoAuxiliar([X,Zs]).

verificaShiftBaixoPrimeiraLinha([]).
verificaShiftBaixoPrimeiraLinha([X|Xs]) :- \+ ehPeca(X), verificaShiftBaixoPrimeiraLinha(Xs).

verificaShiftBaixoAuxiliar([X,Y]):- verificaShiftBaixoLinha(X,Y).
verificaShiftBaixoAuxiliar([X,Y|Zs]) :- verificaShiftBaixoLinha(X,Y), verificaShiftBaixoAuxiliar(Y,Zs).

verificaShiftBaixoLinha([],[]).
verificaShiftBaixoLinha([X|Xs], [Y|Ys]) :- \+ (ehCongelado(X), ehPeca(Y)), verificaShiftBaixoLinha(Xs, Ys).