:- module(menu_actions, [
    print_arte_menu/0,
    print_unlogged_menu_options/0,
    print_logged_menu_options/0,
    clear_screen/0,
    get_user_input/1,
    check_user_input_validity/2,
    register_new_user/0,
    autenticar_user/0
]).

:- use_module('../services/io.pl').

print_arte_menu :-
    write(" ____    _       ____                                            \n"),
    write("\\|  _ \\  | |     |  _ \\                                           \n"),
    write("\\| |_) | | |     | |_) |                                          \n"),
    write("\\|  __/  | |___  |  __/                                           \n"),
    write("\\|_|___  |_____| |_|                                              \n"),
    write("\\|  ___| | | (_)  _ __     ___   _ __    __ _   _ __ ___     __ _ \n"),
    write("\\| |_    | | | | | '_ \\   / _ \\ | '__|  / _` | | '_ ` _ \\   / _` |\n"),
    write("\\|  _|   | | | | | |_) | |  __/ | |    | (_| | | | | | | | | (_| |\n"),
    write("\\|_|     |_| |_| | .__/  \\___|  |_|     \\__,_| |_| |_| |_|  \\__,_|\n"),
    write("\\                |_|  \\/  |   ___   _ __    _   _                 \n"),
    write("\\                  | |\\/| |  / _ \\ | '_ \\  | | | |                \n"),
    write("\\                  | |  | | |  __/ | | | | | |_| |                \n"),
    write("\\                  |_|  |_|  \\___| |_| |_|  \\__,_|                ").


print_unlogged_menu_options :-
    write("\nOpções: "),
    write("\nR - Registrar-se"),
    write("\nL - Fazer Login").

print_logged_menu_options :-
    write("\n Jogos Disponíveis: "),
    write("\nT - Tetris"),
    write("\nF - FMCC"),
    write("\nS - Sair").

clear_screen :-
    write('\e[H\e[2J').

get_user_input(Input) :-
    write("\nDigite sua escolha: "),
    read_line_to_string(user_input, Input).

check_user_input_validity(Input, [Input|_]).
check_user_input_validity(Input, [_|Tail]) :-
    check_user_input_validity(Input, Tail).

register_new_user :-
    write('Escolha um Username: '),
    read_line_to_string(user_input, Username),
    write('Escolha uma senha: '),
    read_line_to_string(user_input, Password),
    flipio:salvar_credenciais_de_usuario(Username, Password),
    flipio:atualizar_mensagem_de_sessao("Usuário cadastrado com sucesso!"). % Checar se username já existe antes de cadastrar

autenticar_user :- 
    write('Username: '),
    read_line_to_string(user_input, Username),
    write('Password: '),
    read_line_to_string(user_input, Password),
    (
        flipio:checar_credenciais_de_usuario(Username, Password)
        -> flipio:salvar_sessao(Username, "Bem Vindo!")
        ; flipio:atualizar_mensagem_de_sessao("Username ou senha inválidos")
    ).
