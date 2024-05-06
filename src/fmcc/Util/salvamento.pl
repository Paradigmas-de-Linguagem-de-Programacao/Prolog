:- module(salvamento, [comeca_jogo_fmcc/0, carrega_jogo_fmcc/0, checkPoint/0, cria_caminho_conquista/1, cria_caminho_jogador/1]).

:- use_module('../Mecanica/loja.pl').
:- use_module('../Historia/prologo.pl').
:- use_module('../Historia/cidadela.pl').
:- use_module('../Historia/final.pl').
:- use_module('../Models/inimigo.pl').

comeca_jogo_fmcc :-
    writeln("Inicializando dados..."),
    jogador:jogador_init,
    salva_jogador,
    comeca_fase(0).

carrega_jogo_fmcc :-
    caminho_jogador(Jogador),
    % funcao pra criar diretorio(exists_directory('../src/fmcc/Diretorio') -> printString("Ola") ; make_directory('../src/fmcc/Diretorio')).
    (not(exists_file(Jogador)) -> (printString("Não existe jogo salvo, começando um novo jogo"), comeca_jogo_fmcc) 
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


carrega_jogador :- caminho_jogador(Jogador), consult(Jogador).

salva_jogador :-
    caminho_jogador(Jogador),
    tell(Jogador),
    retract(jogador(Nome, Gold, Equipamentos, Pocoes, Progresso)),
    asserta(jogador(Nome, 0, [], [], Progresso)),
    listing(jogador),
    told, 
    retract(jogador(Nome, _, _, _, _)),
    asserta(jogador(Nome, Gold, Equipamentos, Pocoes, Progresso)).

inicializa_conquista:- dynamic conquista/2.

ler_conquista:- caminho_conquista(Conquista), consult(Conquista).

cria_caminho_conquista(Diretorio) :-
    atom_concat(Diretorio, '/conquista_fmcc.txt', ArquivoConquista),
    retractall(caminho_conquista(_)),
    assertz(caminho_conquista(ArquivoConquista)).

cria_caminho_jogador(Diretorio) :-
    atom_concat(Diretorio, '/jogador_fmcc.txt', JogadorFmcc),
    retractall(caminho_jogador(_)),
    assertz(caminho_jogador(JogadorFmcc)).

carrega_conquista:- 
    caminho_conquista(Conquista), 
    (exists_file(Conquista) -> ler_conquista ; inicializa_conquista).

desbloquea_conquista("Jubilado"):-
    printString("Parabéns você acabou de ser ejetado... Não sei se vale um parabéns mas você desbloqueou a conquista Jubilado!!"),
    (\+ conquista("Jubilado", "Negue Carl Wilson 8 vezes") ->
        assertz(conquista("Jubilado", "Negue Carl Wilson 8 vezes")),
        salva_conquista ; true).

desbloquea_conquista("Infarto"):-
    printString("É parece que tomar todo aquele energético realmente não faz bem para o coração...\nOs médicos estavam certos fica o aviso crianças se lutarem contra inteligência artificial cuidado com o coração\nContudo nem tudo são perdas parabéns você desbloqueou uma conquista apesar que custou o coração do nosso héroi"),
    (\+ conquista("Se voce nao parar eu Paro", "Tome 5 Pocoes e faça Heanes infartar") ->
        assertz(conquista("Se voce nao parar eu Paro", "Tome 5 Pocoes e faça Heanes infartar")),
        salva_conquista ; true).

desbloquea_conquista("Faixa Preta"):-
    printString("Você realmente foi surpreendete e salvou a todos, parabéns!!!\nCom isso você ganhou o sonho de qualquer judoka, você é FAIXA PRETA além disso também desbloqueou uma conquista!!!"),
    (\+ conquista("Faixa Preta", "Derrotou ConversaGPT") ->
        assertz(conquista("Faixa Preta", "Derrotou ConversaGPT")),
        salva_conquista ; true).

salva_conquista:-
    caminho_conquista(Conquista),
    tell(Conquista),
    listing(conquista),
    told.

lista_conquista:-     
    writeln("Suas conquistas: "), nl,
    forall(conquista(Nome, Descricao),
           format("Nome: ~w~nDescrição: ~w~n~n", [Nome, Descricao])).

mostra_conquista:-
    caminho_conquista(Conquista),
    (exists_file(Conquista) -> lista_conquista ; writeln("Parece que você não tem nenhuma conquista. Tente jogar mais e explorar todas as possibilidades.")).

