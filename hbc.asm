.MODEL SMALL

DISP    MACRO   MSG
        LEA DX,MSG
        MOV AH,09H
        INT 21H
ENDM


.DATA
        NO1     DW      00
        DIVS    DW      0AH
        MSG     DB      13,10,"ENTER NO:$"
        MSG1    DB      13,10,"EQUIVALENT BCD:$"
        MSG2    DB      13,10,"ENTER BCD:$"
        MSG3    DB      13,10,"HEX:$"
        CNT     DB      00
        MLP1     DW      10000
        MLP2     DW      1000
        MLP3     DB      100
        MLP4     DB      10
       
        RES     DW      00

.CODE

        MOV AX,@DATA
        MOV DS,AX

        JMP START

        LEA SI,NO1

        DISP MSG

        MOV CH,4

LOOP1:  ROL [SI],4
        MOV AH,01H
        INT 21H
        CMP AL,39H
        JBE NEXT
        SUB AL,07H
NEXT:   SUB AL,30H
        OR BYTE PTR [SI],AL
        DEC CH
        JNZ LOOP1

        MOV AX,NO1

H2B:    MOV DX,0000
        DIV DIVS
        PUSH DX
        INC CNT
        CMP AX,0000
        JNE H2B

        DISP MSG1
        MOV CL,CNT
LOOP2:  POP DX
        ADD DL,30H
        MOV AH,02H
        INT 21H
        DEC CL
        JNZ LOOP2


        MOV RES,00

        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV AH,00
        MUL MLP1

        ADD RES,AX

        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV AH,00
        MUL MLP2

        ADD RES,AX

        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV AH,00
        MUL MLP3

        ADD RES,AX

        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV AH,00
        MUL MLP4

        ADD RES,AX

        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV AH,00
        ADD RES,AX

        MOV AX,RES


start:  MOV AX,0000
        MOV BX,0000
        MOV CL,5

DO1:    MOV AX,0AH
        MUL BX
        MOV BX,AX

        MOV AH,01H
        INT 21H
        SUB AL,30H

        MOV AH,00
        ADD BX,AX

        DEC CL
        JNZ DO1

        MOV RES,BX
        MOV DX,RES
           
        
       
        

EXIT:   MOV AX,4C00H
        INT 21H
END
        
