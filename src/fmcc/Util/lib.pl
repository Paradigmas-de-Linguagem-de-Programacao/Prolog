:- module(lib, [input/2, inputNumber/2, clearScreen/0, esperandoEnter/0, printString/1 , map/3, voltaMenu/0,
                formata_texto/0, replica_String/2]).

clearScreen :- tty_clear.

input(Texto, Entrada) :- read_pending_chars(user_input, _, _),
                  write(Texto), flush_output(user),
                  read_line_to_string(user_input, Entrada).

inputNumber(Text, N) :- 
    input(Text, OutputAux), 
    normalize_space(atom(Output) , OutputAux),
    (atom_number(Output, N) ->  true; N = -1),
    clearScreen.

esperandoEnter :- input("\nAperte algo para continuar: ", _), clearScreen.

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


replica_String(Palavra, 1):- write(Palavra),!.
replica_String(Palavra, Vezes_replicadas):-
    write(Palavra), 
    Replica_Vezes is Vezes_replicadas-1,
    replica_String(Palavra, Replica_Vezes).

voltaMenu:- lib:printString("Então nosso heroi precisa voltar ao menu para pensar sobre a vida não é? Tudo bem mas por favor volte o mundo precisa de você\n").

