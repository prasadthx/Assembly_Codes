section .data 		;This is data section use to initialize the variables.

msg db "Hello World Program", 0ah  	; initialize msg variable --> 0ah is the new line character  
msg_len equ $-msg   			; equ is equivalent to = in high level language {$-} is used to find length of msg var 

section .text   			; This is text section . In this section actual code is written 

global _start		; Actual execution of code starts here . This is like a main function in high level programming language
_start:

mov rax, 1    ; mov is instruction used to data transfers mov {source},{destination} . We passes opcode 1 to perform write operation
mov rdi, 1   		 ; STD::OUT to display o/p on console
mov rsi, msg 		 ; rsi is index based register --> we passed variable address here 
mov rdx, msg_len   ; length of variable is passed
syscall         ; syscall is used to perform all the above operation 

mov rax, 60    ; opcode 60 is used to stop execution
mov rdi,0        ; 0 or any value can passed to return value on console
syscall
