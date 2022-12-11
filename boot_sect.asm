mov ah, 0x0e    ; set ah to 0x0e teletype mode
mov al, 'H'     ; move H char to al
int 0x10        ; trigger print

jmp $           ; jump here continuously


; Boot sector padding

times 510-($-$$) db 0   ; pad remaining bytes with zeros
dw 0xaa55               ; boot sector magic number