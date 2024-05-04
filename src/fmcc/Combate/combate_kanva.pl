:- module(combate_kanva , [pre_combate_kanva/0]).

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('../Combate/combate_mecanica').   
:- use_module('../Models/inimigo.pl').
:- use_module('../Combate/combate_IA.pl').

pre_combate_kanva:-
    historia_pre_combate,
    jogador_combate_init,
    turno_preparacao,
    visualiza_status("Cachorros caramelos"),
    (verifica_pocoes_tomadas -> morte_pocao ; turno_heroi).

turno_inimigo:-
    writeln("Os cachorros pulam ferozmente e te mordem"),
    ataque_inimigo("Cachorros caramelos"),
    (verifica_heroi_morto -> morte_dano ; turno_heroi).


turno_heroi:-
    writeln("Os cachorros Rosnam para você o que fazer?"),
    writeln("(1) Ataque.\n(2) Usa poção.\n"),
    inputNumber("\nEscolha uma ação: ", Escolha),
    escolha_acao_heroi(Escolha).

escolha_acao_heroi(1):- ataque_heroi("Cachorros caramelos"), (verifica_inimigo_morto("Cachorros caramelos") -> combate_kanva ; turno_inimigo).
escolha_acao_heroi(2):- toma_pocao , (verifica_pocoes_tomadas -> morte_pocao ; turno_inimigo).
escolha_acao_heroi(_):- writeln("Digite uma opção válida."), turno_heroi.

combate_kanva:-
    printString("*Sem tempo para comemorar a vitória você é puxado para dentro do museu deixando Leandro para trás.*\n"),
    writeln("Se prepare rapidamente para o combate!."),
    printString("C.W. te acompanhou de longe e liberou uma poção a mais no seu inventário, essa poção é uma nova criação do Mestre dos Magos, e não pode ser comprada.\n"),
    %funcao que adiciona o monster
    combate_IA(1).

historia_pre_combate:-
    contaHistoria(["C.W.: Tudo bem, vejo que você já que você está preparado, espero que tenha se equipado ao maximo, recomendo ir ao Museu, lá existem feras que estão fora de controle, mas antes deixa eu te ensinar como lutar\n",
                   "Quando você estiver em combate, suas jogadas serão definidas em turnos intercalados entre você e seu inimigo, por isso, tome bastante cuidado nas suas decisões.\nVocê pode escolher atacar ou tomar poções, mas tomar uma poção tem seu preço.",
                   "*Na frente do museu, Heanes vê um homem completamente desesperado de estatura mediana e cabelos bagunçados*\n",
                   "Homem completamente desesperado: Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte. Isso não é arte...\n",
                   "Heanes: Você é o Leandro??\nLeandro: Sim, sou eu. E pelo que me disseram, você é o herói. Não temos tempo a perder, dentro do museu a I.A. chamada Kanva está alterando tudo, substituindo as pinturas mais perfeitas por suas imagens disformes.\n",
                   "*Enquanto Leandro falava, grandes sombras de cor caramelo surgiam ao redor*\n",
                   "Leandro: Meu Deus, os fiéis companheiros do Kanva seus cachorros caramelos distorcidos, olha só aquele tem 3 focinhos\n",
                   "OS CACHORROS FAREJAM VOCES E VÃO EM SUA DIREÇÃO! Heanes e Leandro são cercados por cachorros caramelos gigantes disformes.\nLeandro: Esses são os cachorros criados pelo kanva, fique de costas para mim para nao sermos cercados completamente!!!\n"]).


    
    
