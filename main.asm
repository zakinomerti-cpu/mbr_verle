bits 16
org 0x8000

main:
	mov ax, 0013h
	int 10h

	call d_backg

	push 100 ;w
	push 12 ;h
	push 1 ;x
	push 1 ;y
	call drect

	push 25
	push 25
	push 25
	call dsphere

.exit:
    hlt
    jmp .exit

exit:
	hlt
	jmp exit

;drect(x, y, w, h)
drect:
	push bp
	mov bp, sp
	push di
	push es
	push bx

	;bp+04 - y
	;bp+06 - x
	;bp+08 - h
	;bp+10 - w

	mov ax, 0xA000
	mov es, ax
	mov di, 320*100+160

	mov bx, [bp+10]
	mov dx, [bp+8]
	mov cx, bx
	mov al, 0x89
.repeat:
	rep stosb
	add di, 320
	dec dx
	jz .exit
	mov cx, bx
	sub di, bx
	jmp .repeat
.exit:
	pop bx
	pop es
	pop di
	pop bp
	ret 8



d_backg:
	push di
	push es

	mov ax, 0xA000
	mov es, ax
	xor di, di

	mov cx, 320
	mov dx, 200
	mov al, 0x5
.repeat:
	rep stosb
	dec dx
	jz .exit
	mov cx, 320
	jmp .repeat
.exit:
	pop es
	pop di
	ret


dsphere:
	push bp
	mov bp, sp
	push di
	push es
	push bx

	mov ax, 0xA000
	mov es, ax
	xor di, di

	mov ecx, 320
	shl ecx, 16
	add ecx, 200

	xor edx, edx
	mov dx,  [bp+8]
	imul edx, edx

.repeat:
	movzx eax, cx
	add ax, [bp+6]
	sub eax, 100
	imul eax, eax
	mov ebx, eax
	rol ecx, 16
.repeatx:
	dec cx
	js .nrow

	movzx eax, cx
	add ax, [bp+4]
	sub eax, 160
	imul eax, eax

	add eax, ebx
	cmp eax, edx

	mov al, 0x55
	jl .draw
	inc di
	jmp .repeatx
.draw:
	stosb
	jmp .repeatx
.nrow:
	mov cx, 320
	rol ecx, 16
	dec cx
	jz .exit
	jmp .repeat
.exit:
	pop bx
	pop es
	pop di
	pop bp
	ret 6
