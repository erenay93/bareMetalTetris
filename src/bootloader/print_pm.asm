[bits 32]

VIDEO_MEM equ 0xb8000
FONT_COLOR equ 0x37

print_string_pm:
    pusha
    mov edx, VIDEO_MEM

print_string_pm_loop:
    mov al, [ebx]
    mov ah, FONT_COLOR

    cmp al, 0
    je done

    mov [edx], ax

    add ebx, 1
    add edx, 2

    jmp print_string_pm_loop

done:
    popa
    ret