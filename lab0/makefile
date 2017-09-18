CFLAGS  := -m32 -O1 -ffreestanding -g -Wconversion -std=c99 -Wall -Wextra -Wpedantic 
CC      := clang
ASFLAGS := -m32
SOURCES := $(wildcard *.c)
OBJECTS := $(patsubst %.c,%.o,$(wildcard *.c))
QEMU    := qemu-system-i386 -serial mon:stdio
KERN    := kern0
BOOT    := -kernel $(KERN)

$(KERN): boot.o $(OBJECTS)
	ld -m elf_i386 -Ttext 0x100000 -e 0x100000 $^ -o $@
	# Verificar imagen Multiboot v1.
	grub-file --is-x86-multiboot $@
	objdump -d $@ >$@.asm

clean:
	rm -f kern0 *.o core $(KERN).asm

qemu: $(KERN)
	$(QEMU) $(BOOT)

qemu-gdb: $(KERN)
	$(QEMU) -kernel kern0 -S -gdb tcp:127.0.0.1:7508 $(BOOT)

gdb:
	gdb -q -s kern0 -n -ex 'target remote 127.0.0.1:7508'


.PHONY: clean qemu gdb qemu-gdb
