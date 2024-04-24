:- dynamic inimigo/5.

inimigo_inicial :- 
    asserta(inimigo("Cachorros caramelos", 40, 5, 50, 0)).

inimigo_kanva :-
    retract(inimigo("Cachorros caramelos", 40, 5, 50, 0)),
    asserta(inimigo("Kanva", 55, 10, 200, 85)).

inimigo_playhub :-
    retract(inimigo("Kanva", 55, 10, 200, 75)),
    asserta(inimigo("Playhub", 40, 0, 300, 85)).

inimigo_conversaGPT :-
    retract(inimigo("Playhub", 40, 0, 300, 85)),
    asserta(inimigo("ConversaGPT", 120, 30, 5000, 160)).

get_ataque(Ataque) :-
    inimigo(_,Ataque,_,_,_).

get_defesa(Defesa) :-
    inimigo(_,_,Defesa,_,_).

get_vida(Vida) :-
    inimigo(_,_,_,Vida,_).

set_vida(Dano_recebido) :-
    retract(inimigo(Nome_antigo, Ataque_antigo, Defesa_antiga,Vida_antiga, Especial_antigo)),
    Vida_atual is Vida_antiga - Dano_recebido,
    asserta(inimigo(Nome_antigo, Ataque_antigo, Defesa_antiga,Vida_atual, Especial_antigo)).

get_habilidade_especial(Especial) :-
    inimigo(_,_,_,_,Especial).

formata_inimigo(Nome, Ataque, Defesa, Vida, String) :-
    format(atom(String), " ~w | Ataque: ~d | Defesa: ~d | Vida: ~d \n\n", [Nome, Ataque, Defesa, Vida]).

exibe_inimigo :-
    inimigo(Nome, Ataque, Defesa, Vida, _),
    formata_inimigo(Nome, Ataque, Defesa, Vida, String_formatada),
    write(String_formatada).
