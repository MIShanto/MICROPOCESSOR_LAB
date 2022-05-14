 INCLUDE 'EMU8086.INC'

.MODEL SMALL
.STACK 100H

.DATA
    n DB ?
    divisor DB ?
    
.CODE
    MAIN PROC
        PRINT 'Enter an integer between 0 to 9 : '
        
        MOV AH,1
        INT 21H
        
        SUB AL,48
        CMP AL,1
        JE NOT_PRIME
        
        
        MOV n,AL
        MOV divisor, AL
        
        DEC divisor
        
        FOR:
            MOV AH,0
            CMP divisor,1
            JE ENDFOR
            
            DIV divisor
            
            CMP AH,0
            JE NOT_PRIME
        
            MOV AL,n
            DEC divisor
            
            JMP FOR
        
        ENDFOR:
        CALL NEWLINE
        PRINT 'It is Prime.'
        JMP EXIT
        
        NOT_PRIME:
        CALL NEWLINE
        PRINT 'It is not Prime.'
        
        EXIT:        
        MOV AH,4CH
        INT 21H
MAIN ENDP
    
    
    
NEWLINE PROC
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        RET
NEWLINE ENDP

END MAIN