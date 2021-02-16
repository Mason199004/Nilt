#assemble boot.s file
nasm -f elf64 boot.S -o boot.o

#compile kernel.c file
gcc -m64 -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

#linking the kernel with kernel.o and boot.o files
ld -m elf_x86_64 linker.ld kernel.o boot.o -o MyOS.bin -nostdlib

#check MyOS.bin file is x86 multiboot file or not
grub-file --is-x86-multiboot MyOS.bin

#building the iso file
mkdir -p isodir/boot/grub
cp MyOS.bin isodir/boot/MyOS.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o MyOS.iso isodir

#run it in qemu
qemu-system-x86_64 -cdrom MyOS.iso
