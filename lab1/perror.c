#include <errno.h>
#include <stdio.h>      // perror(3)
#include <sys/types.h>  // ssize_t

#ifdef USE_WRITE2
extern ssize_t __attribute__((cdecl))
write2(int fd, const void *buf, size_t count);
#define write write2
#else
#include <unistd.h>
#endif

const char msg[] = "Escribiendo a nadie\n";

int main(void) {
    ssize_t ret = write(17, msg, sizeof msg - 1);

    if (ret == -1)
        perror("Falló write");

    return (ret >= 0) ? 0 : errno;
}
