
[org 0x7c00]    ; memory start address

mov bx, START_MSG   ; Set bx to START_MSG address
call print_string   ; Call print_string 

mov [BOOT_DRIVE], dl    ; read and store boot drive from dl

mov bp, 0x8000      ; stack address
mov sp, bp

mov bx, 0x9000
mov dh, 3           ; 5 sector
mov dl, [BOOT_DRIVE]
call read_disk      ; Read disk

mov bx, 0x9000
call print_char

mov bx, 0x9000 + 512
call print_char

jmp $           ; jump here continuously

%include "src/bootloader/print.asm"
%include "src/bootloader/disk_read.asm"

;Global var
BOOT_DRIVE: db 0

; Data
START_MSG:
    db "Bare Metal Tetris, System initialization...", 0

; Boot sector padding

times 510-($-$$) db 0   ; pad remaining bytes with zeros
dw 0xaa55               ; boot sector magic number


times 512 db 'X'
times 512 db 'Y'
times 512 db 'Z'