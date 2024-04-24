salvar_credenciais_de_usuario(Username, Password) :-
    atomic_list_concat([Username, ':', Password], UserPass),
    open('usuarios.txt', append, Stream),
    write(Stream, UserPass),
    nl(Stream),
    close(Stream).

salvar_sessao(Username, SessionMessage) :-
    atomic_list_concat([Username, ':', SessionMessage], UserMessage),
    open('sessoes.txt', append, Stream),
    write(Stream, UserMessage),
    nl(Stream),
    close(Stream).

get_message(Username, Message) :-
    open('sessoes.txt', read, Stream), % Open the file for reading
    read_lines(Stream, Lines), % Read all lines from the file
    close(Stream), % Close the file stream
    member(Line, Lines), % Check if the line is a member of Lines
    atomic_list_concat([Username, ':', Message], Line). 

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