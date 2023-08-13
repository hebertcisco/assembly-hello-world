global _start

section .data
    hello db 'Hello, World!',10
    helloLen equ $ - hello

section .text
_start:
    ; write(1, hello, helloLen)
    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, helloLen
    int 0x80

    ; exit(0)
    xor ebx, ebx
    mov eax, 1
    int 0x80
