.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;include
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
includelib Kernel32.lib
includelib user32.lib
includelib msvcrt.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;函数声明
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
scanf proto c:dword,:vararg
printf proto c:dword,:vararg
ExitProcess proto:dword
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;数据段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data   
    scanf1 dd 0;存输入的5个16进制数
    scanf2 dd 0
    scanf3 dd 0
    scanf4 dd 0
    scanf5 dd 0
    
    count1 dd 0;输出计数
    count2 dd 0
    count3 dd 0
    count4 dd 0
    count5 dd 0
    szInFmtStr byte '%x %x %x %x %x',0;输入
    szOutFmtStr byte '%d %d %d %d %d',0;输出
.data?
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.
.const
	NULL equ 0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;代码段
;算法描述
;int BitCount(unsigned int n)
;{
   ; unsigned int c =0 ; // 计数器
   ; while (n >0)
   ; {
    ;    if((n &1) ==0) // 当前位是1
    ;        ++c ; // 计数器加1
    ;    n >>=1 ; // 移位
   ; }
   ; return c ;
;}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code 
BitCount proc a:dword

	xor edx,edx;unsigned int c =0 ; // edx计数器 
	xor eax,eax 
	mov eax,a
	xor ebx,ebx 
compare:
    mov ebx,1;ebx就是上述的1，和1进行逻辑与
	cmp eax,0  ; while (n >0)
	je out_return ;如果等于0 直接退出返回，否则继续
	and ebx,eax
	cmp ebx,0
	je right_move  
	shr eax,1
	jmp compare
right_move:
	inc edx
	shr eax,1;
	jmp compare
out_return:
	mov eax,edx
	ret	
BitCount endp
	
start: 
   
    ;此处添加代码段的功能代码
    invoke scanf,offset szInFmtStr,offset scanf1,offset scanf2,offset scanf3,offset scanf4,offset scanf5
    invoke BitCount,scanf1
    mov count1,eax
    invoke BitCount,scanf2
    mov count2,eax
    invoke BitCount,scanf3
    mov count3,eax
    invoke BitCount,scanf4
    mov count4,eax
    invoke BitCount,scanf5
    mov count5,eax
    invoke printf,offset szOutFmtStr,count1,count2,count3,count4,count5
    ;防止闪退
    invoke scanf,offset szInFmtStr,offset scanf1,offset scanf2,offset scanf3,offset scanf4,offset scanf5
    invoke ExitProcess,NULL ;程序退出
end start;  代码段结束



