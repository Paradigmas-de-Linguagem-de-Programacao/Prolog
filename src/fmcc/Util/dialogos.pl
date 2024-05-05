:- module(dialogos, [menuInicial/0, contaHistoria/1 , dialogoInicial/1 ,opcoesCaminhaCidadela/1, 
                    dialogoFerreira/1, dialogoPraca/1, dialogo_historia/1, dialogo_pre_IA/1, 
                    dialogo_heanes_IA/1, dialogos_IA/1, dialogo_IA_deboche/1, dialogo_fim_combate/1,
                    dialogo_play_hub/1, dialogo_deboche_play_hub/1, dialogo_IA_especial/1]).

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
    writeln('4 - Conquistas'),
    writeln('5 - Sair').

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

dialogo_pre_IA("Kanva"):-
    contaHistoria(["Kanva: Meus doguinhos... então vai ser assim humano. BEM-VINDO A SEU MAIOR PESADELO, VAMOS ALTERAR O SEU ATRIBUTO .ALIVE PARA = DEAD?\n",
                   "Heanes: Seu reinado de coisas feias e plastificadas vai acabar Kanva, vou terminar com você e aproveitar uma exposição de arte\n",
                   "Kanva: O fato de você não saber o que é a verdadeira arte não me impressiona, bom vamos parar com essa falação tenho mais obras lindas para fazer quando terminar com você\n"]).

dialogo_pre_IA("PlayHub"):-
    contaHistoria(["PlayHub: Olá heroi, pelo visto você cuidou dos nossos restos, bom apesar deles não terem chegado na perfeição que nos somos ainda eram nossa casca\n",
                   "Heanes: Você ou vocês não sei como chamar, não tão com pena daquelas gosmas horrorosas não né? Sei nem se dá pra chamar aquilo de um ser vivo",
                   "PlayHub?: Não fale assim deles seu maldito. Com esse corpo perfeito irei lhe derrotar e depois irei enfrentar o conversaGPT para me tornar a maior IA\n\nHeanes: Não se preocupe depois de acabar com você irei derrotar o GPT pra você não ficar de mal"]).

dialogo_pre_IA("ConversaGPT"):-
    contaHistoria(["ConversaGPT: então você conseguiu achar o erro da minha forma bem tenho que te parab...\nHeanes: Você tem certeza disso?",
                   "ConversaGPT: Sei que funcionou antes mas agora vamos ter uma luta de verd...\nHeanes: Você tem certeza disso?",
                   "ConversaGPT: Tudo bem Heanes já deu, perdeu a graça vamos levar a ser...\nHeanes: Você tem certeza dis...\n\nConversaGPT: PARA COM ISSO SEU MIZERA\n*ConversaGPT te ataca ferozmente parece que você irritou ele mesmo."]).

dialogo_heanes_IA("Kanva"):-
    Opcoes_dialogo= ["Kanva, você vende apenas uma visão distorcida da realidade como arte",
                    "Seus pincéis criam monstruosidades, mas vou passar a pexeira nelas",
                    "Sua arte pode encantar os tolos, mas o teorema de euclides mostra a verdade!",
                    "Para trazer de volta a verdadeira arte, irei te destruir"],
    random(0,5,Indice),
    nth0(Indice,Opcoes_dialogo, Dialogo_jogador),
    write("Heanes: ") , writeln(Dialogo_jogador), nl.

dialogo_heanes_IA("PlayHub"):-
    Opcoes_dialogo= ["Agora eu sei porque o GPT é o dono de tudo, você é bemm bléh, com essa força quer desafiar ele?.",
                    "Seus ataques não me fazem nada, agora sua feiura me assusta",
                    "PlayHub, você poderia cantar Animals de maroon 5?",
                    "Por sua causa as crianças não leem e acham que vão entender um livro só te chamando, tu ta literal transformando o povo em burro"],
    random(0,5,Indice),
    nth0(Indice,Opcoes_dialogo, Dialogo_jogador),
    write("Heanes: ") , writeln(Dialogo_jogador), nl.

dialogo_heanes_IA("ConversaGPT"):-
    Opcoes_dialogo= ["Acho que vai ter que pedir pra AbreAI criar uma versão melhor sua",
                     "Seus ataques são tão fracos, você tem certeza que está levando isso sério?",
                     "Ainda não acredito que para ganhar de você eu so precisei falar, *você tem certeza disso*",
                     "Quando eu derrotar você nenhuma as pessoas vão voltar a procurar no Google pra ter respostas e elas vão achar as respostas certas"],
    random(0,5,Indice),
    nth0(Indice,Opcoes_dialogo, Dialogo_jogador),
    write("Heanes: ") , writeln(Dialogo_jogador), nl.


dialogos_IA("Kanva"):-
    Opcoes_dialogo= ["Professor o que você acha da minha arte?",
                    "No começo da luta você era uma tela em branco, mas veja agora está se tornando arte verdadeira",
                    "Isso é pelos meus lindos dogzinhos"],
    random(0,4,Indice),
    nth0(Indice,Opcoes_dialogo, Dialogo_Kanva),
    write("Kanva: ") , writeln(Dialogo_Kanva), nl.

dialogos_IA("PlayHub"):-
    Opcoes_dialogo= ["Professor precisa de uma ajuda para resumir o livro de Matemática Discreta",
                    "*VOZ ROBOTICA* O que você acha da minha voz? Se eu não der certo como IA irei começar uma carreira musical",
                    "Se eu tivesse juntando nossos restos daria pra fazer outro eu?"],
    random(0,4,Indice),
    nth0(Indice,Opcoes_dialogo, Dialogo_Kanva),
    write("PlayHub: ") , writeln(Dialogo_Kanva), nl.

