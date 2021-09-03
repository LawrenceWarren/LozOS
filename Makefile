# Automatically generate lists of sources using wildcards .
C_SOURCES = $(wildcard src/kernel/*.c src/drivers/*.c)
HEADERS = $(wildcard src/kernel/*.h src/drivers/*.h)

# TODO : Make sources dep on all header files .

OBJ = ${wildcard obj/*.o}

# Defaul build target
all: os-image

# Run bochs to simulate booting of our code .
run: all
	qemu-system-i386 -drive file=bin/os-image,format=raw,index=0,media=disk

# This is the actual disk image that the computer loads
# which is the combination of our compiled bootsector and kernel
os-image: bin/boot_sect.bin bin/kernel.bin
	cat $^ > bin/os-image

# This builds the binary of our kernel from two object files :
# - the kernel_entry , which jumps to main () in our kernel
# - the compiled C kernel
bin/kernel.bin : obj/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

# Generic rule for compiling C code to an object file
# For simplicity , we C files depend on all header files .
obj/%.o : src/*/%.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

# Assemble the kernel_entry .
obj/%.o: src/*/%.asm
	nasm $< -f elf64 -o $@

bin/%.bin : src/*/%.asm
	nasm $< -f bin -o $@

clean:
	rm -fr bin/* *.dis obj/*
