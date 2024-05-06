:- module(combate_mecanica , [visualiza_status/1, ataque_heroi/1, ataque_inimigo/1,ataque_inimigo_especial/1,
                              turno_preparacao/0, morte_dano/0, morte_pocao/0, toma_pocao/0]).

:- use_module('../Util/lib.pl').
:- use_module('../Models/inimigo.pl').
:- use_module('../Models/jogador.pl').
:- use_module('../Mecanica/loja.pl').

turno_preparacao:-
    writeln("O que nosso herói vai fazer para ficar mais forte??\n\n"),
    inputNumber("(1)Equipar um item.\n(2)Usar poção.\n(3)Lutar.\n\n", Input),
    turno_preparacao_aux(Input).

turno_preparacao_aux(1) :- equipa_item, esperandoEnter, turno_preparacao.
turno_preparacao_aux(2) :- tomar_pocao, esperandoEnter, turno_preparacao.
turno_preparacao_aux(3) :- writeln("Dê uma olhada nos seus status e nos status de seu inimigo.\nQuando utilizar uma poção os atributos vão ser adicionados aos seus status básicos, ao usar essa é descartado após o combate, logo, tenha cuidado no que vai usar.\n\n").
turno_preparacao_aux(_) :- writeln("Opção inválida, tente novamente"), turno_preparacao.

visualiza_status(Nome_inimigo):-
    writeln("Status Inimigo: "),
    exibe_inimigo(Nome_inimigo),
    formata_texto,
    writeln("Seus Status: "),
    exibe_jogador_combate,
    formata_texto.

ataque_heroi(Nome_Inimigo):-
    get_ataque_heroi(Ataque),
    recebe_dano_inimigo(Nome_Inimigo, Ataque),
    exibe_inimigo(Nome_Inimigo), nl,
    esperandoEnter.

ataque_inimigo(Nome_Inimigo):-
    get_ataque_inimigo(Nome_Inimigo, Ataque),
    recebe_dano(Ataque),
    exibe_jogador_combate, nl.

ataque_inimigo_especial(Nome_Inimigo):-
    get_habilidade_especial_inimigo(Nome_Inimigo, Habilidade),
    recebe_dano(Habilidade),
    exibe_jogador_combate, nl.

toma_pocao:-
    writeln("Nosso herói precisa se abastecer vamos lá"),
    tomar_pocao.

morte_dano:- 
    printString("Você morreu, sei que é complicado digerir isso mas é um jogo então sempre da pra voltar! Porém, você perdeu TODAS AS MOEDAS.\n").

morte_pocao:-
    printString("Seu coração te da uma pontada... VOCÊ... VOCÊ INFARTOU!!"),
    desbloquea_conquista("Infarto").
    


