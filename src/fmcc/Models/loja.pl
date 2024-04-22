:- dynamic loja/3.

loja(
    espada(Espada),
    armadura(Armadura),
    pocao(Pocao)
).

espada(nome(Nome), preco(Preco), ataque(Ataque), defesa(Defesa), descricao(Descricao)).
armadura(nome(Nome), preco(Preco), ataque(Ataque), defesa(Defesa), descricao(Descricao)).
pocao(nome(Nome), preco(Preco),vida(Vida), ataque(Ataque), defesa(Defesa), quantidade(Quantidade)).

setup_inicial :- 

    asserta(loja(
        espada(nome("Espada de Pedra"), preco(30), ataque(30), defesa(0), descricao("So usa espada quem nao se garante.")),
        armadura(nome("Armadura de Couro"), preco(30), ataque(0), defesa(30), descricao("Proteger nem protege muito, mas se tu ta achando ruim vai sem!!")),
        pocao(nome("Café"), preco(20), vida(40), ataque(0), defesa(0), quantidade(1)))).

atualiza_loja :-

    retract(loja(
        espada(nome("Espada de Pedra"), preco(30), ataque(30), defesa(0), descricao("So usa espada quem nao se garante.")),
        armadura(nome("Armadura de Couro"), preco(30), ataque(0), defesa(30), descricao("Proteger nem protege muito, mas se tu ta achando ruim vai sem!!")),
        pocao(nome("Café"), preco(20), vida(40), ataque(0), defesa(0), quantidade(1)))),
    
    asserta(loja(
        espada(nome("Espada de Ferro"), preco(100), ataque(60), defesa(0), descricao("Espada um pouco enferrujada, se nao matar na espadada mata no tetano")),
        armadura(nome("Armadura de Ferro"), preco(100), ataque(0), defesa(60), descricao("Essa daqui até que protege contra as falácias da I.A.")),
        pocao(nome("Red Bull"), preco(60), vida(30), ataque(20), defesa(20), quantidade(1)))).

loja_final :-

    retract(loja(
        espada(nome("Espada de Ferro"), preco(100), ataque(60), defesa(0), descricao("Espada um pouco enferrujada, se nao matar na espadada mata no tetano")),
        armadura(nome("Armadura de Ferro"), preco(100), ataque(0), defesa(60), descricao("Essa daqui até que protege contra as falácias da I.A.")),
        pocao(nome("Red Bull"), preco(60), vida(30), ataque(20), defesa(20), quantidade(1)))),

    asserta(loja(
        espada(nome("Espada de Diamante"), preco(160), ataque(100), defesa(0), descricao("Espada do minecraft.")),
        armadura(nome("Armadura de Diamante"), preco(160), ataque(0), defesa(100), descricao("Armadura do minecraft.")),
        pocao(nome("Tyson Mentality"), preco(300), vida(0), ataque(100), defesa(0), quantidade(1)))).

exibe_loja :-
    loja((espada(nome(Nome), preco(Preco), ataque(Ataque), defesa(Defesa), descricao(Descricao))),
        (armadura(nome(Nome2), preco(Preco2), ataque(Ataque2), defesa(Defesa2), descricao(Descricao2))),
        (pocao(nome(Nome3), preco(Preco3),vida(Vida), ataque(Ataque3), defesa(Defesa3), quantidade(Quantidade)))),
    formata_espada(Nome, Preco, Ataque, Defesa, Descricao),
    formata_armadura(Nome2, Preco2, Ataque2, Defesa2, Descricao2),
    formata_pocao(Nome3, Preco3, Vida, Ataque3, Defesa3, Quantidade).

formata_espada(Nome, Preco, Ataque, Defesa, Descricao) :-
    format(atom(String), " ~w | Preço: ~d \n Ataque: ~d | Defesa: ~d \n Descrição: ~w\n", [Nome, Preco, Ataque, Defesa, Descricao]),
    writeln(String).

formata_armadura(Nome, Preco, Ataque, Defesa, Descricao) :-
    format(atom(String), " ~w | Preço: ~d \n Ataque: ~d | Defesa: ~d \n Descrição: ~w\n", [Nome, Preco, Ataque, Defesa, Descricao]),
    writeln(String).

formata_pocao(Nome, Preco, Vida, Ataque, Defesa, Quantidade) :-
    format(atom(String), " ~w | Preço: ~d \n Vida: ~d | Ataque: ~d | Defesa: ~d \n Quantidade: ~d", [Nome, Preco, Vida, Ataque, Defesa, Quantidade]),
    writeln(String).

