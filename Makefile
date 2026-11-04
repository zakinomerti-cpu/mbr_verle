all:
	nasm -f bin boot.asm -o boot.com
	nasm -f bin main.asm -o main.com
	cat boot.com main.com > disk.img
	qemu-system-i386 -fda disk.img

tst:
	nasm -f elf32 test.asm -o test.o
	gcc -m32 -nostdlib -ffreestanding -e _enter test.o
	edb --run a.out
