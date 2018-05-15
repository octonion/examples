section .text
	global _start
 
	_print:
		mov ebx, 1
		mov eax, 4
		int 0x80
		ret
 
	_start:
		;print out our byte array. ergo, String.
		mov edx, sLen
		mov ecx, sArray
		call _print
		mov edx, f_len
		mov ecx, f_msg
		call _print
		mov edx, 6			;our array members length.
		xor ecx, ecx
		mov ecx, 4
		;turnicate through the array and print all it's members.
		;At an offset of *4, each array member is referenced
		;at 1,2,3 and so on. 
		_out_loops:
			push ecx
			mov ecx, [fArray+esi*4]
			call _print
			inc esi
			pop ecx
		loop _out_loops
		mov edx, u_len
		mov ecx, u_msg
		call _print
		;Let's populate 'uArray' with something from sArray.
		;mov edi, uArray
		mov ecx, 4
		xor esi, esi
		_read_loops:	
			push dword [fArray+esi*4]
			pop dword [uArray+esi*4]
			inc esi
		loop _read_loops
		mov ecx, 4
		xor esi, esi
		_out_loops2:
			push ecx
			mov ecx, [uArray+esi*4]
			call _print
			inc esi
			pop ecx
		loop _out_loops2
		push 0x1
		mov eax, 1
		push eax
		int 0x80
 
section .data
sArray	db 'a','r','r','a','y','s',' ','a','r','e',' ','f','u','n',0xa
sLen		equ $-sArray
 
crap1		db "crap1",0xa
crap2		db "crap2",0xa
crap3		db "crap3",0xa
crap4		db "crap4",0xa
 
fArray	dd crap1,crap2
	dd crap3,crap4
 
f_msg		db "fArray contents",0xa,"----------------------",0xa
f_len		equ $-f_msg
u_msg		db "uArray now holds fArray contents.. dumping..",0xa,"----------------------",0xa
u_len		equ $-u_msg
 
section .bss
uArray	resd 1
        resd 1
	resd 1
	resd 1
