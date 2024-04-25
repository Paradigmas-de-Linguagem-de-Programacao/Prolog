:- module(salvamento , [inicializa_jogador/0]).

:- use_module('../Models/jogador.pl').

%jogador_init(Nome,Gold,Equipamento,Pocoes,Progresso).
inicializa_jogador :- jogador_init.