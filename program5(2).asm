
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
sin proto C :dword
ExitProcess proto:dword
printf proto C:dword,:vararg
scanf proto C:dword,:vararg
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;数据段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data   
    x dword 0
	x1 qword 0
	x2 dword 0
    szFmt byte '%d',0ah,0
    szFmtin byte '%d',0
    szFmtf byte '%f',0ah,0
    i dword 0
    j dword 0
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
   	
   		dec n
   		invoke fbnq,n
   		pop ebx
   		add eax,ebx
   		ret
   fbnq endp
   
start:
	invoke scanf,offset szFmtin,offset x
	xor ebx,ebx
	mov ebx,x
	add ebx,ebx
	add ebx,1
	mov i,ebx
	
	fild i;
	sub esp,8
	fstp qword ptr [esp];
	
	call sin
	
	add esp,8

	invoke fbnq,x
	mov x2,eax
	fimul x2
	fst x1
	
	invoke printf,offset szFmtf,x1
    invoke scanf,offset szFmtin,offset x
    endprocess:invoke ExitProcess,NULL ;程序退出
end start;  代码段结束




