cria_caminho_conquista(Diretorio) :-
    atom_concat(Diretorio, '/conquista_fmcc.txt', ArquivoConquista),
    retractall(caminho_conquista(_)),
    assertz(caminho_conquista(ArquivoConquista)).

cria_caminho_jogador(Diretorio) :-
    atom_concat(Diretorio, '/jogador_fmcc.txt', JogadorFmcc),
    retractall(caminho_jogador(_)),
    assertz(caminho_jogador(JogadorFmcc)).