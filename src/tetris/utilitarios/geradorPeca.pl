gera_peca(0, Peca, (Xo, Yo), (Xf, Yf)) :- gera_I(Peca, (Xo, Yo), (Xf, Yf)).
gera_peca(1, Peca, (Xo, Yo), (Xf, Yf)) :- gera_L(Peca, (Xo, Yo), (Xf, Yf)).
gera_peca(2, Peca, (Xo, Yo), (Xf, Yf)) :- gera_O(Peca, (Xo, Yo), (Xf, Yf)).
gera_peca(3, Peca, (Xo, Yo), (Xf, Yf)) :- gera_R(Peca, (Xo, Yo), (Xf, Yf)).
gera_peca(4, Peca, (Xo, Yo), (Xf, Yf)) :- gera_S(Peca, (Xo, Yo), (Xf, Yf)).
gera_peca(5, Peca, (Xo, Yo), (Xf, Yf)) :- gera_T(Peca, (Xo, Yo), (Xf, Yf)).
gera_peca(6, Peca, (Xo, Yo), (Xf, Yf)) :- gera_Z(Peca, (Xo, Yo), (Xf, Yf)).

gera_I(
    [  
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [1, 1, 1, 1] 
        
    ],
    ( 3,  16), ( 6, 19 )
).

gera_L(
    [ 
        [0, 0, 0],
        [2, 0, 0], 
        [2, 2, 2]
    ],
    ( 4, 17 ), ( 6, 19 )
).

gera_O(
    [
        [3, 3],
        [3, 3]
    ],
    ( 4, 18), (5, 19)
).

gera_R(
    [
        [0, 0, 0],
        [0, 0, 4],
        [4, 4, 4]
    ],
    ( 4, 17 ), ( 6, 19 )
).

gera_S(
    [
        [0, 0, 0],
        [0, 5, 5],
        [5, 5, 0]
    ],
    ( 4, 17 ), ( 6, 19 )
).

gera_T(
    [
        [0, 0, 0],
        [0, 6, 0],
        [6, 6, 6]
    ],
    ( 4, 17 ), ( 6, 19 )
).

gera_Z(
    [
        [0, 0, 0],
        [5, 5, 0],
        [0, 5, 5]
    ],
    ( 4, 17 ), ( 6, 19 )
).