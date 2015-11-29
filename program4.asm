.386
.model flat,stdcall
option casemap:none

;include 语句区域
includelib msvcrt.lib
includelib user32.lib
includelib Kernel32.lib
printf proto c:dword,:vararg
ExitProcess proto stdcall:dword
.data   ;数据段
    dArray dword 20,15,70,30,32,89,12
    ITEMS equ ($-dArray)/4
    szFmt byte 'dArray[%d]=%d',0ah,0;此处添加一些初始化过的变量定义
    NULL equ 0
    jumpflag byte 0
.data?
    ;此处添加一些没有初始化过的变量定义

.const
    ;此处添加一些常量定义

.code ;代码段开始
start: 
   mov ecx,ITEMS-1
   i10:xor esi,esi
   mov jumpflag,0
   i20:mov eax,dArray[esi*4]
   mov ebx,dArray[esi*4+4]
   cmp eax,ebx
   jl i30
   mov dArray[esi*4],ebx
   mov dArray[esi*4+4],eax
   mov jumpflag,1
   i30:inc esi
   cmp esi,ecx
   jb i20
   cmp jumpflag,0
   je break1;
   loop i10
   break1:xor edi,edi
   i40:
   invoke printf,offset szFmt,edi,dArray[edi*4]
   inc edi
   cmp edi,ITEMS
   jb i40
   nop
   ;此处添加代码段的功能代码
   invoke ExitProcess,NULL;程序退出
end start;  代码段结束






