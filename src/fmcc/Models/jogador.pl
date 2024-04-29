:- module(jogador , [jogador_init/0, get_gold/1, modifica_gold/1, adiciona_equipamento/1, adiciona_pocao/1 , get_progresso/1,
                        altera_progresso/1, recebe_dano/1, exibe_jogador_combate/0, compra_gold/1, get_ataque_heroi/1, get_vida_heroi/1,
                        get_equipamentos/1, jogador_combate_init/0, set_ataque/1, set_defesa/1, remove_equipamento/1, remove_pocao/1,
                        get_pocoes/1, set_vida_heroi/1, aumenta_pocao_tomada/0, verifica_heroi_morto/0 , verifica_pocoes_tomadas/0]).

:- dynamic jogador/5.
:- dynamic jogador_combate/5.

%jogador(Nome,Gold,Equipamento,Pocoes,Progresso).
jogador_init :- asserta(jogador("Heanes", 1000, [], [], 0)).

%jogador_combate(Vida,Ataque,Defesa,Pocoes,Pocoes_tomadas).
jogador_combate_init :- asserta(jogador_combate(100, 150, 5, [], 0)).

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

remove_equipamento(Nome_item) :-
    retract(jogador(Nome, Gold_antigo, Equips, Pocoes, Progresso)),
    exclui_equipamento(Nome_item, Equips, Equips_atualizada),
    asserta(jogador(Nome, Gold_antigo, Equips_atualizada, Pocoes, Progresso)).

exclui_equipamento(_, [], _).
exclui_equipamento(Nome_item, [Head|Tail], Equips_atualizada) :- ((Head = espada(Nome_item,_,_,_,_) ; Head = armadura(Nome_item,_,_,_,_))
                -> exclui_equipamento(Nome_item, Tail, Equips_atualizada) ; append([Head], Equips_atualizada, Equips_resultado), exclui_equipamento(Nome_item, Tail, Equips_resultado)).

get_pocoes(Poisson) :- jogador(_,_,_,Poisson,_).

remove_pocao(Nome_item) :-
    retract(jogador(Nome, Gold_antigo, Equips, Pocoes, Progresso)),
    exclui_pocao(Nome_item, Pocoes, Pocoes_atualizada),
    asserta(jogador(Nome, Gold_antigo, Equips, Pocoes_atualizada, Progresso)).

exclui_pocao(_, [], _).
exclui_pocao(Nome_item, [Head|Tail], Pocoes_atualizada) :- (Head = pocao(Nome_item,_,_,_,_,_)
                -> exclui_pocao(Nome_item, Tail, Pocoes_atualizada) ; append([Head], Pocoes_atualizada, Pocoes_resultado), exclui_pocao(Nome_item, Tail, Pocoes_resultado)).

adiciona_pocao(Pocao_nova) :-
    retract(jogador(Nome, Gold, Equipamentos, Pocoes_antiga, Progresso)),
    append([Pocao_nova], Pocoes_antiga, Pocoes),
    asserta(jogador(Nome, Gold, Equipamentos, Pocoes, Progresso)).

get_progresso(Progresso) :- jogador(_,_,_,_,Progresso).

altera_progresso(Progresso_novo) :-
    retract(jogador(Nome, Gold, Equipamentos, Pocoes, _)),
    asserta(jogador(Nome, Gold, Equipamentos, Pocoes, Progresso_novo)).

get_vida_heroi(Hp) :- jogador_combate(Hp,_,_,_,_).

set_vida_heroi(Hp) :-
    retract(jogador_combate(Hp_antigo, Ataque, Defesa, Potions, Pocoes_Tomadas)),
    Hp_atual is Hp_antigo + Hp,
    asserta(jogador_combate(Hp_atual, Ataque, Defesa, Potions, Pocoes_Tomadas)).

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

get_pocoes_combate(Potions) :- jogador(_,_,_,Potions,_).

get_pocoes_tomadas(Tomadas) :- jogador_combate(_,_,_,_,Tomadas).

aumenta_pocao_tomada :-
    retract(jogador_combate(Hp_antigo, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_antiga)),
    Tomadas_atual is Tomadas_antiga + 1,
    asserta(jogador_combate(Hp_antigo, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_atual)).

verifica_heroi_morto:- jogador_combate(0, _, _,_ ,_).

verifica_pocoes_tomadas:- jogador_combate(_, _, _,_ ,6).

exibe_jogador_combate :-
    jogador_combate(Vida, Ataque, Defesa,_, Qtde_pocoes_tomadas),
    format("Vida: ~d | Ataque: ~d | Defesa: ~d \nPocoes Consumidas: ~d\n", [Vida, Ataque, Defesa, Qtde_pocoes_tomadas]).