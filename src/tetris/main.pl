%:- consult('tetris.pl').
%:- consult('conquistas.pl').
%:- consult('utilitarios/estado.pl').
%:- consult('../fmcc/Util/lib.pl').

main_tetris(Diretorio) :-
    %atom_concat(Diretorio, '/conquistas_tetris.json', Arquivo),
    %create_caminho_diretorio(Arquivo),
    writeln('Bem vindo ao Tetris se for novato, ou bem vindo de volta se for um conhecido!').
    %menu_tetris.

menu_tetris :-
    tty_clear,
    writeln('Escolha entre: '),
    writeln('1- Jogar '),
    writeln('2- Ver suas conquistas '),
    writeln('3 - Voltar ao fliperma'),
    inputNumber('', N),
    escolha(N).

escolha(1) :- mock_tetris, menu_tetris, !.

escolha(2) :- tela_conquista, menu_tetris, !.

escolha(3) :- writeln('Obrigado pela visita!'), !.

escolha(_) :- writeln('Opção incorreta!'), menu_tetris, !.