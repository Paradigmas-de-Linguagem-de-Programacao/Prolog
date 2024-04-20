:- use_module('./Util/lib.pl').
:- use_module('./Util/dialogos.pl').
:- use_module('./Historia/prologo.pl').

mock_fmcc:- 
    % função que vai pegar o jogador do banco de dados
    menu.

menu :-
    clearScreen,
    dialogos:menuInicial,
    lib:input("Sua escolha é: ", Escolha),
    menuOpcao(Escolha).

menuOpcao('1') :-
    prologo:comecaJogo,
    menu.

menuOpcao('2') :-
    % vai ser a funçao de carregaJogo,
    esperandoEnter,
    menu.

menuOpcao('3') :-
    % help,
    esperandoEnter,
    menu.

menuOpcao('4') :-
    writeln('Então você decidiu dar uma pausa. Tudo bem... Espero que você volte. Aqui não é o mesmo sem você.').

menuOpcao(_) :-
    writeln('Opção inválida. Por favor, escolha uma opção válida.'),
    esperandoEnter,
    menu.
