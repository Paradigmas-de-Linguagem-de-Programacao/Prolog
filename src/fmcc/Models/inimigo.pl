:- module(inimigo, [inimigo_inicial/0, get_ataque_inimigo/1, recebe_dano_inimigo/1, get_vida_inimigo/1, 
                    exibe_inimigo/0]).
:- dynamic inimigo/5.

%inimigo(Nome, ataque, defesa, vida , ataqueEspecial)
inimigo_inicial :- 
    asserta(inimigo("Cachorros caramelos", 40, 5, 50, 0)).

inimigo_kanva :-
    retractall(inimigo(_, _, _, _, _)),
    asserta(inimigo("Kanva", 55, 10, 200, 85)).

inimigo_playhub :-
    retractall(inimigo(_, _, _, _, _)),
    asserta(inimigo("Playhub", 40, 0, 300, 85)).

inimigo_conversaGPT :-
    retractall(inimigo(_, _, _, _, _)),
    asserta(inimigo("ConversaGPT", 120, 30, 5000, 160)).

get_ataque_inimigo(Ataque) :-
    inimigo(_,Ataque,_,_,_).

get_defesa(Defesa) :-
    inimigo(_,_,Defesa,_,_).

get_vida_inimigo(Vida) :-
    inimigo(_,_,_,Vida,_).

get_habilidade_especial(Especial) :- inimigo(_,_,_,_,Especial).

recebe_dano_inimigo(Ataque_jogador) :-
    retract(inimigo(Nome, Ataque, Defesa, Vida_antiga, Especial)),
    Dano_recebido is max(5, Ataque_jogador-Defesa),
    Vida_atual is max(Vida_antiga - Dano_recebido, 0),
    asserta(inimigo(Nome, Ataque, Defesa, Vida_atual, Especial)).

formata_inimigo(Nome, Ataque, Defesa, Vida, String) :-
    format(atom(String), " ~w | Ataque: ~d | Defesa: ~d | Vida: ~d \n\n", [Nome, Ataque, Defesa, Vida]).

exibe_inimigo :-
    inimigo(Nome, Ataque, Defesa, Vida, _),
    formata_inimigo(Nome, Ataque, Defesa, Vida, String_formatada),
    write(String_formatada).
