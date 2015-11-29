STACKS SEGMENT STACK'S'
	DW 64 DUP('ST')
STACKS ENDS
DATA SEGMENT
BUFFER DB 60,?,60 DUP(?)  ;输入缓冲区
PRINT DB 'Please input a string:','$'  ;要输出提示信息
CRLF  DB 0DH,0AH,'$'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACKS
MAIN PROC FAR
     MOV AX,DATA
     MOV DS,AX
     MOV AH,9               ;输出一串提示信息
     LEA DX,PRINT
     INT 21H
     MOV AH,0AH             ;接受一串字符串
     LEA DX,BUFFER
     INT 21H
     MOV AH,9               ;输出回车换行符，以使光标停在新行首
     LEA DX,CRLF
     INT 21H
     MOV CL,BUFFER+1         ;取接收到的字符在CX中
     XOR CH,CH
     LEA SI,BUFFER+2         ;SI指向接收到的第一个字符
     MOV AH,2
A3:  MOV DL,[SI]             ;装入SI指向的字符

	 CMP DL,[SI-1]          
	 JE ACT2
	 
	 INT 21H                 ;显示装入的字符
ACT2:
	 INC SI
     LOOP A3                 ;循环
	 MOV AX,4C00H 
	 INT 21H
MAIN ENDP
CODE ENDS
     END MAIN     
     
    
CODE ENDS
    END START

