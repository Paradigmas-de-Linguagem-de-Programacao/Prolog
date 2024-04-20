:- module(lib, [input/2, inputNumber/2, clearScreen/0, esperandoEnter/0, printString/1 , map/3]).

clearScreen :- tty_clear.

input(Texto, Entrada) :- read_pending_chars(user_input, _, _),
                  write(Texto), flush_output(user),
                  read_line_to_string(user_input, EntradaAux),
                  normalize_space(atom(Entrada) , EntradaAux).

inputNumber(Text, N) :- 
    input(Text, Output), 
    (atom_number(Output, N) ->  true; N = -1).


esperandoEnter :- input("\nDigite algo para continuar: ", _), clearScreen.

printString(Texto):-
    clearScreen,
    writeln(Texto),
    esperandoEnter.

map(_ , [] , []).

map(Funcao, [X|Xs] , [Y|Ys]):-
    call(Funcao , X , Y),
    map(Funcao , Xs, Ys).
