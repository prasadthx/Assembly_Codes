<h1> Sample Windows 10 64-bit Hello Program </h1>

<h2> Install Nasm Assembler and Clang or any other C compiler</h2> 
In the example, clang compiler is used.

Check whether Nasm and Clang are set to path variables. 

If not set, you will get nasm/clang command not found error.

Check with command:-

<code>nasm --version</code>

<code>clang --version</code>

<img src="./Screenshot (353).png">

<h2> Write your Assembly code </h2>
Write your assembly language code with respect to the Windows OS and 64-bit architecture.

<h2> Use nasm assembler to assemble the code </h2>

<code>nasm -f win64 -o hello_program.win64 hello.asm</code>

Here win64 is the type for Windows 64-bit OS. 
Object file name can be anything that you want.
The .win64 object file extension is for the objects in Windows 64-bit.

<img src="./Screenshot (354).png">

<h2> Use Clang compiler to compile the code </h2>

<code>clang hello_program.win64 -o hello_program_executable.exe</code>

<img src="./Screenshot (354).png">

<h2> Execute the Code </h2>

<code>hello_program_executable</code>
<img src="./Screenshot (355).png">