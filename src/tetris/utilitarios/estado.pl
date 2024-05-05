% estrutura de estado

% estado( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, JogoTerminou ).

:- dynamic estado/9.

create_estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, JogoTerminou) :-
    retractall(estado(_, _, _, _, _, _, _, _, _, _)),
    assertz(estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, JogoTerminou)).

update_estado(NovoGrid, NovasLinhas, NovoNivel, NovoTempo, NovaPontuacao, NovaAtualPeca, NovaIdProximaPeca, NovoFrameNeed, NovaFramePast, EhJogoTerminou) :-
    retractall(estado(_, _, _, _, _, _, _, _, _, _)),
    assertz(estado(NovoGrid, NovasLinhas, NovoNivel, NovoTempo, NovaPontuacao, NovaAtualPeca, NovaIdProximaPeca, NovoFrameNeed, NovaFramePast, EhJogoTerminou)).

create_grid_jogo(Grid) :-
    retractall(grid_jogo(_)),
    assertz(grid_jogo(Grid)).

update_grid_jogo(NovaGrid) :-
    retract(grid_jogo(_)),
    assertz(grid_jogo(NovaGrid)).

create_grid_peca(Grid) :-
    retractall(grid_peca(_)),
    assertz(grid_peca(Grid)).

update_grid_peca(NovaGrid) :-
    retract(grid_peca(_)),
    assertz(grid_peca(NovaGrid)).

create_caixas_texto(TextoPontuacao, TextoNivel, TextoLinhas, TextoTempo) :-
    retractall(caixas_texto(_, _, _, _)),
    assertz(caixas_texto(TextoPontuacao, TextoNivel, TextoLinhas, TextoTempo)).

update_caixas_texto(NovaTextoPontuacao, TextoNivel, TextoLinhas, TextoTempo) :-
    retract(caixas_texto(_, _, _, _)),
    assertz(caixas_texto(NovaTextoPontuacao, TextoNivel, TextoLinhas, TextoTempo)).

create_caixa_termino(NovoTextoTermino) :-
    retractall(mensagem_termino(_)),
    assertz(mensagem_termino(NovoTextoTermino)).

criar_fila_de_processamento :-
    retractall(fila_processamento(_)),
    assertz(fila_processamento([])).

adicionar_processamento_fila(NumeroProcessamento) :-
    fila_processamento(ProcessamentoAteAgora),
    retract(fila_processamento(_)),
    assertz(fila_processamento([NumeroProcessamento | ProcessamentoAteAgora])).

retirar_processamento(NumeroProcessamento) :-
    fila_processamento([NumeroProcessamento | ProcessamentoAteAgora]),
    retract(fila_processamento(_)),
    assertz(fila_processamento([ProcessamentoAteAgora])).