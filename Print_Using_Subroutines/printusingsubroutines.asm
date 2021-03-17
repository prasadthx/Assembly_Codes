section .data

msg db "This is printing text to console using subroutines", 0ah, 0 

%macro exit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

section .text

global _start
_start:
    mov rax, msg
    call _print
 
    mov rax, 60
    mov rdi, 0
    syscall
 
 
;input: rax as pointer to string
;output: print string at rax
_print:
    push rax
    mov rbx, 0
_printLoop:
    inc rax
    inc rbx
    mov cl, [rax]
    cmp cl, 0
    jne _printLoop
 
    mov rax, 1
    mov rdi, 1
    pop rsi
    mov rdx, rbx
    syscall
 
    ret