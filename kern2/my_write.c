#include <sys/types.h>
#include <sys/syscall.h>
#include <stdbool.h>
#include <stdio.h>

void __attribute__((fastcall))my_write(const char *msg, size_t count) {
    asm("int $0x80" : :
        "a"(SYS_write), "b"(1), "c"(msg), "d"(count));
}
bool my_write2(int fd, const char *msg, size_t count) {
    ssize_t ret;
    asm ("int $0x80"
        : "=a"(ret)
        : "a"(SYS_write), "b"(fd), "c"(msg), "d"(count));

    return (ret > 0 && (size_t) ret == count);
}

int main(void) {
    bool result = my_write2(1, "Hello, write2!\n", 15);
        puts("write2 falló");
}
