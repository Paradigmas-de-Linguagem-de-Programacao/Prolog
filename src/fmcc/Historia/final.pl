:- module(final , [fim_de_jogo/0]).

:- use_module('../Util/lib.pl').

fim_de_jogo:-
    lib:printString("Você acorda e vê pessoas ao redor da sua casa, você é um heroi completo agora, saia e vá falar com seus fãs você merece a fama"),
    escolha_final.

escolha_final:-
    maplist(writeln , ["(1) Conversar com o Ferreira.", 
                       "(2) Ir à praça da cidade.", 
                       "(3) Ir à um beco escuro que está te chamando",
                       "(4) Ir ao mestre dos magos.",
                       "(5) Voltar ao menu"]),
    write("\n------------------------------------------------------------------------------------\n"),
    lib:inputNumber("Faça sua escolha: ", Escolha),
    opcao_final(Escolha).

opcao_final(5):- voltaMenu, !.

opcao_final(4):-
    lib:printString("C.W: Parabéns Heanes, você é o salvador de todos nós e ficou bem essa faixa preta que você pegou do conversa\nHeanes: HAHA nada disso seria possivel sem sua ajuda mas... um padeiro me avisou para não confiar em você, nossa serio imagina se eu faço isso nunca teria terminado minha jornada\nCw: HAHAHA, pode contar comigo meu amigo\nHeanes: Tá legal mas como eu volto pra casa\n*SILENCIO ENSURDECEDOR*\nHeanes: Meu Deus mais um déjà vu, NÃO ME DIGA QUE DENOVO.\nC.W: aaaahnn MEU DEUS OLHA A HORA, nós vemos depois\nHeanes: EI VOLTA AQUI "),
    !.

opcao_final(3):-
    lib:printString("Heanes com seus instintos forjados na batalha sente algo em um beco e decide investigar, lá ele encontra ele O PADEIRO\nPadeiro: Nós encontramos de novo Heanes parabéns você cumpriu sua missão\nHeanes: Quem é você ou melhor o que é você?\nPadeiro: Dessa vez você merece respostas, esse é o nosso 4 encontro Heanes\nHeanes: Como assim 4 eu só lembro de um e ess...\n*Padeiro lhe da um peteleco e mágicamente todas suas memorias voltam de uma jornada em funcional uma jornada EM HASKELL"),
    lib:printString("Heanes: Então eu estou vivendo isso mais uma vez? Mas você ainda não me respondeu o que é você?\nPadeiro: मैं निर्माता हूं और यह लौटने का समय है\n*Heanes acorda na sua sala no CN sem saber o que aconteceu, se isso foi um sonho ou real mas percebe que está de kimono e faixa preta, então sim tudo foi real.").

opcao_final(2):-
    lib:printString("Multidão: HEANES HEANES HEANES HEANES\nHeanes não é muito orgulhoso mas fica com uma sensação boa de ouvir uma cidade gritar seu nome."),
    escolha_final.

opcao_final(1):-
    lib:printString("Heanes: ferreira hoje eu não tenho nada para pedir a você finalmente acabou\nFerreira: *lhe da um sorriso sincero* sim Heanes você conseguiu salvou a todos muito obrigado\nHeanes fica sem palavras, aquele homem que era rabugento e gostava de seu dinheiro sabia sorrir então.\nHeanes: De nada meu amigo Ferreira nada disso poderia ter acontecido sem sua ajuda.\n*Um aperto de mãos foi ouvido por toda a cidadela*"),
    escolha_final.

opcao_final(_):-
    writeln("Escreva uma opção válida."),
    escolha_final.
