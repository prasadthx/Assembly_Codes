section .data

msg db "Enter the Hex Number", 0ah
msg_len equ $-msg

emsg db "Number is not valid", 0ah
emsg_len equ $-emsg

%macro print 2
	mov	rax, 1
	mov	rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro input 2
	mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro exit 0
    mov rax, 60 
    mov rdi, 0
    syscall
%endmacro

;-----------------------------------------------------

section .bss

buffer resb 2
num resb 2
num_len equ $-num

;------------------------------------------------------
section .text

global _start
_start:

    print msg, msg_len
 
    call accept
    ; mov bx, 48
    mov [num],bx
    print num, 2
    
    exit

accept:

    input buffer, 2   

    mov rcx, 2
    mov rsi, buffer
    mov rbx, 0

    next_byte:
    shl bx, 8
    mov al,[rsi]

    cmp al, '0'
    jb error1
    cmp al,'9'
    jbe continue

    cmp al,'A'
    jb error1
    cmp al,'F'
    jbe continue

    cmp al,'a'
    jb error1
    cmp al,'f'
    jbe continue


error1: print emsg, emsg_len
exit

continue:

inc rsi
dec rcx
jnz next_byte

mov bx, [buffer]
ret


;nasm -f elf64 -o acceptHex.o acceptHex.asm && ld acceptHex.o -o acceptHex && ./acceptHex