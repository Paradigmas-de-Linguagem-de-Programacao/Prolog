:- module(flipio, [
    salvar_credenciais_de_usuario/2,
    salvar_sessao/2,
    checar_credenciais_de_usuario/2,
    get_username_from_session/1,
    get_mensagem_sessao/2,
    atualizar_mensagem_de_sessao/1
]).

salvar_credenciais_de_usuario(Username, Password) :-
    atomic_list_concat([Username, ':', Password], UserPass),
    open('usuarios.txt', append, Stream),
    write(Stream, UserPass),
    nl(Stream),
    close(Stream).

salvar_sessao(Username, SessionMessage) :-
    atomic_list_concat([Username, ':', SessionMessage], UserMessage),
    open('sessoes.txt', write, Stream),
    write(Stream, UserMessage),
    close(Stream).

atualizar_mensagem_de_sessao(Mensagem) :- 
    get_username_from_session(Username),
    salvar_sessao(Username, Mensagem).

checar_credenciais_de_usuario(Username, Password) :-
    open('usuarios.txt', read, Stream),
    read_lines(Stream, Lines),!,
    close(Stream),
    atomic_list_concat([Username, ':', Password], Line),
    member(Line, Lines),
    !.

get_username_from_session(Username) :-
    open('sessoes.txt', read, Stream),
    read_userdata_lines(Stream, LineCodes),!,
    close(Stream),
    atom_codes(LineAtom, LineCodes),
    atomic_list_concat([Username | _], ':', LineAtom).

read_userdata_lines(Stream, []) :-
    at_end_of_stream(Stream).
read_userdata_lines(Stream, LineCodes) :-
    read_line_to_codes(Stream, LineCodes).


get_mensagem_sessao(Username, Message) :-
    open('sessoes.txt', read, Stream),
    read_lines(Stream, Username, Message),
    close(Stream).

read_lines(Stream, Username, Message) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, LineCodes),
    atom_codes(Line, LineCodes),
    parse_line(Line, Username, Message),
    !.

read_lines(_, _, _) :-
    !,
    fail.

read_lines(Stream, []) :-
    at_end_of_stream(Stream).
read_lines(Stream, [Line|Rest]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, LineCodes),
    atom_codes(Line, LineCodes),
    read_lines(Stream, Rest).

parse_line(Line, Username, Message) :-
    atomic_list_concat([UsernameAtom, MessageAtom], ':', Line),
    atom_string(UsernameAtom, Username),
    atom_string(MessageAtom, Message).