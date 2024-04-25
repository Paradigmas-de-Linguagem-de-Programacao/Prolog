:- module(historia_principal , [curso_historia/1]).

:- use_module('../Util/lib.pl').
:- use_module('../Util/dialogos.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Combate/combate_kanva.pl').

curso_historia(Progresso):-
    dialogo_historia(Progresso),
    historia_principal. % função que chama as escolhas da  historia principal mas não pensei em um nome bom!

combate_inicial(1):- pre_combate_kanva.

opcao_historia(1):-
    writeln("Ganhar alguns mangos sempre é bom, talvez assim nosso herói não precise aderir a nenhuma greve. Como iremos angariar fundos?\n"),
    %funcao que vai para sistema gold,
    lib:esperandoEnter. %tirar isso quando colocar a funçao

opcao_historia(2):-
    %funcao que vai loja de pocao
    lib:esperandoEnter.  %tirar isso quando colocar a funçao

opcao_historia(3):-
    %funcao que vai loja de itens
    lib:esperandoEnter.  %tirar isso quando colocar a funçao

escolha_historia_principal(5):- voltaMenu.

escolha_historia_principal(4):- get_progresso(Progresso), combate_inicial(Progresso).

escolha_historia_principal(Escolha):- opcao_historia(Escolha), historia_principal.

escolha_historia_principal(_):- writeln("Escreva uma opção válida.\n"), historia_principal.

historia_principal:-
    writeln("O que deseja fazer agora que está de volta a cidade?\n"),
    menu_historia_principal,
    lib:inputNumber("Faça sua escolha: ", Escolha),
    escolha_historia_principal(Escolha).
