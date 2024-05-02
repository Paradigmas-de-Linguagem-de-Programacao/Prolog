:- use_module(library(pce)).
:- use_module(library(readutil)).

:- consult('quick_start.pl').
:- consult('componentes/Grid.pl').
:- consult('componentes/PacoteTexto.pl').
:- consult('utilitarios/estado.pl').
:- consult('utilitarios/limparJogo.pl').
:- consult('utilitarios/movimentoPeca.pl').
:- consult('utilitarios/rotacaoPeca.pl').

mock_tetris :-
    quick_start,
    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, _, ProximaPeca, _, _ ),
    new(@window, picture('tetris')),
    send(@window, size, size(1200, 800)),
    send(@window, open),
    reverse(GridVisao, Grid),
    renderiza_grid(GridVisao, 400, 100, 30, @window),
    renderiza_grid(ProximaPeca, 800, 350, 30, @window),
    gera_tutorial(@window),
    gera_estado(@window),
    escreve_jogo(@window, Pontuacao, Nivel, Linhas, Tempo),
    get_single_char(Code),
    process_input(Code).
    
peca_tecla(Event) :-
    get(Event, key, Key),
    estado( Grid, _, _, _, _, AtualPeca, _, _, _ ),
    evento(Key, Grid, AtualPeca).


evento(down, Grid, _) :- 
    verifica_shift_baixo(Grid),
    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, ProximaPeca, FramePast, FrameNeed ),
    shift_baixo(Grid, NovaGrid),
    update_estado( NovaGrid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, ProximaPeca, FramePast, FrameNeed ),
    renderiza_grid(NovaGrid, 400, 100, 30, @window).

evento(down, _, _).
