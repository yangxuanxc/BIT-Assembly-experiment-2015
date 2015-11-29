DATAS SEGMENT
;随机生成200个1000以内的无符号10进制数	
array1 dw 443,669,498,949,309,662,609,757,865,173,102,672,612,599,236,955,34,843,924,294,710
	dw 74,492,239,276,625,285,231,333,524,658,987,18,950,846,806,189,695,349,757,12
    dw 436,478,739,127,85,151,277,429,403,370,961,850,889,903,859,347,996,553,904,565
	dw 22,989,647,114,343,432,436,53,93,425,990,185,118,343,644,285,395,732,820,211
	dw 496,666,660,210,761,213,509,768,447,345,868,27,978,325,138,170,809,193,991,407
    dw 841,76,394,928,547,673,652,486,825,122,161,150,705,21,961,743,722,662,733,258
    dw 471,526,955,953,819,123,518,49,20,608,455,953,714,702,656,136,921,218,860,98
	dw 390,393,197,668,255,954,726,208,758,883,827,659,510,39,293,613,454,534,754,968
	dw 287,701,876,205,209,167,912,595,387,580,963,761,898,242,272,774,777,761,493,31
	dw 178,435,535,161,108,372,378,16,822,638,798,495,27,344,206,569,150,496,747

array2 dw 201 dup (0)  ;从400号单元开始 也就是16进制的 190
	dw 0;用于存当前最大的数的地址：ds:[802]
	

searchArray1 dw 20 dup (0) ;804D  0324H申请的用于存放查找无序数组中的数的地址

searchArray2  dw 20 dup (0);同上，用于查找有序的数组开始：844 34c	

 ;在这里，我们查找数 161D 00a1H，在数组中存在两个，
findWitch dw 161;无序数组中，00de 0170   的位置 
;即10进制的222字节即数组的111位置 和 368字节即数组中第184的位置
;在有序数组中，使第 0150 和 0152 的位置，也就是偏移量的
; 400+336=736开始 16进制02e0 也就是数组中的第168 169 两个数
low_idx    dw   ?;886
high_idx   dw   ?;888
DATAS ENDS

STACKS SEGMENT 
    dw 210 dup(2)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;添加数组1的副本；
    mov cx,200
    mov si,0
ar1:
	push [si]
	add si,2
	loop ar1
    
    mov di,0;表示现在向array2中添加了多少个数
    mov cx,200;第2重循环需要循环200次
for2:
    mov si,0;指向array1中当前访问的数
    push cx;
    mov cx,200;第一重循环需要循环200次
    mov dx,0
for1:;第一重循环开始，利用选择排序
	cmp dx,ds:[si];比较dx寄存器中的数，和array1中的数的大小；
	jb smaller
bigger:
	add si,2
	jmp short jp1
	
smaller:
	mov dx,ds:[si];dx保存当前的最大的数
	mov ds:[802],si;ds:[802]指向当前最大的数的地址
	add si,2
jp1:	
	loop for1
	;进入第二重循环中
	pop cx;
	mov 400[di],dx
	mov bx,ds:[802]
	mov [bx], word ptr 0
	add di,2
	loop for2;
    
    ;恢复数组1；
    mov cx,200
    mov si,398
ar2:
	pop [si]
	sub si,2
	loop ar2
	
;查找开始
    ;无序数组
	mov cx, 200
	mov ax, ds:[884]
	mov bx,0
	mov si,0
Search1:
	cmp [si],ax
	je yes1

	jmp short no1
	
yes1:
	mov 804[bx],si;将相等的数据的地址存入数组中
	add bx,2
no1:	
	add si,2;
	loop search1

;有序数组
	mov cx, 200
	mov ax, ds:[884]
	mov bx,0
	mov si,0
Search2:
	cmp 400[si],ax
	je yes2

	jmp short no2
	
yes2:
	mov 844[bx],si;将相等的数据的地址存入数组中
	add bx,2
no2:	
	add si,2;
	loop search2
	
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START




