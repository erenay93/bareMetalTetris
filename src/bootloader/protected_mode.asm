[bits 16]
switch_to_protected_mode:
    mov ah, 0x00    ; video mode
    mov al, 0x13    ; 320x200 256 color
    int 0x10        ; int 10h

    cli                     ; stop interrupts until protected mode
    lgdt [gdt_descriptor]   ; load gdt

    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    
    jmp CODE_SEG:init_pm

[bits 32]
init_pm:

    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ebp, 0x90000
    mov esp, ebp

    call protected_mode_start

