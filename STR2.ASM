.MODEL SMALL

PRINTM  MACRO   MSG
        LEA DX,MSG
        MOV AH,09H
        INT 21H
ENDM

.DATA

;-------DECLARATIONS-----

        EXTRN   STR1:BYTE
        EXTRN   STR2:BYTE
        EXTRN   MSG1:BYTE
        EXTRN   MSG2:BYTE
        EXTRN   MSG3:BYTE
        EXTRN   MSG4:BYTE
        EXTRN   MSG5:BYTE
        EXTRN   MSG6:BYTE
        EXTRN   CNT:BYTE

        EXTRN   BUFF:BYTE
        

.CODE
        MOV AX,@DATA
        MOV DS,AX

;-------MAKE PROCEDURES PUBLIC

        PUBLIC ACCEPT
        PUBLIC SHOW
        PUBLIC CONCAT
        PUBLIC SUBSTRING



;-------ACCEPT STRINGS FROM USER----------

ACCEPT   PROC    FAR

        PRINTM MSG1 ;ENTER FIRST STRING

        LEA DX,STR1
        MOV AH,0AH
        INT 21H

        PRINTM MSG2  ;ENTER SECOND STRING

        LEA DX,STR2
        MOV AH,0AH
        INT 21H
        RET
ENDP
;----------------------------------------




SHOW    PROC    FAR
;--------DISPLAY STRING CHARACTER BY CHARACTER----
;--------DISPLAY FIRST STRING---------
        PRINTM MSG3
        LEA SI,STR1
        MOV CL,[SI+1]

LOOP1:  MOV DL,[SI+2]
        MOV AH,02H
        INT 21H
        INC SI
        DEC CL
        JNZ LOOP1

;--------DISPLAY SECOND STRING---------
        PRINTM MSG4
        LEA SI,STR2
        MOV CL,[SI+1]

LOOP2:  MOV DL,[SI+2]
        MOV AH,02H
        INT 21H
        INC SI
        DEC CL
        JNZ LOOP2
       
        RET
ENDP




;--------STRING CONCAT----------
CONCAT  PROC    FAR

        LEA SI,STR1     ;LOAD FIRST STING
        LEA DI,BUFF     ;LOAD BUFFER

        MOV CL,[SI+1]
        MOV CH,00

        INC SI          ;INCREMENT SI TWICE TO POINT STR1+2
        INC SI

        CLD             ;RESET DIRECTION FLAG

REP    MOVSB            ;COPY CHARS.


        LEA SI,STR2     ;LOAD SECOND STRING

        MOV CL,[SI+1]
        MOV CH,00

        INC SI          ;INC SI TWICE TO POINT STR+2
        INC SI


        CLD

REP     MOVSB

        MOV  [DI],'$'   ;ENTER A $ CHARACTER TO DENOTE END OF STRING


;-------DISPLAY CONCATENETED STRING------------
        PRINTM MSG5
        
        MOV DX,OFFSET BUFF
        MOV AH,09H
        INT 21H

        RET
ENDP




;-------------OCCURENCE OF PATTERN IN STRING-----------

SUBSTRING       PROC    FAR

        PRINTM  MSG6

        MOV CNT,00      ;LOAD COUNT=0

        LEA DX,BUFF
        MOV AH,0AH
        INT 21H

        LEA SI,STR1     ;LOAD STRING 
        MOV CH,[SI+1]

        
RESET:  LEA DI,BUFF     ;LOAD PATTERN
        MOV CL,[DI+1]


COMPARE:MOV AL,[SI+2]
        CMP AL,[DI+2]
        JNE NEXT

        INC SI
        INC DI
        DEC CL  ;DERCEMENT PATTERN
        CMP CL,00
        JNE COMPARE     ;IF PATTERN NOT END GOTO COMPARE
        INC CNT
        JMP NEXT2
        
NEXT:   INC SI
NEXT2:  LEA DI,BUFF
        DEC CH
        CMP CH,00
        JNE COMPARE

       


DISP_CNT:MOV AH,02H
        MOV DL,13
        INT 21H

        MOV AH,02H
        MOV DL,10
        INT 21H


        MOV DL,CNT
        ADD DL,30H
        MOV AH,02H
        INT 21H

        RET
ENDP









END



        
