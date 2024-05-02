% estrutura de estado

% estado( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, ProximaPeca, FramePast, FrameNeed ).

:- dynamic estado/9.

create_estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, ProximaPeca, FramePast, FrameNeed) :-
    retractall(estado(_, _, _, _, _, _, _, _, _)),
    assertz(estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, ProximaPeca, FramePast, FrameNeed)).

get_estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, ProximaPeca, FramePast, FrameNeed) :-
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, ProximaPeca, FramePast, FrameNeed).

update_estado(NovoGrid, NovasLinhas, NovoNivel, NovoTempo, NovaPontuacao, NovaAtualPeca, NovaProximaPeca, NovoFramePast, NovoFrameNeed) :-
    retract(estado(_, _, _, _, _, _, _, _, _)),
    assertz(estado(NovoGrid, NovasLinhas, NovoNivel, NovoTempo, NovaPontuacao, NovaAtualPeca, NovaProximaPeca, NovoFramePast, NovoFrameNeed)).
