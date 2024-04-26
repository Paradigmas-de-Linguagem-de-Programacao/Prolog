
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
    write("\nOpções: ")
    write("R - Registrar-se")
    write("L - Fazer Login")
    write("D - Deletar Conta")
    write("\nDigite sua escolha: ").

print_logged_menu_options :-
    write("\n Jogos Disponíveis: ")
    write("T - Tetris")
    write("F - FMCC")
    write("S - Sair")
    write("\nDigite sua escolha: ").

clear_screen :-
    write('\e[H\e[2J').