






.MODEL SMALL
.STACK 100H
.DATA

N DB 0
VALUE DB 0
COUNT DW 0

.CODE

MAIN PROC 
     
    MOV AX, @DATA
    MOV DS, AX 
    
    CALL INPUT
    
    CALL OUTPUT
    MOV AH, 2
    MOV DL, N
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    
   
    
MAIN ENDP 


INPUT PROC
    
    MOV AX, @DATA
    MOV DS, AX 
    
    READ:
    MOV AH, 1
    INT 21H
    
    CMP AL, 13
    JE ENDOFNUMBER
    
    MOV VALUE, AL
    SUB VALUE, 48
    
    MOV AL, N
    MOV BL, 10
    MUL BL
    
    ADD AL, VALUE
    
    MOV N, AL
    
    JMP READ

    ENDOFNUMBER: 
    
    MOV AH, 2
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H 
    
    RET 

INPUT ENDP 

OUTPUT PROC
    
    ;initialize count
    MOV COUNT, 0
    
    ; SET DIVIDEND  
    MOV AH, 0
    MOV AL, N
    MOV BH, 0
    
    LABEL1:
        MOV CH, AH
        MOV AH, 2
        MOV DL, AL
        ;ADD DL, 48
        INT 21H
        MOV AH, 0
        
        ; if AL (QUOTIENT) is zero  
        CMP AL, 0
        JE EXIT    
         
        ;initialize BL (DIVISOR) to 10 
        MOV BL, 10     
        
        
                MOV CH, AH
        MOV AH, 2
        MOV DL, 0
        MOV DL, AL
        ;ADD DL, 48
        INT 21H
        MOV AH, 0 
        
        ; extract the last digit
        DIV BL                 
        
        MOV CH, AH
        
        MOV AH, 2
        MOV DL, CH
        ;ADD DL, 48
        INT 21H 
        
         
        ;push REMAINDER (AH) in the stack
       ; push dx             
         
        ;increment the count
        INC COUNT             
         
        ;set REMAINDER to 0
        MOV AH, 0
        MOV CH, 0
        
        JMP LABEL1
        
    print1:
        ;check if count
        ;is greater than zero
        cmp cx,0
        je exit
         
        ;pop the top of stack
        pop dx
         
        ;add 48 so that it
        ;represents the ASCII
        ;value of digits
        add dx,48
         
        ;interrupt to print a
        ;character
        mov ah,02h
        int 21h
         
        ;decrease the count
        dec cx
        jmp print1
exit:
ret 

OUTPUT ENDP

END MAIN