all:
	nasm -f bin main.asm -o main.com
	dosbox main.com

tst:
	nasm -f elf32 test.asm -o test.o
	gcc -m32 -nostdlib -ffreestanding -e _enter test.o
	edb --run a.out