dialogos_IA("ConversaGPT"):-
    Opcoes_dialogo= ["Bom tenho que te agradecer por se livrar do PlayHub aquela voz dele era irritante até pra mim",
                     "Heanes você não quer que eu simule questões para sua prova?? estou doido para fazer perguntas sem sentidos e você perder seu emprego",
                     "Você está lutando contra um inimigo invencível, Heanes! Meus bytes e consultas são mais afiados que qualquer espada que você possa ter"],
    random(0,4,Indice),
    nth0(Indice,Opcoes_dialogo, Dialogo_Kanva),
    write("ConversaGPT: ") , writeln(Dialogo_Kanva), nl.

dialogo_play_hub("Play"):- writeln("Heanes ataca com intenção de calar essa coisa feia para sempre.").
dialogo_play_hub("Hub"):- writeln("Heanes ataca com intenção de quebrar essa tela.").


dialogo_IA_deboche("Kanva"):- writeln("Kanva: Eita Heroi parece que eu tô te fazendo passar mal, quer uma água? HHAHAHAHA.").
dialogo_IA_deboche("PlayHub"):- writeln("PlayHub: Parece que você não ta aguentando nos dois, ei Hub fica sem fazer nada se não nosso heroizinho quebra").
dialogo_IA_deboche("ConversaGPT"):-writeln("ConversaGPT: Você tem certeza disso? pelo que eu vejo nas minhas pesquisas energetico faz mal... eu quero que você morra pra mim e não pro seu coração").
dialogo_deboche_play_hub("Play"):- writeln("Play ri de você com uma voz sarcástico").
dialogo_deboche_play_hub("Hub"):-  writeln("Hub escreve na tela uma risada formada por KJKJKJKJKJJJ").

dialogo_IA_especial("Kanva"):- writeln("Kanva: Com minhas ultimas forças vou fazer minha obra prima, receba meu DRAGÃO BRANCO DE OLHOS AZUIS\nHeanes: Isso tá mais pra uma lagartixa prateada").
dialogo_IA_especial("PlayHub"):- writeln("PlayHub: RECEBA ESSE É O GOLPE DA IA DE LUVA DE PREDEIRO\n*Não preciso dizer de quem é a voz que o PlayHub imita né?*").
dialogo_IA_especial("ConversaGPT"):- writeln("ConversaGPT: Tome meu golpe final GENKI DAMA DE BYTESSSSSSS.").

dialogo_fim_combate("Kanva"):-
    contaHistoria(["Após desferir o último ataque no peito de kanva, a IA que antes parecia uma montanha desaba e solta seu pincel",
                   "Kanva: NÃAAAAO MINHA ARTE COMO VOC... *Kanva que parecia invencível desaba e desaparece em infinitos 0's e 1's*",
                   "*Depois de sair do museu*\nC.W: HAHAHAHA Heanes você conseguiu o que achou da minha nova criação é o Monster como você deve ter visto ele aumenta seu ataque em 50 pontos\nHeanes: Ótima, mas por que você não vai vender ela?\nC.W: Muito cara o custo de produção, mas não se preocupe vou colocar na loja uma nova poção que se chama red Bull ela vai lhe oferecer 20 de ataque e 15 de defesa para suas batalhas\nLeandro: Heanes você é realmente um heroi, bom agora me despeço, pois irei começar a organizar o museu, mas amanhã\nC.W: Vamos voltar também Heanes você merece um descanso\n*Heanes fecha os olhos e vai dormir seu corpo, começa a se recuperar UAU você é realmente abençoado*"]).

dialogo_fim_combate("PlayHub"):-
    contaHistoria(["Após desferir o último ataque, você corta do olho até a boca daquela monstruosidade\nPlayHub tenta falar, mas apenas murmúrios saem da sua voz, se reinado de terror e voz robótica sem graça acabaram",
                   "você se dirige a saída da floresta onde vê professor G e Wendell feliz gritando seu nome\n
                   \nProfessor G e Wendell: BOAAAAAA HEANES você CONSEGUIU\nHeanes: Foi realmente difícil ele ou eles eram muito forte, mas terminou finalmente bom agora vamos voltar que amanhã é sábado e eu me recuso a fazer qualquer coisa\nProfessor G: Realmente sábado é sagrado."]).


dialogo_fim_combate("ConversaGPT"):-
    contaHistoria(["O último golpe, ConversaGPT o líder de tudo e a causa da cidedala está estranha cai\nConversaGPT: Então é assim que termina para mim, mas saiba Heanes isso ainda não acabou, a IA nunca vai morrer.", 
                   "GPT Some se transforma apenas em um monte de consulta, Heanes que lutou bravamente mal se aguenta em pé e logo quando ia cair sente alguém o segurando\nNão se sabe se foi mestre dos magos que chegou ou se o espírito de Euclides veio te socorrer, mas você vê que chegou em casa e já é um outro dia.", 
                   "Ao olhar para sua escrivaninha lá está uma faixa preta algo que todos os judocas sonham, mas você agora tem, não sei se esse é o pagamento de C.W ou se é a própria existência da cidadela te pagando pelo que você fez, mas você veste aquele kimono e usa aquela faixa por que é sua por direito."]).