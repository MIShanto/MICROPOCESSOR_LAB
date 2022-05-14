







.MODEL SMALL
.STACK 100H 

.DATA 

D1 dw 123

.CODE

MAIN PROC FAR
	MOV AX, @DATA
	MOV DS, AX

    ;load the value stored;
    MOV AX, D1

    ;convert the value to binary, print the value
	CALL DEC_TO_BIN
	
	MOV AH, 2
	MOV DL, 10
	INT 21H
	MOV DL, 13
	INT 21H
	
	MOV AX, D1
    CALL DEC_TO_HEX
    
    ;interrupt to exit
	MOV AH, 4CH
	INT 21H

MAIN ENDP
		
DEC_TO_HEX PROC

    ;initialize count
	MOV CX, 0
	MOV DX, 0
	
	LABEL1: ;if ax is zero
		CMP AX, 0
		JE PRINT1

        ;initialize bx to 16 mov bx, 16
        MOV BX, 16 ; DIVISOR

        ;divide it by 16 to convert it to HEX
	    DIV BX

        ;push it in the stack
	    PUSH DX ; DX = REMAINDER

        ;increment the count
	    INC CX

        ;set dx to 0
        XOR DX, DX		
        JMP LABEL1
        
    PRINT1:

        ;check if count is greater than zero
	    CMP CX, 0
	    JE EXIT1

        ;pop the top of stack
        POP DX

	    ;compare the value with 9
	    CMP DX, 9
	    JLE CONTINUE1
	    
  
        ;if value is greater than 9
        ;then add 7 so that after adding 48 it represents A
        ;for example 10 + 7 + 48 = 65
        ;which is ASCII value of A
        ADD DX, 7
          
    CONTINUE1:
  
        ;add 48 so that it represents the ASCII value of digits
        ADD DX, 48
  
        ;interrupt to print
        MOV AH, 2
        INT 21H
        
        ;decrease the count
        DEC CX
        JMP PRINT1

	EXIT1:             
	    RET

DEC_TO_HEX ENDP

DEC_TO_BIN PROC

    ;initialize count
	MOV CX, 0
	MOV DX, 0
	
	LABEL2: ;if ax is zero
		CMP AX, 0
		JE PRINT2

        ;initialize bx to 2 mov bx, 2
        MOV BX, 2 ; DIVISOR

        ;divide it by 2 to convert it to binary
	    DIV BX

        ;push it in the stack
	    PUSH DX ; DX = REMAINDER

        ;increment the count
	    INC CX

        ;set dx to 0
        XOR DX, DX		
        JMP LABEL2
        
    PRINT2:

        ;check if count is greater than zero
	    CMP CX, 0
	    JE EXIT2

        ;pop the top of stack
        POP DX

        ;add 48 so that it represents the ASCII value of digits
	    ADD DX, 48

        ;PRINT
        MOV AH, 2
        INT 21H

        ;decrease the count
	    DEC CX
	    JMP PRINT2
	    
	EXIT2:             
	    RET

DEC_TO_BIN ENDP

END MAIN
