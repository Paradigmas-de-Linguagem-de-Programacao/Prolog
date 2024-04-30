:- module(combate_playHub, [pre_combate_playHub/0]). 

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Combate/combate_mecanica').   
:- use_module('../Models/inimigo.pl').
:- use_module('../Combate/combate_IA.pl').

pre_combate_playHub:-
    dialogo_pre_combate(2),
    turno_preparacao,
    visualiza_status("Cachorros caramelos"),
    turno_heroi.

turno_heroi:-
    verifica_inimigo_morto("Hub"),
    writeln("Somente Play sobrou mas sua voz continua irritante como sempre"),
    writeln("(1) Ataque.\n(2) Usa poção.\n"),
    inputNumber("\nEscolha uma ação: ", Escolha),
    escolha_acao_heroi_hub_vivo(Escolha).

turno_heroi:-
    verifica_inimigo_morto("Play"),
    writeln("Os cachorros pulam ferozmente e te mordem"),
    ataque_inimigo("Cachorros caramelos"),
    (verifica_heroi_morto -> morte_dano ; turno_heroi).

escolha_acao_heroi_hub_vivo(1):-
    writeln("Heanes ataca com intenção de calar essa coisa feia para sempre."),
    



