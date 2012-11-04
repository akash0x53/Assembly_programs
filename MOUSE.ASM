.MODEL SMALL

.DATA
        STATUS  DW 0
        X       DW 0
        Y       DW 0
        LOC_X   DW 0
        LOC_Y   DW 0


.CODE

        MOV AX,@DATA
        MOV DS,AX


        ;CLEAR SCREEN

        MOV AH,06       
        MOV AL,00
        MOV BH,02
        MOV CX,0000 ;UPPER LEFT X,Y
        MOV DH,24   ;Y CORD    
        MOV DL,79   ;X CORD
        INT 10H

        ;WRITE CHARS

        MOV AX,0B800H
        MOV ES,AX
        MOV AL,'X'
        MOV AH,09

        MOV SI,090

        MOV ES:[SI],AX
        ADD SI,2
        MOV AL,':'
        MOV ES:[SI],AX
        MOV LOC_X,SI

        MOV SI,106

        MOV AL,'Y'
        MOV ES:[SI],AX

        MOV AL,':'
        ADD SI,2

        MOV ES:[SI],AX
        MOV LOC_Y,SI


        MOV SI,130
        MOV AL,'['
        MOV ES:[SI],AX

        ADD SI,2

        MOV AL,'X'
        MOV ES:[SI],AX

        ADD SI,2

        MOV AL,']'
        MOV ES:[SI],AX


                
        MOV AX,00
        INT 33H

        MOV AX,01
        INT 33H
     

LOOP1:

        MOV AX,03
        INT 33H

        MOV STATUS,BX
        MOV X,CX
        MOV Y,DX



        CALL XY

        MOV BX,STATUS
        MOV CX,X
        MOV DX,Y
             
        CMP BX,01
        JNE LOOP1

        CALL CLOSE

        CALL BEEP

        JMP LOOP1
    
EXIT:   .EXIT

;-----------BEEP PROCEDURE---------

BEEP    PROC           NEAR

        MOV CX,X
        MOV DX,Y

        CMP CX,100H
        JB ESCP2
        CMP CX,190H
        JA ESCP2
        CMP DX,50H
        JB ESCP2
        CMP DX,80H
        JA ESCP2

        IN AL,61H
        OR AL,00000011B
        OUT 61H,AL
        CALL DELAY
        IN AL,61H
        AND AL,11111100B
        OUT 61H,AL
ESCP2:
       RET
ENDP
;-----------DELAY-----------


DELAY   PROC
     
        MOV CX,0FFFFH
DEC_CX: DEC CX
        JNZ DEC_CX
        RET
ENDP
        

;---------CLOSE--------

CLOSE   PROC

        MOV CX,X
        MOV DX,Y

        

        CMP CX,200H
        JB ESCP
        CMP CX,220H
        JA ESCP
        CMP DX,07
        JA ESCP
        .EXIT

ESCP:

        RET
ENDP         


;--------display (x,y) co-ordinate--------

XY      PROC

        MOV SI,LOC_X
        ADD SI,2

        MOV BX,X
        MOV CL,4

LOOP2:  ROL BX,4
        MOV AL,BL
        SUB AL,30H
        AND AL,0FH
        CMP AL,09H
        JBE NEXT1
        ADD AL,07H
NEXT1:  ADD AL,30H
        MOV AH,09
        MOV ES:[SI],AX
        ADD SI,2
        DEC CL
        CMP CL,00
        JNE LOOP2

        MOV SI,LOC_Y
        ADD SI,2

        MOV BX,Y
        MOV CL,4

LOOP3:  ROL BX,4
        MOV AL,BL
        SUB AL,30H
        AND AL,0FH
        CMP AL,09H
        JBE NEXT2
        ADD AL,07H
NEXT2:  ADD AL,30H
        MOV AH,09
        MOV ES:[SI],AX
        ADD SI,2
        DEC CL
        CMP CL,00
        JNE LOOP3
         

        
        RET
ENDP

END
        





