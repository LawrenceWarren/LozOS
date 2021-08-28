# This is a makefile

rm -rf bin
mkdir bin
nasm src/boot_sect.asm -f bin -o bin/boot_sect.bin