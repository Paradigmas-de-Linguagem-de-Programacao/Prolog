:- module(inimigo, [get_ataque_inimigo/2, get_habilidade_especial_inimigo/2, recebe_dano_inimigo/2, exibe_inimigo/1, verifica_inimigo_morto/1,
                    get_nome_Ia/2 , habilidade_especial_desbloqueada/1]).
:- dynamic inimigo/5.

%inimigo(Nome, ataque, defesa, vida , ataqueEspecial)
inimigo("Cachorros caramelos", 40, 5, 50, 0).
inimigo("Kanva", 55, 10, 200, 85).
inimigo("Playhub", 40, 0, 300, 85).
inimigo("ConversaGPT", 120, 30, 5000, 160).

get_ataque_inimigo(Nome, Ataque) :-
    inimigo(Nome,Ataque,_,_,_).

get_habilidade_especial_inimigo(Nome, Especial) :- inimigo(Nome,_,_,_,Especial).

recebe_dano_inimigo(Nome, Ataque_jogador) :-
    retract(inimigo(Nome, Ataque, Defesa, Vida_antiga, Especial)),
    Dano_recebido is max(5, Ataque_jogador-Defesa),
    Vida_atual is max(Vida_antiga - Dano_recebido, 0),
    asserta(inimigo(Nome, Ataque, Defesa, Vida_atual, Especial)).

verifica_inimigo_morto(Nome):- inimigo(Nome,_,_,0,_).

exibe_inimigo(Nome) :-
    inimigo(Nome, Ataque, Defesa, Vida, _),
    format("~w | Ataque: ~d | Defesa: ~d | Vida: ~d \n\n", [Nome, Ataque, Defesa, Vida]).

habilidade_especial_desbloqueada(Nome):-
    inimigo(Nome,_,_,Vida,_), Vida=<35.

get_nome_Ia(1,"Kanva").
get_nome_Ia(2, "Playhub").
get_nome_Ia(3, "ConversaGPT").