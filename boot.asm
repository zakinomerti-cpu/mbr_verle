bits 16
org 7C00h

main:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax,
	mov sp, 0x7C00

	mov ah, 0x02
	mov al, 1
	mov ch, 0
	mov cl, 2
	mov dh, 0
	mov bx, 0x8000
	int 0x13
	call 0x8000
	

data:
	times 510 - ($ - $$) db 0
	dw 0AA55h
















