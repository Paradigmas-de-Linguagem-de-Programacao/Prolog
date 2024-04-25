:- module(combate_mecanica , [visualiza_status/0, ataque_heroi/0, ataque_inimigo/0, verifica_inimigo_morto/0, verifica_heroi_morto/0,
                             verifica_pocoes_tomadas/0, turno_preparacao/0, morte_dano/0]).

:- use_module('../Util/lib.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Models/inimigo.pl').

turno_preparacao:-
    inimigo_inicial,
    jogador_combate_init.

visualiza_status:-
    writeln("Dê uma olhada nos seus status e nos status de seu inimigo. Quando utilizar um item ou poção os atributos vão ser adicionados aos seus status básicos. Quando você utiliza um equipamento ou poção, ele é descartado após o combate, logo, tenha cuidado no que vai usar.\n"),
    writeln("Status Inimigo: "),
    exibe_inimigo,
    formata_texto,
    writeln("Seus Status: "),
    exibe_jogador_combate,
    formata_texto.

ataque_heroi:-
    get_ataque_heroi(Ataque),
    recebe_dano_inimigo(Ataque),
    exibe_inimigo.

ataque_inimigo:-
    get_ataque_inimigo(Ataque),
    recebe_dano(Ataque),
    exibe_jogador_combate.

verifica_inimigo_morto:- get_vida_inimigo(Vida), Vida=:=0.
verifica_heroi_morto:- get_vida_heroi(Vida), Vida=:=0.
verifica_pocoes_tomadas:-get_pocoes_tomadas(Pocoes_Tomadas), Pocoes_Tomadas=:=6. %desbloquear conquista.

morte_dano:- 
    writeln("Você morreu, sei que é complicado digerir isso mas é um jogo então sempre da pra voltar! Porém, você perdeu TODAS AS MOEDAS.\n"),
    esperandoEnter.


