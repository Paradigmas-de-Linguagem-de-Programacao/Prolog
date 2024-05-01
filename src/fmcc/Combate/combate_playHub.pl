:- module(combate_playHub, [pre_combate_playHub/0]). 

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Combate/combate_mecanica').   
:- use_module('../Models/inimigo.pl').
:- use_module('../Combate/combate_IA.pl').

pre_combate_playHub:-
    historia_pre_combate,
    turno_preparacao,
    visualiza_status("Cachorros caramelos"),
    turno_heroi.

turno_heroi:-
    verifica_inimigo_morto("Hub"),
    writeln("Somente Play sobrou mas sua voz continua irritante como sempre"),
    writeln("(1) Ataque.\n(2) Usa poção.\n"),
    inputNumber("\nEscolha uma ação: ", Escolha),
    escolha_acao_heroi(Escolha, "Play").

turno_heroi:-
    verifica_inimigo_morto("Play"),
    writeln("Somente Hub sobrou, sua tela para mostrar resumos ainda funciona"),
    writeln("(1) Ataque.\n(2) Usa poção.\n"),
    inputNumber("\nEscolha uma ação: ", Escolha),
    escolha_acao_heroi(Escolha, "Hub").

turno_heroi:-
    writeln("As duas partes ainda existe, temos que erradicar"),
    writeln("(1) Ataque.\n(2) Usa poção.\n"),
    inputNumber("\nEscolha uma ação: ", Escolha),
    escolha_acao_heroi(Escolha).

turno_inimigo:-
    ataque_inimigo,
    (verifica_heroi_morto -> morte_dano ; turno_heroi).

ataque_inimigo:-
    verifica_inimigo_morto("Hub"),
    writeln("Play grita e lhe causa um dano sonoro"),
    ataque_inimigo("Play").

ataque_inimigo:-
    verifica_inimigo_morto("Play"),
    writeln("Hub lê o arquivo txt que guardava seu ataque e aplica ele em você"),
    ataque_inimigo("Hub").

ataque_inimigo:-
    writeln("Play grita e lhe causa um dano sonoro"), nl,
    ataque_inimigo("Play"),
    writeln("Inspirado pelo ataque de Play"), 
    writeln("Hub lê o pdf que guarda o ataque e mostra na sua tela, aplicando em seguida em você"),
    ataque_inimigo("Hub"), nl.

escolha_acao_heroi(1):-
    writeln("Como pode ver existe duas partes para você bater então em quem você vai dar o ataque?"),
    writeln("(1) Play.\n(2) Hub."),
    inputNumber("\nEscolha uma ação: ", Escolha),
    ataque_escolha(Escolha),
    turno_inimigo.

escolha_acao_heroi(2):-
    writeln("Play e Hub riem de você um com uma voz grotesca e outro printando na tela... você se sente humilhado mas vai derrotá-los"),
    toma_pocao,
    (verifica_pocoes_tomadas -> morte_pocao ; turno_inimigo).

escolha_acao_heroi(_):- writeln("Digite uma opção válida."), turno_heroi.

ataque_escolha(1):-
    writeln("Heanes ataca com intenção de calar essa coisa feia para sempre."),
    ataque_heroi("Play").

ataque_escolha(2):-
    writeln("Heanes ataca com intenção de quebrar essa tela."),
    ataque_heroi("Hub").

ataque_escolha(_):-
    writeln("Estamos em uma luta e não temos tempo para demorar, por isso Heanes ataca o primeiro que vê pela frente"),
    ataque_heroi("Hub").


escolha_acao_heroi(1, Nome):-
    dialogo_play_hub(Nome),
    ataque_heroi(Nome),
    (verifica_inimigo_morto(Nome) -> combate_playHub ; turno_inimigo).

escolha_acao_heroi(2, Nome):-
    dialogo_deboche_play_hub(Nome),
    toma_pocao,
    (verifica_pocoes_tomadas -> morte_pocao ; turno_inimigo).

escolha_acao_heroi(_ , _):- writeln("Digite uma opção válida."), turno_heroi.

combate_playHub:-
    printString("*Sem tempo para comemorar a vitória, você vai mais ao fundo da floresta em busca do verdadeiro monstro o PlayHub*\nHeanes encontra uma casca como se uma borbuleta tivesse surgido e quando se depara lá está PlayHub."),
    combate_IA(2).

historia_pre_combate:-
    contaHistoria(["C.W: Heanes vá em direção à floresta das IA's lá você vai encontrar duas pessoas que lhe explicaram a situação, G e Wendell\n*Após caminhar durante algumas horas Heanes avista duas pessoas*",
                   "Professor G: Meu Deus aquela coisa se fundiu e agora Wendell o que a gente faz\nWendell: E eu sei lá... ei olha que está vindo ali\nHeanes: Meu Deus. Como aquilo existe, parece que um casamento de carne foi feito.",
                   "Wendell: Então você é o herói que Leandro falou, bom como pode ver aquela monstruosidade de boca e olhos é uma IA, anteriormente eram duas uma apenas olho com a função de ler PDF e a outra apenas boca que reproduzia uma voz grotesca, agora bom se tornou isso\nHeanes: Apesar de ser muito feio irei enfrentar-lá me desejem sorte.",
                   "Professor G: Calma herói, apesar das IA's terem se fundido sua fusão não foi perfeita e partes dos seus restos ficaram como caminho e tem vida, pelo que parece você vai ter que passar por uma batalha contra essas duas coisas.",
                   "Heanes: AHHHHHHH mais trabalho pra mim... meu salário não cobre essas coisas"]).




