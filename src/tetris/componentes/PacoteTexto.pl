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