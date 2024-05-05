:- use_module(library(pce)).

:- consult('quick_start.pl').
:- consult('componentes/Grid.pl').
:- consult('componentes/PacoteTexto.pl').
:- consult('utilitarios/estado.pl').
:- consult('utilitarios/limparJogo.pl').
:- consult('utilitarios/movimentoPeca.pl').
:- consult('utilitarios/rotacaoPeca.pl').

mock_tetris :-

    quick_start,

    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, _, IdProximaPeca, _, _, 0 ),
    
    new(@window, picture('tetris')),
    send(@window, size, size(1200, 800)),
    send(@window, open),
    
    pacote_texto_termino(@window, 1, TextoTermino),
    create_caixa_termino(TextoTermino),
    free(TextoTermino),

    gera_grid_renderizavel(Grid, 30, GridsRenderizaveis),
    create_grid_jogo(GridsRenderizaveis),
    reverse(GridsRenderizaveis, GridVisao),
    renderiza_grid(@window, 400, 100, 30, GridVisao),

    gera_peca(IdProximaPeca, ProximaPeca, _, _),
    gera_grid_renderizavel(ProximaPeca, 30, PecaRenderizavel),
    create_grid_peca(PecaRenderizavel),
    reverse(PecaRenderizavel, PecaVisao),
    renderiza_grid(@window, 800, 350, 30, PecaVisao),
    
    pacote_texto_tutorial(@window),
    pacote_texto_fixo(@window),
    pacote_texto_estado_jogo(@window, (Pontuacao, Nivel, Linhas, Tempo), (TextoPontuacao, TextoNivel, TextoLinhas, TextoTempo)),
    
    create_caixas_texto(TextoPontuacao, TextoNivel, TextoLinhas, TextoTempo),

    send(@window, recogniser, new(K, key_binding(@nil, argument))),
    send(K, function, 'cursor_down', message(@prolog, evento_tecla_down)),
    send(K, function, 'cursor_left', message(@prolog, evento_tecla_left)),
    send(K, function, 'cursor_right', message(@prolog, evento_tecla_right)),
    send(K, function, 'r', message(@prolog, evento_tecla_r)),
    send(K, function, 'R', message(@prolog, evento_tecla_r)),
    send(K, function, 'SPC', message(@prolog, evento_tecla_space)),
    send(K, function, 'x', message(@prolog, evento_tecla_x)),
    send(K, function, 'X', message(@prolog, evento_tecla_x)),
    send(K, function, 'z', message(@prolog, evento_tecla_z)),
    send(K, function, 'Z', message(@prolog, evento_tecla_z)),
    send(K, function, '\\e', message(@prolog, evento_tecla_esc)),

    atualizador_tempo.

evento_tecla_esc :-
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, _),
    update_estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 2),
    free(@window).

atualizador_tempo :-
    TempoEspera is 1/12, 
    sleep(TempoEspera),
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0),
    NovoFramePast is FramePast + 1,
    ((NovoFramePast mod FrameNeed) =:= 0 -> 
        jogar_para_baixo(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, NovoFramePast,  _); 
        update_estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, NovoFramePast, 0)), 
    atualizador_tempo, !.

atualizador_tempo :- 
    estado(_, _, _, _, _, _, _, _, _, Muda),
    Muda =\= 2,    
    atualizador_tempo.

evento_tecla_down :-
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0 ),
    jogar_para_baixo( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, _),
    estado( NovaGrid, NovasLinhas, NovoNivel, Tempo, NovaPontuacao, NovaPecaAtual, NovaIdProximaPeca, FrameNeed, FramePast, 0),
    FinalPontuacao is NovaPontuacao + 5,
    atualiza_estado_jogo(FinalPontuacao, NovoNivel, NovasLinhas, Tempo),
    update_estado(NovaGrid, NovasLinhas, NovoNivel, Tempo, FinalPontuacao, NovaPecaAtual, NovaIdProximaPeca, FrameNeed, FramePast, 0).

