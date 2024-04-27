:- module(combate_IA , [combate_IA/0]).

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('../Util/salvamento.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Models/inimigo.pl').
:- use_module('../Combate/combate_mecanica').   

escolha_heroi(nome_IA, 1):- realiza_ataque(Nome_IA), (verifica_inimigo_morto -> fim_combate(Nome_IA) ; turno_inimigo(Nome_IA)).
escolha_heroi(nome_IA, 2):- usa_pocao(Nome_IA) , (verifica_pocoes_tomadas -> morte_pocao ; turno_inimigo(Nome_IA)).
escolha_heroi(nome_IA,_):- writeln("Digite uma opção válida."), turno_heroi(nome_IA).

combate_IA:-
    get_progresso(Progresso),
    dialogo_pre_IA(Progresso),
    nome_IA(Progresso , Nome_IA),
    visualiza_status(Nome_IA),
    turno_heroi(Nome_IA).

turno_heroi(Nome_IA):-
    dialogo_jogador_IA(Nome_IA),
    writeln("(1) Ataque.\n(2) Usa poção.\n"),
    inputNumber("\nEscolha uma ação: ", Escolha),
    escolha_heroi(Nome_IA, Escolha).

realiza_ataque(Nome_IA):-
    dialogo_heanes_IA(Nome_IA),
    ataque_heroi(Nome_IA),
    dialogo_recebe_dano(Nome_IA).

usa_pocao(Nome_IA):-
    dialogo_IA_deboche(Nome_IA),
    toma_pocao.

turno_inimigo(Nome_IA):-
    dialogos_IA(Nome_IA),
    ataque_inimigo(Nome_IA),
    (verifica_heroi_morto -> morte_dano ; turno_heroi(Nome_IA)).

fim_combate(Nome_IA):-
    dialogo_fim_combate(Nome_IA),
    nome_IA(nome_IA,Progresso).
    writeln(Progresso). %isso aqui vai ser a funcao que salva o game
    


