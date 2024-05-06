:- module(combate_conversaGPT, [pre_combate_conversaGPT/0]). 

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('../Models/inimigo.pl').
:- use_module('../Combate/combate_mecanica').   
:- use_module('../Combate/combate_IA.pl').
:- use_module('../Models/jogador.pl').

pre_combate_conversaGPT :-
    historia_pre_combate,
    jogador_combate_init,
    turno_preparacao,
    visualiza_status_gpt_imortal,
    write("\nHeanes: Espere, tem algo errado...que glitchs são esses?? C.W. não me disse nada!!\nConversaGPT:CUIDAAAADO Dog, tubarao vai te pegar."),
    (verifica_pocoes_tomadas -> morte_pocao ; turno_heroi_gpt1).

turno_heroi_gpt1 :-
    writeln("\n(1) Fugir da batalha covardemente e reclamar que o C.W. não te preparou."),
    writeln("(2) Arriscar um ataque sabendo que tem algo errado."),
    writeln("(3) Usar poção."),
    inputNumber("\nEscolha uma ação: ", Escolha),
    turno_heroi_gpt1(Escolha).

turno_heroi_gpt1(0) :- printString("\nConversaGPT ri alto e o humilha\nConversaGPT: Clamando por ajuda héroi? Você realmente é fraco.\n").

turno_heroi_gpt1(1) :- printString("Eu nem ia te atacar por um tempo, fair play, mas tentar correr? *ConversaGPT te agarra e te mata instataneamente.*"), morte_dano.

turno_heroi_gpt1(2) :- turno_aux(0).

turno_heroi_gpt1(3) :- write("\nConversaGPT é mais rápido e não deixa você usar!! Você tenta atacar: \n"), turno_heroi_gpt1(2).

turno_heroi_gpt1(_) :- write("\nOpção inválida, tente novamente.\n"), turno_heroi_gpt1.

turno_aux(Tentativa_de_ataque) :-
    dialogo_gpt_tunado(Tentativa_de_ataque),
    visualiza_status_gpt_imortal,
    Novo_ataque_realizado is Tentativa_de_ataque + 1,
    writeln("\n(0) *Clamar por C.W.*."),
    writeln("(1) Fugir covardemente."),
    writeln("(2) Arriscar um ataque novamente.\n"),
    inputNumber("\nEscolha uma ação:\n ", Escolha),
    (Escolha =:= 2 -> (Novo_ataque_realizado =:= 4 -> duvida_gpt(1) ; turno_aux(Novo_ataque_realizado)) ; duvida_gpt_errado).

duvida_gpt(4) :- 
    write("\n(2) Conversinha...VOCÊ REALMENTE TEM CERTEZA MESMO??\n"),
    write("\nHUMANO, VOCÊ ESTÁ CORRETO!!\n"), esperandoEnter,
    combate_IA(3).

duvida_gpt(Vezes) :-
    write("\n(1) Desistir inutilmente.\n(2) Heanes: ConversaGPT... você tem certeza disso?\n"), replica_String("errado. ", Vezes),
    write("\nConversaGPT: Não, não "), replica_String("Não ", Vezes),
    writeln("\n------------------------------------------------------------------------------------\n"),
    inputNumber("Qual sua escolha: ", EscolhaJogador),
    (EscolhaJogador =:= 2 -> Vezes_atual is Vezes + 1, clearScreen, duvida_gpt(Vezes_atual) ; duvida_gpt_errado).

duvida_gpt_errado :-
    printString("Você deveria ter continuado a duvidar, humano.\n"), morte_dano.

dialogo_gpt_tunado(Vezes_atacado):-
    Lista_dialogo_gpt = ["\nVocê desfere um ataque forte, mas...conversaGPT não se move e não sente nada, você é um homem morto.\n",
                         "\nHeanes tenta uma investida arriscada e que deixa várias brechas, o seu inimigo apenas o pega e o joga pelo lugar.\n",
                         "\nSem confiança alguma, você tenta um golpe perfeito, conversaGPT apenas o pega e quebra sua defesa e acerta um golple.\n",
                         "\nConversaGPT: Você nunca vai me derrotar Heanes\nHeanes: Você tem certeza disso?\nApós escutar essa palavras Conversa parece ter sentido algum dano"],
    nth0(Vezes_atacado ,Lista_dialogo_gpt , Dialogo_gpt),
    writeln(Dialogo_gpt).

historia_pre_combate:-
    contaHistoria(["C.W: Enfim chegamos ao fim, está vendo aquele castelo nada chamativo em cima de uma montanha nada caricata de filme, é lá onde o líder das IA's ConversaGPT vive, por favor Heanes nos ajude uma última vez.",
                   "*Indo em direção ao castelo dessa vez você não encontra ninguem apenas você até que de repente*\nConversaGPT: Olha olha se não é Heanes a pessoa mais falada desse mundo, parece que você andou batendo nos meus amigos não é? Infelizmente pelo bem do meu reinado vou ter que te eliminar, não leve para o pessoal.",
                   "Heanes: Ganhei de todos os outros sem suar e você acha que vai me parar? Conversa, você é apenas o último obstaculo antes de voltar para minha casa e lutar meu judo.",
                   "ConversaGPT: Bom, vamos ver do que você é capaz"]).

visualiza_status_gpt_imortal:-
    writeln("ConversaGpt | Ataque: Indeterminado | Defesa: Indeterminado | Vida: Indeterminado \n\n").

