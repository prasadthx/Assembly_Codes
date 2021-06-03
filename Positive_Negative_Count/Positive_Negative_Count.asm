section .data

pmsg db "The number of positive numbers are: "
pmsg_len equ $-pmsg

nmsg db 0ah,"The number of negative numbers are: "
nmsg_len equ $-nmsg

array dq -4h,70h, 54h, -19h, 20h
array_len equ 5

newline db 0ah

;----------------------------
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
;------------------------------------------------

section .bss

displayDigit resb 2
positiveCount resb 8
negativeCount resq 1

;------------------------------------------------

section .text

global _start

_start:
    mov rsi, array
    mov rbx, array_len

    mov rcx, 0
    mov rdx, 0

    back:
        mov rax, [rsi]
        shl rax, 1

        jc negative
        
        positive:
        add rcx, 1
        jmp next

        negative:
        add rdx, 1

        next:
        add rsi, 8
        dec rbx
        jnz back
    
    mov [positiveCount], rcx
    mov [negativeCount], rdx

    print pmsg, pmsg_len
    mov rax, [positiveCount]
    call display
    print nmsg, nmsg_len
    mov rax, [negativeCount]
    call display

    print newline, 1
    
    exit


;------------------------------------------------
display: 
    
    mov rbx, 16
    mov rcx, 2
    mov rsi, displayDigit+1

    loop:

    mov rdx, 0
    div rbx

    cmp dl, 09h
    jbe add30
    add dl, 07h

    add30:
    add dl, 30h

    mov [rsi], dl
    dec rsi
    dec rcx

    jnz loop

    print displayDigit, 2

    ret
