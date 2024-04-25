:- module(lib, [input/2, inputNumber/2, clearScreen/0, esperandoEnter/0, printString/1 , map/3, voltaMenu/0, formata_texto/0]).

clearScreen :- tty_clear.

input(Texto, Entrada) :- read_pending_chars(user_input, _, _),
                  write(Texto), flush_output(user),
                  read_line_to_string(user_input, EntradaAux),
                  normalize_space(atom(Entrada) , EntradaAux).

inputNumber(Text, N) :- 
    input(Text, Output), 
    (atom_number(Output, N) ->  true; N = -1),
    clearScreen.


esperandoEnter :- input("\nDigite algo para continuar: ", _), clearScreen.

printString(Texto):-
    clearScreen,
    writeln(Texto),
    write("------------------------------------------------------------------------------------\n"),
    esperandoEnter.

formata_texto:-
    write("\n------------------------------------------------------------------------------------\n"),
    esperandoEnter.

map(_ , [] , []).

map(Funcao, [X|Xs] , [Y|Ys]):-
    call(Funcao , X , Y),
    map(Funcao , Xs, Ys).

voltaMenu:- lib:printString("Então nosso heroi precisa voltar ao menu para pensar sobre a vida não é? Tudo bem mas por favor volte o mundo precisa de você\n").

