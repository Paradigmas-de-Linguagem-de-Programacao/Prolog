/* essa estrutura de diretórios visa facilitar as consultas de prolog, para isso,
tanto Tetris quanto FMCC devem no fliperama a partir daqui. */

:- consult('../src/fmcc/fmcc.pl').
:- consult('../src/tetris/tetris.pl').
:- consult('../src/fliperama/fliperama.pl').

main:-
    mock_fmcc,
    halt.
