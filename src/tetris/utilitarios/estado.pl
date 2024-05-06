% estrutura de estado

% estado( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, JogoTerminou ).

:- consult('json.pl').

:- dynamic estado/9.

nivel_maximo(1).

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

escrever_estatistica(Tempo, Pontuacao) :-
    caminho_diretorio(Arquivo),
    (exists_file(Arquivo) -> 
        escrever_estatistica_arquivo_existe(Arquivo, Tempo, Pontuacao); 
        escrever_json(Arquivo, Pontuacao, Tempo, Tempo)).


escrever_estatistica_arquivo_existe(Arquivo, Tempo, Pontuacao) :-
    ler_json(Arquivo, MaiorPontuacao, MenorTempo, MaiorTempo),
    meu_max(MaiorPontuacao, Pontuacao, PontuacaoEscrever),
    meu_min(MenorTempo, Tempo, MenorTempoEscrever),
    meu_max(MaiorTempo, Tempo, MaiorTempoEscrever),
    escrever_json(Arquivo, PontuacaoEscrever, MenorTempoEscrever, MaiorTempoEscrever).
    
meu_max(X, Y, X) :- X > Y, !.
meu_max(_, Y, Y).

meu_min(X, Y, X) :- X < Y, !.
meu_min(_, Y, Y).

fato.

create_caminho_diretorio(Diretorio) :-
    retractall(caminho_diretorio(_)),
    assertz(caminho_diretorio(Diretorio)).

criar_fila_de_processamento :-
    retractall(fila_processamento(_)),
    assertz(fila_processamento([])).

push_fila([], Elemento, [Elemento]).
push_fila([Cabeca | Cauda], Elemento, [Cabeca | NovaCauda]) :-
    push_fila(Cauda, Elemento, NovaCauda).

adicionar_processamento_fila(NumeroProcessamento) :-
    fila_processamento(ProcessamentoAteAgora),
    retract(fila_processamento(_)),
    push_fila(ProcessamentoAteAgora, NumeroProcessamento, NovoProcessamento),
    assertz(fila_processamento(NovoProcessamento)).

retirar_processamento(NumeroProcessamento) :-
    fila_processamento([NumeroProcessamento | ProcessamentoAteAgora]),
    retract(fila_processamento(_)),
    assertz(fila_processamento(ProcessamentoAteAgora)).

eh_tela_conquista_aberta :-
    retractall(tela_conquista_aberta(_)),
    assertz(tela_conquista_aberta(1)).

eh_tela_conquista_fechada :-
    retract(tela_conquista_aberta(_)),
    assertz(tela_conquista_aberta(0)).