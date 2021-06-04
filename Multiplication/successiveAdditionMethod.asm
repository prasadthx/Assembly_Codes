section .data

n1msg db 10,"Enter first number: "
n1msg_len equ $-n1msg

n2msg db 10,"Enter second number: "
n2msg_len equ $-n2msg

ansmsg db "Your answer is: "
ansmsg_len equ $-ansmsg

newline db 0ah
newline_len equ $-newline

%macro print 2
    mov rax,1
    mov rdi,1
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

%macro input 2
    mov rax,0
    mov rdi,0
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

%macro exit 0
    mov rax,60
    mov rdi,0
    syscall
%endmacro

;------------------------------------------------------------------------------

section .bss

buffer resb 5

buffer_len equ $-buffer

answer resb 16

number1 resw 1

number2 resw 1

answerl resw 1

answerh resw 1

;------------------------------------------------------------------------------

section .text

global _start

_start:
    call successiveAddition
    print newline, newline_len
    exit

successiveAddition:
    
    mov word[answerl], 0
    mov word[answerh], 0 

    print n1msg, n1msg_len
    call accept_16
    mov [number1], bx

    print n2msg, n2msg_len
    call accept_16
    mov [number2], bx

    mov ax, [number1]
    mov cx, [number2]

    cmp cx, 0
    je final

    cmp ax, 0
    je final

    back:
        add [answerl], ax
        jnc next
        inc word[answerh]

    next:
        dec cx
        jnz back

    final:
        print ansmsg, ansmsg_len
        
        mov ax, [answerh]
        call display_16

        mov ax, [answerl]
        call display_16

    ret

accept_16:
        input buffer, 5
    	mov rsi, buffer
    	mov rcx, 4
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

display_16:
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


;nasm -f elf64 -o successiveAdditionMethod.o successiveAdditionMethod.asm && ld successiveAdditionMethod.o -o successiveAdditionMethod && ./successiveAdditionMethod