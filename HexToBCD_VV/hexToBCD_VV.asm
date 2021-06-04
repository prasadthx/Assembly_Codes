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

newline db 0ah
newline_len equ $-newline

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
    je exit

    exit


hexToBCD:
    
    print msg1, msg1_len

    input number, 5

    call asciiToHex

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
    print newline, newline_len

jmp _start 

bcdToHEX: 
    print msg2, msg2_len
    
    input number, 6

    mov rbp, 5
    mov rsi, number
    mov rbx, 10
    mov rax, 0

    bcdToValue:
            mov cx, 0
            mul bx
            mov cl, [rsi]
            sub cl, 30h
            add ax, cx
            inc rsi
            dec rbp 
            jnz bcdToValue

    mov [factor], ax
    print msg3, msg3_len

    mov rax, [factor]
    call display 
    jmp _start

asciiToHex:
    	mov rsi, number
    	mov rcx, 4
    	mov rbx, 0  
        mov rax, 0   
    alphabet:	
        shl rbx, 4    
    	mov al, [rsi] 
    	cmp al, 39h   
    	jbe num    
    	sub al, 07h   
    num:	
        sub al, 30h   
    	add bl, al  
    	inc rsi      
    	dec rcx      
    	jnz alphabet
ret	

display:
        mov rdi, answer+3
        mov rcx,4  
        mov rbx,16  
    alphabet2:	
        mov rdx, 0
        div rbx              
        cmp dl,09h           
        jbe add30            
        add dl,07h          
    add30:	
        add dl,30h           
        mov [rdi],dl
        dec rdi              
        dec rcx            
        jnz alphabet2
        print answer, 16
ret



;nasm -f elf64 -o hexToBCD_VV.o hexToBCD_VV.asm && ld hexToBCD_VV.o -o hexToBCD && ./hexToBCD    