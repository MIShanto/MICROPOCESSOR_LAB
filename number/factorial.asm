INCLUDE 'EMU8086.INC'

.MODEL SMALL
.STACK 100H

.DATA
    n DB ?
    fact DB ? 
    
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DX, AX
        
    PRINT 'Enter an integer between 0 to 3 : '
        
    MOV AH,1
    INT 21H
    SUB AL,48
        
    CMP AL,0   ; 0! = 1
    JE IS_ZERO
        
    JMP NOT_ZERO
        
    IS_ZERO:
        MOV AL,1
        JMP ENDFOR
        
    NOT_ZERO:        
        MOV n,AL
        DEC n        
       
        FOR:
            CMP n,0
            JE ENDFOR
            
            MUL n
            DEC n
            JMP FOR 
            
        ENDFOR:
        
            MOV fact, AL
            ADD fact,48
        
        CALL NEWLINE 
        
        PRINT 'Factorial : '  
        
        MOV AH,2
        MOV DL,fact
        INT 21H
        
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