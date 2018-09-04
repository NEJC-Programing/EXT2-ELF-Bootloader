CC = gcc -w -fno-pic -fno-builtin -nostdlib -ffreestanding -std=gnu99 -m32

all:
	mkdir obj/ -p
	$(CC) -c main.c -o obj/boot_main.o
	$(CC) -c ext2.c -o obj/boot_ext2.o
	$(CC) -c lib.c -o obj/boot_lib.o
	$(CC) -c vga.c -o obj/boot_vga.o
	$(CC) -c elf.c -o obj/boot_elf.o
	ld -m elf_i386 -N -e stage2_main -Ttext 0x00050000 -o boot.bin obj/boot_main.o obj/boot_ext2.o obj/boot_lib.o obj/boot_vga.o obj/boot_elf.o --oformat binary
