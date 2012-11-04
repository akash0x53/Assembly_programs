.MODEL SMALL


DISP    MACRO MSG
        LEA DX,MSG
        MOV AH,09H
        INT 21H
ENDM


.DATA

        FILE    DB 20 DUP(0)
          
        ERR1    DB 10,13,'NO ARGUMENTS FOUND$'
        ERR2    DB 10,13,'FILE NOT FOUND$'

        BUFF    DB 81
                DB  0
                DB 80 DUP('$')


.CODE

        MOV AX,@DATA
        MOV DS,AX


        MOV AH,62H
        INT 21H
        MOV ES,BX



        MOV SI,80H
        CMP BYTE PTR ES:[SI],00H
        JE NO_ARG

        MOV SI,82H
        LEA DI,FILE

LOOP1:  MOV DL,ES:[SI]
        MOV [DI],DL
        INC SI
        CMP BYTE PTR ES:[SI],0DH
        JE READ_FILE
        INC DI
        JMP LOOP1


READ_FILE:

        MOV AH,3DH
        MOV AL,00H
        LEA DX,FILE
        INT 21H
        JC CREATE_FILE


        MOV BX,AX
        MOV CX,200
        LEA DX,BUFF
        MOV AH,3FH
        INT 21H
        JC NOT_FOUND

        DISP BUFF
        JMP EXIT


CREATE_FILE:
        MOV AH,3CH
        MOV CX,32
        LEA DX,FILE
        INT 21H
        JC NOT_FOUND

        PUSH AX

        MOV AH,0AH
        LEA DX,BUFF
        INT 21H


        POP BX

        MOV AH,40H

        LEA SI,BUFF

        MOV CX,[SI+2]

        MOV DX,SI
        ADD DX,0002
       
        INT 21H
        JC NOT_FOUND
        JMP READ_FILE     







NO_ARG: DISP ERR1
        JMP EXIT

NOT_FOUND:
        DISP ERR2

EXIT:   .EXIT

END

