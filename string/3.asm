






.MODEL SMALL
.STACK 100H
.DATA

RES DB 100 DUP(?)
NO_OF_DIGITS DB 0
NO_OF_VOWELS DB 0
NO_OF_CONSONANTS DB 0
NO_OF_WORDS DB 0

W_MSG DB "No of words: $"
V_MSG DB "No of vowels: $"
C_MSG DB "No of consonants: $"
D_MSG DB "No of digits: $"

.CODE

MAIN PROC 
     
    MOV AX, @DATA
    MOV DS, AX
  
    ;TAKE INPUT
     
    MOV AH, 1
    MOV DI, 0
    MOV CX, 0; ALTERNATIVE = MOV XOR CX, CX
    MOV BL, 0 ; USED FOR WORDS LOGIC TRACKING
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
    
    CHECK_CASES:
        
        CMP RES[DI],'$' ; END OF STRING
        JE IS_IT_THE_LAST_WORD
        JNE PROCESS_FURTEHR
        
        IS_IT_THE_LAST_WORD:
            CMP BL, 1
            JE COUNT_FINAL_WORD
            JMP OUTPUT
            
            COUNT_FINAL_WORD:
                INC NO_OF_WORDS
                JMP OUTPUT
            
        PROCESS_FURTEHR:
        
        CMP RES[DI], " " ; IF SPACE FOUND AND HAS A LETTER BEFORE IT, COUNT AS WORD
        JE  IS_IT_WORD
        
        MOV BL, 1 ; ANY CHAR IS FOUND BEFORE A SPACE
        
        CMP RES[DI], '0' ; IF LESS PASS
        JL NEXT  
    
        CMP RES[DI], '9' ; IF GREATER THEN CHECK FOR VOWELS AND CONSONANTS
        JG IS_IT_VOWEL
    
        INC NO_OF_DIGITS ; COUNT AS DIGIT
    
        JMP NEXT         ; CHECK NEXT ONE 
        
            IS_IT_WORD:
                CMP BL, 1
                JE COUNT_WORD
                
                JMP NEXT
                
                COUNT_WORD:
                    MOV BL, 0
                    INC NO_OF_WORDS
                    
                    JMP NEXT
            
            IS_IT_VOWEL:  
    
                CMP RES[DI], 'a'  
                JE COUNT_VOWEL  
                
                CMP RES[DI], 'A'  
                JE COUNT_VOWEL
                
                CMP RES[DI], 'e'  
                JE COUNT_VOWEL  
                
                CMP RES[DI], 'E'  
                JE COUNT_VOWEL
                
                CMP RES[DI], 'i'  
                JE COUNT_VOWEL  
                
                CMP RES[DI], 'I'  
                JE COUNT_VOWEL
                
                CMP RES[DI], 'o'  
                JE COUNT_VOWEL  
                
                CMP RES[DI], 'O'  
                JE COUNT_VOWEL
                
                CMP RES[DI], 'u'  
                JE COUNT_VOWEL  
                
                CMP RES[DI], 'U'  
                JE COUNT_VOWEL
                
                JMP IS_IT_CONSONANT ; IF ALL CHECKS FAILS SEE IS IT IS CONSONATS
                
                COUNT_VOWEL:
                    INC NO_OF_VOWELS
                    JMP NEXT
                
                IS_IT_CONSONANT:
                    CMP RES[DI], 'A'
                    JL NEXT
                    
                    CMP RES[DI], 'Z'
                    JG CHECK_LOWERCASES
                    
                    INC NO_OF_CONSONANTS
                    
                    JMP NEXT
                    
                    CHECK_LOWERCASES:
                        CMP RES[DI], 'a'
                        JL NEXT
                        
                        CMP RES[DI], 'z'
                        JG NEXT
                        
                        INC NO_OF_CONSONANTS
                        
                        JMP NEXT
        
    NEXT:
        INC DI
        JMP CHECK_CASES
    
    OUTPUT:
        ; WORDS
        
        MOV AH, 09H
        LEA DX, W_MSG
        INT 21H
        
        MOV AH, 02H
        MOV DL, NO_OF_WORDS
        ADD DL, 48
        INT 21H
        
        MOV AH,2 
        MOV DL, 13 ; 13 = 0DH
        INT 21H
        MOV DL, 10 ; 10 = 0AH
        INT 21H
        
        ; VOWELS
        
        MOV AH, 09H
        LEA DX, V_MSG
        INT 21H
        
        MOV AH, 02H
        MOV DL, NO_OF_VOWELS
        ADD DL, 48
        INT 21H
        
        MOV AH,2 
        MOV DL, 13 ; 13 = 0DH
        INT 21H
        MOV DL, 10 ; 10 = 0AH
        INT 21H
        
        ; CONSONATS
        
        MOV AH, 09H
        LEA DX, C_MSG
        INT 21H
        
        MOV AH, 02H
        MOV DL, NO_OF_CONSONANTS
        ADD DL, 48
        INT 21H
        
        MOV AH,2 
        MOV DL, 13 ; 13 = 0DH
        INT 21H
        MOV DL, 10 ; 10 = 0AH
        INT 21H
        
        ; DIGITS
        
        MOV AH, 09H
        LEA DX, D_MSG
        INT 21H
        
        MOV AH, 02H
        MOV DL, NO_OF_DIGITS
        ADD DL, 48
        INT 21H
        
        MOV AH,2 
        MOV DL, 13 ; 13 = 0DH
        INT 21H
        MOV DL, 10 ; 10 = 0AH
        INT 21H
    
  EXIT:
    MOV AH, 4CH
    INT 21H    
   
  
  
MAIN ENDP
END MAIN
