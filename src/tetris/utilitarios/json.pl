:- use_module(library(http/json)).

ler_json(CaminhoArquivo, Pontuacao, MenorTempo, MaiorTempo) :-
    exists_file(CaminhoArquivo),
    open(CaminhoArquivo, read, Stream), 
    json_read_dict(Stream, Dicionario), 
    ler_dictionario(Dicionario, Pontuacao, MenorTempo, MaiorTempo),
    close(Stream).

ler_dictionario(Dicionario, Pontuacao, MenorTempo, MaiorTempo) :-
    Dicionario = _{maiorPontuacao: Pontuacao, menorTempo: MenorTempo, maiorTempo: MaiorTempo}.

escrever_json(CaminhoArquivo, Pontuacao, MenorTempo, MaiorTempo) :-
    open(CaminhoArquivo, write, Stream),
    json_write(Stream, _{maiorPontuacao: Pontuacao, menorTempo: MenorTempo, maiorTempo: MaiorTempo}),
    close(Stream).