CFLAGS := -m32 -g -std=c99 -Wall -Wextra -Wpedantic
CFLAGS += -O1  -fno-omit-frame-pointer -fno-pic -no-pie
ASFLAGS = $(CFLAGS)

ASMS     := $(wildcard *.S)
SRCS     := $(wildcard *.c)
OBJS_ASM := $(patsubst %.S,%.o,$(wildcard *.S))
OBJS_C 	 := $(patsubst %.c,%.o,$(wildcard *.c))
PROG += perror2 perror write2

all: $(PROG)

perror2: perror.c write2.S
	$(CC) $(CFLAGS) $(CPPFLAGS) -DUSE_WRITE2 $^ -o $@


clean:
	rm -f $(PROG) *.o 

.PHONY: clean all
