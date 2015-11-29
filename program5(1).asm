
.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;include
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
includelib user32.lib
includelib kernel32.lib
includelib msvcrt.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;函数声明
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ExitProcess proto:dword
printf proto C:dword,:vararg
scanf proto C:dword,:vararg
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;数据段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data   
    NULL equ 0;此处添加一些初始化过的变量定义
    get_before_number dword 0
    x dword 0
    output dword 0
    szFmt byte '%d',0ah,0
    szFmt2 byte 'error',0ah,0
    szFmtin byte '%d',0
    i dword 0
.data?
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.stack 2048
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.
.const
	NULL equ 0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;代码段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code 
;递归调用斐波那契
   fbnq proc n:dword
        xor eax,eax
   		cmp n,1

   		ja continue_go
   		cmp n,0
   		ja equal_1
equal_0:
   		xor eax,eax
   		ret 		
equal_1:
		mov eax,1  		
   		ret
   		
continue_go:

   		dec n
   		invoke fbnq,n
   		push eax
   		;mov get_before_number,eax
   	
   		dec n
   		invoke fbnq,n
   		pop ebx
   		add eax,ebx
		;add eax,get_before_number
   		ret
   fbnq endp
   
start:
	invoke scanf,offset szFmtin,offset x
	
	while1:
    invoke fbnq,i
    inc i 
    cmp eax,x
    je found_it
   	jg not_found
   	jl contine_to_found_it
	

 contine_to_found_it:
    jmp while1

    
found_it:
	dec i
    invoke printf,offset szFmt,i
    invoke scanf,offset szFmtin,offset x
    jmp endprocess
    
not_found:
    invoke printf,offset szFmt2
    invoke scanf,offset szFmtin,offset x
    endprocess:invoke ExitProcess,NULL ;程序退出
end start;  代码段结束



