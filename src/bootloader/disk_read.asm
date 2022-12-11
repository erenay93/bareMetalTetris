read_disk:
    push dx         ; store sector count

    mov ah, 0x02    ; sector function
    mov al, dh      ; read dh sectors
    mov ch, 0x00    ; cylinder 0
    mov dh, 0x00    ; head 0
    mov cl, 0x02    ; start from 2nd sector

    int 0x13

    jc disk_error

    pop dx          ; restore sectore count
    cmp dh, al      ; compare read sector cnt and expected
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MESSAGE
    call print_string
    jmp $

DISK_ERROR_MESSAGE: db "Error while reading the disk!!!", 0