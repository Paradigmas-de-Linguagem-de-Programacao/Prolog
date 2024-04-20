:- module(prologo,[comecaJogo/0]).

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('./cidadela.pl').

comecaJogo:-
    dialogos:contaHistoria([
        "*Um professor de matemática de uma universidade localizada em Campina Extensa, enquanto dava uma aula sobre o Teorema do resto chines...*\n\nHeanes: Bom turma e agora aplicando euclides para descobrir o md…\n",
        "*Um portal se abre e Heanes foi sumonado para um mundo totalmente novo, a pessoa que o trouxe a esse mundo foi Carl Wilson, conhecido como C.W  ou comumente chamado de mestre dos magos nesse mundo*\n",
        "Carl Wilson: Olá professor, sei que você possivelmente não está entendendo o por que não está em uma sala de aula às 8:27 da manhã mas não temos tempo para uma longa explicação.\n",
        "Carl Wilson: Precisamos da sua ajuda. O nosso mundo tem uma força que não conseguimos controlar e nem entender, chamada Inteligência Artificial. Você nos ajudaria nessa caminhada para proteger nossa cidadela de cristal?\n"
    ]),
    input("Professor: Calma, um momen…\n\nCarl Wilson: Por favor faça sua escolha.\n\n(1) Sim, quero ajudar.\n(2) Prefiro morrer.\n", Decisao),
    escolha_jogador(Decisao).

escolha_jogador('1'):- inicioAventura.

escolha_jogador('2'):- 
    lib:printString("Heanes: Estava dando minha aula e quero voltar a ela, me mande de volta."),
    negaCarl(1).

escolha_jogador(_):-
    writeln("A liberdade de expressão era uma mentira..."),
    esperandoEnter,
    inicioAventura.

negaCarl(8):-
    writeln("Heanes: Quantas vezes vou ter que repetir eu não quero fazer isso???"),
    writeln("Carl Wilson: Então você escolheu isso... não me culpe meu amigo\n\n*você foi ejetado para o limbo*\n"),
    %desbloquea conquista jubilado,
    esperandoEnter,
    !.

negaCarl(VezesNegado):-
    writeln("Pense melhor sobre isso professor...\n"),
    writeln("(1) Sim, quero ajudar.\n(2) Prefiro morrer.\n"), % colocar a logica de repetir Nao VezesNegado
    writeln("\n------------------------------------------------------------------------------------\n"),
    input("Qual sua escolha: ", EscolhaJogador),
    (EscolhaJogador = '2' -> NegadoMaisUmaVez is VezesNegado + 1 , clearScreen , negaCarl(NegadoMaisUmaVez) ; escolha_jogador("Dog")).


inicioAventura:-
    dialogos:contaHistoria([
        "Carl Wilson: Excelente ideia meu amigo pedagogo.\n\n*Após chegar nesse novo mundo, C.W. nos apresenta a Cidadela de Cristal um lugar repleto de pessoas.*\n",
        "C.W.: Aqui no nordeste desse mundo está a Cidadela de Cristal, um lugar com 500 anos de história, e com diversas pessoas vivendo sua vida, entre elas está o dono da loja de armas, Armas & Muita Defesa, mais conhecido como AMD.\n",
        "C.W.: Bom, aqui vai ser o lugar onde você vai se equipar para viver uma vida de batalhas, nada de camisa social. Iremos partir para o mundo medieval e usar armas e armaduras, lhe apresento o ferreiro Ferreira.\n",
        "Ferreira: Olá mestre dos magos, quem é o seu amigo?\n",
        "Heanes: Olá, me chamo Heanes, sou um professor de matemática e estou de passagem por esse mundo.\n",
        "Ferreira: Pera, como assim de passagem?!\n\n*Mestre dos magos explica a situação e toda a parte de viagem entre mundos*\n\nFerreira: Uou. Achei que a coisa mais aleatória que eu veria hoje seria um gato com 3 patas pixelado, mas isso me surpreendeu. Bom amigo, aqui é onde você vai se equipar e gastar seu suado salário de professor.\n",
        "C.W.: Bom, eu esqueci um energético no caldeirão, fique livre para explorar a cidade e falar com todos, e quando se sentir tranquilo vá até a minha torre para você entender sobre as forças desse mundo.\n"
    ]),
    clearScreen,
    % atualizar progresso player para 1,
    cidadela:irCidadelaDeCristal.