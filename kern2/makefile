CFLAGS        := -m32 -nostartfiles -ffreestanding -g -std=c99 -Wall -Wextra -Wpedantic -std=c99 -O0 -fno-omit-frame-pointer -fno-pic -nopie
CPPFLAGS      := -nostdlibinc -idirafter lib
ASFLAGS       := $(CFLAGS)
CC            := clang
LIBGCC := $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)

KERN_C_SRCS    := write.c kern2.c ./lib/*.c
KERN_ASM_SRCS  := boot.S
KERN_OBJS      := $(patsubst %S,%o,$(KERN_ASM_SRCS))
KERN_OBJS      += $(patsubst %c,%o,$(KERN_C_SRCS))
KERN           := kern2
PROG           := kern2
QEMU           := qemu-system-i386 -serial mon:stdio
QEMU_EXTRA     := -append "'param1=hola param2=adios'"
BOOT           := -kernel $(KERN)

$(KERN): boot.o $(KERN_OBJS)
	ld -m elf_i386 -Ttext 0x100000 $^ -o $@
	# Verificar imagen Multiboot v1.
	grub-file --is-x86-multiboot $@
	objdump -d $@ >$@.asm

clean:
	rm -f $(PROG) *.o 

qemu: $(KERN)
	$(QEMU) $(BOOT) $(QEMU_EXTRA)

qemu-gdb: $(KERN)
	$(QEMU) -kernel $(KERN) -S -gdb tcp:127.0.0.1:7508 $(BOOT)

gdb:
	gdb -q -s kern2 -n -ex 'target remote 127.0.0.1:7508'

.PHONY: clean
