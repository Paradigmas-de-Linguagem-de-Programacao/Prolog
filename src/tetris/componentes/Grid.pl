:- consult('../quick_start.pl').

:- use_module(library(pce)).

busca_cor(0, black).
busca_cor(1, blue).
busca_cor(2, orange).
busca_cor(3, yellow).
busca_cor(4, teal).
busca_cor(5, green).
busca_cor(6, purple).
busca_cor(7, red).
busca_cor(8, white).

renderiza_grid([], _, _, _, _).
renderiza_grid([Linha|ProximasLinhas], X, Y, LadoCelula, Window) :-
    renderiza_linha_recursivo(Window, Linha, X, Y, LadoCelula),
    NovoY is Y + LadoCelula,
    renderiza_grid(ProximasLinhas, X, NovoY, LadoCelula, Window).

renderiza_linha_recursivo(_, [], _, _, _).
renderiza_linha_recursivo(Window, [Peca | ProximasPecas], X, Y, LadoCelula) :-
    renderiza_celula(Peca, LadoCelula, Celula),
    send(Window, display, Celula, point(X, Y)),
    NovoX is X + LadoCelula,
    renderiza_linha_recursivo(Window, ProximasPecas, NovoX, Y, LadoCelula).

renderiza_celula(Peca, LadoCelula, Celula) :-
    new(Celula, box(LadoCelula, LadoCelula)),
    CodigoPeca is Peca mod 10,
    busca_cor(CodigoPeca, Cor),
    send(Celula, fill_pattern, colour(Cor)).