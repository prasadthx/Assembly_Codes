section .data

msg db "Math Operations:", 0ah
msg_len equ $-msg

digit db 0, 10

%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro exit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

section .text

global _start

_start:
    print msg, msg_len
    mov rax, 6
    mov rbx, 3
    mov rdx, 0
    div rbx           ; Division performed. rax/rbx => rax --> quotient, rdx --> remainder
    call displayDigit ; Displays 2 at the console

    mov rax, 1
    add rax, 5        ; Addtion performed. 
    call displayDigit ; Displays 6 at the console

    mov rax, 5
    inc rax           ; Increments rax by 1. 
    call displayDigit ; Displays 6 at the console
           
    call displayDigit ; Displays 2 at the console IMPORTANT=>After syscall rax's value is 2
    dec rax           ; Decrements rax by 1
    call displayDigit ; Displays 1 at the console

    mov rax, 3
    mov rbx, 2
    mul rbx           ; Multiplication performed. rax=rax*rbx 
    call displayDigit ; Displays 6 at the console

    mov rax, 10
    mov rbx, 7
    sub rax, rbx
    call displayDigit ; Displays 3 at the console.
    exit


displayDigit:
    add rax, 48
    mov [digit], al
    print digit, 2
    ret
        

