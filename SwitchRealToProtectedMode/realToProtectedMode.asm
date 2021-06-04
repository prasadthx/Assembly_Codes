section .data

title db 10, "ALP to print the values of GDTR, LDTR, IDTR, TR"
title_len equ $-title

gdtmsg db 10, "GDT Contents | "
gmsg_len equ $-gdtmsg

ldtmsg db 10, "LDT Contents | "
lmsg_len equ $-ldtmsg

idtmsg db 10, "IDT Contents | "
imsg_len equ $-idtmsg

trmsg db 10, "TR  Contents | "
trmsg_len equ $-trmsg

mswmsg db 10, "MSW Contents | "
mswmsg_len equ $-mswmsg

colmsg db ":"

rmodemsg db 10, "Processor In | Real Mode"
rmodemsg_len equ $-rmodemsg

pmodemsg db 10, "Processor In | Protected Mode"
pmodemsg_len equ $-pmodemsg

count db 04h

newline db 0ah
newline_len equ $-newline

%macro print 2
    mov rax,1
    mov rdi,1
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

%macro exit 0
    mov rax,60
    mov rdi,0
    syscall
%endmacro

;-------------------------------------------------------------------------

section .bss

g:	resd 1
	resw 1

l:	resw 1

idtr:	resd 1
    	resw 1

msw:	resd 1

tr:	resw 1

value :resb 4

;-------------------------------------------------------------------------

section .text

global _start

_start:
    
    print title,title_len
    
    smsw [msw]
    mov eax,dword[msw]
    bt eax,0
    jc next
    
    print rmodemsg, rmodemsg_len
    jmp exit
    
    next:
        print pmodemsg, pmodemsg_len
        
        ;---GDTR---
        print gdtmsg, gmsg_len
        SGDT [g]
        mov bx, word[g+4]
        call display
        mov bx,word[g+2]
        call display
        mov bx, word[g]
        call display

        ;---LDTR---
        print ldtmsg, lmsg_len
        SLDT [l]
        mov bx,word[l]
        call display


        ;--- IDTR ---
        print idtmsg, imsg_len
        SIDT [idtr]
        mov bx, word[idtr+4]
        call display
        mov bx,word[idtr+2]
        call display
        mov bx, word[idtr]
        call display


        ;---- TR ----
        print trmsg, trmsg_len
        mov bx,word[tr]
        call display

        ;---- MSW ----
        print mswmsg, mswmsg_len
        mov bx, word[msw+2]
        call display
        mov bx, word[msw]
        call display

        print newline, newline_len
        
        exit


display:	
    mov rdi,value
    mov byte[count],4
    alphabet:
        rol bx,04
        mov cl,bl
        and cl,0Fh
        cmp cl,09h
        jbe number
        add cl,07H
    number: 
        add cl, 30H
        mov byte[rdi],cl
        inc rdi
        dec byte[count]
        jnz alphabet
        print value, 4
ret

;nasm -f elf64 -o realToProtectedMode.o realToProtectedMode.asm && ld realToProtectedMode.o -o realToProtectedMode && ./realToProtectedMode