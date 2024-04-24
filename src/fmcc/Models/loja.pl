:- dynamic loja/3.

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

printa_loja :-
    loja((espada(Nome, Preco, Ataque, Defesa, Descricao)),
        (armadura(Nome2, Preco2, Ataque2, Defesa2, Descricao2)),
        (pocao(Nome3, Preco3, Vida, Ataque3, Defesa3, Quantidade))),
    formata_espada(Nome, Preco, Ataque, Defesa, Descricao, String_espada),
    formata_armadura(Nome2, Preco2, Ataque2, Defesa2, Descricao2, String_armadura),
    formata_pocao(Nome3, Preco3, Vida, Ataque3, Defesa3, Quantidade, String_Pocao),
    write(String_espada), write(String_armadura), write(String_Pocao).

formata_espada(Nome, Preco, Ataque, Defesa, Descricao, String) :-
    format(atom(String), " ~w | Preço: ~d \n Ataque: ~d | Defesa: ~d \n Descrição: ~w\n\n", [Nome, Preco, Ataque, Defesa, Descricao]).

formata_armadura(Nome, Preco, Ataque, Defesa, Descricao, String) :-
    format(atom(String), " ~w | Preço: ~d \n Ataque: ~d | Defesa: ~d \n Descrição: ~w\n\n", [Nome, Preco, Ataque, Defesa, Descricao]).

formata_pocao(Nome, Preco, Vida, Ataque, Defesa, Quantidade, String) :-
    format(atom(String), " ~w | Preço: ~d \n Vida: ~d | Ataque: ~d | Defesa: ~d \n Quantidade: ~d", [Nome, Preco, Vida, Ataque, Defesa, Quantidade]).

