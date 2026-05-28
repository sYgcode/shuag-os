;input: dh = number of sectors to read
;       dl = drive number to read from
;       es:bx = memory location to read the sectors into
disk_load:
    pusha
    push dx ; save the number of sectors to read on the stack so that we can verify it later

    mov ah, 0x02 ; bios disk read function
    mov al, dh ; number of sectors to read
    mov ch, 0 ; cylinder number to read from (we will only read from the first cylinder, so 0 is fine)
    mov dh, 0 ; head number to read from (we will only read from the first head, so 0 is fine)
    mov cl, 2 ; sector number to read from (we will start reading from the second sector, since the first sector is our boot sector)

    int 0x13 ; call the bios disk interrupt to read the sectors into memory


    jc .disk_error ; if there was an error, jump to the disk error handler
    pop dx ; get the number of sectors we read back from the stack
    cmp al, dh ; verify that we read the correct number of sectors
    jne .sector_error ; if we didn't read the correct number of sectors, jump to the sector error handler

    mov bx, msg_success
    call print
    popa
    ret

.disk_error:
    ; print error message
    mov bx, msg_disk_error
    call print
    jmp $
.sector_error:
    ; print error message
    mov bx, msg_sector_error
    call print
    jmp $
