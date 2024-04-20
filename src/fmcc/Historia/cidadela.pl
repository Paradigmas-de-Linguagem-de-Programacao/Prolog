:- module(cidadela , [irCidadelaDeCristal/0]).

:- use_module('../Util/lib.pl').

irCidadelaDeCristal:-
    writeln("O que você deseja fazer??\n\n(1) Explorar a cidade.\n(2) Seguir Carl Wilson.\n(3) Voltar ao menu"),
    lib:input("Faça sua escolha: ", Escolha),
    writeln(Escolha).


