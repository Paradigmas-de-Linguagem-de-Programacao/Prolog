:- use_module('./Util/lib.pl').
:- use_module('./Util/dialogos.pl').
:- use_module('./Util/salvamento.pl').
:- use_module('./Models/jogador.pl').

mock_fmcc(Diretorio):-
    salvamento:cria_caminho_jogador(Diretorio),
    salvamento:cria_caminho_conquista(Diretorio),
    salvamento:carrega_conquista,
    menu_fmcc.

menu_fmcc :-
    clearScreen,
    dialogos:menuInicial,
    lib:inputNumber("Sua escolha é: ", Escolha),
    menuOpcao(Escolha).

menuOpcao(1) :-
    salvamento:comeca_jogo_fmcc,
    menu_fmcc.

menuOpcao(2) :-
    salvamento:carrega_jogo,
    menu_fmcc.

menuOpcao(3) :-
    salvamento:help,
    menu_fmcc.

menuOpcao(4):-
    mostra_conquista,
    esperandoEnter,
    menu_fmcc.

menuOpcao(5) :-
    writeln('Então você decidiu dar uma pausa. Tudo bem... Espero que você volte. Aqui não é o mesmo sem você.').

menuOpcao(_) :-
    writeln('Opção inválida. Por favor, escolha uma opção válida.'),
    esperandoEnter,
    menu_fmcc.
