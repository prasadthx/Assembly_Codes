section .data
    
    msg db "Hello world!", 0ah
    
    sblock db 10h,20h,30h,40h,50h,60h,70h   ; size of individual is 1 byte
    sblock_len equ 7
    
    dblock times 7 db 0h
    
    msg1 db "Before : "
    msg1_len equ $-msg1
    
    msg2 db "After : "
    msg2_len equ $-msg2
    
    space db " "
    space_len equ $-space

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

;----------------------------------------------------------------

section .bss 

char_ans resb 2

;----------------------------------------------------------------

section .text

global _start

_start:
        print msg1,msg1_len
        mov rsi,sblock
        call block_display
        
        print msg2,msg2_len
        mov rsi , dblock-2
        call block_display
        
        call block_transfer
        
        print msg1,msg1_len
        mov rsi,sblock
        call block_display
            
        print msg2,msg2_len
        mov rsi,dblock-2
        call block_display       

        exit 
    
block_transfer:
    mov rsi,sblock+6
    mov rdi,dblock+4
    mov rcx,7
    proc_:
        mov al,[rsi]
        mov[rdi],al
        dec rsi
        dec rdi
        dec rcx
        jnz proc_
ret

block_display:
    mov rbp,7
    next_num:
        mov rax,[rsi]
        push rsi
        call display 
        print space , space_len
        pop rsi
        inc rsi
        dec rbp
        jnz next_num
    print newline, newline_len
ret

display: 
   mov rbx,16
   mov rcx,2
   mov rsi,char_ans+1
   back:
        mov rdx,0
        div rbx  			; rax/rbx  o/p -> rdx ->remainder rax->quotient
        cmp dl,09h
        jbe add30
        add dl,07h
   add30:
        add dl,30h
        mov [rsi],dl
        dec rsi
        dec rcx
        jnz back
        print char_ans,2
   ret


;nasm -f elf64 -o overlappedWithoutString.o overlappedWithoutString.asm && ld overlappedWithoutString.o -o overlappedWithoutString && ./overlappedWithoutString