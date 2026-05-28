print:
    pusha
.start_loop:
    mov al, [bx]
    cmp al, 0
    je .done

    mov ah, 0x0e
    int 0x10

    add bx, 1
    jmp .start_loop
.done:
    popa
    ret