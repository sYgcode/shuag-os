; directives
; loads the OS from the drive into memory starting at 0x7C00, this will also be our memory offset
org 0x7C00
bits 16

; so that we start from main
start:
    jmp main

; print a string to the screen
; Params:
;   - ds:si points to string
puts:
    ; save the registers we will be modifying
    push si
    push ax

.loop:
    lodsb ; load the next char in al and increments our memory accordingly
    or al, al ; verifies if the next character is null
    jz .done

    mov ah, 0x0e
    mov bh, 0
    int 0x10

    jmp .loop

.done:
    pop ax
    pop si
    ret


; hold the CPU doing nothing
main:

    ; setup our data segments
    mov ax, 0 ; since we can't directly write to ds/es
    mov ds, ax
    mov es, ax
    ; setup our stack 
    mov ss, ax
    mov sp, 0x7C00 ; stack grows downwards


    ; print message
    mov si, msg_hello
    call puts

    hlt

; if we get past the halt, then stop us in an infinite loop
.halt:
    jmp .halt

msg_hello: db 'Hello World!', 0x0A, 0

; calculate how many bytes we have left out of 510 and fill with 0s
times 510 - ($ - $$) db 0

; finish with 2 bytes indicating the end of the boot sector. Will not boot without this.
dw 0xAA55
