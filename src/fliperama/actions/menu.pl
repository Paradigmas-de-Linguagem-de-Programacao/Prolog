:- use_module('../data/io.pl').

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
    write("R - Registrar-se"),
    write("L - Fazer Login"),
    write("D - Deletar Conta").

print_logged_menu_options :-
    write("\n Jogos Disponíveis: "),
    write("T - Tetris"),
    write("F - FMCC"),
    write("S - Sair").

clear_screen :-
    write('\e[H\e[2J').

get_user_input(Input) :-
    write("\nDigite sua escolha: "),
    read(Input).

check_user_input_validity(Input, [Input|_]).
check_user_input_validity(Input, [_|Tail]) :-
    check_user_input_validity(String, Tail).

register_new_user :-
    write('Escolha um Username: '),
    read_line_to_string(user_input, Username),
    write('Escolha uma senha: '),
    read_line_to_string(user_input, Password),
    flipio:salvar_credenciais_de_usuario(Username, Password). % Checar se username já existe antes de cadastrar
