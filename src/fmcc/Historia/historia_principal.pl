:- module(historia_principal , [curso_historia/1]).

:- use_module('../Util/lib.pl').
:- use_module('../Util/dialogos.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Combate/combate_kanva.pl').
:- use_module('../Combate/combate_playHub.pl').
:- use_module('../Combate/combate_conversaGPT.pl').
:- use_module('../Mecanica/gold.pl').
:- use_module('../Mecanica/loja.pl').

curso_historia(Progresso):-
    dialogo_historia(Progresso),
    historia_principal. % função que chama as escolhas da  historia principal mas não pensei em um nome bom!


historia_principal:-
    writeln("O que deseja fazer agora que está de volta a cidade?\n"),
    menu_historia_principal,
    lib:inputNumber("Faça sua escolha: ", Escolha),
    escolha_historia_principal(Escolha).

escolha_historia_principal(5):- voltaMenu.

escolha_historia_principal(4):- get_progresso(Progresso), combate_inicial(Progresso).

escolha_historia_principal(Escolha):- opcao_historia(Escolha), historia_principal.

escolha_historia_principal(_):- writeln("Escreva uma opção válida.\n"), historia_principal.

opcao_historia(1):-
    writeln("Ganhar alguns mangos sempre é bom, talvez assim nosso herói não precise aderir a nenhuma greve. Como iremos angariar fundos?\n"),
    menugold.

opcao_historia(2):-
    abre_loja_pocao.

opcao_historia(3):-
    abre_loja_itens.

combate_inicial(1):- pre_combate_kanva.

combate_inicial(2):- pre_combate_playHub.

combate_inicial(3):- pre_combate_conversaGPT.