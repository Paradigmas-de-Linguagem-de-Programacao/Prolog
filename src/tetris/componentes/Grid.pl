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

gera_grid_renderizavel([], _, []).
gera_grid_renderizavel([LinhaGrid | ProximasLinhasGrid], LadoCelula, [LinhaRenderizada | LinhasRenderizadas]) :-
    gera_linha_renderizavel(LinhaGrid, LadoCelula, LinhaRenderizada),
    gera_grid_renderizavel(ProximasLinhasGrid, LadoCelula, LinhasRenderizadas).

gera_linha_renderizavel([], _, []).
gera_linha_renderizavel([Peca | Pecas], LadoCelula, [Celula | Celulas]) :-
    gera_celula_renderizavel(Peca, LadoCelula, Celula),
    gera_linha_renderizavel(Pecas, LadoCelula, Celulas).

gera_celula_renderizavel(Peca, LadoCelula, Celula) :-
    new(Celula, box(LadoCelula, LadoCelula)),
    CodigoPeca is Peca mod 10,
    busca_cor(CodigoPeca, Cor),
    send(Celula, fill_pattern, colour(Cor)).

renderiza_grid(_, _, _, _, []).
renderiza_grid(Window, X, Y, LadoCelula, [LinhaRenderizavel | LinhasRenderizaveis]) :-
    renderiza_linha(Window, X, Y, LadoCelula, LinhaRenderizavel),
    NovoY is Y + LadoCelula,
    renderiza_grid(Window, X, NovoY, LadoCelula, LinhasRenderizaveis).

renderiza_linha(_, _, _, _, []).
renderiza_linha(Window, X, Y, LadoCelula, [Celula | Celulas]) :-
    send(Window, display, Celula, point(X, Y)),
    NovoX is X + LadoCelula,
    renderiza_linha(Window, NovoX, Y, LadoCelula, Celulas).

apaga_grid([]).
apaga_grid([Linha | Linhas]) :-
    apaga_linha(Linha),
    apaga_grid(Linhas).

apaga_linha([]).
apaga_linha([Celula | Celulas]) :-
    free(Celula),
    apaga_linha(Celulas).

update_grid([], []).
update_grid([LinhaGrid | LinhasGrid], [LinhaRenderizavel | LinhasRenderizaveis]) :-
    update_linha(LinhaGrid, LinhaRenderizavel),
    update_grid(LinhasGrid, LinhasRenderizaveis).

update_linha([], []).
update_linha([Peca | Pecas], [Celula | Celulas]) :-
    CodigoPeca is Peca mod 10,
    busca_cor(CodigoPeca, Cor),
    send(Celula, fill_pattern, colour(Cor)),
    update_linha(Pecas, Celulas).