:- use_module('./Util/lib.pl').
:- use_module('./Util/dialogos.pl').
:- consult('./Util/salvamento.pl').
:- consult('./Models/jogador.pl').


mock_fmcc:- 
    menu.

menu :-
    clearScreen,
    dialogos:menuInicial,
    lib:inputNumber("Sua escolha é: ", Escolha),
    menuOpcao(Escolha).

menuOpcao(1) :-
    salvamento:comeca_jogo,
    menu.

menuOpcao(2) :-
    salvamento:carrega_jogo,
    menu.

menuOpcao(3) :-
    salvamento:help,
    menu.

menuOpcao(4) :-
    writeln('Então você decidiu dar uma pausa. Tudo bem... Espero que você volte. Aqui não é o mesmo sem você.').

menuOpcao(_) :-
    writeln('Opção inválida. Por favor, escolha uma opção válida.'),
    esperandoEnter,
    menu.
