:- module(flipio, [
    salvar_credenciais_de_usuario/2,
    salvar_sessao/2,
    checar_credenciais_de_usuario/2,
    get_username_from_session/1,
    get_message_from_session/1,
    atualizar_mensagem_de_sessao/1,
    reset_sessao/0,
    setup_menu/0,
    username_exists/1
]).

salvar_credenciais_de_usuario(Username, Password) :-
    atom_concat('../src/fliperama/data/jogador/', Username, Diretorio),
    make_directory(Diretorio),
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

reset_sessao :-
    open('sessoes.txt', write, Stream),
    write(Stream, ":"),
    close(Stream).

setup_menu :-
    create_file_if_not_exists('sessoes.txt'),
    create_file_if_not_exists('usuarios.txt').

create_file_if_not_exists(File) :-
    \+ exists_file(File), % Check if the file does not exist
    open(File, write, Stream), % Open the file
    close(Stream). % Close the file
create_file_if_not_exists(_).

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

get_message_from_session(Message) :-
    open('sessoes.txt', read, Stream),
    read_session_data_message_lines(Stream, LineCodes),!,
    close(Stream),
    atom_codes(LineAtom, LineCodes),
    atomic_list_concat([_ | [Message | _]], ':', LineAtom).

read_session_data_message_lines(Stream, []) :-
    at_end_of_stream(Stream).
read_session_data_message_lines(Stream, LineCodes) :-
    read_line_to_codes(Stream, LineCodes).


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

username_exists(Username) :-
    read_file_to_string('usuarios.txt', FileContent, []),
    split_string(FileContent, "\n", "", Lines), % Split file content into lines
    member(Line, Lines), % Select a line from the lines
    \+ Line = "", % Exclude empty lines
    split_string(Line, ":", "", [UsernameFound|_]), % Split line into Username and Password
    UsernameFound = Username. 