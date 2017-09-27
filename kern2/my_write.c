#include <sys/types.h>
#include <sys/syscall.h>

void my_write(const char *msg, size_t count) {
    asm("int $0x80" : :
        "a"(SYS_write), "b"(1), "c"(msg), "d"(count));
}

int main(void) {
    my_write("Hello, world!\n", 14);
}
