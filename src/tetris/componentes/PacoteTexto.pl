:- use_module(library(pce)).

pacote_texto_tutorial(Window) :-
    X = 50,
    new(FontTutorial, font(times, normal, 15)),
    send(Window, display, new(TextoTutorial1, text('Seta pra esquerda mover pra esquerda')), point(X,100)),
    send(Window, display, new(TextoTutorial2, text('Seta pra direita mover pra direita')), point(X,150)),
    send(Window, display, new(TextoTutorial3, text('Seta pra baixo mover pra baixo')), point(X,200)),
    send(Window, display, new(TextoTutorial4, text('R - Reniciar Jogo')), point(X,250)),
    send(Window, display, new(TextoTutorial5, text('Z - Rotacionar anti-horario')), point(X,300)),
    send(Window, display, new(TextoTutorial6, text('X - Rotacionar horario')), point(X,350)),
    send(Window, display, new(TextoTutorial7, text('espaco - Jogar a peca pra baixo')), point(X,400)),
    send(Window, display, new(TextoTutorial8, text('esc - sair do jogo')), point(X,450)),
    send(TextoTutorial1, font, FontTutorial),
    send(TextoTutorial2, font, FontTutorial),
    send(TextoTutorial3, font, FontTutorial),
    send(TextoTutorial4, font, FontTutorial),
    send(TextoTutorial5, font, FontTutorial),
    send(TextoTutorial6, font, FontTutorial),
    send(TextoTutorial7, font, FontTutorial),
    send(TextoTutorial8, font, FontTutorial).

pacote_texto_fixo(Window) :-
    X = 800,
    new(FontEstado, font(times, normal, 25)),
    send(Window, display, new(TextoProxima, text('Proxima')), point(X,300)),
    send(Window, display, new(TextoPontuacao, text('Pontuacao')), point(X,525)),
    send(Window, display, new(TextoNivel, text('Nivel')), point(X,575)),
    send(Window, display, new(TextoLinhas, text('Linhas')), point(X,625)),
    send(Window, display, new(TextoTempo, text('Tempo')), point(X,675)),
    send(TextoProxima, font, FontEstado),
    send(TextoPontuacao, font, FontEstado),
    send(TextoNivel, font, FontEstado),
    send(TextoLinhas, font, FontEstado),
    send(TextoTempo, font, FontEstado).

pacote_texto_estado_jogo(Window, (Pontuacao, Nivel, Linhas, Tempo), (TextoPontuacao, TextoNivel, TextoLinhas, TextoTempo)) :-
    X = 950,
    new(FontEstado, font(times, normal, 25)),

    new(TextoPontuacao, text(Pontuacao)),
    new(TextoNivel, text(Nivel)),
    new(TextoLinhas, text(Linhas)),
    new(TextoTempo, text(Tempo)),    
    
    send(Window, display, TextoPontuacao, point(X,525)),
    send(Window, display, TextoNivel, point(X,575)),
    send(Window, display, TextoLinhas, point(X,625)),
    send(Window, display, TextoTempo, point(X,675)),

    send(TextoPontuacao, font, FontEstado),
    send(TextoNivel, font, FontEstado),
    send(TextoLinhas, font, FontEstado),
    send(TextoTempo, font, FontEstado).

pacote_texto_termino(Window, -1, TextoTermino) :-
    X = 800,

    new(FontEstado, font(times, bold, 15)),
    new(TextoTermino, text('Você perdeu')),

    send(Window, display, TextoTermino, point(X, 100)),

    send(TextoTermino, font, FontEstado).

pacote_texto_termino(Window, 1, TextoTermino) :-
    X = 800,

    new(FontEstado, font(times, bold, 15)),
    new(TextoTermino, text('Você venceu')),

    send(Window, display, TextoTermino, point(X, 100)),

    send(TextoTermino, font, FontEstado).

pacote_texto_fixo_conquista(Window) :-
    
    Y = 100,

    new(FontInstrucao, font(times, bold, 25)),

    new(FontEstado, font(times, bold, 50)),
    
    new(TextoInstrucao, text('Aperte esc para sair!')),

    new(TextoPontuacao, text('Pontuacao')),
    new(TextoMenorTempo, text('Menor Tempo')),
    new(TextoMaiorTempo, text('Maior Tempo')),

    send(Window,display, TextoInstrucao, point(0,0)),

    send(Window, display, TextoPontuacao, point(0, Y)),
    send(Window, display, TextoMaiorTempo, point(350, Y)),
    send(Window, display, TextoMenorTempo, point(780, Y)),

    send(TextoInstrucao, font, FontInstrucao),

    send(TextoPontuacao, font, FontEstado),
    send(TextoMaiorTempo, font, FontEstado),
    send(TextoMenorTempo, font, FontEstado).

