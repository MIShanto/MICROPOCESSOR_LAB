





INCLUDE 'EMU8086.INC'


.MODEL SMALL
.STACK 100H

.DATA

    SUM DB ?
    N DB ?
    
.CODE   

MAIN PROC
    MOV AX, @DATA
    MOV DX, AX
    
    MOV SUM, 0
    ;MOV DIVISOR, 2
    PRINT 'Enter an integer between 1 to 3 : '
    
    MOV AH, 1
    INT 21H
    
    SUB AL, 48
    MOV N, AL
    
    CALL NEWLINE
        
    PROCESS:
        CMP N, 0
        JE OUTPUT
        
        MOV BL, SUM 
        ADD BL, N  
        
        MOV SUM, BL
        
        DEC N
        JMP PROCESS
        
    OUTPUT:
        ADD SUM, 48
    
        PRINT 'SUM = '
    
        MOV AH,2
        MOV DL,SUM
        INT 21H
      
        MOV AH, 4CH
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