evento_tecla_left :-
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0),
    verifica_shift_esquerda(Grid), 
    shift_esquerda(Grid, NovaGrid),
    grid_jogo(GridRenderizavel),
    update_grid(NovaGrid, GridRenderizavel),
    update_estado( NovaGrid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0), !.

evento_tecla_left.

evento_tecla_right :-
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0 ),
    verifica_shift_direita(Grid),
    shift_direita(Grid, NovaGrid),
    grid_jogo(GridRenderizavel),
    update_grid(NovaGrid, GridRenderizavel),
    update_estado( NovaGrid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0 ), !.

evento_tecla_right.

evento_tecla_space :-
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0 ),
    jogar_para_baixo( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, Change),
    estado( NovaGrid, NovasLinhas, NovoNivel, Tempo, NovaPontuacao, NovaPecaAtual, NovaIdProximaPeca, FrameNeed, FramePast, 0),
    FinalPontuacao is NovaPontuacao + 20,
    atualiza_estado_jogo(FinalPontuacao, NovoNivel, NovasLinhas, Tempo),
    update_estado(NovaGrid, NovasLinhas, NovoNivel, Tempo, FinalPontuacao, NovaPecaAtual, NovaIdProximaPeca, FrameNeed, FramePast, 0),
    Change = 0,
    evento_tecla_space.

evento_tecla_space.

evento_tecla_x :-
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0 ),
    rotaciona_peca_horario(AtualPeca, AtualPecaRotacionada),
    mapeia_coordenadas(Grid, 0, [Xo, Yo], [Xf, Yf]),
    gera_coordenadas([Xo, Yo], [Xf, Yf], [XoCompleto, YoCompleto], [XfCompleto, YfCompleto]),
    limpar_grid(Grid, GridLimpa),
    pode_atribuir_peca(GridLimpa, AtualPecaRotacionada, [XoCompleto, YoCompleto], [XfCompleto, YfCompleto]),
    atribuicao_peca(GridLimpa, AtualPecaRotacionada, [XoCompleto, YoCompleto], [XfCompleto, YfCompleto], NovaGrid),
    grid_jogo(GridRenderizavel),
    update_grid(NovaGrid, GridRenderizavel),
    update_estado( NovaGrid, Linhas, Nivel, Tempo, Pontuacao, AtualPecaRotacionada, IdProximaPeca, FrameNeed, FramePast, 0).

evento_tecla_x.

evento_tecla_z :-
    estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0 ),
    rotaciona_peca_anti_horario(AtualPeca, AtualPecaRotacionada),
    mapeia_coordenadas(Grid, 0, [Xo, Yo], [Xf, Yf]),
    gera_coordenadas([Xo, Yo], [Xf, Yf], [XoCompleto, YoCompleto], [XfCompleto, YfCompleto]),
    limpar_grid(Grid, GridLimpa),
    pode_atribuir_peca(GridLimpa, AtualPecaRotacionada, [XoCompleto, YoCompleto], [XfCompleto, YfCompleto]) ,
    atribuicao_peca(GridLimpa, AtualPecaRotacionada, [XoCompleto, YoCompleto], [XfCompleto, YfCompleto], NovaGrid),
    grid_jogo(GridRenderizavel),
    update_grid(NovaGrid, GridRenderizavel),
    update_estado( NovaGrid, Linhas, Nivel, Tempo, Pontuacao, AtualPecaRotacionada, IdProximaPeca, FrameNeed, FramePast, 0 ).

evento_tecla_z.

evento_tecla_r :-
    quick_start,
    mensagem_termino(TextoTermino),
    free(TextoTermino),
    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, _, IdProximaPeca, _, 0, 0),
    grid_jogo(GridRenderizavel),
    update_grid(Grid, GridRenderizavel),
    grid_peca(PecaRenderizavelAtual),
    apaga_grid(PecaRenderizavelAtual),
    gera_peca(IdProximaPeca, ProximaPeca, _, _),
    gera_grid_renderizavel(ProximaPeca, 30, PecaRenderizavel),
    create_grid_peca(PecaRenderizavel),
    reverse(PecaRenderizavel, PecaVisao),
    renderiza_grid(@window, 800, 350, 30, PecaVisao),
    atualiza_estado_jogo(Pontuacao, Nivel, Linhas, Tempo).

