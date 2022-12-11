run:
	make clean
	make os-image
	qemu-system-x86_64 bin/tetris.bin

os-image: bin/boot_sect.bin bin/kernel.bin
	cat $^ > bin/tetris.bin

bin/kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -o bin/kernel.bin -Ttext 0x1000 $^ --oformat binary --entry main

kernel.o : src/kernel/kernel.c
	gcc -fno-pie -m32 -ffreestanding -static -nostdlib -c $< -o $@

kernel_entry.o : src/kernel/kernel_entry.asm
	nasm $< -f elf -o $@

bin/boot_sect.bin : src/bootloader/boot_sect.asm
	nasm $< -f bin -o $@

clean:
	rm -fr *.bin *.dis *.o os-image *.map bin/*