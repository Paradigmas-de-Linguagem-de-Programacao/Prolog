:- module(combate_IA , [combate_IA/0]).

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('../Util/salvamento.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Models/inimigo.pl').
:- use_module('../Combate/combate_mecanica').   

combate_IA:-
    get_progresso(Progresso),
    dialogo_pre_IA(Progresso),
    get_nome_Ia(Progresso , Nome_Inimigo),
    visualiza_status(Nome_Inimigo),
    turno_heroi(Nome_Inimigo).

turno_heroi(Nome_Inimigo):-
    writeln("(1) Ataque.\n(2) Usa poção.\n"),
    inputNumber("\nEscolha uma ação: ", Escolha),
    escolha_acao_heroi(Nome_Inimigo, Escolha).

escolha_acao_heroi(Nome_Inimigo, 1):- 
    realiza_ataque(Nome_Inimigo), 
    (verifica_inimigo_morto(Nome_Inimigo) -> fim_combate(Nome_Inimigo) ; turno_inimigo(Nome_Inimigo)).

escolha_acao_heroi(Nome_Inimigo, 2):- 
    usa_pocao(Nome_Inimigo) , 
    (verifica_pocoes_tomadas -> morte_pocao ; turno_inimigo(Nome_Inimigo)).

escolha_acao_heroi(Nome_Inimigo, _):- writeln("Digite uma opção válida."), turno_heroi(Nome_Inimigo).


realiza_ataque(Nome_Inimigo):-
    dialogo_heanes_IA(Nome_Inimigo),
    ataque_heroi(Nome_Inimigo).

usa_pocao(Nome_Inimigo):-
    toma_pocao,
    dialogo_IA_deboche(Nome_Inimigo).

turno_inimigo(Nome_Inimigo):-
    dialogos_IA(Nome_Inimigo),
    ataque_inimigo(Nome_Inimigo),
    (verifica_heroi_morto -> morte_dano ; turno_heroi(Nome_Inimigo)).

fim_combate(Nome_Inimigo):-
    dialogo_fim_combate(Nome_Inimigo),
    get_nome_Ia(Nome_Inimigo,Progresso),
    writeln(Progresso). %isso aqui vai ser a funcao que salva o game
    


