:- module(cidadela , [irCidadelaDeCristal/0]).

:- use_module('../Util/lib.pl').

opcao(1, Progresso) :- visualizarItensLoja(Progresso). % colocar aqui o ir pra loja
opcao(2, Progresso) :- dialogoFerreira(Progresso).
opcao(3, Progresso) :- dialogoPraca(Progresso).
opcao(4, Progresso) :- cursoHistoria(Progresso).

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

escolhaCidadela(2 , Progresso):-
    writeln("O que deseja fazer agora que está de volta a cidade?\n"),
    menu_historia_principal,
    lib:inputNumber("Faça sua escolha: ", Escolha).

irCidadelaDeCristal:-
    % getProgresso que iria ditar qual fase e qual mensagem ia aparecer
    Progresso = 3,
    dialogoInicial(Progresso),
    lib:inputNumber("Faça sua escolha: ", Escolha),
    escolhaCidadela(Escolha, Progresso).