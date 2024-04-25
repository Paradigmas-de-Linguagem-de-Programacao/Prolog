:- module(jogador , [jogador_init/0, get_gold/1, modifica_gold/1, adiciona_equipamento/1, adiciona_Pocao/1 , get_progresso/1,
                        altera_progresso/1, recebe_dano/1, exibe_jogador_combate/0, compra_gold/1, get_ataque_heroi/1, get_vida_heroi/1,
                        get_equipamentos/1, jogador_combate_init/0]).

:- dynamic jogador/5.
:- dynamic jogador_combate/5.

%jogador(Nome,Gold,Equipamento,Pocoes,Progresso).
jogador_init :- asserta(jogador("Heanes", 1000, [], [], 0)).

%jogador_combate(Vida,Ataque,Defesa,Pocoes,Pocoes_tomadas).
jogador_combate_init :- asserta(jogador_combate(100, 10, 5, [], 0)).

get_gold(Dinheiro) :- jogador(_,Dinheiro,_,_,_).

modifica_gold(Gold_ganho) :-
    retract(jogador(Nome, Gold_antigo, Equipamentos, Pocoes, Progresso)),
    Gold_atual is Gold_ganho + Gold_antigo,
    asserta(jogador(Nome, Gold_atual, Equipamentos, Pocoes, Progresso)).

compra_gold(Gold_preco) :-
    retract(jogador(Nome, Gold_antigo, Equipamentos, Pocoes, Progresso)),
    Gold_atual is Gold_antigo - Gold_preco,
    asserta(jogador(Nome, Gold_atual, Equipamentos, Pocoes, Progresso)).

get_equipamentos(Equips) :- jogador(_,_, Equips,_,_).

adiciona_equipamento(Equipamento_novo):-
    retract(jogador(Nome, Gold, Equipamentos_antigo, Pocoes, Progresso)),
    append([Equipamento_novo], Equipamentos_antigo, Equipamentos),
    asserta(jogador(Nome, Gold, Equipamentos, Pocoes, Progresso)).

get_pocoes(Poisson) :- jogador(_,_,_,Poisson,_).

adiciona_Pocao(Pocao_nova) :-
    retract(jogador(Nome, Gold, Equipamentos, Pocoes_antiga, Progresso)),
    append([Pocao_nova], Pocoes_antiga, Pocoes),
    asserta(jogador(Nome, Gold, Equipamentos, Pocoes, Progresso)).

get_progresso(Progresso) :- jogador(_,_,_,_,Progresso).

altera_progresso(Progresso_novo) :-
    retract(jogador(Nome, Gold, Equipamentos, Pocoes, _)),
    asserta(jogador(Nome, Gold, Equipamentos, Pocoes, Progresso_novo)).

get_vida_heroi(Hp) :- jogador_combate(Hp,_,_,_,_).

recebe_dano(Ataque_Inimigo) :-
    retract(jogador_combate(Hp_antigo, Ataque, Defesa, Potions, Pocoes_Tomadas)),
    Dano_sofrido is Ataque_Inimigo - Defesa,
    Hp_atual is max(Hp_antigo - Dano_sofrido, 0),
    asserta(jogador_combate(Hp_atual, Ataque, Defesa, Potions, Pocoes_Tomadas)).

get_ataque_heroi(Ataq) :- jogador_combate(_,Ataq,_,_,_).

set_ataque(Ataq_ganho) :-
    retract(jogador_combate(Hp_antigo, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_antiga)),
    Ataq_atual is Ataque_antigo + Ataq_ganho,
    asserta(jogador_combate(Hp_antigo, Ataq_atual, Defesa_antiga, Potions_antiga, Tomadas_antiga)).

get_defesa(Def) :- jogador_combate(_,_,Def,_,_).

set_defesa(Def_ganha) :-
    retract(jogador_combate(Hp_antigo, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_antiga)),
    Def_atual is Defesa_antiga + Def_ganha,
    asserta(jogador_combate(Hp_antigo, Ataque_antigo, Def_atual, Potions_antiga, Tomadas_antiga)).

get_pocoes_combate(Potions) :- jogador_combate(_,_,_,Potions,_).

get_pocoes_tomadas(Tomadas) :- jogador_combate(_,_,_,_,Tomadas).

set_pocoes_tomadas :-
    retract(jogador_combate(Hp_antigo, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_antiga)),
    Tomadas_atual is Tomadas_antiga + 1,
    asserta(jogador_combate(Hp_antigo, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_atual)).

formata_jogador(Nome, Gold, Equipamentos, Pocoes, Progresso, String) :-
    format(atom(String), " ~w | Gold: ~d \n Equipamentos: ~q \n Pocoes: ~q \n Progresso: ~d\n", [Nome, Gold, Equipamentos, Pocoes, Progresso]).

formata_jogador_combate(Vida, Ataque, Defesa, Pocoes, Qtde_pocoes_tomadas, String) :-
    format(atom(String), " Vida: ~d | Ataque: ~d | Defesa: ~d \n Pocoes: ~q \n Pocoes Consumidas: ~d\n", [Vida, Ataque, Defesa, Pocoes, Qtde_pocoes_tomadas]).

exibe_jogador :- 
    jogador(Nome, Gold, Equipamentos, Pocoes, Progresso),
    formata_jogador(Nome, Gold, Equipamentos, Pocoes, Progresso, String_resultado),
    write(String_resultado).

exibe_jogador_combate :-
    jogador_combate(Vida, Ataque, Defesa, Pocoes, Qtde_pocoes_tomadas),
    formata_jogador_combate(Vida, Ataque, Defesa, Pocoes, Qtde_pocoes_tomadas, String_resultado),
    write(String_resultado).
