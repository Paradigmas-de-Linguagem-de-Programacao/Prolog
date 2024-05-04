:- use_module('../Mecanica/loja.pl').
:- use_module('../Historia/prologo.pl').
:- use_module('../Historia/cidadela.pl').
:- use_module('../Historia/final.pl').
:- use_module('../Models/inimigo.pl').

comeca_jogo :-
    writeln("Inicializando dados..."),
    jogador_init,
    salva_jogador,
    comeca_fase(0).

carrega_jogo :-
    % funcao pra criar diretorio(exists_directory('../src/fmcc/Diretorio') -> printString("Ola") ; make_directory('../src/fmcc/Diretorio')).
    (not(exists_file('../src/fmcc/Diretorio/jogador.txt')) -> (printString("Não existe jogo salvo, começando um novo jogo"), comeca_jogo) 
    ;
        carrega_jogador,
        jogador:get_progresso(Progresso),
        comeca_fase(Progresso)).

checkPoint:-
    atualiza_progresso(Progresso),
    salva_jogador,
    writeln("Carregando dados..."),
    comeca_fase(Progresso).

comeca_fase(0) :- prologo:comecaJogo.
comeca_fase(1) :- inicializa_fase(1).
comeca_fase(2) :- inicializa_fase(2).
comeca_fase(3) :- inicializa_fase(3).
comeca_fase(4) :- final:fim_de_jogo.

inicializa_fase(Progresso) :- 
    loja:inicializa_loja(Progresso),
    inimigo:inicializa_inimigos(Progresso),
    cidadela:irCidadelaDeCristal.


help :- maplist(writeln,
            [ "Olá amigo viajante! Estou aqui para esclarecer algumas dúvidas que talvez você possa ter:\n"
            , "Em primeiro plano, este jogo é um RPG textual que segue o estilo IDLE para ganhar recursos. Além disso, ele é munido de 3 fases."
            , "Se você criou um jogo e após entrar na sua conta novamente você optou por inicializar o game,"
            , "você perderá todo seu progresso, ou seja, TOME BASTANTE CUIDADO."
            , "Além disso, se você optar por continuar o jogo, vai começar da cidadela." 
            , "Ou seja, se por algum motivo você fechou o jogo em uma luta ou morreu, vai começar da mesma fase, mas SEM GOLD."
            , "Por fim o que separa uma parte da história de outra são traços na tela: ----, como essa logo abaixo.\n"
            , "Bom jogo, e seja bem vindo a Fábulas de Magia : Cidadela de Cristal (FMCC)!"]),
        formata_texto.


carrega_jogador :- consult('../src/fmcc/Diretorio/jogador.txt').

salva_jogador :-
    tell('../src/fmcc/Diretorio/jogador.txt'),
    retract(jogador(Nome, Gold, Equipamentos, Pocoes, Progresso)),
    asserta(jogador(Nome, 0, [], [], Progresso)),
    listing(jogador),
    told,
    retract(jogador(Nome, _, _, _, _)),
    asserta(jogador(Nome, Gold, Equipamentos, Pocoes, Progresso)).