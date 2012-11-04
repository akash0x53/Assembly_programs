.MODEL SMALL

DISP    MACRO   MSG
        LEA DX,MSG
        MOV AH,09H
        INT 21H
ENDM

.DATA

        STR1    DB      10,?,40 DUP(?)
        STR2    DB      10,?,40 DUP(?)

        M1      DB        13,10,"1: ACCEPT STRING:"
                DB        13,10,"2: DISPLAY STRING:"
                DB        13,10,"3: CONCAT STRINGS:"
                DB        13,10,"4: OCCURENCE OF STRING:"
                DB        13,10,"5: EXIT:"
                DB        13,10,"--------------------:$"

        MSG1     DB      13,10,"ENTER FIRST STRING:$"
        MSG2     DB      13,10,"ENTER SECOND STRING:$"

        MSG3     DB      13,10,"FIRST STRING:$"
        MSG4     DB      13,10,"SECOND STRING:$"
        MSG5     DB      13,10,"CONCATENATED STRING:",13,10,'$'
        MSG6     DB      13,10,"ENTER PATTERN:$"

        BUFF    DB      10,?,40 DUP(?)
        CNT     DB      00

                                            
  

.CODE
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

;-------DECLARATIONS-----
        PUBLIC STR1,STR2
        PUBLIC MSG1,MSG2,MSG3,MSG4,MSG5,MSG6,CNT
        PUBLIC BUFF
        
        EXTRN ACCEPT:FAR
        EXTRN SHOW:FAR
        EXTRN CONCAT:FAR
        EXTRN SUBSTRING:FAR


START:  CALL MENU

        MOV AH,01H
        INT 21H


        CMP AL,31H
        JE INPUT

        CMP AL,32H
        JE OUTPUT

        CMP AL,33H
        JE CONC

        CMP AL,34H
        JE PATTERN

        CMP AL,35H
        JE EXIT

        JMP START

INPUT:  CALL ACCEPT
        JMP START

OUTPUT: CALL SHOW
        JMP START

CONC:   CALL CONCAT
        JMP START

PATTERN: CALL SUBSTRING
        JMP START


EXIT:   MOV AH,4CH
        INT 21H



;----------MENU PROCEDURE---------
MENU    PROC NEAR

        DISP M1

        RET

ENDP



END

