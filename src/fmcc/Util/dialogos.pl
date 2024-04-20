:- module(dialogos, [menuInicial/0, contaHistoria/1 , dialogoInicial/1 ,
                    opcoesCaminhaCidadela/1, menu_historia_principal/0 , dialogoFerreira/1, voltaMenu/0]).

:- use_module('./lib.pl').

slogan:-
    string_concat(            "----------------------------------------------------------------------------------","\n",Slogan_str1),
    string_concat(Slogan_str1," ███████████       ██           ███         ██████████         ██████████       | \n",Slogan_str2),
    string_concat(Slogan_str2," ███               ████        ████        ███                ███               | \n",Slogan_str3), 
    string_concat(Slogan_str3," ███               ██ ██      ██ ██        ███                ███               |\n",Slogan_str4),
    string_concat(Slogan_str4," ██████████        ██  ██    ██  ██        ███                ███               |\n",Slogan_str5),
    string_concat(Slogan_str5," ███               ██    ██ ██   ██        ███                ███               |\n",Slogan_str6),
    string_concat(Slogan_str6," ███               ██     ███    ██         ██████████         ██████████       |\n",Slogan_str7),
    string_concat(Slogan_str7,"----------------------------------------------------------------------------------",Slogan),
    writeln(Slogan).


menuInicialOpcoes:-
    writeln('Bem-vindo a Fábulas de Magia : Cidadela de Cristal, mais conhecido como FMCC'),
    writeln('Escolha uma opção:'),
    writeln('1 - Começar o jogo'),
    writeln('2 - Carregar o jogo'),
    writeln('3 - Ajuda'),
    writeln('4 - Sair').

menuInicial:-
    slogan,
    menuInicialOpcoes.

contaHistoria([]).

contaHistoria([Frase|RestoHistoria]):-
    printString(Frase),
    contaHistoria(RestoHistoria).

dialogoInicial(1):-
    writeln("O que você deseja fazer??\n\n(1) Explorar a cidade.\n(2) Seguir Carl Wilson.\n(3) Voltar ao menu\n").

dialogoInicial(2):-
    writeln("Após a luta de ontem você desperta, mas vê que ainda são 6h da manhã O que você deseja fazer??\n\n(1) Explorar a cidade pela manhã.\n(2) Descansar mais um pouco\n(3) Voltar ao menu\n").

dialogoInicial(3):-
    writeln("Após descansar por 2 dias nosso heroi acorda e vê que é segunda denovo, parece que nem em outro mundo você se livra disso, enfim o que deseja fazer??\n\n(1) Explorar a cidade em uma segunda infernal.\n(2) Dar uma procrastinada\n(3) Voltar ao menu").

opcoesCaminhaCidadela(1):-
    maplist(writeln , ["(1) Voltar a loja do ferreiro Ferreira para *ver* os itens disponíveis.", 
                       "(2) Conversar com o Ferreira.", 
                       "(3) Ir à praça da cidade.",
                       "(4) Seguir Carl Wilson.",
                       "(5) Voltar ao menu"]).

opcoesCaminhaCidadela(2):-
    maplist(writeln , ["(1) Voltar a loja do ferreiro Ferreira para *ver* os itens disponíveis.", 
                       "(2) Conversar com o Ferreira.", 
                       "(3) Ir à praça da cidade.",
                       "(4) Ir tirar um cochilo.",
                       "(5) Voltar ao menu"]).

opcoesCaminhaCidadela(3):-
    maplist(writeln , ["(1) Voltar a loja do ferreiro Ferreira para *ver* os itens disponíveis.", 
                       "(2) Conversar com o Ferreira.", 
                       "(3) Ir à praça da cidade.",
                       "(4) Procrastinar um pouco.",
                       "(5) Voltar ao menu"]).

dialogoFerreira(1):-
    writeln("Heanes: Ferreira, se eu vou salvar o mundo, por que você só não me dá os melhores itens de uma vez?\n\nFerreira: *cerra os olhos e diz* Negócios são negócios, como vou pagar o meu café que tomo em seu Élho?\n\n*Ferreira não está mais aberto a conversas, acho melhor fazer alguma outra coisa decente*\n").

dialogoFerreira(2):-
    writeln("Heanes: Ei os seus itens quebraram apos um uso? não tem nada sobre a garantia, algo como se quebrar em até 14 dias devolvemos seu dinheiro?\n\nFerreira: *arrega os olhos e diz*  Você tem a brilhante ideia de lutar contra cachorros e uma IA, por causa dos meus itens você está vivo e tem a cara de pau de falar que eles são defeituosos?\n\nHeanes: é pensando por esse lado...").

dialogoFerreira(3):-
    writeln("Heanes: Mais uma vez estou aqui sem nada, mas pelo que me disseram estou para ir enfrentar o ultimo desafio o que acha de me dar essa armadura que você está polindo?\nFerreira: *olhando com desgosto e descontentamento diz* Heroi parece que você não gosta de ser bem tratado na minha loja não é...\nHeanes: Desculpa... era apenas uma brincadeira\nHeanes sai do local parece que ferreira sabe ser cruel com as palavras.").


menu_historia_principal:-
    maplist(writeln, [
        "(1) Ganhar dinheiro","(2) Comprar poções com C.W.",
        "(3) Visitar o ferreiro Ferreira","(4) Me garanto em enfrentar a I.A.","(5) Voltar ao menu"]).

voltaMenu:- lib:printString("Então nosso heroi precisa voltar ao menu para pensar sobre a vida não é? Tudo bem mas por favor volte o mundo precisa de você\n").