pacote_texto_pontuacao_conquista(Window, Pontuacao) :-

    X = 15,

    new(FontEstado, font(times, bold, 10)),

    pontuacao_20_000_mais(Pontuacao, Texto1),
    pontuacao_22_000_mais(Pontuacao, Texto2),
    pontuacao_25_000_mais(Pontuacao, Texto3),
    pontuacao_28_000_mais(Pontuacao, Texto4),
    pontuacao_30_000_mais(Pontuacao, Texto5),

    atom_concat('Sua Pontuacao Máxima ', Pontuacao, Texto0),

    new(CaixaTexto0, text(Texto0)),
    new(CaixaTexto1, text(Texto1)),
    new(CaixaTexto2, text(Texto2)),
    new(CaixaTexto3, text(Texto3)),
    new(CaixaTexto4, text(Texto4)),
    new(CaixaTexto5, text(Texto5)),

    send(Window, display, CaixaTexto0, point(X, 200)),
    send(Window, display, CaixaTexto1, point(X, 250)),
    send(Window, display, CaixaTexto2, point(X, 300)),
    send(Window, display, CaixaTexto3, point(X, 350)),
    send(Window, display, CaixaTexto4, point(X, 400)),
    send(Window, display, CaixaTexto5, point(X, 450)),


    send(CaixaTexto0, font, FontEstado),
    send(CaixaTexto1, font, FontEstado),
    send(CaixaTexto2, font, FontEstado),
    send(CaixaTexto3, font, FontEstado),
    send(CaixaTexto4, font, FontEstado),
    send(CaixaTexto5, font, FontEstado).


pontuacao_30_000_mais(Pontuacao, 'Você apertou outra coisa além de espaço? (30 mil pontos)') :- Pontuacao > 30000, !.
pontuacao_30_000_mais(_, 'Consiga mais de 30 mil pontos para ter esta conquista!').

pontuacao_28_000_mais(Pontuacao, 'Você precisa sair de casa! (28 mil pontos)') :- Pontuacao > 28000, !.
pontuacao_28_000_mais(_, 'Consiga mais de 28 mil pontos para ter esta conquista!').

pontuacao_25_000_mais(Pontuacao, 'Acho que é o padrão para um viciado. (25 mil pontos)') :- Pontuacao > 25000, !.
pontuacao_25_000_mais(_, 'Consiga mais de 25 mil pontos para ter esta conquista!').

pontuacao_22_000_mais(Pontuacao, 'Legal. (22 mil pontos)') :- Pontuacao > 22000, !.
pontuacao_22_000_mais(_, 'Consiga mais de 22 mil pontos para ter esta conquista!').

pontuacao_20_000_mais(Pontuacao, 'Sua primeira vez jogando? (20 mil pontos)') :- Pontuacao > 20000, !.
pontuacao_20_000_mais(_, 'Consiga mais de 20 mil pontos para ter esta conquista!').

pacote_texto_menorTempo_conquista(Window, MenorTempo) :-
    X = 365,

    new(FontEstado, font(times, bold, 10)),

    menorTempo_60_menos(MenorTempo, Texto1),
    menorTempo_120_menos(MenorTempo, Texto2),
    menorTempo_180_menos(MenorTempo, Texto3),
    menorTempo_240_menos(MenorTempo, Texto4),
    menorTempo_300_menos(MenorTempo, Texto5),
    menorTempo_360_menos(MenorTempo, Texto6),

    atom_concat('Seu menor tempo:', MenorTempo, Texto0),

    new(CaixaTexto0, text(Texto0)),
    new(CaixaTexto1, text(Texto1)),
    new(CaixaTexto2, text(Texto2)),
    new(CaixaTexto3, text(Texto3)),
    new(CaixaTexto4, text(Texto4)),
    new(CaixaTexto5, text(Texto5)),
    new(CaixaTexto6, text(Texto6)),

    send(Window, display, CaixaTexto0, point(X, 200)),
    send(Window, display, CaixaTexto1, point(X, 250)),
    send(Window, display, CaixaTexto2, point(X, 300)),
    send(Window, display, CaixaTexto3, point(X, 350)),
    send(Window, display, CaixaTexto4, point(X, 400)),
    send(Window, display, CaixaTexto5, point(X, 450)),
    send(Window, display, CaixaTexto6, point(X, 500)),


    send(CaixaTexto0, font, FontEstado),
    send(CaixaTexto1, font, FontEstado),
    send(CaixaTexto2, font, FontEstado),
    send(CaixaTexto3, font, FontEstado),
    send(CaixaTexto4, font, FontEstado),
    send(CaixaTexto5, font, FontEstado),
    send(CaixaTexto6, font, FontEstado).
    
