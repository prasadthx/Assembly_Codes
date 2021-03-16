<h1> General Purpose registers </h1>
<h2>The 64-bit versions of the 'original' x86 registers are named:</h2>
<ul>
<li>rax - register a extended
<li>rbx - register b extended
<li>rcx - register c extended
<li>rdx - register d extended
<li>rbp - register base pointer (start of stack)
<li>rsp - register stack pointer (current location in stack, growing downwards)
<li>rsi - register source index (source for data copies)
<li>rdi - register destination index (destination for data copies)
</ul>

<h2>The registers added for 64-bit mode are named:</h2>
<ul>
<li>r8 - register 8
<li>r9 - register 9
<li>r10 - register 10
<li>r11 - register 11
<li>r12 - register 12
<li>r13 - register 13
<li>r14 - register 14
<li>r15 - register 15
</ul>

<h3>These may be accessed as:</h3>
<ul>
<li>64-bit registers using the 'r' prefix: rax, r15
<li>32-bit registers using the 'e' prefix (original registers: e_x) or 'd' suffix (added registers: r__d): eax, r15d
<li>16-bit registers using no prefix (original registers: _x) or a 'w' suffix (added registers: r__w): ax, r15w
<li>8-bit registers using 'h' ("high byte" of 16 bits) suffix (original registers - bits 8-15: _h): ah, bh
<li>8-bit registers using 'l' ("low byte" of 16 bits) suffix (original registers - bits 0-7: _l) or 'b' suffix (added registers: r__b): al, bl, r15b

<h3>Usage during syscall/function call:</h3>
<ul>
<li>First six arguments are in rdi, rsi, rdx, rcx, r8d, r9d; remaining arguments are on the stack.
<li>For syscalls, the syscall number is in rax.
<li>Return value is in rax.
<li>The called routine is expected to preserve rsp,rbp, rbx, r12, r13, r14, and r15 but may trample any other registers.


<h1> Examples </h1>
<code>
add %r10,%r11    // add r10 and r11, put result in r11   </br>
add $5,%r10      // add 5 to r10, put result in r10 </br>
call label       // call a subroutine / function / procedure  </br>
cmp %r10,%r11    // compare register r10 with register r11.  The comparison sets flags in the processor status register which affect conditional jumps. </br>
cmp $99,%r11     // compare the number 99 with register r11.  The comparison sets flags in the processor status register which affect conditional jumps.  </br>
div %r10         // divide rax by the given register (r10), places quotient into rax and remainder into rdx (rdx must be zero before this instruction)  </br>
inc %r10         // increment r10 </br>
jmp label        // jump to label   </br>
je  label        // jump to label if equal  </br>
jne label        // jump to label if not equal  </br>
jl  label        // jump to label if less </br>
jg  label        // jump to label if greater  </br>
mov %r10,%r11    // move data from r10 to r11 </br>
mov $99,%r10     // put the immediate value 99 into r10 </br>
mov %r10,(%r11)  // move data from r10 to address pointed to by r11   </br>
mov (%r10),%r11  // move data from address pointed to by r10 to r10   </br>
mul %r10         // multiplies rax by r10, places result in rax and overflow in rdx   </br>
push %r10        // push r10 onto the stack   </br>
pop %r10         // pop r10 off the stack   </br>
ret              // routine from subroutine (counterpart to call)   </br>
syscall          // invoke a syscall (in 32-bit mode, use "int $0x80" instead)    </br>

</code>
