.386
.model flat,stdcall
option casemap:none
MessageBoxA PROTO :dword,:dword,:dword,:dword
MessageBox equ <MessageBoxA>
Includelib user32.lib
NULL equ 0
MB_YESNO equ 4
MB_OK equ 0

.stack 4096

.data
szTitle byte '杨旋',0
szMsg byte '1120131802',0
szYes byte '你选择的是yes',0
szNo byte '你选择的是no',0

.code
start:
	invoke 	MessageBox,
			NULL,
			offset szMsg,
			offset szTitle,
			MB_YESNO
	cmp EAX,6
	jz YES
	cmp EAX,7
	jz NO
YES:
	invoke 	MessageBox,
			NULL,
			offset szYes,
			offset szTitle,
			MB_OK
	ret
NO:
	invoke 	MessageBox,
			NULL,
			offset szNo,
			offset szTitle,
			MB_OK
	ret
end			start

