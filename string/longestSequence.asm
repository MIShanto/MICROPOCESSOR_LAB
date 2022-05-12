






.MODEL SMALL
.STACK 100H
.DATA

RES DB 100 DUP(?) 

START_INDEX DW 0
END_INDEX DW 0

LONGEST_SEQ DB 100 DUP(?)

OLD_SEQ_LENGTH DB 0
NEW_SEQ_LENGTH DB 0

OUTPUT_MSG DB "Longest alphabetic sequence: $"

.CODE

MAIN PROC 
     
    MOV AX, @DATA
    MOV DS, AX
    
    CALL TAKE_INPUT
    
    CHECK_CASES:
        
        CMP RES[DI],'$' ; END OF STRING
        JE OUTPUT   
        
        CMP RES[DI],'a' ; IF FIRST LETTER IS SMALLER. WHOLE STRING IS IN LOWERCASE SO PROCESS LIKEWISE.. 
        JAE  IS_LOWERCASE
        
        CMP RES[DI],'A' ; IF FIRST LETTER IS CAPITAL. WHOLE STRING IS IN UPPERCASE SO PROCESS LIKEWISE.. 
        JAE IS_UPPERCASE
        
        IS_LOWERCASE:
            CMP RES[DI],'z' ; WHOLE STRING IS IN LOWERCASE SO PROCESS LIKEWISE.. 
            JBE CALC_FOR_LOWERCASE
            
            CALC_FOR_LOWERCASE:   
                INC NEW_SEQ_LENGTH
    
                MOV SI, DI      ; SI = NEXT INDEX,   DI = CURRENT INDEX
                INC SI
                
                MOV BL, RES[DI]
                INC BL           ; BL HOLDS THE NEXT INDEX CONTENT NOW
                
                CMP BL, RES[SI]  ; IF IT IS THE NEXT LETTER, SET END_INDEX TO SI
                JE SET_END_INDEX_L
                JNE SET_START_INDEX_L ; ELSE IT IS NOT THE NEXT LETTER, RESET START_INDEX TO SI
                
                SET_END_INDEX_L:
                    MOV END_INDEX, SI
                    JMP EXIT_METHOD_L
                    
                SET_START_INDEX_L:
                    ; STORE THE FOUND SEQUENCE AT FIRST IF IT IS THE LONGEST THAN PREVIOUS..
                    MOV BL, OLD_SEQ_LENGTH 
                    
                    CMP NEW_SEQ_LENGTH, BL
                    JG  STORE_SEQUENCE_L
                    JNE PROCEED_WITHOUT_STORING_L
                    
                    STORE_SEQUENCE_L:
                    
                    MOV DX, DI
                    MOV DI, 0  ; WILL BE USED AS CURRENT INDEX OF THE SEQUENCE ARRAY 
                     
                    MOV SI, START_INDEX
                    
                    INSERT_TO_ARRAY_L:
                    
                        MOV BL, RES[SI]
                 
                        MOV LONGEST_SEQ[DI], BL
                
                        CMP SI, END_INDEX
                        JE STORING_DONE_L
                        
                        INC DI
                        INC SI
                        JMP INSERT_TO_ARRAY_L
                        
                        STORING_DONE_L:
                            INC DI
                            MOV LONGEST_SEQ[DI], '$'
                            
                            MOV DI, DX
                            MOV SI, DI
                            INC SI
                            
                            MOV BL, NEW_SEQ_LENGTH
                            MOV OLD_SEQ_LENGTH, BL
                            
                            
                    PROCEED_WITHOUT_STORING_L:
                        MOV START_INDEX, SI
                        MOV END_INDEX, SI
                        MOV NEW_SEQ_LENGTH, 0   
                        
            EXIT_METHOD_L:
            
            JMP NEXT
            
        IS_UPPERCASE:
            CMP RES[DI],'Z' ; WHOLE STRING IS IN UPPERCASE SO PROCESS LIKEWISE.. 
            JBE CALC_FOR_UPPERCASE
            
            CALC_FOR_UPPERCASE:   
                INC NEW_SEQ_LENGTH
    
                MOV SI, DI      ; SI = NEXT INDEX,   DI = CURRENT INDEX
                INC SI
                
                MOV BL, RES[DI]
                INC BL           ; BL HOLDS THE NEXT INDEX CONTENT NOW
                
                CMP BL, RES[SI]  ; IF IT IS THE NEXT LETTER, SET END_INDEX TO SI
                JE SET_END_INDEX_U
                JNE SET_START_INDEX_U ; ELSE IT IS NOT THE NEXT LETTER, RESET START_INDEX TO SI
                
                SET_END_INDEX_U:
                    MOV END_INDEX, SI
                    JMP EXIT_METHOD_U
                    
                SET_START_INDEX_U:
                    ; STORE THE FOUND SEQUENCE AT FIRST IF IT IS THE LONGEST THAN PREVIOUS..
                    MOV BL, OLD_SEQ_LENGTH 
                    
                    CMP NEW_SEQ_LENGTH, BL
                    JG  STORE_SEQUENCE_U
                    JNE PROCEED_WITHOUT_STORING_U
                    
                    STORE_SEQUENCE_U:
                    
                    MOV DX, DI
                    MOV DI, 0  ; WILL BE USED AS CURRENT INDEX OF THE SEQUENCE ARRAY 
                     
                    MOV SI, START_INDEX
                    
                    INSERT_TO_ARRAY_U:
                    
                        MOV BL, RES[SI]
                 
                        MOV LONGEST_SEQ[DI], BL
                
                        CMP SI, END_INDEX
                        JE STORING_DONE_U
                        
                        INC DI
                        INC SI
                        JMP INSERT_TO_ARRAY_U
                        
                        STORING_DONE_U:
                            INC DI
                            MOV LONGEST_SEQ[DI], '$'
                            
                            MOV DI, DX
                            MOV SI, DI
                            INC SI
                            
                            MOV BL, NEW_SEQ_LENGTH
                            MOV OLD_SEQ_LENGTH, BL
                            
                            
                    PROCEED_WITHOUT_STORING_U:
                        MOV START_INDEX, SI
                        MOV END_INDEX, SI
                        MOV NEW_SEQ_LENGTH, 0   
                        
            EXIT_METHOD_U:
            
            JMP NEXT
        
    NEXT:
        INC DI
        JMP CHECK_CASES
    
    OUTPUT:
        ; SMALLEST CHARACTER
        
        MOV AH, 09H
        LEA DX, OUTPUT_MSG
        INT 21H
        
        ; PRINT THE SEQUENCE...
        MOV AH, 2              
        MOV SI, 0
        WHILE_$:
            CMP LONGEST_SEQ[SI], '$' ; END OF STRING
            JE EXIT
               
            MOV DL, LONGEST_SEQ[SI]
            INT 21H
            
            INC SI
            JMP WHILE_$
    
  EXIT:
    MOV AH, 4CH
    INT 21H    
   
  
  
MAIN ENDP


TAKE_INPUT PROC ; INPUT FUNCTION
    
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
