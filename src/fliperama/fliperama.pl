:- use_module("./actions/menu_impl.pl").
:- use_module("./services/io.pl").

% Quer adicionar seu jogo? Navegue para: ./actions/menu_impl.pl

mock_fliperama :-
    flipio:setup_menu,
    menu.
