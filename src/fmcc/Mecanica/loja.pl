:- module(loja, [inicializa_loja/1, printa_itens/0, printa_pocao/0, abre_loja_pocao/0, abre_loja_itens/0]).
:- dynamic loja/3.
:- use_module('../Util/lib.pl').

inicializa_loja(1) :- 
    retractall(loja(_,_,_)),  
    asserta(loja(
        espada("Espada de Pedra", 30, 30, 0, "So usa espada quem nao se garante."),
        armadura("Armadura de Couro", 30, 0, 30, "Proteger nem protege muito, mas se tu ta achando ruim vai sem."),
        pocao("Café", 20, 40, 0, 0, 1))).

inicializa_loja(2) :-
    retractall(loja(_,_,_)),  
    asserta(loja(
        espada("Espada de Ferro", 100, 60, 0, "Espada um pouco enferrujada, se nao matar na espadada mata no tetano."),
        armadura("Armadura de Ferro", 100, 0, 60, "Essa daqui até que protege contra as falácias da I.A."),
        pocao("Red Bull", 60, 30, 20, 20, 1))).

inicializa_loja(3) :-
    retractall(loja(_,_,_)),
    asserta(loja(
        espada("Espada de Diamante", 160, 100, 0, "Espada do minecraft."),
        armadura("Armadura de Diamante", 160, 0, 100, "Armadura do minecraft."),
        pocao("Tyson Mentality", 300, 0, 100, 0, 1))).

printa_itens :-
    loja((espada(Nome, Preco, Ataque, Defesa, Descricao)),
        (armadura(Nome2, Preco2, Ataque2, Defesa2, Descricao2)), _),
    formata_espada(Nome, Preco, Ataque, Defesa, Descricao, String_espada),
    formata_armadura(Nome2, Preco2, Ataque2, Defesa2, Descricao2, String_armadura),
    write(String_espada), write(String_armadura).

printa_pocao :-
    loja(_, _, (pocao(Nome3, Preco3, Vida, Ataque3, Defesa3, Quantidade))),
    formata_pocao(Nome3, Preco3, Vida, Ataque3, Defesa3, Quantidade, String_Pocao),
    write(String_Pocao), nl.

get_espada(Espada) :-
    loja(Espada,_,_).

get_armadura(Armadura) :-
    loja(_,Armadura,_).

get_pocao(Pocao) :-
    loja(_,_,Pocao).

abre_loja_itens :-
    writeln("\nOlá Héroi, esse são os itens que possuo...\n"), printa_itens,
    inputNumber("E então, deseja comprar algum item?\n(1)Sim.\n(2)Não.\n\n", Escolha),
    compra_item(Escolha).

compra_item(2) :- writeln("Entendo pobre, volte ao menu com o rabo entre as pernas.").
compra_item(1) :-
    lib:input("\nDigite o nome do item que deseja comprar:\n", Input),
    (verifica_nome_item(Input, Resultado), Resultado == true -> compra_item_aux(Input); writeln("\nItem com nome incorreto, tente novamente.\n"), abre_loja_itens).
compra_item(_) :- writeln("Entendo entendo... Nosso héroi é disléxico, bem, tente novamente mais tarde.").

verifica_nome_item(Input, Resultado) :- 
    get_espada(X),
    X = espada(Nome,_,_,_,_),
    get_armadura(Y),
    Y = armadura(Nome2,_,_,_,_),
    ((Nome == Input ; Nome2 == Input)-> Resultado = true ; Resultado = false).

compra_item_aux(Input) :-
    get_espada(X),
    X = espada(Nome,_,_,_,_),
    get_armadura(Y),
    (Nome == Input -> espada_compra(X) ; armadura_compra(Y)).

espada_compra(Espada) :-
    get_gold(Gold),
    Espada = espada(_, Preco,_,_,_),
    (Gold >= Preco -> compra_gold(Preco), adiciona_equipamento(Espada), write("\nItem comprado com sucesso!!\n"), nl;
    write("Você não tem dinheiro o suficiente professor, trabalhe mais.\n"), lib:esperandoEnter).

armadura_compra(Armadura) :-
    get_gold(Gold),
    Armadura = armadura(_, Preco,_,_,_),
    (Gold >= Preco -> compra_gold(Preco), adiciona_equipamento(Armadura), write("\nItem comprado com sucesso!!\n"), nl;
    write("Você não tem dinheiro o suficiente professor, trabalhe mais.\n"), lib:esperandoEnter). 

