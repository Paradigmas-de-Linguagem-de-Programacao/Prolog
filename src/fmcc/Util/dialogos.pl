:- module(dialogos, [menuInicial/0, contaHistoria/1]).

:- use_module('./lib.pl').

slogan:-
    string_concat(            "----------------------------------------------------------------------------------","\n",Slogan_str1),
    string_concat(Slogan_str1," ███████████       ██           ███         ██████████         ██████████       | \n",Slogan_str2),
    string_concat(Slogan_str2," ███               ████        ████        ███                ███               | \n",Slogan_str3), 
    string_concat(Slogan_str3," ███               ██ ██      ██ ██        ███                ███               |\n",Slogan_str4),
    string_concat(Slogan_str4," ██████████        ██  ██    ██  ██        ███                ███               |\n",Slogan_str5),
    string_concat(Slogan_str5," ███               ██    ██ ██   ██        ███                ███               |\n",Slogan_str6),
    string_concat(Slogan_str6," ███               ██     ███    ██         ██████████         ██████████       |\n",Slogan_str7),
    string_concat(Slogan_str7,"----------------------------------------------------------------------------------",Slogan),
    writeln(Slogan).


menuInicialOpcoes:-
    writeln('Bem-vindo a Fábulas de Magia : Cidadela de Cristal, mais conhecido como FMCC'),
    writeln('Escolha uma opção:'),
    writeln('1 - Começar o jogo'),
    writeln('2 - Carregar o jogo'),
    writeln('3 - Ajuda'),
    writeln('4 - Sair').

menuInicial:-
    slogan,
    menuInicialOpcoes.

contaHistoria([]).

contaHistoria([Frase|RestoHistoria]):-
    printString(Frase),
    contaHistoria(RestoHistoria).