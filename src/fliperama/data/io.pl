salvar_credenciais_de_usuario(Username, Password) :-
    atomic_list_concat([Username, ':', Password], UserPass),
    open('usuarios.txt', append, Stream),
    write(Stream, UserPass),
    nl(Stream),
    close(Stream).

% Predicate to check if credentials are present in the file
checar_credenciais_de_usuario(Username, Password) :-
    open('usuarios.txt', read, Stream),
    read_lines(Stream, Lines),!,
    close(Stream),
    atomic_list_concat([Username, ':', Password], Line),
    member(Line, Lines),
    !.

read_lines(Stream, []) :-
    at_end_of_stream(Stream).
read_lines(Stream, [Line|Rest]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, LineCodes),
    atom_codes(Line, LineCodes),
    read_lines(Stream, Rest).