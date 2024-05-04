% estrutura de estado

% estado( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed ).

:- dynamic estado/9.

create_estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed) :-
    retractall(estado(_, _, _, _, _, _, _, _, _)),
    assertz(estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed)).

get_estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed) :-
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed).

update_estado(NovoGrid, NovasLinhas, NovoNivel, NovoTempo, NovaPontuacao, NovaAtualPeca, NovaIdProximaPeca, NovoFramePast, NovoFrameNeed) :-
    retract(estado(_, _, _, _, _, _, _, _, _)),
    assertz(estado(NovoGrid, NovasLinhas, NovoNivel, NovoTempo, NovaPontuacao, NovaAtualPeca, NovaIdProximaPeca, NovoFramePast, NovoFrameNeed)).

create_grid_jogo(Grid) :-
    retractall(grid_jogo(_)),
    assertz(grid_jogo(Grid)).

get_grid_jogo(Grid) :-
    grid_jogo(Grid).

update_grid_jogo(NovaGrid) :-
    retract(grid_jogo(_)),
    assertz(grid_jogo(NovaGrid)).

create_grid_peca(Grid) :-
    retractall(grid_peca(_)),
    assertz(grid_peca(Grid)).

get_grid_peca(Grid) :-
    grid_peca(Grid).

update_grid_peca(NovaGrid) :-
    retract(grid_peca(_)),
    assertz(grid_peca(NovaGrid)).