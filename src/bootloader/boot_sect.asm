
[org 0x7c00]    ; memory start address
KERNEL_OFFSET equ 0x1000    ; Kernel memory offset

mov bx, START_MSG   ; Set bx to START_MSG address
call print_string   ; Call print_string 

mov [BOOT_DRIVE], dl    ; read and store boot drive from dl

mov bp, 0x9000      ; stack address
mov sp, bp

call load_kernel

call switch_to_protected_mode

jmp $           ; jump here continuously

%include "src/bootloader/print.asm"
%include "src/bootloader/gdt.asm"
%include "src/bootloader/print_pm.asm"
%include "src/bootloader/protected_mode.asm"
%include "src/bootloader/disk_read.asm"

[bits 16]

load_kernel:
    mov bx, LOAD_KERNEL_MESSAGE
    call print_string

    mov bx, KERNEL_OFFSET
    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call read_disk
    ret

[bits 32]
protected_mode_start:
    mov ebx, PROTECTED_MODE_MSG
    call print_string_pm

    call KERNEL_OFFSET

    jmp $

;Global var
BOOT_DRIVE: db 0

; Data
START_MSG:
    db "Bare Metal Tetris, System initialization...", 0

LOAD_KERNEL_MESSAGE:
    db "Kernel is loading from the disk...", 0
PROTECTED_MODE_MSG:
    db  "32bit Protected mode...", 0
; Boot sector padding

times 510-($-$$) db 0   ; pad remaining bytes with zeros
dw 0xaa55               ; boot sector magic number