:- use_module("./menu_actions.pl").
:- use_module("../services/io.pl").

uppercase_string(InputString, UppercaseString) :-
    atom_string(AtomInput, InputString), % Convert input string to atom
    upcase_atom(AtomInput, UppercaseAtom), % Convert atom to uppercase atom
    atom_string(UppercaseAtom, UppercaseString). % Convert uppercase atom to string

handle_unlogged_user :-
    menu_actions:print_unlogged_menu_options,
    get_user_input(Input),
    uppercase_string(Input, UpperCaseInput),
    (
        check_user_input_validity(UpperCaseInput, ["R", "L"]) = true ->
        handle_user_option(UpperCaseInput)
        ; libio:atualizar_mensagem_de_sessao("Opção Inválida")
    ).

handle_user_option(Option) :- Option = "R", menu_actions:register_new_user.
handle_user_option(Option) :- Option = "L", menu_actions:autenticar_user.

menu(MenuMessage) :-
    menu_actions:clear_screen,
    menu_actions:print_arte_menu,
    flipio:get_username_from_session(LoggedUsername),
    (
        flipio:get_mensagem_sessao(LoggedUsername, Message) = false ->
        writeln(MenuMessage)
        ; writeln(Message)
    ),
    (
        LoggedUsername = ''
        -> handle_unlogged_user
        ; menu_actions:print_logged_menu_options
    ),
    menu("").