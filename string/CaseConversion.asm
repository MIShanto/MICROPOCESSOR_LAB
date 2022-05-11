






.MODEL SMALL
.STACK 100H
.DATA

RES DB 100 DUP(?)

.CODE

MAIN PROC 
     
    MOV AX, @DATA
    MOV DS, AX
  
    ; SOLVE NORMALLY
  
    COMMENT @
  
    ;TAKE INPUT
     
    MOV AH, 1
    MOV DI, 0
    MOV CX, 0; ALTERNATIVE = MOV XOR CX, CX
  
    INPUT:
        INT 21H
    
        CMP AL, 0DH ; IF PRESSED ENTER
        JZ EXIT_INPUT
    
        MOV RES[DI], AL;ELSE STORE AS ARRAY
        INC DI
        JMP INPUT
  
    EXIT_INPUT:
        ;ADJUST CARET AND GOTO NEW LINE. 
    
        MOV AH,2 
        MOV DL, 13 ; 13 = 0DH
        INT 21H
        MOV DL, 10 ; 10 = 0AH
        INT 21H
    
        MOV CX, DI
    
    CHECK_CASE:
        DEC DI  
    
        CMP RES[DI], 'A' ; IF LESS CHECK NEXT
        JL NEXT  
    
        CMP RES[DI], 'Z' ; IF GREATER THEN CHECK IF LOWERCASE
        JG IS_IT_LOWERCASE
    
        ADD RES[DI], 20H ; CONVERT UPPER TO LOWER  
    
        JMP NEXT         ; CHECK NEXT ONE
    
            IS_IT_LOWERCASE:  
    
                CMP RES[DI], 'a' ; IF GREATER THEN CHECK LIMIT FOR LOWERCASE
                JL NEXT  
        
                CMP RES[DI], 'z' ; IF GREATER THEN CHECK LIMIT FOR UPPERCASE
                JG NEXT
          
                SUB RES[DI], 20H ; CONVERT LOWER TO UPPER
                
                JMP NEXT
        
    NEXT:
      CMP DI, 0
      JE OUTPUT
      JMP CHECK_CASE
    
    OUTPUT: 
        MOV DL, RES[DI]
        INC DI 
        INT 21H
        LOOP OUTPUT
    
  EXIT:
    MOV AH, 4CH
    INT 21H    
  @   
  
  ; SOLVE BY USING LOGICAL OPERATION 
  
  ;COMMENT @ 
  
  ;TAKE INPUT
     
    MOV AH, 1
    MOV DI, 0
    MOV CX, 0; ALTERNATIVE = MOV XOR CX, CX
  
    INPUT:
        INT 21H
    
        CMP AL, 0DH ; IF PRESSED ENTER
        JZ EXIT_INPUT
    
        MOV RES[DI], AL;ELSE STORE AS ARRAY
        INC DI
        JMP INPUT
  
    EXIT_INPUT:
        ;ADJUST CARET AND GOTO NEW LINE. 
    
        MOV AH,2 
        MOV DL, 13 ; 13 = 0DH
        INT 21H
        MOV DL, 10 ; 10 = 0AH
        INT 21H
    
        MOV CX, DI
    
    CHECK_CASE:
        DEC DI  
    
        CMP RES[DI], 'A' ; IF LESS CHECK NEXT
        JL NEXT  
    
        CMP RES[DI], 'Z' ; IF GREATER THEN CHECK IF LOWERCASE
        JG IS_IT_LOWERCASE
    
        OR RES[DI], 20H ; CONVERT UPPER TO LOWER  
    
        JMP NEXT         ; CHECK NEXT ONE
    
            IS_IT_LOWERCASE:  
    
                CMP RES[DI], 'a' ; IF GREATER THEN CHECK LIMIT FOR LOWERCASE
                JL NEXT  
        
                CMP RES[DI], 'z' ; IF GREATER THEN CHECK LIMIT FOR UPPERCASE
                JG NEXT
          
                AND RES[DI], 0DFH ; CONVERT LOWER TO UPPER
                
                JMP NEXT
        
    NEXT:
      CMP DI, 0
      JE OUTPUT
      JMP CHECK_CASE
    
    OUTPUT: 
        MOV DL, RES[DI]
        INC DI 
        INT 21H
        LOOP OUTPUT
    
  EXIT:
    MOV AH, 4CH
    INT 21H    
  ;@ 
   
  
  
MAIN ENDP
END MAIN
