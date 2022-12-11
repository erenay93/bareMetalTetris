print_string:
    pusha
    call priv_print_loop
    popa
    ret

print_char:
    pusha
    call priv_print_single_char
    popa
    ret

priv_print_loop:
    call priv_print_single_char
    inc bx
    mov ax, [bx]
    cmp ax, 0
    jne priv_print_loop
    ret

priv_print_single_char:
    mov ah, 0x0e
    mov al, [bx]
    int 0x10
    ret