






.MODEL SMALL
.STACK 100H
.DATA

RES DB 100 DUP(?) 

SMALLEST_CHAR DB 130
BIGGEST_CHAR DB 60


S_MSG DB "Smallest alphabet: $"
B_MSG DB "Biggest alphabet: $"

.CODE

MAIN PROC 
     
    MOV AX, @DATA
    MOV DS, AX
    
    CALL TAKE_INPUT
    
    CHECK_CASES:
        
        CMP RES[DI],'$' ; END OF STRING
        JE OUTPUT
        
        MOV BL, RES[DI] 
        
        CMP BL, BIGGEST_CHAR ; IF > BIGGEST, MAKE IT BIG
        JA  UPDATE_BIGGEST
        
        PROCESS_FURTHER:
        
        MOV BL, RES[DI]
        
        CMP BL, SMALLEST_CHAR ; IF < SMALLEST, MAKE IT SMALL
        JB  UPDATE_SMALLEST
    
        JMP NEXT         ; CHECK NEXT ONE
         
        
            UPDATE_BIGGEST:
                MOV BL, RES[DI]
                MOV BIGGEST_CHAR, BL
                    
                JMP PROCESS_FURTHER
            
            UPDATE_SMALLEST:  
                MOV BL, RES[DI]
                MOV SMALLEST_CHAR, BL
                    
                JMP NEXT

        
    NEXT:
        INC DI
        JMP CHECK_CASES
    
    OUTPUT:
        ; SMALLEST CHARACTER
        
        MOV AH, 09H
        LEA DX, S_MSG
        INT 21H
        
        MOV AH, 02H
        MOV DL, SMALLEST_CHAR
        INT 21H
        
        MOV AH,2 
        MOV DL, 13 ; 13 = 0DH
        INT 21H
        MOV DL, 10 ; 10 = 0AH
        INT 21H
        
        ; BIGGEST CHARACTER
        
        MOV AH, 09H
        LEA DX, B_MSG
        INT 21H
        
        MOV AH, 02H
        MOV DL, BIGGEST_CHAR
        INT 21H

    
  EXIT:
    MOV AH, 4CH
    INT 21H    
   
  
  
MAIN ENDP


TAKE_INPUT PROC
    
    ;TAKE INPUT
     
    MOV AH, 1
    MOV DI, 0
    MOV SI, 0
    
    INPUT:
        INT 21H
    
        CMP AL, 0DH ; IF PRESSED ENTER
        JZ EXIT_INPUT
    
        MOV RES[SI], AL;ELSE STORE AS ARRAY
        INC SI
        JMP INPUT
  
    EXIT_INPUT:
        ;ADJUST CARET AND GOTO NEW LINE. 
    
        MOV AH,2 
        MOV DL, 13 ; 13 = 0DH
        INT 21H
        MOV DL, 10 ; 10 = 0AH
        INT 21H
    
        MOV RES[SI], '$'   

RET
   
TAKE_INPUT ENDP 

END MAIN
