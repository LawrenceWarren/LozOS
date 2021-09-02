# This is a makefile

rm -rf bin
rm -rf obj
mkdir bin
mkdir obj

# assemble the bootsector
nasm src/boot_sect.asm -f bin -o bin/boot_sect.bin

# compile the kernel
gcc -ffreestanding -c src/kernel/kernel.c -o obj/kernel.o
ld -o bin/kernel.bin -Ttext 0x1000 obj/kernel.o --oformat binary

# Build the os-image file
cat bin/boot_sect.bin bin/kernel.bin > bin/os-image