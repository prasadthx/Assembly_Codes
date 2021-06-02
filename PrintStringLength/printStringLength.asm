section .data 

msg db "Enter the String to find its length (MAX 20)", 0ah
msg_len equ $-msg

%macro print 1
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, $-%1
    syscall
%endmacro

%macro exit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

section .bss

string resb 20

section .text
global _start

_start:

    print msg_len
    exit






;nasm -f elf64 -o printStringLenth.o printStringLength.asm 
;ld printStringLength.o printStringLength && ./printStringLenth