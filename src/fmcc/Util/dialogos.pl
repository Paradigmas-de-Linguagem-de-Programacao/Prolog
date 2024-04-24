:- module(dialogos, [menuInicial/0, contaHistoria/1 , dialogoInicial/1 ,opcoesCaminhaCidadela/1, 
                    menu_historia_principal/0 , dialogoFerreira/1, dialogoPraca/1,
                    dialogo_historia/1]).

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
    lib:printString("Heanes: Ferreira, se eu vou salvar o mundo, por que você só não me dá os melhores itens de uma vez?\n\nFerreira: *cerra os olhos e diz* Negócios são negócios, como vou pagar o meu café que tomo em seu Élho?\n\n*Ferreira não está mais aberto a conversas, acho melhor fazer alguma outra coisa decente*\n").

dialogoFerreira(2):-
    lib:printString("Heanes: Ei os seus itens quebraram apos um uso? não tem nada sobre a garantia, algo como se quebrar em até 14 dias devolvemos seu dinheiro?\n\nFerreira: *arrega os olhos e diz*  Você tem a brilhante ideia de lutar contra cachorros e uma IA, por causa dos meus itens você está vivo e tem a cara de pau de falar que eles são defeituosos?\n\nHeanes: é pensando por esse lado...").

dialogoFerreira(3):-
    lib:printString("Heanes: Mais uma vez estou aqui sem nada, mas pelo que me disseram estou para ir enfrentar o ultimo desafio o que acha de me dar essa armadura que você está polindo?\nFerreira: *olhando com desgosto e descontentamento diz* Heroi parece que você não gosta de ser bem tratado na minha loja não é...\nHeanes: Desculpa... era apenas uma brincadeira\nHeanes sai do local parece que ferreira sabe ser cruel com as palavras.").

dialogoPraca(1):-
    lib:printString("\n*Você encontra a Panificadora Alfa no caminho e decide conversar com o padeiro...*\n\nPadeiro: HoHoHo, Nos encontramos mais uma vez héroi a quanto tempo.\n\nHeanes: O que quer dizer com isso??\nPadeiro: Então você não se lembra não é, tudo bem no fim da sua jornada eu lhe explicarei mas tome cuidado जादूगर पर भरोसा मत करो...\n\n*Misterioresamente o homem que estava lá, desaparece aos olhos do professor.*\n\n*O professor sente um déjà vu decide ignorar isso por enquanto. Por enquanto...*").

dialogoPraca(2):-
    lib:printString("Leandro: Meu amigo, graças a você eu não vejo mais por aí aquelas imagens que cheira a plástico rodeando o museu muito obrigado\nHeanes: de nada meu amigo fico feliz em ajudar\nLeandro: Palavras não são o bastante para expressar minha felicidade venha a mim qualquer dia vou pintar você e colocar o nome de mano liso, será minha obra de arte\nHeanes: Isso não demoraria muito tempo pra ficando parado para você me pintar tenho que salvar o mundo\nLeandro: A arte sempre vem em primeiro lugar.").

dialogoPraca(3):-
    lib:printString("Professor G: Heanes, meu heroi graças a você não preciso mais corrigir trabalhos errados por quê as crianças optaram por usar a IA, não gostaria de entrar e tomar uma xicara de café?\nWendell carneiro: Perai G, Heanes é ocupado, após ele derrotar todas as IA faça esse pedido, enfim obrigado Heanes graças a você aquela voz irritante sumiu\nHeanes: de nada é meu trabalho, após terminar tudo irei tomar um cafezinho e wendell tem certeza que não nos conhecemos sua voz é familiar?\nWendell: coincidência meu amigo coincidência.").

dialogo_historia(1):-
    lib:printString("C.W.: Olá Heanes, agora vou lhe explicar como você conseguirá enfrentar seus desafios.\nBasicamente, quando você entrar em combate, terá opções variadas que se escolhidas corretamente quando combinadas com seus atributos básicos, podem derrotar o seu inimigo.\n\nHeanes: Entendi essa parte, mas como vou saber meus atributos básicos?.\n\nMestre dos Magos (C.W.): Se você visitou a loja, sabe que existem itens e poções que aumentam seus atributos\nC.W: Um exemplo é a poção Café que eu vendo ela faz com que você recupere 40 de vida bem util durante a batalha.\nClaro, para isso você tem que trabalhar e ganhar dinheiro nesse mundo. Apesar de ser um mago, ainda não produzo dinheiro\nE quanto ao dinheiro... se seguir para o prédio bem grande ali chamado SISTEMA GOLD irá entender como ganhar dinheiro\n").

dialogo_historia(2):-
    lib:printString("*Você percebe que não descansou o suficiente, e que ninguem é de ferro, assim indo tirar um cochilo de mais meia hora\n*30 Minutes later*\nApos acordar você por algum motivo lembra de BoB Esponja e vê que é mais um dia de luta para salvar o mundo").

dialogo_historia(3):-
    lib:printString( "Segunda feira é um dia que tem algo que te puxa para baixo, você decide ir procrastinar e deixar para salvar o mundo para depois.\nApós uma boa descansada sem proposito você parte para sua aventura").

menu_historia_principal:-
    maplist(writeln, [
        "(1) Ganhar dinheiro","(2) Comprar poções com C.W.",
        "(3) Visitar o ferreiro Ferreira","(4) Me garanto em enfrentar a I.A.","(5) Voltar ao menu"]),
    write("\n------------------------------------------------------------------------------------\n").
