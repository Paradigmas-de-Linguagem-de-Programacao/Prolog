:- dynamic jogador/5.
:- dynamic jogador_combate/5.

jogador_inicial :- 
    asserta(jogador("Heanes", 0, [], [], 0)).

jogador_combate_inicial :- 
    asserta(jogador_combate(100, 10, 5, [], 0)).

get_gold(Dinheiro) :- 
    jogador(_,Dinheiro,_,_,_).

set_gold(Gold_ganho) :-
    retract(jogador(Nome_antigo, Gold_antigo, Equipamentos_antigo, Pocoes_antiga, Progresso)),
    Gold_atual is Gold_ganho + Gold_antigo,
    asserta(jogador(Nome_antigo, Gold_atual, Equipamentos_antigo, Pocoes_antiga, Progresso)).

get_equipamentos(Equips) :-
    jogador(_,_, Equips,_,_).

set_equipamentos(Equipamento_novo):-
    retract(jogador(Nome_antigo, Gold_antigo, Equipamentos_antigo, Pocoes_antiga, Progresso)),
    append([Equipamento_novo], Equipamentos_antigo, Resultado),
    asserta(jogador(Nome_antigo, Gold_antigo, Resultado, Pocoes_antiga, Progresso)).

get_pocoes(Poisson) :- 
    jogador(_,_,_,Poisson,_).

set_pocoes(Pocao_nova) :-
    retract(jogador(Nome_antigo, Gold_antigo, Equipamentos_antigo, Pocoes_antiga, Progresso)),
    append([Pocao_nova], Pocoes_antiga, Result),
    asserta(jogador(Nome_antigo, Gold_antigo, Equipamentos_antigo, Result, Progresso)).

get_progresso(Prog) :- 
    jogador(_,_,_,_,Prog).

set_progresso(Prog_novo) :-
    retract(jogador(Nome_antigo, Gold_antigo, Equipamentos_antigo, Pocoes_antiga, _)),
    asserta(jogador(Nome_antigo, Gold_antigo, Equipamentos_antigo, Pocoes_antiga, Prog_novo)).

get_vida(Hp) :- 
    jogador_combate(Hp,_,_,_,_).

set_vida(Dano_sofrido) :-
    retract(jogador(Hp_antigo, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_antiga)),
    Hp_atual is Hp_antigo - Dano_sofrido,
    asserta(jogador(Hp_atual, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_antiga)).

get_ataque(Ataq) :- 
    jogador_combate(_,Ataq,_,_,_).

set_ataque(Ataq_ganho) :-
    retract(jogador_combate(Hp_antigo, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_antiga)),
    Ataq_atual is Ataque_antigo + Ataq_ganho,
    asserta(jogador_combate(Hp_antigo, Ataq_atual, Defesa_antiga, Potions_antiga, Tomadas_antiga)).

get_defesa(Def) :- jogador_combate(_,_,Def,_,_).

set_defesa(Def_ganha) :-
    retract(jogador_combate(Hp_antigo, Ataque_antigo, Defesa_antiga, Potions_antiga, Tomadas_antiga)),
    Def_atual is Defesa_antiga + Def_ganha,
    asserta(jogador_combate(Hp_antigo, Ataque_antigo, Def_atual, Potions_antiga, Tomadas_antiga)).

get_pocoes_combate(Potions) :- 
    jogador_combate(_,_,_,Potions,_).

get_pocoes_tomadas(Tomadas) :- 
    jogador_combate(_,_,_,_,Tomadas).

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
