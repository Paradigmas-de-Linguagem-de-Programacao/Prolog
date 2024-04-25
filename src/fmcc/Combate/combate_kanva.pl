:- module(combate_kanva , [pre_combate_kanva/0]).

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Combate/combate_mecanica').   

escolha_heroi(1):- ataque_heroi, (verifica_inimigo_morto -> combate_kanva ; turno_inimigo).
escolha_heroi(2):- toma_pocao , (verifica_pocoes_tomadas -> morte_pocao ; turno_inimigo).
escolha_heroi(_):- writeln("Digite uma opção válida."), turno_heroi.

pre_combate_kanva:-
    dialogo_pre_combate(1),
    turno_preparacao,
    visualiza_status,
    turno_heroi.

turno_inimigo:-
    writeln("Os cachorros pulam ferozmente e te mordem"),
    ataque_inimigo,
    (verifica_heroi_morto -> morte_dano ; turno_heroi).


turno_heroi:-
    writeln("(1) Ataque.\n(2) Usa poção.\n"),
    inputNumber("\nEscolha uma ação: ", Escolha),
    escolha_heroi(Escolha).

combate_kanva:-
    read(Olaa),
    write(Olaa).
    
    
