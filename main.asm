lea si, string
call printf

hlt

string db "Hello World", 0

printf PROC
    mov AL, [SI]
    cmp AL, 0
    je pfend

    mov AH, 0Eh
    int 10h
    inc SI
    jmp printf

    pfend
    ret
printf ENDP