/* essa estrutura de diretórios visa facilitar as consultas de prolog, para isso,
tanto Tetris quanto FMCC devem no fliperama a partir daqui. */

:- consult('Fmcc/fmcc.pl').
:- consult('Tetris/tetris.pl').

main:-
    mock_fmcc,
    nl,
    mock_tetris,
    halt.
