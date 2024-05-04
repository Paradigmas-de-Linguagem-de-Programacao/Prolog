:- use_module(library(pce)).

:- consult('quick_start.pl').
:- consult('componentes/Grid.pl').
:- consult('componentes/PacoteTexto.pl').
:- consult('utilitarios/estado.pl').
:- consult('utilitarios/limparJogo.pl').
:- consult('utilitarios/movimentoPeca.pl').
:- consult('utilitarios/rotacaoPeca.pl').

%    send(Window, display, Celula, point(X, Y)),

mock_tetris :-
    
    quick_start,
    
    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, _, IdProximaPeca, _, _ ),
    
    new(@window, picture('tetris')),
    send(@window, size, size(1200, 800)),
    send(@window, open),
    
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
    
    pacote_texto_estado_jogo(@window, Pontuacao, Nivel, Linhas, Tempo),
    
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
    send(K, function, 'Z', message(@prolog, evento_tecla_z)).

evento_tecla_down :-
    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed ),
    jogar_para_baixo( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed, _).

evento_tecla_left :-
    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed ),
    (
        verifica_shift_esquerda(Grid) -> (
            shift_esquerda(Grid, NovaGrid),
            get_grid_jogo(GridRenderizavel),
            update_grid(NovaGrid, GridRenderizavel),
            update_estado( NovaGrid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed )
        );
            evento_whatever('pode não')).

evento_tecla_right :-
    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed ),
    (
        verifica_shift_direita(Grid) -> (
            shift_direita(Grid, NovaGrid),
            get_grid_jogo(GridRenderizavel),
            update_grid(NovaGrid, GridRenderizavel),
            update_estado( NovaGrid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed )
        );
            evento_whatever('pode não')).

evento_tecla_space :-
    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed ),
    jogar_para_baixo( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed, Change),
    (Change = 0 -> evento_tecla_space; writeln('tome')).

jogar_para_baixo( Grid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed, Mudei ):- 
    (verifica_shift_baixo(Grid) -> (
                shift_baixo(Grid, NovaGrid),
                get_grid_jogo(GridRenderizavel),
                update_grid(NovaGrid, GridRenderizavel),
                update_estado( NovaGrid, Linhas, Nivel, Tempo, Pontuacao, AtualPeca, IdProximaPeca, FramePast, FrameNeed ),
                Mudei = 0
            ); (            
                
                congelar_tudo(Grid, GridCongelada),
                
                gera_peca(IdProximaPeca, NovaAtualPeca, (Xo, Yo), (Xf, Yf)),
                
                atribuicao_peca(GridCongelada, NovaAtualPeca, [Xo, Yo], [Xf, Yf], NovaGrid),
                get_grid_jogo(GridRenderizavel),
                update_grid(NovaGrid, GridRenderizavel),

                get_grid_peca(PecaRenderizavelAtual),
                apaga_grid(PecaRenderizavelAtual),

                NovoIdProximaPeca is ((IdProximaPeca + Linhas + Nivel + Tempo + Pontuacao) mod 7),
                
                gera_peca(NovoIdProximaPeca, ProximaPeca, _, _),

                gera_grid_renderizavel(ProximaPeca, 30, PecaRenderizavel),
                
                create_grid_peca(PecaRenderizavel),
                
                reverse(PecaRenderizavel, PecaVisao),
                
                renderiza_grid(@window, 800, 350, 30, PecaVisao),
 
                update_estado( NovaGrid, Linhas, Nivel, Tempo, Pontuacao, NovaAtualPeca, NovoIdProximaPeca, FramePast, FrameNeed ),

                Mudei = 1            
            )).

evento_tecla_x :-
    writeln('x').

evento_tecla_z :-
    writeln('z').

evento_tecla_r :-
    quick_start,
    estado( Grid, Linhas, Nivel, Tempo, Pontuacao, _, IdProximaPeca, _, _ ),
    get_grid_jogo(GridRenderizavel),
    update_grid(Grid, GridRenderizavel),
    get_grid_peca(PecaRenderizavelAtual),
    apaga_grid(PecaRenderizavelAtual),
    gera_peca(IdProximaPeca, ProximaPeca, _, _),
    gera_grid_renderizavel(ProximaPeca, 30, PecaRenderizavel),
    create_grid_peca(PecaRenderizavel),
    reverse(PecaRenderizavel, PecaVisao),
    renderiza_grid(@window, 800, 350, 30, PecaVisao).

evento_whatever(Tecla) :- writeln(Tecla).
