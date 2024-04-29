:- module(salvamento , [inicializa_jogador/0, inicializa_loja/0]).

:- use_module('../Models/jogador.pl').
:- use_module('../Mecanica/loja.pl').

%jogador_init(Nome,Gold,Equipamento,Pocoes,Progresso).
inicializa_jogador :- jogador_init, jogador_combate_init.

%loja_init
inicializa_loja :- setup_inicial.