abre_loja_pocao :-
    writeln("\nOlá Héroi, essa são as minhas recomendações de poções pra você:\n"), printa_pocao,
    inputNumber("\nE então, deseja comprar?\n(1)Sim.\n(2)Não.\n\n", Escolha),
    compra_pocao(Escolha).

compra_pocao(2) :- writeln("Entendo pobre, volte ao menu com o rabo entre as pernas.").
compra_pocao(1) :-
    lib:input("\nConfirme o nome da poção que deseja comprar:\n", Input),
    (verifica_nome_pocao(Input, Resultado), Resultado == true -> 
    (get_pocoes(Y),inventario_pocao(Y, Input, Possui_pocao), Possui_pocao == true -> get_pocoes(Potions), incrementa_pocao(Input, Potions) ; compra_pocao_aux) ;
    writeln("\nPoção com nome incorreto, tente novamente.\n"), abre_loja_pocao).
compra_pocao(_) :- writeln("Entendo entendo... Nosso héroi é disléxico, bem, tente novamente mais tarde.").

inventario_pocao([Head|Tail], Input, Possui_pocao) :- (Head = pocao(Input,_,_,_,_,_) -> Possui_pocao = true ; Possui_pocao = false, inventario_pocao(Tail, Input, Possui_pocao)).

incrementa_pocao(Input, [Head|Tail]) :-
    (Head = pocao(Input,Preco,Vida,Ataque,Defesa,Quantidade) -> 
    remove_pocao(Input), Quantidade_atual is Quantidade + 1, Pocao_att = pocao(Input,Preco,Vida,Ataque,Defesa,Quantidade_atual), adiciona_pocao(Pocao_att),
    write("\nPoção comprada com sucesso, olhe ela no seu inventário:\n") ; incrementa_pocao(Input, Tail)),
    formata_pocao(Input,Preco,Vida,Ataque,Defesa,Quantidade_atual, Resultado), nl, write(Resultado), nl.

verifica_nome_pocao(Input, Resultado) :- 
    get_pocao(X),
    X = pocao(Nome,_,_,_,_,_),
    ((Nome == Input)-> Resultado = true ; Resultado = false).

compra_pocao_aux :-
    get_pocao(Pocao),
    get_gold(Gold),
    Pocao = pocao(_,Preco,_,_,_,_),
    (Gold >= Preco -> compra_gold(Preco), adiciona_pocao(Pocao), write("\nPocao comprada com sucesso!!\n"), nl;
    write("Você não tem dinheiro o suficiente professor, trabalhe mais.\n"), lib:esperandoEnter).

equipa_item :-
    write("\nEsses são os seus equipamentos:\n\n"),
    get_equipamentos(Equipamentos), formata_equipamentos(Equipamentos, Resultado), write(Resultado), nl,
    lib:input("\nEscreva o nome do item que deseja equipar, se quiser desistir da ação digite: 'VOLTAR'.\n\n", Escolha),
    equipa_item_aux(Escolha).

formata_equipamentos([],[]).
formata_equipamentos([Head|Tail], Resultado) :- formata_equipamentos(Tail, Resultado_antigo), (Head = espada(Nome,_,Ataque,_,_) -> 
    formata_espada_possuida(Nome, Ataque, Result), append([Result], Resultado_antigo, Resultado) ;
    Head = armadura(Nome,_,_,Defesa,_) -> formata_armadura_possuida(Nome, Defesa, Result), append([Result], Resultado_antigo, Resultado)).

formata_espada_possuida(Nome, Ataque, String) :- format(atom(String), " ~w | Ataque: ~d", [Nome, Ataque]).
formata_armadura_possuida(Nome, Defesa, String) :- format(atom(String), " ~w | Defesa: ~d", [Nome, Defesa]).
formata_pocao_possuida(Nome, Vida, Ataque, Defesa, String) :- format(atom(String), " ~w | Vida: ~d | Ataque: ~d | Defesa: ~d", [Nome, Vida, Ataque, Defesa]).

equipa_item_aux("VOLTAR").
equipa_item_aux(Nome) :- (get_equipamentos(Itens), verifica_equips(Nome, Itens, Resultado), Resultado = true ->
    acha_item(Nome, Itens) ; write("Você não possui esse equipamento, assalariado.")).

