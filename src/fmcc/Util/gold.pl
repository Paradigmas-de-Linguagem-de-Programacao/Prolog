:- use_module('./lib.pl').

menugold :- clearScreen,
            writeln("(1) Trabalhar ajudando a carregar alguns suprimentos para um mercado mágico próximo.\n(2) Responder enigmas que as IAs utilizam para afirmar sua superioridade.\n(3) N.D.A."),
            writeln("\n------------------------------------------------------------------------------------\n"),
            lib:inputNumber("Faça sua escolha: ", Escolha),
            sistemagold(Escolha).

sistemagold(1) :- clearScreen, 
                writeln("C.W.: Ótimo! Então me ajude a carregar essas caixas, e dependendo de quantas você levar, eu pago a quantia adequada.\n"),
                writeln("*QUANDO QUISER PARAR, APERTE QUALQUER TECLA.*"),
                sgp(0).

sgp(GOLD) :-
    writeln("carregando caixas..."),
    current_input(I),
    wait_for_input([I], A, 3),
    A = [] ->
        GOLD2 is GOLD + 10,
        sgp(GOLD2)
    ;
        write("C.W.:Você se cansa rápido para um héroi...\n\n*Você olha para sua carteira de professor, e vê "),
        GOLD2 is GOLD + 10,
        write(GOLD2),
        write(" moedas de critais.*\n"),!,halt.

 