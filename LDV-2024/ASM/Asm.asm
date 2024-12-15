.586
.model flat, stdcall
includelib libucrt.lib
includelib kernel32.lib
includelib "../Debug/lib.lib"
ExitProcess PROTO:DWORD 
.stack 4096

ExitProcess PROTO :DWORD
outn PROTO : SDWORD
outw PROTO : DWORD
outnf PROTO : SDWORD
outwf PROTO : DWORD
len PROTO : DWORD
comp PROTO : DWORD, : DWORD
stcmp PROTO : DWORD, : DWORD

.const
		newline byte 13, 10, 0
L1 byte 'Это процедура', 0
L2 sdword 2
L3 sdword 9
L4 byte 'Максимальное число больше 5', 0
L5 sdword 5
L6 byte 'sdfgh', 0
L7 byte 'Project', 0
L8 byte 'Projec!', 0
L9 byte 'Длины строк равны', 0
L10 byte 'Длины строк НЕ равны', 0
L11 byte ' ', 0
L12 sdword 10
L13 sdword 32
.data
		temp sdword ?
		buffer byte 256 dup(0)

find_maxmax sdword 0
max sdword 0
text dword ?
res dword ?
str1 dword ?
str2 dword ?
strc1 sdword 0
strc2 sdword 0
answer1 sdword 0
answer2 sdword 0
math1 sdword 0
math2 sdword 0
math3 sdword 0
math4 sdword 0
math5 sdword 0
check1 sdword 0
check2 sdword 0
res2 sdword 0
left dword ?
rig dword ?
result sdword ?
result_str byte 4 dup(0)
.code
int_to_char PROC uses eax ebx ecx edi esi,
pstr: dword,
intfield : sdword
mov edi, pstr
mov esi, 0
mov eax, intfield
cdq
mov ebx, 10
idiv ebx
test eax, 80000000h
jz plus
neg eax
neg edx
mov cl, '-'
mov[edi], cl
inc edi
plus :
push dx
inc esi
test eax, eax
jz fin
cdq
idiv ebx
jmp plus
fin :
mov ecx, esi
write :
pop bx
add bl, '0'
mov[edi], bl
inc edi
loop write
ret
int_to_char ENDP


;----------- find_max ------------
find_max PROC,
	find_maxx : sdword, find_maxy : sdword  
; --- save registers ---
push ebx
push edx
; ----------------------
push find_maxx

pop ebx
mov left, ebx

push find_maxy

pop ebx
mov rig, ebx

mov edx, left
cmp edx, rig

jg right1
jl wrong1
 right1:
push find_maxx

pop ebx
mov find_maxmax, ebx


jmp next1
wrong1:
push find_maxy

pop ebx
mov find_maxmax, ebx

next1:
; --- restore registers ---
pop edx
pop ebx
; -------------------------
mov eax, find_maxmax
ret
find_max ENDP
;------------------------------


;----------- foo ------------
foo PROC,
	fooxxx : dword  
; --- save registers ---
push ebx
push edx
; ----------------------
; --- restore registers ---
pop edx
pop ebx
; -------------------------
mov eax, fooxxx
ret
foo ENDP
;------------------------------


;----------- func ------------
func PROC 
	
; --- save registers ---
push ebx
push edx
; ----------------------

INVOKE outwf, offset L1

; --- restore registers ---
pop edx
pop ebx
; -------------------------
ret
func ENDP
;------------------------------


;----------- MAIN ------------
main PROC

call func

push L2
push L3
call find_max
push eax

pop ebx
mov max, ebx

mov text, offset L4
push max

pop ebx
mov left, ebx

push L5

pop ebx
mov rig, ebx

mov edx, left
cmp edx, rig

jg right2
jmp next2
 right2:

INVOKE outwf, text

next2:
mov res, offset L6

INVOKE outwf, res

mov str1, offset L7
mov str2, offset L8
push str1
call len
push eax

pop ebx
mov strc1, ebx

push str2
call len
push eax

pop ebx
mov strc2, ebx

push strc1

pop ebx
mov left, ebx

push strc2

pop ebx
mov rig, ebx

mov edx, left
cmp edx, rig

jz right3
jnz wrong3
 right3:
mov text, offset L9

jmp next3
wrong3:
mov text, offset L10
next3:

INVOKE outwf, text

push str1
push str2
call comp
push eax

pop ebx
mov answer1, ebx

push str1
push str1
call comp
push eax

pop ebx
mov answer2, ebx

mov eax, answer1
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outw, offset result_str


INVOKE outw, offset L11

mov eax, answer2
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outwf, offset result_str

push L5
push L2
pop ebx
pop eax
sub eax, ebx
push eax

pop ebx
mov math1, ebx

push L5
push L2
pop ebx
pop eax
add eax, ebx
push eax

pop ebx
mov math2, ebx

push L5
push L2

	pop ebx
	pop eax
	test ebx, ebx
	jz EXIT_DIV_ON_NULL
	cdq
	mov	edx, 	0
	idiv ebx
	push edx
pop ebx
mov math3, ebx

push L5
push L2
pop ebx
pop eax
imul eax, ebx
push eax

pop ebx
mov math4, ebx

push L5
push L2

	pop ebx
	pop eax
	test ebx, ebx
	jz EXIT_DIV_ON_NULL
	cdq
	mov	edx, 	0
	idiv ebx
	push eax
pop ebx
mov math5, ebx

mov eax, math1
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outwf, offset result_str

mov eax, math2
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outwf, offset result_str

mov eax, math3
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outwf, offset result_str

mov eax, math4
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outwf, offset result_str

mov eax, math5
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outwf, offset result_str

push L12

pop ebx
mov check1, ebx

push L13

pop ebx
mov check2, ebx

push check1
push check2
pop ebx
pop eax
add eax, ebx
push eax

pop ebx
mov res2, ebx

mov eax, check1
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outwf, offset result_str

mov eax, check2
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outwf, offset result_str

mov eax, res2
mov result, eax	
 lea edi, result_str
 mov ecx, 4
 xor al, al
 rep stosb
INVOKE int_to_char, offset result_str, result
INVOKE outwf, offset result_str

INVOKE ExitProcess,0
EXIT_DIV_ON_NULL:
INVOKE ExitProcess,-1
main ENDP
end main
