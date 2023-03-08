
.MODEL SMALL

.STACK 100H

.DATA


; NEWLINE MACRO

CR EQU 0DH
LF EQU 0AH

; VARIABLES UNDECLARED

NUMBER_IN DW ?
TEMP DW ?
TEMP2 DW ?
LEN1 DW ?
LEN2 DW ?

; VARIABLES DECLARED

NUMBER_OUT DW '00000$' 

ARR DW ? 
ARR2 DW ?


.CODE

; MAIN PROCEDURE ==========================================

MAIN PROC
    ; DATA SEGMENT STORED
    MOV AX, @DATA
    MOV DS, AX
   
    CALL ARRAY_INPUT  
    
    CALL NEWLINE
    
    LEA SI, ARR  
    MOV CX, LEN1  
    
    ELEMENT_OUTPUT_LOOP:
    
    MOV AX, [SI]
    ADD SI, 2
        
    CALL INTEGER_OUTPUT
    MOV DL, ' ' 
    MOV AH, 2
    INT 21H  
    
    LOOP ELEMENT_OUTPUT_LOOP   
    
    CALL NEWLINE
    CALL ARRAY_INPUT2 
    CALL NEWLINE 
    LEA SI, ARR2
    MOV CX, LEN2  
   
    
    ELEMENT_OUTPUT_LOOP2:
    
    MOV AX, [SI]
    ADD SI, 2
        
    CALL INTEGER_OUTPUT
    MOV DL, ' ' 
    MOV AH, 2
    INT 21H
    
    LOOP ELEMENT_OUTPUT_LOOP2  
    
    CALL NEWLINE
    
    CALL MINUS
    
    ; ENDPOINT OF MAIN PROCEDURE AND PROGRAM
    END_PROGRAM:
    CALL NEWLINE 
    MOV AH, 4CH
    INT 21H               

MAIN ENDP 

MINUS PROC  
    
    LEA SI, ARR  
    MOV TEMP, SI 
      
    
    OUTER_LOOP:
    MOV SI, TEMP 
    MOV BX, [SI]
    ADD TEMP, 2  
    
    LEA SI, ARR2
    MOV CX, LEN2
    INNER_LOOP:
    MOV AX, [SI]
    ADD SI, 2
    
    CMP AX,BX 
    JE NEXT
    
    CALL INTEGER_OUTPUT 
    MOV DL, ' ' 
    MOV AH, 2
    INT 21H 
    NEXT:  
    LOOP INNER_LOOP
      
    DEC LEN1 
    MOV CX, LEN1
    LOOP OUTER_LOOP
    
    RET
MINUS ENDP

ARRAY_INPUT PROC
    
    LEA SI, ARR 
      
    ELEMENT_INPUT_LOOP:
    
    CALL INTEGER_INPUT  
     
    
    MOV AX, NUMBER_IN
    MOV [SI], AX
    ADD SI, 2  
    INC LEN1 
    
    CMP TEMP2, 1
    JE  END_LOOP
    
    LOOP ELEMENT_INPUT_LOOP  
    
    END_LOOP:
         
    RET
ARRAY_INPUT ENDP 

ARRAY_INPUT2 PROC
    
    LEA SI, ARR2 
      
    ELEMENT_INPUT_LOOP2:
    
    CALL INTEGER_INPUT  
     
    
    
    MOV AX, NUMBER_IN
    MOV [SI], AX
    ADD SI, 2  
    INC LEN2
    
    CMP TEMP2, 1
    JE  END_LOOP2
    
    LOOP ELEMENT_INPUT_LOOP2  
    
    END_LOOP2:
         
    RET
ARRAY_INPUT2 ENDP

 
NEWLINE PROC
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV DL, LF
    INT 21H
    RET
NEWLINE ENDP


INTEGER_INPUT PROC
    
    PUSH AX
    PUSH BX
    
    ; BX RESET
    XOR BX, BX   
    
    MOV TEMP2, 0
    
    NUMBER_INPUT_LOOP:    
    MOV AH, 1
    INT 21H
    
    CMP AL, CR
    JE END_ARRAY
    CMP AL, LF
    JE END_NUMBER_INPUT_LOOP
    CMP AL, 20H
    JE END_NUMBER_INPUT_LOOP
    
        
    CHAR_TO_DIGIT:
    ; CHAR TO DIGIT CONVERSION
    AND AX, 000FH
    
    MOV TEMP, AX
    
    MOV AX, 10
    MUL BX
    ADD AX, TEMP
    MOV BX, AX
    JMP NUMBER_INPUT_LOOP   
    
    
    END_ARRAY:
    MOV TEMP2, 1
    
    
    END_NUMBER_INPUT_LOOP:
    MOV NUMBER_IN, BX
    JMP EXIT_INPUT_PROC

 
    
    
    EXIT_INPUT_PROC:
    
    POP BX
    POP AX
    RET
    
INTEGER_INPUT ENDP


INTEGER_OUTPUT PROC
    
    PUSH AX
    PUSH BX
    PUSH DX
    
    
    CONVERT_TO_CHAR:
    
    LEA DI, NUMBER_OUT
    ADD DI, 5
    
    PRINT_LOOP:
    DEC DI
    MOV DX, 0
    
    MOV BX, 10
    DIV BX
    
    ADD DL, '0'
    MOV [DI], DL 
    
    CMP AX, 0
    JNE PRINT_LOOP
     
    MOV DX, DI
    MOV AH, 9
    INT 21H    
    
    POP DX
    POP BX
    POP AX
    
    RET
    
INTEGER_OUTPUT ENDP    
                      
            

END MAIN 