verifica_equips(_,[], Resultado) :- Resultado = false.
verifica_equips(Nome, [Head|Tail], Resultado) :- ((Head = espada(Nome,_,_,_,_) ; Head = armadura(Nome,_,_,_,_)) ->
                                                 Resultado = true ;Resultado = false, verifica_equips(Nome, Tail, Resultado)).

acha_item(Nome, [Head|Tail]) :- ((Head = espada(Nome,_, Ataque, Defesa,_) ; Head = armadura(Nome,_, Ataque, Defesa,_)) ->
                                 usa_item_aux(Ataque, Defesa), remove_equipamento(Nome), write("\nItem equipado com sucesso.\n"), exibe_jogador_combate ; acha_item(Nome, Tail)).

usa_item_aux(Ataque, Defesa) :-
    set_ataque(Ataque),
    set_defesa(Defesa).

equipa_pocao :-
    write("\nEssas são suas poções disponíveis:\n\n"),
    get_pocoes(Pocoes), formata_pocoes_possuidas(Pocoes, Resultado), write(Resultado), nl,
    lib:input("\nConfirme o nome da poção que deseja tomar, se quiser desistir da ação digite: 'VOLTAR'.\n\n", Input),
    equipa_pocao_aux(Input).

formata_pocoes_possuidas([],[]).
formata_pocoes_possuidas([Head|Tail], Resultado) :- formata_pocoes_possuidas(Tail, Resultado_antigo), (Head = pocao(Nome,_,Vida,Ataque,Defesa,_) -> 
    formata_pocao_possuida(Nome, Vida, Ataque, Defesa, Result), append([Result], Resultado_antigo, Resultado)).

equipa_pocao_aux("VOLTAR").
equipa_pocao_aux(Nome) :- (get_pocoes(Pocoes), verifica_pocoes(Nome, Pocoes, Resultado), Resultado = true ->
    acha_pocao(Nome, Pocoes) ; write("Você nao possui essa poção, malandrinho.")).

verifica_pocoes(_,[], Resultado) :- Resultado = false.
verifica_pocoes(Nome, [Head|Tail], Resultado) :- (Head = pocao(Nome,_,_,_,_,_) -> Resultado = true ; verifica_equips(Nome, Tail, Resultado)).

acha_pocao(Nome, [Head|Tail]) :- (Head = pocao(Nome,Preco,Vida,Ataque,Defesa,Quantidade) ->
    (Quantidade>1 -> remove_pocao(Nome), decrementa_pocao(Nome,Preco,Vida,Ataque,Defesa,Quantidade), usa_pocao_aux(Vida, Ataque, Defesa), write("\nPoção usada com sucesso.\n") ; 
    usa_pocao_aux(Vida, Ataque, Defesa), remove_pocao(Nome), write("\nPoção usada com sucesso.\n")); acha_pocao(Nome, Tail)).

decrementa_pocao(Nome, Preco, Vida, Ataque, Defesa, Quantidade) :-
    Quantidade_atual is Quantidade - 1,
    Pocao_atualizada = pocao(Nome, Preco, Vida, Ataque, Defesa, Quantidade_atual),
    adiciona_pocao(Pocao_atualizada).

usa_pocao_aux(Vida, Ataque, Defesa) :-
    aumenta_pocao_tomada, set_vida_heroi(Vida),
    set_ataque(Ataque), set_defesa(Defesa).

formata_espada(Nome, Preco, Ataque, Defesa, Descricao, String) :-
    format(atom(String), " ~w | Preço: ~d \n Ataque: ~d | Defesa: ~d \n Descrição: ~w\n\n", [Nome, Preco, Ataque, Defesa, Descricao]).

formata_armadura(Nome, Preco, Ataque, Defesa, Descricao, String) :-
    format(atom(String), " ~w | Preço: ~d \n Ataque: ~d | Defesa: ~d \n Descrição: ~w\n\n", [Nome, Preco, Ataque, Defesa, Descricao]).

formata_pocao(Nome, Preco, Vida, Ataque, Defesa, Quantidade, String) :-
    format(atom(String), " ~w | Preço: ~d \n Vida: ~d | Ataque: ~d | Defesa: ~d \n Quantidade: ~d", [Nome, Preco, Vida, Ataque, Defesa, Quantidade]).
