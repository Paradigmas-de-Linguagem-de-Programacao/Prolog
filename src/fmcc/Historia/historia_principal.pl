:- module(historia_principal , [curso_historia/1]).

:- use_module('../Util/lib.pl').
:- use_module('../Util/dialogos.pl').

curso_historia(Progresso):-
    dialogo_historia(Progresso),
    nome_a_ser_pensado. % função que chama as escolhas da  historia principal mas não pensei em um nome bom!

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

opcao_historia(4):-
    %funcao que vai para o combate
    lib:esperandoEnter.  %tirar isso quando colocar a funçao 

escolha_historia_principal(5):- voltaMenu,!.

escolha_historia_principal(Escolha):- opcao_historia(Escolha), nome_a_ser_pensado.

escolha_historia_principal(_):- writeln("Escreva uma opção válida.\n"), nome_a_ser_pensado.

nome_a_ser_pensado:-
    writeln("O que deseja fazer agora que está de volta a cidade?\n"),
    menu_historia_principal,
    lib:inputNumber("Faça sua escolha: ", Escolha),
    escolha_historia_principal(Escolha).
