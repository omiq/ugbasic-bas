DIM X as INT: DIM Y as INT: DIM DX as INT: DIM DY as INT: DIM P as INT: DIM B as INT: DIM OB as INT: DIM OP as INT: DIM DELAY as INT: DIM K$ as STRING*1
DIM PADDLE$ as STRING*40: PADDLE$=" {DOWN}{LEFT}"+CHR$(208)+"{DOWN}{LEFT}"+CHR$(246)+"{DOWN}{LEFT}"+CHR$(246)+"{DOWN}{LEFT}"+CHR$(246)+"{DOWN}{LEFT}"+CHR$(250)+"{DOWN}{LEFT} "
POKE 211, 0

INIT:
    X=10: Y=10: DX=1: DY=1: P=0: B=0: OB=0: K$="": DELAY=0
    PRINT CHR$(147)

LOOP: 
    X=X+DX
    Y=Y+DY
    IF X<1 AND Y>0 AND (Y<P OR Y>(P+6)) THEN GOTO GAMEOVER
    IF X=40 OR X<1 THEN 
        DX=DX*-1 
        X=X+DX
    END IF

    IF Y=25 OR Y<0 THEN 
        DY=DY*-1
        Y=Y+DY
    END IF

    OB=B
    POKE OB, 32
    B=1024+(Y*40)+X
    POKE B,87

CONTROLS:
    GET K$ 
    IF K$="Q" or K$="q" THEN 
        OP=P
        P=P-1
    END IF
    IF K$="A" or K$="a" THEN 
        OP=P
        P=P+1
    END IF
    IF P<0 OR P=18 THEN P=OP

DRAWPADDLE:
    POKE 214, P
    SYS 58732
    PRINT PADDLE$

    FOR DELAY =1 TO 1000: NEXT DELAY
    GOTO LOOP

GAMEOVER:
    PRINT CHR$(147);"               game over{13}              play again?"
    REM PRINT X,Y,P
    WAITKEY:
    GET K$: IF K$="Y" OR K$="y" THEN GOTO INIT
    GOTO WAITKEY