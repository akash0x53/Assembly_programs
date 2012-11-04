.MODEL SMALL

DISP    MACRO MSG
        LEA DX,MSG
        MOV AH,09H
        INT 21H
ENDM


.DATA
        NO      DW 10   DUP(0)
        RES     DW      00
        CNT     DB      0
        CARRY   DB      0

        MSG     DB 13,10,"ENTER NO:$"
        MSG1    DB 13,10,"ENTER SIZE OF ARRAY$"
        MSG2    DB 13,10,"ADDITION=$" 

.CODE

        MOV AX,@DATA
        MOV DS,AX

        DISP MSG1

        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV CNT,AL

;-------ACCEPT ARRAY ELEMENTS---------
        MOV CL,CNT
        LEA SI,NO

INIT:   DISP MSG

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
        INC SI
        INC SI
        DEC CL
        JNZ INIT

        MOV CL,CNT
        MOV BX,00
        LEA SI,NO

ADDING: ADD BX,[SI]
        JNC PROCD
        INC CARRY
PROCD:  INC SI
        INC SI
        DEC CL
        JNZ ADDING

        MOV RES,BX



;-------DISPLAY ARRAY ELEMENTS---------
;        LEA SI,NO
;        MOV CL,CNT
       
;INIT2:  MOV CH,4
;        MOV BX,[SI]

;LOOP2:  ROL BX,4
;        MOV DL,BL
;        AND DL,0FH
;        CMP DL,09H
;        JBE NEXT2
;        ADD DL,07H
;NEXT2:  ADD DL,30H
;        MOV AH,02H
;        INT 21H
;        DEC CH
;        JNZ LOOP2
;        INC SI
;        INC SI
;        DEC CL
;        JNZ INIT2

        DISP MSG2

       
        MOV DL,CARRY
        ADD DL,30H
        MOV AH,02H
        INT 21H


RESLT:  MOV BX,RES
        MOV CL,4

LOOP4:  ROL BX,4
        MOV DL,BL
        AND DL,0FH
        CMP DL,09H
        JBE NEXT3
        ADD DL,07H
NEXT3:  ADD DL,30H
        MOV AH,02H
        INT 21H

        DEC CL
        JNZ LOOP4

        


EXIT:   MOV AH,4CH
        INT 21H
END
        


