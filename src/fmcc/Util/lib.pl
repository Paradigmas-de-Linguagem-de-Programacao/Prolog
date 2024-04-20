:- module(lib, [input/2, inputNumber/2, clearScreen/0, esperandoEnter/0, printString/1]).

clearScreen :- tty_clear.

input(Text, V) :- read_pending_chars(user_input, _, _),
                  write(Text), flush_output(user),
                  read_line_to_string(user_input, V1),
                  normalize_space(atom(V) , V1).

inputNumber(Text, N) :- input(Text, Output), atom_number(Output, N).


esperandoEnter :- input("\nDigite algo para continuar: ", _), clearScreen.

printString(Texto):-
    clearScreen,
    writeln(Texto),
    esperandoEnter.
