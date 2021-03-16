# Assembly_Codes

Run Assembly on Linux :-

1. Get 'nasm' assembler.

2. Use nasm to compile down the code to generate .o (object file).
   command => nasm -f {system format} -o {output object file name} {input .asm file}

3. Convert object file (.o file) to executable file using linker.
   command => ld {input file name} -o {output file name}

4. Run the executable file:-
   command => ./{output file in step3}
   
   


On Arch Linux x64 :-

1. sudo pacman -S nasm

2. nasm -f elf64 -o example.o example.asm

3. ld example.o -o example

4. ./example
