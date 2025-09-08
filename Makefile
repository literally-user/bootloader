AS = nasm
INC = ./src
ASFLAGS = -f bin $(INC:%=-I %)

all: ./src/boot.bin

./src/boot.bin: ./src/boot_s1.bin ./src/boot_s2.bin
	cat $^ > $@

./src/%.bin: ./src/%.asm
	$(AS) $(ASFLAGS) -o $@ $<

run: ./src/boot.bin
	qemu-system-x86_64 -drive format=raw,file=./src/boot.bin

clean:
	rm -f ./src/boot_s1.bin ./src/boot_s2.bin ./src/boot.bin

