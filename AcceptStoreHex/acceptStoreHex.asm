section .data 

msg db "Enter 5 hexadecimal numbers: ", 0ah
msg_len equ $-msg

msg2 db 0ah, "Entered numbers are: " , 0ah
msg2_len equ $-msg2

newline db 0ah
newline_len equ $-newline

time equ 05

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

_input resb 20

_output resb 20

array resb 300

count resb 1

;----------------------------------------------------

section .text

global _start

_start:

    print msg, msg_len

    mov byte[count], time

    mov rbp, array

    acceptnum:
        input _input, 17
        call asciiToHex
        mov [rbp], rbx
        add rbp, 8
        dec byte[count]
        jnz acceptnum

    mov byte[count], time
    mov rbp, array
    print msg2, msg2_len

    display:
        mov rax, [rbp]
        call hexToAscii
        print _output, 16
        print newline, newline_len
        add rbp, 8
        dec byte[count]
        jnz display

    exit


asciiToHex:
    	mov rsi, _input
    	mov rcx,16
    	mov rbx, 0  
        mov rax, 0   
    alphabet:	
        shl rbx, 4    
    	mov al, [rsi] 
    	cmp al, 39h   
    	jbe number     
    	sub al, 07h   
    number:	
        sub al, 30h   
    	add bl, al  
    	inc rsi      
    	dec rcx      
    	jnz alphabet
ret	

hexToAscii:
        mov rdi, _output+15   
        mov rcx,16           
    alphabet2:	
        mov rdx, 0
        mov rbx,16         
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
ret

;nasm -f elf64 -o acceptStoreHex.o acceptStoreHex.asm && ld acceptStoreHex.o -o acceptStoreHex && ./acceptStoreHex