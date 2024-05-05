/* essa estrutura de diretórios visa facilitar as consultas de prolog, para isso,
tanto Tetris quanto FMCC devem no fliperama a partir daqui. */

:- consult('../src/fliperama/fliperama.pl').

main:-
    mock_fliperama,
    halt.
