:- module(loja, [setup_inicial/0, printa_itens/0, printa_pocao/0]).
:- dynamic loja/3.
:- use_module('../Util/lib.pl').
:- use_module('../Models/jogador.pl').

setup_inicial :- 

    asserta(loja(
        espada("Espada de Pedra", 30, 30, 0, "So usa espada quem nao se garante."),
        armadura("Armadura de Couro", 30, 0, 30, "Proteger nem protege muito, mas se tu ta achando ruim vai sem."),
        pocao("Café", 20, 40, 0, 0, 1))).

atualiza_loja :-

    retract(loja(
        espada("Espada de Pedra", 30, 30, 0, "So usa espada quem nao se garante."),
        armadura("Armadura de Couro", 30, 0, 30, "Proteger nem protege muito, mas se tu ta achando ruim vai sem."),
        pocao("Café", 20, 40, 0, 0, 1))),
    
    asserta(loja(
        espada("Espada de Ferro", 100, 60, 0, "Espada um pouco enferrujada, se nao matar na espadada mata no tetano."),
        armadura("Armadura de Ferro", 100, 0, 60, "Essa daqui até que protege contra as falácias da I.A."),
        pocao("Red Bull", 60, 30, 20, 20, 1))).

loja_final :-

    retract(loja(
        espada("Espada de Ferro", 100, 60, 0, "Espada um pouco enferrujada, se nao matar na espadada mata no tetano."),
        armadura("Armadura de Ferro", 100, 0, 60, "Essa daqui até que protege contra as falácias da I.A."),
        pocao("Red Bull", 60, 30, 20, 20, 1))),

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
    jogador_init,
    setup_inicial,
    writeln("\nOlá Héroi, esse são os itens que possuo...\n"), printa_itens,
    inputNumber("E então, deseja comprar algum item?\n(1)Sim.\n(2)Não.\n\n", Escolha),
    compra_item(Escolha).

compra_item(2) :- writeln("Entendo pobre, volte ao menu com o rabo entre as pernas."). %volta volta ao menu
compra_item(1) :-
    lib:input_aux("\nDigite o nome do item que deseja comprar:\n", Input),
    (verifica_nome_item(Input, Resultado), Resultado == true -> compra_item_aux(Input); writeln("\nItem com nome incorreto, tente novamente.\n"), abre_loja_itens).
compra_item(_) :- writeln("Entendo entendo... Nosso héroi é disléxico, bem, tente novamente mais tarde."). %volta pro menu

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
    write("Você não tem dinheiro o suficiente professor, trabalhe mais.\n")). %aperte enter para continuar e volta pro menu

armadura_compra(Armadura) :-
    get_gold(Gold),
    Armadura = armadura(_, Preco,_,_,_),
    (Gold >= Preco -> compra_gold(Preco), adiciona_equipamento(Armadura), write("\nItem comprado com sucesso!!\n"), nl;
    write("Você não tem dinheiro o suficiente professor, trabalhe mais.\n")). %aperte enter para continuar e volta pro menu

abre_loja_pocao :-
    writeln("\nOlá Héroi, essa são as minhas recomendações de poções pra você:\n"), printa_pocao,
    inputNumber("\nE então, deseja comprar?\n(1)Sim.\n(2)Não.\n\n", Escolha),
    compra_pocao(Escolha).

compra_pocao(2) :- writeln("Entendo pobre, volte ao menu com o rabo entre as pernas."). %volta volta ao menu
compra_pocao(1) :-
    lib:input_aux("\nConfirme o nome da poção que deseja comprar:\n", Input),
    (verifica_nome_pocao(Input, Resultado), Resultado == true -> compra_pocao_aux ; writeln("\nPoção com nome incorreto, tente novamente.\n"), abre_loja_pocao).
compra_pocao(_) :- writeln("Entendo entendo... Nosso héroi é disléxico, bem, tente novamente mais tarde."). %volta pro menu

verifica_nome_pocao(Input, Resultado) :- 
    get_pocao(X),
    X = pocao(Nome,_,_,_,_,_),
    ((Nome == Input)-> Resultado = true ; Resultado = false).

compra_pocao_aux :-
    get_pocao(Pocao),
    get_gold(Gold),
    Pocao = pocao(_,Preco,_,_,_,_),
    (Gold >= Preco -> compra_gold(Preco), adiciona_pocao(Pocao), write("\nItem comprado com sucesso!!\n"), nl;
    write("Você não tem dinheiro o suficiente professor, trabalhe mais.\n")). %aperte enter para continuar e volta pro menu

formata_espada(Nome, Preco, Ataque, Defesa, Descricao, String) :-
    format(atom(String), " ~w | Preço: ~d \n Ataque: ~d | Defesa: ~d \n Descrição: ~w\n\n", [Nome, Preco, Ataque, Defesa, Descricao]).

formata_armadura(Nome, Preco, Ataque, Defesa, Descricao, String) :-
    format(atom(String), " ~w | Preço: ~d \n Ataque: ~d | Defesa: ~d \n Descrição: ~w\n\n", [Nome, Preco, Ataque, Defesa, Descricao]).

formata_pocao(Nome, Preco, Vida, Ataque, Defesa, Quantidade, String) :-
    format(atom(String), " ~w | Preço: ~d \n Vida: ~d | Ataque: ~d | Defesa: ~d \n Quantidade: ~d", [Nome, Preco, Vida, Ataque, Defesa, Quantidade]).
