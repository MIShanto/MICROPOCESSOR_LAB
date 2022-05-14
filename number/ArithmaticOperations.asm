






.MODEL SMALL
.STACK 100H
.DATA

ADDITION DB ?
SUBTRACTION DB ?
MULTIPLICATION DW ?
DIVISION DB ?


A_MSG DB "ENTER TWO SINGLE DIGIT FOR ADDITION: $"
S_MSG DB "ENTER TWO SINGLE DIGIT FOR SUBTRACTION: $"
M_MSG DB "ENTER TWO SINGLE DIGIT FOR MULTIPLICATION: $"
D_MSG DB "ENTER TWO SINGLE DIGIT FOR DIVISION: $"  

A_OUT_MSG DB "ADDITION RESULT: $"  
S_OUT_MSG DB "SUBTRACTION RESULT: $"
M_OUT_MSG DB "MULTIPLICATION RESULT: $"
D_OUT_MSG DB "DIVISION RESULT: $"

.CODE

MAIN PROC 
     
    MOV AX, @DATA
    MOV DS, AX
    
    ; ADDITION
    
    LEA DX, A_MSG
    MOV AH, 09H
    INT 21H
    
    ; TAKE INPUT
    
    MOV AH, 01H
    INT 21H ; 1ST INPUT
    
    MOV BL, AL     
    SUB BL, 30H ; CONVERT CHAR TO DIGIT
    
    INT 21H ; 2ND INPUT
    
    SUB AL, 30H ; CONVERT CHAR TO DIGIT
    ADD BL, AL
    
    MOV ADDITION, BL
    ADD ADDITION, 30H ; CONVERT DIGIT TO CHAR
    
    MOV AH, 02H
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    
    
    
    
    
    
    
    
    
    
    
    
    ; SUBTRACTION
    
    LEA DX, S_MSG
    MOV AH, 09H
    INT 21H
    
    ; TAKE INPUT
    
    MOV AH, 01H
    INT 21H ; 1ST INPUT
    
    MOV BL, AL     
    SUB BL, 30H ; CONVERT CHAR TO DIGIT
    
    INT 21H ; 2ND INPUT
    
    SUB AL, 30H ; CONVERT CHAR TO DIGIT
    SUB BL, AL
    
    MOV SUBTRACTION, BL
    ADD SUBTRACTION, 30H ; CONVERT DIGIT TO CHAR  
    
    MOV AH, 02H
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
                
                
                
                
                
                
                
                
    ; MULTIPLICATION  ; MULTIPLIES AL BY SOURCE [ MUL SOURCE ] RES = AX
                                     
    LEA DX, M_MSG
    MOV AH, 09H
    INT 21H
    
    ; TAKE INPUT
    
    MOV AH, 01H
    INT 21H ; 1ST INPUT
    
    MOV BL, AL     
    SUB BL, 30H ; CONVERT CHAR TO DIGIT
    
    INT 21H ; 2ND INPUT
    
    SUB AL, 30H ; CONVERT CHAR TO DIGIT   
    
    MUL BL ; MULTIPLIES WITH AL
    
    MOV MULTIPLICATION, AX
    ADD MULTIPLICATION, 30H ; CONVERT DIGIT TO CHAR
    
    MOV AH, 02H
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H     
    
    ; DIVISION   ; DIVIDES AX BY SOURCE [ DIV SOURCE ] RES = AL(DIVISION), AH(REMAINDER)
    
    LEA DX, D_MSG
    MOV AH, 09H
    INT 21H
    
    ; TAKE INPUT 

    MOV AX, 0 ; CLEAR AX
    MOV AH, 01H
    INT 21H ; 1ST INPUT
    
    MOV BX, 0     
    SUB AL, 30H  ; CONVERT CHAR TO DIGIT
    MOV BL, AL   ; 1ST IS STORED IN BX
        
    INT 21H ; 2ND INPUT
    
    MOV DL, AL
    SUB DL, 30H  ; CONVERT CHAR TO DIGIT
    
    MOV AX, BX    ; 1ST IS IN AX
    
    DIV DL ; DIVIDES AX BY DL
    
    MOV DIVISION, AL
    ADD DIVISION, 30H  ; CONVERT DIGIT TO CHAR 
    
    MOV AH, 02H
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    
       
       
       
       
       
       
       
       
    OUTPUT: 
        ;ADDITION
        
        MOV AH, 09H
        LEA DX, A_OUT_MSG
        
        MOV AH, 02H
        MOV DL, ADDITION
        INT 21H

        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        
        ;SUBTRACTION
        
        MOV AH, 09H
        LEA DX, S_OUT_MSG
        
        MOV AH, 02H
        MOV DL, SUBTRACTION
        INT 21H

        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H 
        
        ;MULTIPLICATION
        
        MOV AH, 09H
        LEA DX, M_OUT_MSG
        
        MOV AH, 02H
        MOV DX, MULTIPLICATION
        INT 21H

        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H  
        
        ;DIVISION
        
        MOV AH, 09H
        LEA DX, D_OUT_MSG
        
        MOV AH, 02H
        MOV DL, DIVISION
        INT 21H

        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
    
    
    
    
MAIN ENDP 

END MAIN



@COMMENT ; TAKE MULTIPLE DIGIT INPUT
 
.MODEL SMALL
.STACK 100H
.DATA
MSG DB "ENTER A NUMBER: $"
TOTAL DB 0
VALUE DB 0
.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, MSG
    INT 21H
    
    READ:
    MOV AH, 1
    INT 21H
    
    CMP AL, 13
    JE ENDOFNUMBER
    
    MOV VALUE, AL
    SUB VALUE, 48
    
    MOV AL, TOTAL
    MOV BL, 10
    MUL BL
    
    ADD AL, VALUE
    
    MOV TOTAL, AL
    
    JMP READ

    ENDOFNUMBER:   

MAIN ENDP

@