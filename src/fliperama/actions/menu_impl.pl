:- module(menu, [ menu/0 ]).

:- use_module("./menu_actions.pl").
:- use_module("../services/io.pl").

:- consult('../src/fmcc/fmcc.pl').
:- consult('../src/tetris/main.pl').

tetris :- writeln("Abriu tetris"), menu_tetris.
fmcc :- writeln("Abriu FMCC"), mock_fmcc.

handle_user_option(Option) :- Option = "R", menu_actions:register_new_user.
handle_user_option(Option) :- Option = "L", menu_actions:autenticar_user.

handle_user_option(Option) :- Option = "T", tetris.
handle_user_option(Option) :- Option = "F", fmcc.

handle_user_option(Option) :- Option = "D", flipio:reset_sessao.
handle_user_option(Option) :- Option = "S", flipio:reset_sessao, halt.

uppercase_string(InputString, UppercaseString) :-
    atom_string(AtomInput, InputString),
    upcase_atom(AtomInput, UppercaseAtom),
    atom_string(UppercaseAtom, UppercaseString).

handle_unlogged_user :-
    menu_actions:print_unlogged_menu_options,
    get_user_input(Input),
    uppercase_string(Input, UpperCaseInput),
    (
        menu_actions:check_user_input_validity(UpperCaseInput, ["R", "L", "S"])
        -> handle_user_option(UpperCaseInput)
        ;  libio:atualizar_mensagem_de_sessao("Opção Inválida")
    ).

handle_logged_user :- 
    menu_actions:print_logged_menu_options,
    get_user_input(Input),
    uppercase_string(Input, UpperCaseInput),
    (
        menu_actions:check_user_input_validity(UpperCaseInput, ["T", "F", "S", "D"])
        -> handle_user_option(UpperCaseInput)
        ;  libio:atualizar_mensagem_de_sessao("Opção Inválida")
    ).

menu :-
    flipio:reset_sessao,
    menu("").
menu(MenuMessage) :-
    menu_actions:clear_screen,
    menu_actions:print_arte_menu,
    flipio:get_message_from_session(SessionMessage),
    (
         SessionMessage = '' 
         -> writeln(MenuMessage)
         ;  writeln(SessionMessage)
    ),
    flipio:get_username_from_session(LoggedUsername),
    (
        LoggedUsername = ''
        -> handle_unlogged_user
        ;  handle_logged_user
    ),
    menu('').