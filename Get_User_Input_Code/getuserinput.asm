section .data
    text1 db "What is your name? "
    text1_len equ $-text1

    text2 db "Hello, "
    text2_len equ $-text2

%macro print 2
    mov rax, 1
    mov rdi, 1
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

section .bss
    name resb 16
 
section .text

    global _start

_start:
 
    print text1, text1_len
    input name, 16
    print text2, text2_len
    print name, 16
 
    exit
 
