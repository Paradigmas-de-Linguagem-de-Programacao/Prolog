:- consult('utilitarios/estado.pl').
:- consult('utilitarios/json.pl').
:- consult('componentes/PacoteTexto.pl').

:- use_module(library(pce)).

tela_conquista :-
    new(@telaConquista, picture('Suas conquistas!')),
    
    send(@telaConquista, size, size(1200, 800)),
    send(@telaConquista, open),
    send(@telaConquista, recogniser, new(K, key_binding(@nil, argument))),
    
    send(K, function, '\\e', message(@prolog, fecha_tela)),

    eh_tela_conquista_aberta,

    caminho_diretorio(Diretorio),

    (exists_file(Diretorio) -> tela_com_conquista(Diretorio) ; tela_sem_conquista).

tela_sem_conquista :- 
    
    pacote_texto_fixo_conquista_instrucao(@telaConquista),

    new(FontEstado, font(times, bold, 35)),
    
    new(TextoInstrucao, text('Vença ao menos uma partida para ter conquistas!')),

    send(@telaConquista, display, TextoInstrucao, point(200, 200)),

    send(TextoInstrucao, font, FontEstado),
    
    loop_infinito.

tela_com_conquista(Diretorio) :-
    ler_json(Diretorio, Pontuacao, MenorTempo, MaiorTempo),

    pacote_texto_fixo_conquista(@telaConquista),

    pacote_texto_pontuacao_conquista(@telaConquista, Pontuacao),
    pacote_texto_menorTempo_conquista(@telaConquista, MenorTempo),
    pacote_texto_maiorTempo_conquista(@telaConquista, MaiorTempo),
    loop_infinito.


loop_infinito :- TempoEspera is 1/2, sleep(TempoEspera), tela_conquista_aberta(1), loop_infinito, !.
loop_infinito.

fecha_tela :- eh_tela_conquista_fechada, free(@telaConquista).