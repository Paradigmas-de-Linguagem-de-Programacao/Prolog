:- module(gold , [menugold/0]).

:- use_module('../Util/lib.pl').
:- use_module('../Models/jogador.pl').



menugold :-
            writeln("(1) Trabalhar ajudando a carregar alguns suprimentos para um mercado mágico próximo.\n(2) Responder enigmas que as IAs utilizam para afirmar sua superioridade.\n(3) N.D.A."),
            writeln("\n------------------------------------------------------------------------------------\n"),
            lib:inputNumber("Faça sua escolha: ", Escolha),
            sistemagold(Escolha).

sistemagold(1) :- clearScreen, 
                writeln("C.W.: Ótimo! Então me ajude a carregar essas caixas, e dependendo de quantas você levar, eu pago a quantia adequada.\n"),
                writeln("*QUANDO QUISER PARAR, APERTE QUALQUER TECLA.*"),
                sgp(0).

sistemagold(2) :- clearScreen,
                dialogo_vending_machine,
                jogador:get_progresso(Progresso),
                sga(Progresso).

sistemagold(_):- writeln("Não quer trabalhar hein, tudo bem. Boa sorte!\n"), esperandoEnter.

sga(1) :- 
    lib:input("Vending Machine: QUAL A MELHOR LINGUAGEM DE PROGRAMAÇÃO JÁ CRIADA?\n", ENTRADA),
    string_upper(ENTRADA, UPPER),
    (UPPER = "PROLOG" -> 
        writeln("Vending Machine: MUITO BEM, HUMANO! AINDA BEM QUE MEU PROGRAMADOR NÃO ME FEZ EM PROLOG... ECA!"),
        jogador:modifica_gold(50),
        parabeniza_acerto
        ;    maquina_irritada).

sga(2) :-
    lib:inputNumber("Vending Machine: A QUANTOS ANOS A CIDADELA DE CRISTAIS FOI FUNDADA?\n", ENTRADA),
    (ENTRADA =:= 500 -> 
        writeln("\nVending Machine: MUITO BEM, HUMANO! SÃO 500 ANOS DE HISTÓRIA!"),
        jogador:modifica_gold(50),
        parabeniza_acerto
    ;
        maquina_irritada).

sga(3) :-
    writeln("NINGUEM NUNCA VEIO TÃO LONGE MEU AMIGO HUMANO, em comemoração a sua vasta inteligência irei lhe fazer uma promoção duas perguntas pelo preço de uma vinda\nserá que você tem o que é necessario para responder tamanhas perguntas, essas últimas pergunta são de um nivel jamais visto nesse mundo\nmeu criador conseguiu ela através de um erro no espaço tempo que chegou a uma outra dimesão e um outro planeta, você terá que responder algo sobre CAMPINA GRANDE\nvamos ver como você se sai, BOA SORTE"),
    lib:input("Vending Machine: QUAL O MAIOR TIME DE FUTEBOL DA PARAÍBA?\n", ENTRADA),
    string_upper(ENTRADA, UPPER),
    ((UPPER = "TREZE"; UPPER = "GALO") -> 
        writeln("\nVending Machine: MUITO BEM, HUMANO! UH É GALO DOIDO!"),
        jogador:modifica_gold(50),
        parabeniza_acerto
    ;
        maquina_irritada),
    segunda_pergunta.

segunda_pergunta :-
    lib:input("Vending Machine: QUAL A PRIMEIRA LINGUAGEM DE PROGRAMAÇÃO QUE FOI UTILIZADA NA CADEIRA DE PLP DE UMA UNIVERSIDADE DE CAMPINA GRANDE?\n", ENTRADA),
    string_upper(ENTRADA, UPPER),
    (UPPER = "HASKELL" -> 
        writeln("\nVending Machine: MUITO BEM, HUMANO! O PARADIGMA FUNCIONAL JÁ FOI EXPLORADO NAQUELA DISCIPLINA!"),
        writeln("\nMas ainda bem que eu não fui feito naquilo imagina."),
        jogador:modifica_gold(50),
        parabeniza_acerto
    ;
        maquina_irritada).

        
maquina_irritada :-
    write("Vending Machine: COMO VOCÊ PODE FALAR UMA COISA DESSAS??? REPENSE SUAS ATITUDEZINHAS, SEM REWARD PARA VOCÊ.\n\n*Você olha para sua carteira de professor, e ela está vazia, você pensa em entrar em greve. Enquanto isso, você se vê de volta a cidade meio cabisbaixo*\n").

parabeniza_acerto :-
    write("\n*Você olha para sua carteira de professor, e vê "),
    jogador:get_gold(GOLD),
    write(GOLD), 
    write(" moedas de critais\n"), esperandoEnter.

dialogo_vending_machine :-
    writeln("*Heanes se encaminha para um lugar de procedência duvidosa, lá ele encontra uma Vending Machine*\n"),
    writeln("Vending Machine: OLÁ HUMANO! VOCÊ É CAPAZ DE RESPONDER A MINHA PERGUNTA?\n"),
    writeln("Vending Machine: A CADA VEZ QUE VOCÊ DERROTAR UMA IA TEREI UMA PERGUNTA FRESQUINHA PARA VOCÊ! MAS EU TENHO UM LEVE DEFEITO DE REPETIR A PERGUNTA SE VOCÊ SE AFASTAR DE MIM E VOLTAR. MAS SEI QUE VOCÊ NÃO ABUSARIA DESSE BUG PARA LUCRAR, NÃO É MESMO HERÓI?\n").

sgp(GOLD) :-
    writeln("carregando caixas..."),
    current_input(I),
    wait_for_input([I], A, 3),
    (A = [] ->
        Gold_adicionado is GOLD + 10,
        sgp(Gold_adicionado)
    ;
        lib:esperandoEnter, %função para limpar o buffer e a tela
        Gold_adicionado is GOLD + 10,
        write("C.W.:Você se cansa rápido para um héroi...\n\n*Após todo esse esforço jogando caixa pra lá e pra cá você recebeu: "),
        write(Gold_adicionado),
        writeln(" moedas de critais.*"),
        lib:formata_texto,
        jogador:modifica_gold(Gold_adicionado)).


 