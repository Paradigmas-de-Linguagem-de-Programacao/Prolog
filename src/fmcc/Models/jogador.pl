:- dynamyc jogador/7

jogador(
    nome(Nome),
    vida(Vida),
    gold(Gold),
    ataque(Ataque),
    defesa(Defesa),
    equipamentos(Equipamentos),
    pocoes(Pocoes)
).

jogador_inicial :- 
    asserta(jogador(nome("Heanes"), vida(100), gold(0), ataque(10), defesa(5), equipamentos([]), pocoes([]))).

atualiza_jogador(Nome, Vida, Gold, Ataque, Defesa, Equipamentos, Pocoes) :-
    retract(jogador(_,_,_,_,_,_,_)) % exclui a ultima representacao de jogador
    asserta(jogador(nome(Nome), vida(Vida), gold(Gold), ataque(Ataque), defesa(Defesa), equipamentos(Equipamentos), pocoes(Pocoes))). % adiciona uma nova representacao de jogador
