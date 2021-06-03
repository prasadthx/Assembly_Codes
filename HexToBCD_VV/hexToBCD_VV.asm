section .data

menu db "Enter your choice: ", 0ah
     db "1. HEX to BCD", 0ah
     db "2. BCD to HEX", 0ah
     db "3. Exit", 0ah
     db "Enter your choice: ", 0ah

menu_len equ $-menu

msg1 db "Enter your HEX number: ", 0ah
msg1_len equ $-msg1

msg2 db "Enter your BCD number: ", 0ah
msg2_len equ $-msg2

msg3 db "Equivalent HEX number: ", 0ah
msg3_len equ $-msg3

msg4 db "Equivalent BCD number: ", 0ah
msg4_len equ $-msg4

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

%macro input 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

;----------------------------------------------------------------

section .bss

choice resb 1

number resb 16

answer resb 16

factor resb 16

;---------------------------------------------------------------

section .text

global _start

_start: 

    print menu, menu_len

    input choice, 2

    cmp byte[choice], '1'
    je hexToBCD

    cmp byte[choice], '2'
    je bcdToHEX

    cmp byte[choice], '3'
    jae exit


hexToBCD:
    
    print msg1, msg1_len

    input number, 17

    call asciiHexToHEX

    mov rax, rbx
    mov rbx, 10
    mov rdi, number + 15
    
    loop2:
        mov rdx, 0
        div rbx
        add dl, 30h
        mov [rdi], dl
        dec rdi
        cmp rax, 0
        jne loop2

    print msg4, msg4_len   
    print number, 16

    jmp _start 

asciiHexToHEX:
    mov rsi, number
    mov rcx, 16
    mov rbx, 0
    mov rax, 0

    loop1: 
        rol rbx, 4
        mov al, [rsi]
        cmp al, 39h
        jmp skip
        sub al, 7h
    skip: 
        sub al, 30h
        add rbx, rax
        inc rsi  
        dec rcx
        jnz loop1
    ret      

bcdToHEX: 
    exit

;nasm -f elf64 -o hexToBCD_VV.o hexToBCD_VV.asm && ld hexToBCD_VV.o -o hexToBCD && ./hexToBCD    