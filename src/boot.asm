; directives
; loads the OS from the drive into memory starting at 0x7C00, this will also be our memory offset
org 0x7C00
bits 16

; so that we start from main
start:
    jmp main


; hold the CPU doing nothing
main:

    ; setup our data segments
    mov ax, 0 ; since we can't directly write to ds/es
    mov ds, ax ; set our data segment to 0, so that we can access our data at 0x7C00
    mov es, ax ; set our extra segment to 0
    ; setup our stack 
    mov ss, ax
    mov sp, 0x7C00 ; stack grows downwards


    ; print message
    mov bx, msg_hello
    call print
    mov dh, 1        ; We want to read 1 sector
    mov bx, 0x9000   ; We want to load it to memory address 0x9000
    call disk_load   ; dl is already set by the BIOS, so we just call the function!

    hlt

; if we get past the halt, then stop us in an infinite loop
.halt:
    jmp .halt

%include "src/boot_sect_print.asm"
%include "src/boot_from_disk.asm"

;data

msg_hello: db 'Hello World!', 0x0D, 0x0A, 0
msg_disk_error: db 'Disk read error!', 0x0D, 0x0A, 0
msg_sector_error: db 'Sector read error!', 0x0D, 0x0A, 0
msg_success: db 'Successfully loaded OS from disk!', 0x0D, 0x0A, 0
; calculate how many bytes we have left out of 510 and fill with 0s
times 510 - ($ - $$) db 0

; finish with 2 bytes indicating the end of the boot sector. Will not boot without this.
dw 0xAA55

times 512 db 'A'   ; Fill Sector 2 completely with the letter 'A'