.MODEL SMALL

.STACK 100H

.DATA
    IVPASS DW 'Invalid Password $'  
    VPASS DW 'Valid Password $'   
    C1 DB 30H  
    C2 DB 30H
    C3 DB 30H

.CODE

MAIN PROC
;initialize DS
    MOV AX, @DATA
    MOV DS, AX
    
    WHILE:
       MOV AH, 1
       INT 21H 
       CMP AL, 21H
       JL  RESULT 
       
       CMP AL, 7EH
       JG  RESULT 
        
       CMP AL, 30H 
       JL WHILE
       
       CMP AL, 39H  
       JLE DIGIT   
       
       CMP AL, 41H 
       JL WHILE
       
       CMP AL, 5AH  
       JLE UPPER   
       
       CMP AL, 61H 
       JL WHILE
       
       CMP AL, 7AH  
       JLE LOWER
       
    DIGIT:
       ADD C1, 1
       JMP WHILE
       
    UPPER:
       ADD C2, 1
       JMP WHILE
       
    LOWER:
       ADD C3, 1
       JMP WHILE
       
    RESULT: 
       
       CMP C1, 30H
       JLE NOO
       
       CMP C2, 30H
       JLE NOO
       
       CMP C3, 30H
       JLE
        NOO 
       
       LEA DX, VPASS
       MOV AH, 09H
       INT 21H  
       JMP EXIT
       
       
    NOO: 
       LEA DX, IVPASS
       MOV AH, 09H
       INT 21H 
       
    EXIT:  
       
       MOV DX, 13 
       MOV AH, 2
       INT 21H
       MOV DX, 10
       MOV AH, 2
       INT 21H  
       JMP DEBUG
    DEBUG:
       MOV DL, C1 
       MOV AH, 2
       INT 21H
       
       MOV DL, C2 
       MOV AH, 2
       INT 21H
       
       MOV DL, C3 
       MOV AH, 2
       INT 21H
    
    
;DOX exit
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

    END MAIN