menorTempo_60_menos(MenorTempo, 'Eu sei que você trapaceou... (60 segundos)') :- MenorTempo < 60, !.
menorTempo_60_menos(_, 'Consiga vencer em menos de 60 segundos para ter esta conquista!').

menorTempo_120_menos(MenorTempo, 'Relaxa, não estamos em um campeonato. (120 segundos)') :- MenorTempo < 120, !.
menorTempo_120_menos(_, 'Consiga vencer em menos de 120 segundos para ter esta conquista!').

menorTempo_180_menos(MenorTempo, 'Vá pegar um sol cara. (180 segundos)') :- MenorTempo < 180, !.
menorTempo_180_menos(_, 'Consiga vencer em menos de 180 segundos para ter esta conquista!').

menorTempo_240_menos(MenorTempo, 'Pode printar. (240 segundos)') :- MenorTempo < 240, !.
menorTempo_240_menos(_, 'Consiga vencer em menos de 240 segundos para ter esta conquista!').

menorTempo_300_menos(MenorTempo, 'Com certeza, top 100 dos que jogaram o fliperama! (300 segundos)') :- MenorTempo < 300, !.
menorTempo_300_menos(_, 'Consiga vencer em menos de 300 segundos para ter esta conquista!').

menorTempo_360_menos(MenorTempo, 'Bem vindo ao Tetris! (360 segundos)') :- MenorTempo < 360, !.
menorTempo_360_menos(_, 'Consiga vencer em menos de 360 segundos para ter esta conquista!').

pacote_texto_maiorTempo_conquista(Window, MaiorTempo) :-
    X = 800,

    new(FontEstado, font(times, bold, 10)),

    maiorTempo_420_mais(MaiorTempo, Texto1),
    maiorTempo_480_mais(MaiorTempo, Texto2),
    maiorTempo_540_mais(MaiorTempo, Texto3),
    maiorTempo_600_mais(MaiorTempo, Texto4),
    maiorTempo_800_mais(MaiorTempo, Texto5),
    maiorTempo_1500_mais(MaiorTempo, Texto6),

    atom_concat('Seu maior tempo:', MaiorTempo, Texto0),

    new(CaixaTexto0, text(Texto0)),
    new(CaixaTexto1, text(Texto1)),
    new(CaixaTexto2, text(Texto2)),
    new(CaixaTexto3, text(Texto3)),
    new(CaixaTexto4, text(Texto4)),
    new(CaixaTexto5, text(Texto5)),
    new(CaixaTexto6, text(Texto6)),

    send(Window, display, CaixaTexto0, point(X, 200)),
    send(Window, display, CaixaTexto1, point(X, 250)),
    send(Window, display, CaixaTexto2, point(X, 300)),
    send(Window, display, CaixaTexto3, point(X, 350)),
    send(Window, display, CaixaTexto4, point(X, 400)),
    send(Window, display, CaixaTexto5, point(X, 450)),
    send(Window, display, CaixaTexto6, point(X, 500)),


    send(CaixaTexto0, font, FontEstado),
    send(CaixaTexto1, font, FontEstado),
    send(CaixaTexto2, font, FontEstado),
    send(CaixaTexto3, font, FontEstado),
    send(CaixaTexto4, font, FontEstado),
    send(CaixaTexto5, font, FontEstado),
    send(CaixaTexto6, font, FontEstado).
    
maiorTempo_420_mais(maiorTempo, 'Normal (420 segundos)') :- maiorTempo > 420, !.
maiorTempo_420_mais(_, 'Consiga vencer em mais de 420 segundos para ter esta conquista!').

maiorTempo_480_mais(maiorTempo, 'Precisa Melhorar. (480 segundos)') :- maiorTempo > 480, !.
maiorTempo_480_mais(_, 'Consiga vencer em mais de 480 segundos para ter esta conquista!').

maiorTempo_540_mais(maiorTempo, 'Já pensou em apertar espaço? (540 segundos)') :- maiorTempo > 540, !.
maiorTempo_540_mais(_, 'Consiga vencer em mais de 540 segundos para ter esta conquista!').

maiorTempo_600_mais(maiorTempo, 'Se fez de propósito, é impressionante (600 segundos)') :- maiorTempo > 600, !.
maiorTempo_600_mais(_, 'Consiga vencer em mais de 600 segundos para ter esta conquista!').

maiorTempo_800_mais(maiorTempo, 'Ok, isso é ainda mais impressionante que fazer rápido! (800 segundos)') :- maiorTempo > 800, !.
maiorTempo_800_mais(_, 'Consiga vencer em mais de 800 segundos para ter esta conquista!').

maiorTempo_1500_mais(maiorTempo, 'Você já conseguiu a conquista acima, isto foi exagero.') :- maiorTempo > 1500, !.
maiorTempo_1500_mais(_, 'Consiga vencer em menos de 1500 segundos para ter esta conquista!').