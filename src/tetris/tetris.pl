:- consult('quick_start.pl').
:- consult('componentes/Grid.pl').
:- consult('componentes/PacoteTexto.pl').

mock_tetris :-
    new(Window, picture('tetris')),
    send(Window, size, size(1200, 800)),
    send(Window, open),
    gerador_matriz(10,20, Grid),
    gerador_matriz(3,3, ProximaPeca),
    renderiza_grid(Grid, 400, 100, 30, Window),
    renderiza_grid(ProximaPeca, 800, 350, 30, Window),
    gera_tutorial(Window),
    gera_estado(Window).