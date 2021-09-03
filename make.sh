# This is a makefile

rm -rf bin
rm -rf obj
mkdir bin
mkdir obj

# assemble the bootsector
nasm src/boot_sect.asm -f bin -o bin/boot_sect.bin
# Building an object file
nasm src/kernel/kernel_entry.asm -f elf64 -o obj/kernel_entry.o

# Build an object file
gcc -ffreestanding -c src/kernel/kernel.c -o obj/kernel.o
# compile the kernel
ld -o bin/kernel.bin -Ttext 0x1000 obj/kernel_entry.o obj/kernel.o --oformat binary

# Concatenate the os-image file
cat bin/boot_sect.bin bin/kernel.bin > bin/os-image
