section .data

sblock db 10h, 20h, 30h, 40h, 50h, 60h, 70h

dblock times 7 db 0h

;---------------------------------------------------



;-----------------------------------------------------

section .data



block_transfer:
    mov rsi, sblock
    mov rdi, dblock
    mov rcx, 7

    back:
        mov al, [rsi]
        mov [rdi], al

        inc rsi
        inc rdi

        dec rdx  
        jnz back  
    ret


block_display:
    mov rbp, 7  