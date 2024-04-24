:- module(cidadela , [irCidadelaDeCristal/0]).

:- use_module('../Util/lib.pl').
:- use_module('../Util/dialogos.pl').
:- use_module('../Historia/historia_principal.pl').
:- use_module('../Models/jogador.pl').

opcao(1, Progresso) :- visualizarItensLoja(Progresso). % colocar aqui o ir pra loja
opcao(2, Progresso) :- dialogoFerreira(Progresso).
opcao(3, Progresso) :- dialogoPraca(Progresso).
opcao(4, Progresso) :- curso_historia(Progresso).

escolhaCaminhaDaCidadela(5, _) :- voltaMenu,!.

escolhaCaminhaDaCidadela(Escolha, Progresso) :-
    opcao(Escolha, Progresso),
    caminhadaCidadela(Progresso).

escolhaCaminhaDaCidadela(_, Progresso) :-
    writeln("Escreva uma opção válida.\n"),
    caminhadaCidadela(Progresso).

caminhadaCidadela(Progresso):-
    opcoesCaminhaCidadela(Progresso),
    writeln("\n------------------------------------------------------------------------------------\n"),
    lib:inputNumber("Faça sua escolha: ", Escolha),
    lib:clearScreen,
    escolhaCaminhaDaCidadela(Escolha, Progresso).


escolhaCidadela(1 , Progresso):-
    writeln("Você escolheu explorar a cidade, para onde nosso bravo web-guerreiro irá?\n"),
    caminhadaCidadela(Progresso).

escolhaCidadela(2 , Progresso):- curso_historia(Progresso).

escolhaCidadela(3 , _):- voltaMenu,!.

escolhaCidadela(_ , _):- 
    writeln("Escreva uma opção válida.\n"),
    irCidadelaDeCristal.

irCidadelaDeCristal:-
    get_progresso(Progresso),
    dialogoInicial(Progresso),
    write("------------------------------------------------------------------------------------\n"),
    lib:inputNumber("Faça sua escolha: ", Escolha),
    clearScreen,
    escolhaCidadela(Escolha, Progresso).

