:- use_module("./actions/menu_impl.pl").
:- use_module("./services/io.pl").

main :-
    flipio:setup_menu,
    menu.