jogar_para_baixo( Grid, Linhas, Nivel, _, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0 ):- 
    NovoTempo is FramePast // 12,
    verifica_shift_baixo(Grid),
    shift_baixo(Grid, NovaGrid),
    grid_jogo(GridRenderizavel),
    update_grid(NovaGrid, GridRenderizavel),
    atualiza_estado_jogo(Pontuacao, Nivel, Linhas, NovoTempo),
    update_estado( NovaGrid, Linhas, Nivel, NovoTempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 0 ),
    !.

jogar_para_baixo( Grid, Linhas, Nivel, _, Pontuacao, _, IdProximaPeca, _, FramePast, 1 ):-             
    NovoTempo is FramePast // 12,
    congelar_tudo(Grid, GridCongelada),
    clear_game(GridCongelada, GridLimpa, QuantidadeLinhasLimpas),
    gera_peca(IdProximaPeca, NovaAtualPeca, (Xo, Yo), (Xf, Yf)),
    pode_atribuir_peca(GridLimpa, NovaAtualPeca, [Xo, Yo], [Xf, Yf]),
    atribuicao_peca(GridLimpa, NovaAtualPeca, [Xo, Yo], [Xf, Yf], NovaGrid),
    grid_jogo(GridRenderizavel),
    update_grid(NovaGrid, GridRenderizavel),

    % Operações de próxima Peça
    grid_peca(PecaRenderizavelAtual),
    apaga_grid(PecaRenderizavelAtual),
    NovoIdProximaPeca is ((IdProximaPeca + Linhas + Nivel + NovoTempo + Pontuacao) mod 7),
    gera_peca(NovoIdProximaPeca, ProximaPeca, _, _),
    gera_grid_renderizavel(ProximaPeca, 30, PecaRenderizavel),
    create_grid_peca(PecaRenderizavel),
    reverse(PecaRenderizavel, PecaVisao),
    renderiza_grid(@window, 800, 350, 30, PecaVisao),

    NovasLinhas is Linhas + QuantidadeLinhasLimpas,
    NovoNivel is (NovasLinhas // 10) + 1,
    NovaPontuacao is (Pontuacao + QuantidadeLinhasLimpas * NovoNivel * 5),

    (NovoNivel >= 6 -> 
        (JogoTerminou = 1, pacote_texto_termino(@window, 1, TextoTermino), create_caixa_termino(TextoTermino)); 
        JogoTerminou = 0),

    NovoFrameNeed is 12 // Nivel,

    atualiza_estado_jogo(NovaPontuacao, NovoNivel, NovasLinhas, NovoTempo),
    update_estado(NovaGrid, NovasLinhas, NovoNivel, NovoTempo, NovaPontuacao, NovaAtualPeca, NovoIdProximaPeca, NovoFrameNeed, FramePast, JogoTerminou), 
    !.

jogar_para_baixo( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, 1 ):-
    pacote_texto_termino(@window, -1, TextoTermino), create_caixa_termino(TextoTermino),         
    update_estado(Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FrameNeed, FramePast, -1).

atualiza_estado_jogo(Pontuacao, Nivel, Linhas, Tempo) :-
    caixas_texto(TextoPontuacao, TextoNivel, TextoLinhas, TextoTempo),
    free(TextoPontuacao),
    free(TextoNivel),
    free(TextoLinhas),
    free(TextoTempo),

    pacote_texto_estado_jogo(@window, (Pontuacao, Nivel, Linhas, Tempo), (TextoPontuacaoNova, TextoNivelNova, TextoLinhasNova, TextoTempoNova)),
    create_caixas_texto(TextoPontuacaoNova, TextoNivelNova, TextoLinhasNova, TextoTempoNova).