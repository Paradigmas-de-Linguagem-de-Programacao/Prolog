:- module(combate_conversaGPT, [pre_combate_conversaGPT/0]). 

:- use_module('../Util/dialogos.pl').
:- use_module('../Util/lib.pl').
:- use_module('../Util/salvamento.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Models/inimigo.pl').
:- use_module('../Combate/combate_mecanica').   
:- use_module('../Combate/combate_IA.pl').

pre_combate_conversaGPT :-
    historia_pre_combate,
    turno_preparacao,
    %visualiza_status("ConversaGPT"),
    write("\nHeanes: Espere, tem algo errado...que glitchs são esses?? C.W. não me disse nada!!\nConversaGPT:CUIDAAAADO Dog, tubarao vai te pegar."),
    %o print do gpt nao mostra vida nem defesa, apenas ataque.
    turno_heroi_gpt1.

turno_heroi_gpt1 :-
    write("\n(1) Fugir da batalha covardemente e reclamar que o C.W. não te preparou.\n
             (2) Arriscar um ataque sabendo que tem algo errado.\n
             (3) Usar poção."),
    inputNumber("\nEscolha uma ação: ", Escolha),
    turno_heroi_gpt1(Escolha).

turno_heroi_gpt1(0) :- write("\nConversaGPT ri alto e o humilha\nConversaGPT: Clamando por ajuda héroi? Você realmente é fraco.\n").

turno_heroi_gpt1(1) :- write("Eu nem ia te atacar por um tempo, fair play, mas tentar correr? *ConversaGPT te agarra e te mata instataneamente.*"). %morte do player

turno_heroi_gpt1(2) :- Lista = ["\nVocê desfere um ataque forte, mas...conversaGPT não se move e não sente nada, você é um homem morto.\n",
                                "\nHeanes tenta uma investida arriscada e que deixa várias brechas, o seu inimigo apenas pega sua espada e a quebra.\n",
                                "\nSem confiança alguma, você tenta um golpe perfeito, conversaGPT apenas o pega e quebra seu escudo ao meio.\n"], turno_aux(Lista).

turno_heroi_gpt1(3) :- write("\nConversaGPT é mais rápido e não deixa você usar!! Você tenta atacar: \n"), turno_heroi_gpt1(2).

turno_heroi_gpt1(_) :- write("\nOpção inválida, tente novamente.\n"), turno_heroi_gpt1.

turno_aux(Lista_att) :-
    Index = length(Lista_att) - 1,
    nth0(Index, Lista_att, Resultado), %pega o ultimo elemento da lista
    nl, write(Resultado), nl,
    %imprime status do chatgpt, so que sem alteracao nenhuma, imprime infinitamente os mesmo status.
    write("\n(0) *Clamar por C.W.*\n.
             (1) Fugir covardemente.\n
             (2) Arriscar um ataque novamente.\n"),
    inputNumber("\nEscolha uma ação:\n ", Escolha),
    (Escolha =:= 2 -> (Index =:= 0 -> duvida_gpt(0) ; remove_ultimo_elemento(Lista_att, Lista), turno_aux(Lista)) ; duvida_gpt_errado1(Escolha)).

remove_ultimo_elemento([_], []).
remove_ultimo_elemento([Head|Tail], [Head|Lista]) :- 
    remove_ultimo_elemento(Tail, Lista).

duvida_gpt(5) :- 
    write("\n(2) Conversinha...VOCÊ REALMENTE TEM CERTEZA MESMO??\n"),
    write("\nHUMANO, VOCÊ ESTÁ CORRETO!!\n"), clearScreen.
    combate_IA(3).

duvida_gpt(Vezes) :-
    write("\n(1)Desistir inutilmente.\n(2) Heanes: ConversaGPT... você está errado.\n"), replica_String(" errado. ", Vezes),
    write("\nConversaGPT: Não, não "), replica_String("Não ", Vezes),
    writeln("\n------------------------------------------------------------------------------------\n"),
    inputNumber("Qual sua escolha: ", EscolhaJogador),
    (EscolhaJogador =:= 2 -> Vezes_atual is Vezes + 1, clearScreen, duvida_gpt(Vezes_atual) ; duvida_gpt(1)).

duvida_gpt_errado(_) :-
    write("\nVocê deveria ter continuado a duvidar, humano.\n"). %jogador morre novamente.

historia_pre_combate:-
    contaHistoria(["C.W: Enfim chegamos ao fim, está vendo aquele castelo nada chamativo em cima de uma montanha nada caricata de filme, é lá onde o líder das IA's ConversaGPT vive, por favor Heanes nos ajude uma última vez.",
                   "*Indo em direção ao castelo dessa vez você não encontra ninguem apenas você até que de repente*\nConversaGPT: Olha olha se não é Heanes a pessoa mais falada desse mundo, parece que você andou batendo nos meus amigos não é? Infelizmente pelo bem do meu reinado vou ter que te eliminar, não leve para o pessoal.",
                   "Heanes: Ganhei de todos os outros sem suar e você acha que vai me parar? Conversa, você é apenas o último obstaculo antes de voltar para minha casa e lutar meu judo.",
                   "ConversaGPT: Bom, vamos ver do que você é capaz"]).
