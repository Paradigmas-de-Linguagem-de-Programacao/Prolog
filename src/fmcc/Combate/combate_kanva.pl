:- module(combate_kanva , [pre_combate_kanva/0]).

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Combate/combate_mecanica').   
:- use_module('../Models/inimigo.pl').
:- use_module('../Combate/combate_IA.pl').

escolha_heroi(1):- ataque_heroi("Cachorros caramelos"), (verifica_inimigo_morto("Cachorros caramelos") -> combate_kanva ; turno_inimigo).
escolha_heroi(2):- toma_pocao , (verifica_pocoes_tomadas -> morte_pocao ; turno_inimigo).
escolha_heroi(_):- writeln("Digite uma opção válida."), turno_heroi.

pre_combate_kanva:-
    dialogo_pre_combate(1),
    turno_preparacao,
    visualiza_status("Cachorros caramelos"),
    turno_heroi.

turno_inimigo:-
    writeln("Os cachorros pulam ferozmente e te mordem"),
    ataque_inimigo("Cachorros caramelos"),
    (verifica_heroi_morto -> morte_dano ; turno_heroi).


turno_heroi:-
    writeln("Os cachorros Rosnam para você o que fazer?"),
    writeln("(1) Ataque.\n(2) Usa poção.\n"),
    inputNumber("\nEscolha uma ação: ", Escolha),
    escolha_heroi(Escolha).

combate_kanva:-
    printString("*Sem tempo para comemorar a vitória você é puxado para dentro do museu deixando Leandro para trás.*\n"),
    writeln("Se prepare rapidamente para o combate!."),
    printString("C.W. te acompanhou de longe e liberou uma poção a mais no seu inventário, essa poção é uma nova criação do Mestre dos Magos, e não pode ser comprada.\n"),
    %funcao que adiciona o monster
    combate_IA.


    
    
