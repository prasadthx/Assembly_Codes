section .data 

msg db "Enter the String to find its length (MAX 99)"
msg_len equ $-msg

msg2 db "Entered String is: "
msg2_len equ $-msg2

msg3 db "The length of the string is: "
msg3_len equ $-msg3

newline db 0ah
newline_len equ $-newline


%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro input 1
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, 20
    syscall
%endmacro

%macro exit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

;------------------------------------------------------------------------------

section .bss

string resb 20

count resd 1

dispnum resb 2  

;------------------------------------------------------------------------------

section .text
global _start

_start:

    print msg, msg_len
    print newline, newline_len

    input string
    mov [count], rax
    
    print msg2, msg2_len
    print string, [count]
    
    print msg3, msg3_len
 
    mov rax, [count]
    mov rsi,dispnum + 1           ;rsi points to 2nd location of dispnum
    mov rax,[count]             ;rax now stores value of count
    mov rcx,2                   ;rcx gets initiaised with 2

    counter:                        ;counter label
        mov rdx,0                   ;rdx gets initiaised with 0
        mov rbx,10                  ;rbx gets initialised with 10
        div rbx                     ;divide the contents of rax by rbx
        add dl,30h                  ;add 30 to the remainder
        mov [rsi],dl                ;dl content gets copied at rsi 
        dec rsi                     ;decrement rsi
        loop counter                ;Loop till rcx = 0

    print dispnum, 2
    print newline, newline_len
    
    exit



;nasm -f elf64 -o printStringLength.o printStringLength.asm && ld printStringLength.o -o printStringLength && ./printStringLength
