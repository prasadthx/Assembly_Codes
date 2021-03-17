# Assembly_Codes

<h2> The following codes are of Linux OS </h2>
Codes differ for Windows and Linux.

<h2>Run Assembly on Windows:- </h2>

1. Get 'nasm' assembler.

2. Set nasm to path variable for accessing it everywhere in the directories.

3. Get C compiler ( Clang , GCC , etc.)
 
4. Compile the assembly language file using the nasm assembler.
   Command => nasm -f {system type} -o {object file name} {input assembly file}
   Returns => Object file.

5. Compile the object file using the c compiler.
   Command => {compiler name} {object file name} -o {executable file}
   
6. Execute the file.   

<h2>Important Note: Why do we need C compiler ? </h2>
The Linux interrupt code (syscall) 0x80, doesn’t exist in Windows like many other functions. In Windows (or rather, DOS), the correct interrupt function would be 0x21 (or 21h), but that would mean you’re forced to write in 16-bit. Either way, calling the kernel directly in Windows seems to be not the way forward.
If we cannot directly call the kernel, then what options are available to us? The obvious choice is C runtime libraries. 


<h2>Run Assembly on Windows 10 64-bit example (Clang compiler used)</h2>

1. Download nasm and clang.

2. Set nasm as path variable.

3. Write assembly code specific for Windows 10 64-bit.

4. nasm -f win64 -o example.win64 example.asm

5. clang example.win64 -o example.exe

6. example.exe.   

<h2>Run Assembly on Linux :- </h2>

1. Get 'nasm' assembler.

2. Use nasm to compile down the code to generate .o (object file).
   command => nasm -f {system format} -o {output object file name} {input .asm file}

3. Convert object file (.o file) to executable file using linker.
   command => ld {input file name} -o {output file name}

4. Run the executable file:-
   command => ./{output file in step3}
   
   


<h2>On Arch Linux x64 :-</h2>

<code>sudo pacman -S nasm</code>

<code>nasm -f elf64 -o example.o example.asm</code>

<code>ld example.o -o example</code>

<code>example</code>
