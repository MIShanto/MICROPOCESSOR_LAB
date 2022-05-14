






.MODEL SMALL
.STACK 100H
.DATA

STR DB 100 DUP ?
I_MSG DB "Enter the string: $"
O_MSG DB "After Sorting: $"
    
N DW ?

.CODE

MAIN PROC FAR 
     
    MOV AX, @DATA
    MOV DS, AX 
    
    LEA DX,I_MSG 
    MOV AH,09H
    INT 21H
    
    MOV SI,0
    MOV DI,0
    
    CALL PROCESS_INPUT
    
    CALL SORT
            
    CALL PRINT
    
    MOV AH,4CH
    INT 21H 
   
    
MAIN ENDP 


PROCESS_INPUT PROC
    
   INPUT:
        MOV AH,1
        INT 21H 
        
        CMP AL,0DH
        JZ ENDINPUT
     
        MOV STR[SI], AL 
        INC SI
           
        JMP INPUT 
        
    ENDINPUT: 
    
RET 

PROCESS_INPUT ENDP 


SORT PROC
    ;sorting segment increasing order (Using bubble sort)
    MOV N, SI;
    SUB N, 1
        
    MOV CX,N
    
    OUTTOP:
        MOV SI,0
        MOV DI,1           

        TOP:
            MOV AL, STR[SI]    
            CMP AL, STR[DI]
            JL SKIP ; JG to decreasing order sort
                
            XCHG AL, STR[DI]
            MOV STR[SI], AL
                
        SKIP:
                
            CMP DI,N
            JZ ENDTOP
           
            INC DI
            INC SI
            JMP TOP:
        
        ENDTOP:        
            LOOP OUTTOP

RET
            
SORT ENDP
            
PRINT PROC

    ;Printing segment
    CALL NEWLINE
    
    LEA DX,O_MSG 
    MOV AH,09H
    INT 21H   
     
    INC N
    MOV DI,0
     
    OUTPUT:
        MOV DL, STR[DI]
        CMP DI,N
        JZ ENDOUTPUT
        
        MOV DL,STR[DI]
        MOV AH,2
        INT 21H
        
        INC DI   
        
        JMP OUTPUT
        
    ENDOUTPUT: 
   
RET

PRINT ENDP

NEWLINE PROC
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H 
    
RET        

NEWLINE ENDP


END MAIN