section .data
    text1 db "Enter your name: ",0ah
    text2 db "Hello, "
    text1_len equ $-text1
    text2_len equ $-text2

%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2 
    syscall
%endmacro

%macro input 0
    mov rax, 0
    mov rdi, 0
    mov rsi, name
    mov rdx, 16
    syscall
%endmacro

%macro exit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

section .bss
    name resb 16
 
section .text

    global _start

_start:
 
    print text1, text1_len
    input
    print text2, text2_len
    print name, 16
 
    exit
 

