:- module(combate_mecanica , [visualiza_status/1, ataque_heroi/1, ataque_inimigo/1, turno_preparacao/0,
                              morte_dano/0, morte_pocao/0]).

:- use_module('../Util/lib.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Models/inimigo.pl').

turno_preparacao:-
    jogador_combate_init.

visualiza_status(Nome_inimigo):-
    writeln("Dê uma olhada nos seus status e nos status de seu inimigo. Quando utilizar um item ou poção os atributos vão ser adicionados aos seus status básicos. Quando você utiliza um equipamento ou poção, ele é descartado após o combate, logo, tenha cuidado no que vai usar.\n"),
    writeln("Status Inimigo: "),
    exibe_inimigo(Nome_inimigo),
    formata_texto,
    writeln("Seus Status: "),
    exibe_jogador_combate,
    formata_texto.

ataque_heroi(Nome_Inimigo):-
    get_ataque_heroi(Ataque),
    recebe_dano_inimigo(Nome_Inimigo, Ataque),
    exibe_inimigo(Nome_Inimigo).

ataque_inimigo(Nome_Inimigo):-
    get_ataque_inimigo(Nome_Inimigo, Ataque),
    recebe_dano(Ataque),
    exibe_jogador_combate.
    
morte_dano:- 
    printString("Você morreu, sei que é complicado digerir isso mas é um jogo então sempre da pra voltar! Porém, você perdeu TODAS AS MOEDAS.\n").

morte_pocao:-
    writeln("Seu coração te da uma pontada... VOCÊ... VOCÊ INFARTOU!!"),
    printString("É parece que tomar todo aquele energético realmente não faz bem para o coração... Os médicos estavam certos fica o aviso crianças se lutarem contra inteligência artificial cuidado com o coração").
    %desbloquear conquista
    


